-- Função 1: Calcular Valor Total em Estoque por Categoria

DELIMITER //
CREATE FUNCTION fn_total_estoque_categoria(p_id_categoria INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2);
    
    SELECT SUM(e.quantidade * p.preco) INTO v_total
    FROM produtos p
    JOIN estoque e ON p.id_produto = e.id_produto
    WHERE p.id_categoria = p_id_categoria;
    
    RETURN IFNULL(v_total, 0);
END //
DELIMITER ;

-- Teste
SELECT cat.nome AS categoria, fn_total_estoque_categoria(cat.id_categoria) AS valor_total_estoque
FROM categorias cat;