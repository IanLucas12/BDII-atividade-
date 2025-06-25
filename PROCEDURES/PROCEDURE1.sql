-- 1. Procedure para Cadastro Completo de Produto


-- 1. TOP_PRODUTOS_MAIS_VENDIDOS
CREATE VIEW vw_top_produtos_vendidos AS
SELECT p.nome AS produto, SUM(iv.quantidade) AS total_vendido
FROM produtos p
JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome
ORDER BY total_vendido DESC
LIMIT 10;

-- 2. CLIENTES_MAIOR_VALOR_GASTO
CREATE VIEW vw_clientes_maior_gasto AS
SELECT c.nome AS cliente, 
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS total_gasto
FROM clientes c
JOIN vendas v ON c.id_cliente = v.id_cliente
JOIN itens_venda iv ON v.id_venda = iv.id_venda
GROUP BY c.nome
ORDER BY total_gasto DESC;

-- 3. ALERTA_ESTOQUE_BAIXO
CREATE VIEW vw_alerta_estoque_baixo AS
SELECT p.nome AS produto, e.quantidade AS estoque
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produto
WHERE e.quantidade < 10 AND p.ativo = TRUE
ORDER BY e.quantidade ASC;

-- 4. DESEMPENHO_FUNCIONARIOS
CREATE VIEW vw_desempenho_funcionarios AS
SELECT f.nome AS funcionario, 
       COUNT(v.id_venda) AS total_vendas,
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_total
FROM funcionarios f
JOIN vendas v ON f.id_funcionario = v.id_funcionario
JOIN itens_venda iv ON v.id_venda = iv.id_venda
GROUP BY f.nome
ORDER BY valor_total DESC;

-- 5. PRODUTOS_SEM_VENDAS
CREATE VIEW vw_produtos_sem_vendas AS
SELECT p.nome AS produto, p.preco, m.nome AS marca
FROM produtos p
LEFT JOIN itens_venda iv ON p.id_produto = iv.id_produto
JOIN marcas m ON p.id_marca = m.id_marca
WHERE iv.id_item IS NULL AND p.ativo = TRUE;

-- 6.  VENDAS_POR_CATEGORIA_MENSAL
CREATE VIEW vw_vendas_categoria_mensal AS
SELECT cat.nome AS categoria, 
       SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS total_vendido,
       MONTH(v.data_venda) AS mes,
       YEAR(v.data_venda) AS ano
FROM categorias cat
JOIN produtos p ON cat.id_categoria = p.id_categoria
JOIN itens_venda iv ON p.id_produto = iv.id_produto
JOIN vendas v ON iv.id_venda = v.id_venda
GROUP BY cat.nome, mes, ano
ORDER BY ano, mes, total_vendido DESC;

-- 7. PROMOCOES_ATIVAS
CREATE VIEW vw_promocoes_ativas AS
SELECT p.nome AS produto, 
       pr.desconto AS desconto_percentual,
       p.preco AS preco_original, 
       ROUND(p.preco * (1 - pr.desconto/100), 2) AS preco_promocional,
       pr.data_inicio,
       pr.data_fim
FROM produtos p
JOIN promocoes pr ON p.id_produto = pr.id_produto
WHERE CURRENT_DATE() BETWEEN pr.data_inicio AND pr.data_fim
AND p.ativo = TRUE;

-- 8.  MARGEM_LUCRO_PRODUTOS
CREATE VIEW vw_margem_lucro_produtos AS
SELECT p.nome AS produto, 
       p.preco AS preco_venda, 
       p.custo,
       (p.preco - p.custo) AS lucro_unitario,
       ROUND(((p.preco - p.custo) / p.custo * 100), 2) AS margem_percentual,  
       m.nome AS marca
FROM produtos p
JOIN marcas m ON p.id_marca = m.id_marca
WHERE p.custo > 0
ORDER BY margem_percentual DESC;

-- 9. CLIENTES_INATIVOS

CREATE VIEW vw_clientes_inativos AS
SELECT c.nome AS cliente, 
       MAX(v.data_venda) AS ultima_compra,
       DATEDIFF(CURRENT_DATE, MAX(v.data_venda)) AS dias_sem_comprar
FROM clientes c
LEFT JOIN vendas v ON c.id_cliente = v.id_cliente
GROUP BY c.nome
HAVING ultima_compra IS NULL 
OR ultima_compra < DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH)
ORDER BY dias_sem_comprar DESC;

-- 10. ANALISE_GIRO_ESTOQUE 

CREATE VIEW vw_giro_estoque AS
SELECT p.nome AS produto, 
       e.quantidade AS estoque_atual,
       COALESCE(SUM(iv.quantidade), 0) AS total_vendido,
       CASE 
           WHEN e.quantidade = 0 THEN 999.99
           ELSE ROUND(COALESCE(SUM(iv.quantidade), 0) / e.quantidade, 2)
       END AS giro_estoque
FROM produtos p
JOIN estoque e ON p.id_produto = e.id_produto
LEFT JOIN itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome, e.quantidade
ORDER BY giro_estoque DESC;