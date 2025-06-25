-- 5. Procedure para Migração de Categoria


DELIMITER //
CREATE PROCEDURE sp_migrar_categoria(
    IN p_id_categoria_origem INT,
    IN p_id_categoria_destino INT)
BEGIN
    DECLARE v_qtd_produtos INT;
    
    -- 1. Verifica se categorias existem
    IF NOT EXISTS (SELECT 1 FROM categorias WHERE id_categoria = p_id_categoria_origem) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoria de origem não encontrada';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM categorias WHERE id_categoria = p_id_categoria_destino) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoria de destino não encontrada';
    END IF;
    
    -- 2. Conta produtos na categoria origem
    SELECT COUNT(*) INTO v_qtd_produtos
    FROM produtos
    WHERE id_categoria = p_id_categoria_origem;
    
    -- 3. Atualiza produtos para nova categoria
    UPDATE produtos
    SET id_categoria = p_id_categoria_destino
    WHERE id_categoria = p_id_categoria_origem;
    
    -- 4. Registra histórico
    INSERT INTO historico_migracao_categoria (id_categoria_origem, id_categoria_destino, qtd_produtos, data_migracao)
    VALUES (p_id_categoria_origem, p_id_categoria_destino, v_qtd_produtos, NOW());
    
    SELECT CONCAT('Migração concluída. ', v_qtd_produtos, ' produtos movidos') AS mensagem;
END //
DELIMITER ;

-- Tabela auxiliar
CREATE TABLE IF NOT EXISTS historico_migracao_categoria (
    id_migracao INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria_origem INT,
    id_categoria_destino INT,
    qtd_produtos INT,
    data_migracao DATETIME,
    FOREIGN KEY (id_categoria_origem) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_categoria_destino) REFERENCES categorias(id_categoria)
);

-- Teste
CALL sp_migrar_categoria(1, 2);