-- Função 3: Calcular Idade do Cliente

DELIMITER //
CREATE FUNCTION fn_calcular_idade_cliente(p_id_cliente INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_data_nascimento DATE;
    DECLARE v_idade INT;
    
    -- Verifica sem tentar alterar a tabela
    SELECT data_nascimento INTO v_data_nascimento
    FROM clientes
    WHERE id_cliente = p_id_cliente;
    
    IF v_data_nascimento IS NULL THEN
        RETURN NULL;
    END IF;
    
    SET v_idade = TIMESTAMPDIFF(YEAR, v_data_nascimento, CURDATE());
    
    RETURN v_idade;
END //
DELIMITER ;