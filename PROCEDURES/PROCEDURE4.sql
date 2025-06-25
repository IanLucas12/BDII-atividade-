-- 4. Procedure para Análise de Desempenho de Funcionários



DELIMITER //
CREATE PROCEDURE sp_analise_desempenho_funcionarios(
    IN p_mes INT,
    IN p_ano INT)
BEGIN
    -- 1. Total de vendas por funcionário
    SELECT f.nome AS funcionario, 
           COUNT(v.id_venda) AS total_vendas,
           SUM(iv.quantidade * iv.preco_unitario - iv.desconto) AS valor_total
    FROM funcionarios f
    LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
    LEFT JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE (p_mes IS NULL OR MONTH(v.data_venda) = p_mes)
    AND (p_ano IS NULL OR YEAR(v.data_venda) = p_ano)
    GROUP BY f.nome
    ORDER BY valor_total DESC;
    
    -- 2. Média de itens por venda
    SELECT f.nome AS funcionario,
           AVG(iv.quantidade) AS media_itens_por_venda
    FROM funcionarios f
    LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
    LEFT JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE (p_mes IS NULL OR MONTH(v.data_venda) = p_mes)
    AND (p_ano IS NULL OR YEAR(v.data_venda) = p_ano)
    GROUP BY f.nome
    ORDER BY media_itens_por_venda DESC;
    
    -- 3. Ticket médio por funcionário
    SELECT f.nome AS funcionario,
           AVG(iv.quantidade * iv.preco_unitario - iv.desconto) AS ticket_medio
    FROM funcionarios f
    LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
    LEFT JOIN itens_venda iv ON v.id_venda = iv.id_venda
    WHERE (p_mes IS NULL OR MONTH(v.data_venda) = p_mes)
    AND (p_ano IS NULL OR YEAR(v.data_venda) = p_ano)
    GROUP BY f.nome
    ORDER BY ticket_medio DESC;
    
    -- 4. Produtos mais vendidos por funcionário
    SELECT f.nome AS funcionario,
           p.nome AS produto,
           SUM(iv.quantidade) AS total_vendido
    FROM funcionarios f
    LEFT JOIN vendas v ON f.id_funcionario = v.id_funcionario
    LEFT JOIN itens_venda iv ON v.id_venda = iv.id_venda
    LEFT JOIN produtos p ON iv.id_produto = p.id_produto
    WHERE (p_mes IS NULL OR MONTH(v.data_venda) = p_mes)
    AND (p_ano IS NULL OR YEAR(v.data_venda) = p_ano)
    GROUP BY f.nome, p.nome
    ORDER BY f.nome, total_vendido DESC;
END //
DELIMITER ;

-- Teste
CALL sp_analise_desempenho_funcionarios(3, 2023);