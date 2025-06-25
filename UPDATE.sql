-- 1. Atualizar preço de um produto específico
UPDATE produtos SET preco = 59.90 WHERE id_produto = 1;

-- 2. Atualizar estoque após uma venda
UPDATE estoque SET quantidade = quantidade - 2 WHERE id_produto = 1;

-- 3. Atualizar status de uma venda para "Entregue"
UPDATE vendas SET status = 'Entregue' WHERE id_venda = 3;

-- 4. Atualizar informações de um cliente
UPDATE clientes 
SET endereco = 'Av. Nova, 1000', telefone = '(11) 9999-1111' 
WHERE id_cliente = 1;

-- 5. Atualizar cargo e email de um funcionário
UPDATE funcionarios 
SET cargo = 'Gerente de Vendas', email = 'novoemail@loja.com' 
WHERE id_funcionario = 2;

-- 6. Atualizar preço de custo de vários produtos da mesma marca
UPDATE produtos 
SET custo = custo * 1.1 
WHERE id_marca = 1;

-- 7. Atualizar data de fim de uma promoção
UPDATE promocoes 
SET data_fim = '2023-04-30' 
WHERE id_promocao = 1;

-- 8. Atualizar status de produtos inativos
UPDATE produtos 
SET ativo = FALSE 
WHERE id_produto IN (10, 5);

-- 9. Atualizar forma de pagamento de vendas canceladas
UPDATE vendas 
SET forma_pagamento = 'Estorno' 
WHERE status = 'Cancelada';

-- 10. Atualizar desconto em itens de venda de um produto específico
UPDATE itens_venda 
SET desconto = 15.00 
WHERE id_produto = 3 AND desconto < 15;