-- 1. Adicionar coluna de CPF em clientes
ALTER TABLE clientes ADD COLUMN cpf VARCHAR(14) UNIQUE;

-- 2. Modificar tipo da coluna tamanho (Sintaxe original correta para MySQL)
ALTER TABLE produtos MODIFY COLUMN tamanho VARCHAR(20);

-- 3. Adicionar índice em nome do produto
CREATE INDEX idx_nome_produto ON produtos(nome);

-- 4. Adicionar coluna de custo em produtos
ALTER TABLE produtos ADD COLUMN custo DECIMAL(10,2);

-- 5. Remover coluna de descrição de categorias
ALTER TABLE categorias DROP COLUMN descricao;

-- 6. Adicionar restrição de preço positivo
ALTER TABLE produtos ADD CONSTRAINT chk_preco_positivo CHECK (preco > 0);

-- 7. Adicionar coluna de status em produtos (MySQL usa TINYINT(1) para BOOLEAN)
ALTER TABLE produtos ADD COLUMN ativo BOOLEAN DEFAULT TRUE;

-- 8. Alterar nome da coluna status_entrega (Sintaxe correta para MySQL)
ALTER TABLE vendas CHANGE COLUMN status_entrega status VARCHAR(50); -- IMPORTANTE: Especifique o tipo de dado da coluna novamente.

-- 9. Adicionar coluna de data de cadastro em clientes
ALTER TABLE clientes ADD COLUMN data_cadastro DATE;

-- 10. Adicionar coluna de observação em vendas
ALTER TABLE vendas ADD COLUMN observacoes TEXT;
