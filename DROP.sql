-- Desativa verificação de chaves estrangeiras temporariamente
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- REMOÇÃO DE TODOS OS TRIGGERS
-- =============================================
DROP TRIGGER IF EXISTS tr_auditoria_produtos;
DROP TRIGGER IF EXISTS tr_atualiza_estoque_venda;
DROP TRIGGER IF EXISTS tr_valida_desconto;
DROP TRIGGER IF EXISTS tr_historico_status_venda;
DROP TRIGGER IF EXISTS tr_bloqueia_alteracao_venda_concluida;
DROP TRIGGER IF EXISTS tr_atualiza_estatisticas_cliente;
DROP TRIGGER IF EXISTS tr_atualizar_estoque_venda;
DROP TRIGGER IF EXISTS tr_validar_estoque_venda;
DROP TRIGGER IF EXISTS tr_registrar_alteracao_preco;
DROP TRIGGER IF EXISTS tr_atualizar_ultima_compra;
DROP TRIGGER IF EXISTS tr_impedir_exclusao_produto_vendido;
DROP TRIGGER IF EXISTS tr_atualizar_total_venda;
DROP TRIGGER IF EXISTS tr_atualizar_total_venda_update;
DROP TRIGGER IF EXISTS tr_atualizar_total_venda_delete;
DROP TRIGGER IF EXISTS tr_log_alteracao_cliente;

-- =============================================
-- REMOÇÃO DE TODAS AS VIEWS
-- =============================================
DROP VIEW IF EXISTS vw_top_produtos_vendidos;
DROP VIEW IF EXISTS vw_clientes_maior_gasto;
DROP VIEW IF EXISTS vw_alerta_estoque_baixo;
DROP VIEW IF EXISTS vw_desempenho_funcionarios;
DROP VIEW IF EXISTS vw_produtos_sem_vendas;
DROP VIEW IF EXISTS vw_vendas_categoria_mensal;
DROP VIEW IF EXISTS vw_promocoes_ativas;
DROP VIEW IF EXISTS vw_margem_lucro_produtos;
DROP VIEW IF EXISTS vw_clientes_inativos;
DROP VIEW IF EXISTS vw_giro_estoque;

-- =============================================
-- REMOÇÃO DE TODAS AS FUNCTIONS
-- =============================================
DROP FUNCTION IF EXISTS fn_total_estoque_categoria;
DROP FUNCTION IF EXISTS fn_verificar_disponibilidade;
DROP FUNCTION IF EXISTS fn_calcular_idade_cliente;
DROP FUNCTION IF EXISTS fn_calcular_lucro_produto;
DROP FUNCTION IF EXISTS fn_status_venda;
DROP FUNCTION IF EXISTS fn_dias_desde_ultima_compra;
DROP FUNCTION IF EXISTS fn_media_valor_venda_cliente;

-- =============================================
-- REMOÇÃO DE TODOS OS PROCEDURES
-- =============================================
DROP PROCEDURE IF EXISTS sp_registrar_venda;
DROP PROCEDURE IF EXISTS sp_relatorio_financeiro_mensal;
DROP PROCEDURE IF EXISTS sp_repor_estoque;
DROP PROCEDURE IF EXISTS sp_analise_clientes;
DROP PROCEDURE IF EXISTS sp_atualizar_precos;
DROP PROCEDURE IF EXISTS sp_migrar_estoque;
DROP PROCEDURE IF EXISTS sp_cadastrar_produto_completo;
DROP PROCEDURE IF EXISTS sp_relatorio_vendas_periodo;
DROP PROCEDURE IF EXISTS sp_atualizar_estoque_notificacao;
DROP PROCEDURE IF EXISTS sp_analise_desempenho_funcionarios;
DROP PROCEDURE IF EXISTS sp_migrar_categoria;
DROP PROCEDURE IF EXISTS sp_aplicar_promocao_categoria;
DROP PROCEDURE IF EXISTS sp_verificar_coluna_data_nascimento;

-- =============================================
-- REMOÇÃO DE TODAS AS TABELAS (ORDEM INVERSA DE DEPENDÊNCIA)
-- =============================================
DROP TABLE IF EXISTS historico_estoque;
DROP TABLE IF EXISTS notificacoes;
DROP TABLE IF EXISTS historico_migracao_estoque;
DROP TABLE IF EXISTS historico_migracao_categoria;
DROP TABLE IF EXISTS log_alteracoes;
DROP TABLE IF EXISTS historico_precos;
DROP TABLE IF EXISTS auditoria_produtos;
DROP TABLE IF EXISTS historico_status_venda;
DROP TABLE IF EXISTS itens_venda;
DROP TABLE IF EXISTS promocoes;
DROP TABLE IF EXISTS vendas;
DROP TABLE IF EXISTS estoque;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS marcas;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS fornecedores;

-- Reativa verificação de chaves estrangeiras
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- VERIFICAÇÃO FINAL (OPCIONAL)
-- =============================================
-- Lista todos os objetos remanescentes (deve retornar vazio)
SELECT 
    table_name AS objeto, 
    'TABLE' AS tipo 
FROM information_schema.tables 
WHERE table_schema = DATABASE()

UNION ALL

SELECT 
    routine_name AS objeto, 
    routine_type AS tipo 
FROM information_schema.routines 
WHERE routine_schema = DATABASE()

UNION ALL

SELECT 
    trigger_name AS objeto, 
    'TRIGGER' AS tipo 
FROM information_schema.triggers 
WHERE trigger_schema = DATABASE()

UNION ALL

SELECT 
    table_name AS objeto, 
    'VIEW' AS tipo 
FROM information_schema.views 
WHERE table_schema = DATABASE();