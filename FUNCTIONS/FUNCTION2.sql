-- Função 2: Verificar Disponibilidade de Produto





DELIMITER //
CREATE FUNCTION fn_verificar_disponibilidade(p_id_produto INT, p_quantidade INT) 
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE v_estoque INT;
    DECLARE v_resultado VARCHAR(50);
    
    SELECT quantidade INTO v_estoque
    FROM estoque
    WHERE id_produto = p_id_produto;
    
    IF v_estoque >= p_quantidade THEN
        SET v_resultado = 'Disponível';
    ELSEIF v_estoque > 0 THEN
        SET v_resultado = CONCAT('Disponível parcialmente (', v_estoque, ' unidades)');
    ELSE
        SET v_resultado = 'Esgotado';
    END IF;
    
    RETURN v_resultado;
END //
DELIMITER ;

-- Teste
SELECT p.nome, fn_verificar_disponibilidade(p.id_produto, 5) AS disponibilidade
FROM produtos p;