-- 5. Trigger de Validação de Desconto (Depois do INSERT)



DELIMITER //
CREATE TRIGGER tr_valida_desconto
BEFORE INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE preco_produto DECIMAL(10,2);
    
    -- Obtém preço atual do produto
    SELECT preco INTO preco_produto
    FROM produtos
    WHERE id_produto = NEW.id_produto;
    
    -- Valida se desconto não excede 30% do valor
    IF NEW.desconto > (preco_produto * 0.3) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Desconto não pode exceder 30% do valor do produto';
    END IF;
END //
DELIMITER ;