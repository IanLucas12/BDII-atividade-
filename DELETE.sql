-- 1. Remover um cliente inativo (sem vendas)
-- Verifica primeiro se o cliente não tem vendas associadas
DELETE FROM clientes 
WHERE id_cliente = 8 
AND NOT EXISTS (SELECT 1 FROM vendas WHERE id_cliente = 8);

-- 2. Remover promoções expiradas
DELETE FROM promocoes WHERE data_fim < CURDATE();

-- 3. Remover itens de venda de uma venda cancelada
DELETE FROM itens_venda 
WHERE id_venda IN (SELECT id_venda FROM vendas WHERE status = 'Cancelada');

-- 4. Remover fornecedor sem produtos associados
DELETE FROM fornecedores 
WHERE id_fornecedor = 10 
AND NOT EXISTS (SELECT 1 FROM produtos WHERE id_marca IN 
               (SELECT id_marca FROM marcas WHERE nome LIKE '%Luxo%'));

-- 5. Remover registros de estoque zerados
DELETE FROM estoque WHERE quantidade = 0;

-- 6. Remover funcionário desligado (substituir pelo ID correto)
DELETE FROM funcionarios WHERE id_funcionario = 5;

-- 7. Remover categorias sem produtos
DELETE FROM categorias 
WHERE id_categoria NOT IN (SELECT DISTINCT id_categoria FROM produtos);

-- 8. Remover marcas não utilizadas
DELETE FROM marcas 
WHERE id_marca NOT IN (SELECT DISTINCT id_marca FROM produtos);

-- 9. Remover vendas muito antigas e já entregues (com histórico)
-- Primeiro garantir que os itens foram deletados
DELETE FROM itens_venda 
WHERE id_venda IN (SELECT id_venda FROM vendas 
                  WHERE status = 'Entregue' AND data_venda < '2023-01-01');
                  
DELETE FROM vendas 
WHERE status = 'Entregue' AND data_venda < '2023-01-01';