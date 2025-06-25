-- 2. Procedure para Relatório de Vendas por Período



DELIMITER //
CREATE PROCEDURE sp_relatorio_vendas_periodo(
    IN p_data_inicio DATE,
    IN p_data_fim DATE)
BEGIN
    -- 1. Total de vendas no período
    SELECT COUNT(*) AS total_vendas, 
           SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_total
    FROM vendas v
    JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE v.data_venda BETWEEN p_data_inicio AND p_data_fim;
    
    -- 2. Vendas por dia
    SELECT v.data_venda, 
           COUNT(*) AS qtd_vendas,
           SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_dia
    FROM vendas v
    JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE v.data_venda BETWEEN p_data_inicio AND p_data_fim
    GROUP BY v.data_venda
    ORDER BY v.data_venda;
    
    -- 3. Top 5 produtos mais vendidos
    SELECT p.nome AS produto, 
           SUM(iv.quantidade) AS total_vendido
    FROM produtos p
    JOIN itens_venda iv ON p.id_produto = iv.id_produto
    JOIN vendas v ON iv.id_venda = v.id_venda
    WHERE v.data_venda BETWEEN p_data_inicio AND p_data_fim
    GROUP BY p.nome
    ORDER BY total_vendido DESC
    LIMIT 5;
    
    -- 4. Formas de pagamento mais utilizadas
    SELECT v.forma_pagamento, 
           COUNT(*) AS qtd_vendas,
           SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_total
    FROM vendas v
    JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE v.data_venda BETWEEN p_data_inicio AND p_data_fim
    GROUP BY v.forma_pagamento
    ORDER BY valor_total DESC;
END //
DELIMITER ;

-- Teste
CALL sp_relatorio_vendas_periodo('2023-03-01', '2023-03-31');