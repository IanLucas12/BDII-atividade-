-- 1. TOP 10 PRODUTOS MAIS VENDIDOS (QUANTIDADE)
SELECT p.nome AS produto, SUM(iv.quantidade) AS total_vendido
FROM produtos p
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 10;

-- 2. CLIENTES QUE MAIS GASTARAM (VALOR TOTAL)
SELECT c.nome AS cliente, SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS total_gasto
FROM clientes c
JOIN vendas v ON c.id_cliente = v.id_cliente
JOIN itens_venda iv ON v.id_venda = iv.id_venda
GROUP BY c.nome
ORDER BY total_gasto DESC
LIMIT 10;

-- 3. PRODUTOS COM ESTOQUE BAIXO (MENOS DE 10 UNIDADES)
SELECT p.nome AS produto, e.quantidade AS estoque
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 10 AND p.ativo = TRUE
ORDER BY e.quantidade ASC;

-- 4. VENDAS POR FUNCIONÁRIO (DESEMPENHO)
SELECT f.nome AS funcionario, COUNT(v.id_venda) AS total_vendas,
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_total
FROM funcionarios f
JOIN vendas v ON f.id_funcionario = v.id_funcionario
JOIN itens_venda iv ON v.id_venda = iv.id_venda
GROUP BY f.nome
ORDER BY valor_total DESC;

-- 5. PRODUTOS QUE NUNCA FORAM VENDIDOS
SELECT p.nome AS produto
FROM produtos p
LEFT JOIN itens_venda iv ON p.id_produto = iv.id_produto
WHERE iv.id_item IS NULL AND p.ativo = TRUE;

-- 6. TICKET MÉDIO POR CLIENTE
SELECT c.nome AS cliente, 
       COUNT(v.id_venda) AS qtd_compras,
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) / COUNT(v.id_venda) AS ticket_medio
FROM clientes c
JOIN vendas v ON c.id_cliente = v.id_cliente
JOIN itens_venda iv ON v.id_venda = iv.id_venda
GROUP BY c.nome
ORDER BY ticket_medio DESC;

-- 7. VENDAS POR CATEGORIA (MÊS ATUAL)
SELECT cat.nome AS categoria, 
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS total_vendido
FROM categorias cat
JOIN produtos p ON cat.id_categoria = p.id_categoria
JOIN itens_venda iv ON p.id_produto = iv.id_produto
JOIN vendas v ON iv.id_venda = v.id_venda
WHERE MONTH(v.data_venda) = MONTH(CURRENT_DATE())
AND YEAR(v.data_venda) = YEAR(CURRENT_DATE())
GROUP BY cat.nome
ORDER BY total_vendido DESC;

-- 8. MÉDIA DE ITENS POR VENDA
SELECT AVG(itens_por_venda) AS media_itens_por_venda
FROM (
    SELECT id_venda, COUNT(*) AS itens_por_venda
    FROM itens_venda
    GROUP BY id_venda
) AS subquery;

-- 9. PRODUTOS EM PROMOÇÃO ATUAL
SELECT p.nome AS produto, pr.desconto AS desconto_percentual,
       p.preco AS preco_original, 
       p.preco * (1 - pr.desconto/100) AS preco_promocional
FROM produtos p
JOIN promocoes pr ON p.id_produto = pr.id_produto
WHERE CURRENT_DATE() BETWEEN pr.data_inicio AND pr.data_fim
AND p.ativo = TRUE;

-- 10. HISTÓRICO DE COMPRAS POR CLIENTE
SELECT c.nome AS cliente, p.nome AS produto, 
       iv.quantidade, iv.preco_unitario, v.data_venda
FROM clientes c
JOIN vendas v ON c.id_cliente = v.id_cliente
JOIN itens_venda iv ON v.id_venda = iv.id_venda
JOIN produtos p ON iv.id_produto = p.id_produto
WHERE c.id_cliente = 1  -- Substituir pelo ID do cliente desejado
ORDER BY v.data_venda DESC;

