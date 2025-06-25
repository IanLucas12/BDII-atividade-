-- Função 4: Calcular Lucro por Produto


DELIMITER //
CREATE FUNCTION fn_calcular_lucro_produto(p_id_produto INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_lucro DECIMAL(10,2);
    
    SELECT (preco - custo) INTO v_lucro
    FROM produtos
    WHERE id_produto = p_id_produto;
    
    RETURN IFNULL(v_lucro, 0);
END //
DELIMITER ;

-- Teste
SELECT p.nome, p.preco, p.custo, fn_calcular_lucro_produto(p.id_produto) AS lucro_unitario
FROM produtos p;