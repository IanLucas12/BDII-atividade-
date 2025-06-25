-- 1. Trigger para Atualizar Estoque Após Venda (Depois do INSERT)



DELIMITER //
CREATE TRIGGER tr_atualizar_estoque_venda
AFTER INSERT ON itens_venda
FOR EACH ROW
BEGIN
    UPDATE estoque 
    SET quantidade = quantidade - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
    
    INSERT INTO historico_estoque (id_produto, quantidade, operacao, data_movimento)
    VALUES (NEW.id_produto, NEW.quantidade, 'S', NOW());
END //
DELIMITER ;

-- Teste
INSERT INTO vendas (id_cliente, id_funcionario, data_venda, forma_pagamento, status) 
VALUES (1, 2, CURDATE(), 'Cartão', 'Concluída');

INSERT INTO itens_venda (id_venda, id_produto, quantidade, preco_unitario)
VALUES (LAST_INSERT_ID(), 1, 2, (SELECT preco FROM produtos WHERE id_produto = 1));

-- Verifique o estoque
SELECT * FROM estoque WHERE id_produto = 1;
SELECT * FROM historico_estoque;