-- 3. Procedure para Atualização de Estoque com Notificação


DELIMITER //
CREATE PROCEDURE sp_atualizar_estoque_notificacao(
    IN p_id_produto INT,
    IN p_quantidade INT,
    IN p_operacao CHAR(1)) -- 'E' para entrada, 'S' para saída
BEGIN
    DECLARE v_quantidade_atual INT;
    DECLARE v_nova_quantidade INT;
    
    -- 1. Verifica se produto existe
    IF NOT EXISTS (SELECT 1 FROM produtos WHERE id_produto = p_id_produto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Produto não encontrado';
    END IF;
    
    -- 2. Obtém quantidade atual
    SELECT COALESCE(quantidade, 0) INTO v_quantidade_atual 
    FROM estoque 
    WHERE id_produto = p_id_produto;
    
    -- 3. Calcula nova quantidade
    IF p_operacao = 'E' THEN
        SET v_nova_quantidade = v_quantidade_atual + p_quantidade;
    ELSEIF p_operacao = 'S' THEN
        SET v_nova_quantidade = v_quantidade_atual - p_quantidade;
        
        -- Verifica se há estoque suficiente
        IF v_nova_quantidade < 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Estoque insuficiente';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operação inválida. Use "E" ou "S"';
    END IF;
    
    -- 4. Atualiza estoque
    UPDATE estoque 
    SET quantidade = v_nova_quantidade, 
        data_entrada = CURDATE()
    WHERE id_produto = p_id_produto;
    
    -- 5. Registra movimentação
    INSERT INTO historico_estoque (id_produto, quantidade, operacao, data_movimento)
    VALUES (p_id_produto, p_quantidade, p_operacao, NOW());
    
    -- 6. Verifica estoque baixo e gera notificação
    IF v_nova_quantidade < 10 THEN
        INSERT INTO notificacoes (mensagem, tipo, data_notificacao)
        VALUES (CONCAT('Estoque baixo para o produto ID ', p_id_produto, '. Quantidade: ', v_nova_quantidade), 
               'estoque', NOW());
    END IF;
    
    SELECT CONCAT('Estoque atualizado. Nova quantidade: ', v_nova_quantidade) AS mensagem;
END //
DELIMITER ;

-- Tabelas auxiliares
CREATE TABLE IF NOT EXISTS historico_estoque (
    id_movimento INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    quantidade INT,
    operacao CHAR(1),
    data_movimento DATETIME,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE IF NOT EXISTS notificacoes (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT,
    tipo VARCHAR(20),
    data_notificacao DATETIME,
    lida BOOLEAN DEFAULT FALSE
);

-- Teste
CALL sp_atualizar_estoque_notificacao(1, 5, 'S');