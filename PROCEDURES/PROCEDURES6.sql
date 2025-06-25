-- 6. Procedure para Promoção de Produtos por Categoria


DELIMITER //
CREATE PROCEDURE sp_aplicar_promocao_categoria(
    IN p_id_categoria INT,
    IN p_desconto DECIMAL(5,2),
    IN p_dias_duracao INT)
BEGIN
    DECLARE v_data_inicio DATE;
    DECLARE v_data_fim DATE;
    DECLARE v_qtd_produtos INT;
    
    SET v_data_inicio = CURDATE();
    SET v_data_fim = DATE_ADD(v_data_inicio, INTERVAL p_dias_duracao DAY);
    
    -- 1. Verifica se categoria existe
    IF NOT EXISTS (SELECT 1 FROM categorias WHERE id_categoria = p_id_categoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoria não encontrada';
    END IF;
    
    -- 2. Verifica se desconto é válido
    IF p_desconto <= 0 OR p_desconto >= 100 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Desconto inválido (deve ser entre 0 e 100)';
    END IF;
    
    -- 3. Cria promoções para todos os produtos da categoria
    INSERT INTO promocoes (id_produto, desconto, data_inicio, data_fim)
    SELECT id_produto, p_desconto, v_data_inicio, v_data_fim
    FROM produtos
    WHERE id_categoria = p_id_categoria AND ativo = TRUE;
    
    -- 4. Conta produtos afetados
    SELECT ROW_COUNT() INTO v_qtd_produtos;
    
    -- 5. Retorna relatório
    SELECT CONCAT('Promoção aplicada a ', v_qtd_produtos, ' produtos') AS mensagem,
           v_data_inicio AS inicio_promocao,
           v_data_fim AS fim_promocao,
           p_desconto AS desconto_aplicado;
END //
DELIMITER ;

-- Teste
CALL sp_aplicar_promocao_categoria(2, 15.00, 30);
