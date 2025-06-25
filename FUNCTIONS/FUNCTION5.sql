-- Função 5: Verificar Status de Venda


DELIMITER //
CREATE FUNCTION fn_status_venda(p_id_venda INT) 
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_status VARCHAR(30);
    DECLARE v_data_venda DATE;
    DECLARE v_resultado VARCHAR(100);
    
    SELECT status, data_venda INTO v_status, v_data_venda
    FROM vendas
    WHERE id_venda = p_id_venda;
    
    IF v_status = 'Concluída' THEN
        SET v_resultado = CONCAT('Venda concluída em ', DATE_FORMAT(v_data_venda, '%d/%m/%Y'));
    ELSEIF v_status = 'Cancelada' THEN
        SET v_resultado = 'Venda cancelada';
    ELSE
        SET v_resultado = CONCAT('Status atual: ', v_status, ' (desde ', DATE_FORMAT(v_data_venda, '%d/%m/%Y'), ')');
    END IF;
    
    RETURN v_resultado;
END //
DELIMITER ;

-- Teste
SELECT id_venda, fn_status_venda(id_venda) AS status_completo
FROM vendas;