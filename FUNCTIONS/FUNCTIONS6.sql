-- Função 6: Calcular Dias desde Última Compra do Cliente


DELIMITER //
CREATE FUNCTION fn_dias_desde_ultima_compra(p_id_cliente INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_ultima_compra DATE;
    
    SELECT MAX(data_venda) INTO v_ultima_compra
    FROM vendas
    WHERE id_cliente = p_id_cliente;
    
    IF v_ultima_compra IS NULL THEN
        RETURN NULL;
    END IF;
    
    RETURN DATEDIFF(CURDATE(), v_ultima_compra);
END //
DELIMITER ;

-- Teste
SELECT c.nome, fn_dias_desde_ultima_compra(c.id_cliente) AS dias_sem_comprar
FROM clientes c;