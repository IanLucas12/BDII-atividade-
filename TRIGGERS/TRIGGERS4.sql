-- 4. Trigger de Atualização de Estoque Automático (Depois do INSERT)




DELIMITER //
CREATE TRIGGER tr_atualiza_estoque_venda
AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    DECLARE estoque_atual INT;
    
    -- Verifica estoque atual
    SELECT quantidade INTO estoque_atual
    FROM estoque
    WHERE id_produto = NEW.id_produto;
    
    -- Atualiza estoque se houver quantidade suficiente
    IF estoque_atual >= NEW.quantidade THEN
        UPDATE estoque
        SET quantidade = quantidade - NEW.quantidade
        WHERE id_produto = NEW.id_produto;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Estoque insuficiente para concluir a operação';
    END IF;
END //
DELIMITER ;