-- 11. MARGEM DE LUCRO POR PRODUTO
SELECT p.nome AS produto, 
       p.preco AS preco_venda, 
       p.custo AS custo,
       (p.preco - p.custo) AS lucro_unitario,
       ROUND(((p.preco - p.custo) / p.custo) * 100, 2) AS margem_percentual
FROM produtos p
WHERE p.custo > 0
ORDER BY margem_percentual DESC;

-- 12. VENDAS CANCELADAS E MOTIVO
SELECT v.id_venda, c.nome AS cliente, v.data_venda, v.observacoes AS motivo
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.status = 'Cancelada';

-- 13. PRODUTOS MAIS VENDIDOS POR MARCA
SELECT m.nome AS marca, p.nome AS produto, 
       SUM(iv.quantidade) AS total_vendido
FROM marcas m
JOIN produtos p ON m.id_marca = p.id_marca
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY m.nome, p.nome
ORDER BY m.nome, total_vendido DESC;

-- 14. EVOLUÇÃO DE VENDAS MÊS A MÊS
SELECT YEAR(data_venda) AS ano, MONTH(data_venda) AS mes,
       COUNT(*) AS qtd_vendas,
       SUM(iv.total_item) AS valor_total
FROM vendas v
JOIN (
    SELECT id_venda, SUM(quantidade * preco_unitario - desconto) AS total_item
    FROM itens_venda
    GROUP BY id_venda
) iv ON v.id_venda = iv.id_venda
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY ano, mes;

-- 15. CLIENTES QUE NÃO COMPRARAM NO ÚLTIMO TRIMESTRE
SELECT c.nome AS cliente, MAX(v.data_venda) AS ultima_compra
FROM clientes c
LEFT JOIN vendas v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
HAVING ultima_compra IS NULL 
OR ultima_compra < DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH);

-- 16. PRODUTOS COM MAIOR GIRO DE ESTOQUE
SELECT p.nome AS produto, 
       e.quantidade AS estoque_atual,
       SUM(iv.quantidade) AS total_vendido,
       ROUND(SUM(iv.quantidade) / e.quantidade, 2) AS giro_estoque
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produto
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome, e.quantidade
ORDER BY giro_estoque DESC;

-- 17. FORMAS DE PAGAMENTO MAIS UTILIZADAS
SELECT forma_pagamento, 
       COUNT(*) AS qtd_vendas,
       SUM(total_venda) AS valor_total
FROM vendas v
JOIN (
    SELECT id_venda, SUM(quantidade * preco_unitario - desconto) AS total_venda
    FROM itens_venda
    GROUP BY id_venda
) iv ON v.id_venda = iv.id_venda
GROUP BY forma_pagamento
ORDER BY valor_total DESC;

-- 18. MÉDIA DE TEMPO PARA ENTREGA
SELECT AVG(DATEDIFF(CURRENT_DATE, v.data_venda)) AS media_dias_em_aberto
FROM vendas v
WHERE v.status = 'Entregue';

-- 19. PRODUTOS COM DESEMPENHO ABAIXO DA MÉDIA
SELECT p.nome AS produto, 
       SUM(iv.quantidade) AS total_vendido
FROM produtos p
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
HAVING total_vendido < (
    SELECT AVG(total_vendido) 
    FROM (
        SELECT SUM(quantidade) AS total_vendido
        FROM itens_venda
        GROUP BY id_produto
    ) AS subquery
)
ORDER BY total_vendido ASC;

-- 20. RELAÇÃO DE PRODUTOS E SEUS FORNECEDORES
SELECT p.nome AS produto, 
       m.nome AS marca, 
       f.nome AS fornecedor,
       f.telefone AS contato_fornecedor
FROM produtos p
JOIN marcas m ON p.id_marca = m.id_marca
JOIN fornecedores f ON m.nome LIKE CONCAT('%', f.nome, '%') -- Relação aproximada
WHERE p.ativo = TRUE
ORDER BY m.nome, p.nome;