-- Inserindo categorias
INSERT INTO categorias (nome) VALUES
('Camisetas'), ('Calças'), ('Vestidos'), ('Casacos'), ('Sapatos'),
('Acessórios'), ('Roupas Íntimas'), ('Esportivo'), ('Jeans'), ('Moda Praia');

-- Inserindo marcas
INSERT INTO marcas (nome) VALUES
('Nike'), ('Adidas'), ('Zara'), ('H&M'), ('Levi''s'),
('Puma'), ('Gucci'), ('Louis Vuitton'), ('Calvin Klein'), ('Tommy Hilfiger');

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, tamanho, cor, id_categoria, id_marca, custo, ativo) VALUES
('Camiseta Basic', 'Camiseta algodão puro', 49.90, 'M', 'Branca', 1, 1, 25.00, TRUE),
('Jeans Skinny', 'Calça jeans modelo skinny', 199.90, '38', 'Azul', 2, 5, 89.90, TRUE),
('Tênis Runner', 'Tênis para corrida', 349.90, '40', 'Preto', 5, 2, 150.00, TRUE),
('Vestido Floral', 'Vestido midi floral', 159.90, 'P', 'Multicolor', 3, 3, 70.00, TRUE),
('Jaqueta Corta-Vento', 'Jaqueta impermeável', 279.90, 'G', 'Vermelha', 4, 4, 120.00, TRUE),
('Bolsa Tote', 'Bolsa grande em couro sintético', 189.90, 'Único', 'Bege', 6, 7, 80.00, TRUE),
('Cueca Boxer', 'Cueca algodão comfort', 39.90, 'M', 'Preta', 7, 9, 15.00, TRUE),
('Shorts Esportivo', 'Shorts para atividades físicas', 79.90, 'GG', 'Cinza', 8, 6, 35.00, TRUE),
('Biquíni Listrado', 'Conjunto de biquíni', 129.90, '42', 'Azul Marinho', 10, 4, 55.00, TRUE),
('Óculos de Sol', 'Óculos com proteção UV', 159.90, 'Único', 'Preto', 6, 8, 65.00, TRUE);

-- Inserindo estoque
INSERT INTO estoque (id_produto, quantidade, data_entrada) VALUES
(1, 100, '2023-01-15'), (2, 50, '2023-02-10'), (3, 30, '2023-03-05'),
(4, 40, '2023-01-20'), (5, 25, '2023-02-28'), (6, 15, '2023-03-15'),
(7, 200, '2023-01-10'), (8, 60, '2023-02-20'), (9, 35, '2023-03-01'),
(10, 20, '2023-03-10');

-- Inserindo fornecedores
INSERT INTO fornecedores (nome, endereco, telefone, email) VALUES
('Distribuidora Moda Ltda', 'Rua das Indústrias, 100', '(11) 1234-5678', 'contato@distribuidora.com.br'),
('Confecções Estilo S/A', 'Av. da Produção, 500', '(21) 9876-5432', 'vendas@estiloconfec.com.br'),
('Importadora Luxury', 'Rua Internacional, 789', '(31) 4567-8901', 'compras@luxuryimport.com.br'),
('Atacado Vest Bem', 'Av. Comercial, 1234', '(41) 2345-6789', 'atendimento@vestbem.com.br'),
('Malhas e Cia', 'Rua dos Tecidos, 56', '(51) 7890-1234', 'malhas@malhasecia.com.br'),
('Acessórios Fashion', 'Av. dos Acessórios, 789', '(85) 6789-0123', 'contato@fashionacess.com.br'),
('Couros Nobres', 'Rua do Couro, 321', '(71) 9012-3456', 'vendas@courosnobres.com.br'),
('Esportivo Radical', 'Av. Esportiva, 654', '(19) 3456-7890', 'compras@radicalesport.com.br'),
('Praia e Sol', 'Rua das Ondas, 987', '(47) 5678-9012', 'contato@praiaesol.com.br'),
('Luxo Europeu', 'Av. Elegante, 159', '(11) 9876-5432', 'import@luxoeuropeu.com.br');

-- Inserindo clientes
INSERT INTO clientes (nome, endereco, telefone, email, cpf, data_cadastro) VALUES
('João Silva', 'Rua A, 123', '(11) 9999-8888', 'joao@email.com', '123.456.789-00', '2023-01-05'),
('Maria Santos', 'Av. B, 456', '(21) 8888-7777', 'maria@email.com', '987.654.321-00', '2023-01-10'),
('Carlos Oliveira', 'Rua C, 789', '(31) 7777-6666', 'carlos@email.com', '456.789.123-00', '2023-01-15'),
('Ana Pereira', 'Av. D, 101', '(41) 6666-5555', 'ana@email.com', '789.123.456-00', '2023-02-01'),
('Pedro Costa', 'Rua E, 202', '(51) 5555-4444', 'pedro@email.com', '321.654.987-00', '2023-02-10'),
('Juliana Almeida', 'Av. F, 303', '(85) 4444-3333', 'juliana@email.com', '654.987.321-00', '2023-02-15'),
('Marcos Souza', 'Rua G, 404', '(71) 3333-2222', 'marcos@email.com', '147.258.369-00', '2023-03-01'),
('Fernanda Lima', 'Av. H, 505', '(19) 2222-1111', 'fernanda@email.com', '258.369.147-00', '2023-03-05'),
('Ricardo Rocha', 'Rua I, 606', '(47) 1111-0000', 'ricardo@email.com', '369.147.258-00', '2023-03-10'),
('Patrícia Nunes', 'Av. J, 707', '(11) 9999-0000', 'patricia@email.com', '159.357.486-00', '2023-03-15');

-- Inserindo funcionários
INSERT INTO funcionarios (nome, cargo, telefone, email) VALUES
('Roberto Alves', 'Gerente', '(11) 9888-7777', 'roberto@loja.com'),
('Sandra Moraes', 'Vendedor', '(21) 9777-6666', 'sandra@loja.com'),
('Luiz Gonzaga', 'Vendedor', '(31) 9666-5555', 'luiz@loja.com'),
('Amanda Dias', 'Caixa', '(41) 9555-4444', 'amanda@loja.com'),
('Gustavo Henrique', 'Estoquista', '(51) 9444-3333', 'gustavo@loja.com'),
('Beatriz Campos', 'Vendedor', '(85) 9333-2222', 'beatriz@loja.com'),
('Rodrigo Pires', 'Supervisor', '(71) 9222-1111', 'rodrigo@loja.com'),
('Tatiane Melo', 'Vendedor', '(19) 9111-0000', 'tatiane@loja.com'),
('Felipe Castro', 'Caixa', '(47) 9000-9999', 'felipe@loja.com'),
('Larissa Monteiro', 'Gerente', '(11) 9888-9999', 'larissa@loja.com');

-- Inserindo vendas
INSERT INTO vendas (id_cliente, id_funcionario, data_venda, forma_pagamento, status, observacoes) VALUES
(1, 2, '2023-03-01', 'Cartão Crédito', 'Entregue', 'Presente para aniversário'),
(3, 3, '2023-03-02', 'PIX', 'Preparando envio', NULL),
(5, 6, '2023-03-03', 'Cartão Débito', 'Entregue', NULL),
(2, 2, '2023-03-04', 'Dinheiro', 'Cancelada', 'Cliente desistiu'),
(4, 8, '2023-03-05', 'Cartão Crédito', 'Enviado', 'Presente para mãe'),
(6, 3, '2023-03-06', 'PIX', 'Entregue', 'Embalar com cuidado'),
(7, 6, '2023-03-07', 'Cartão Débito', 'Preparando envio', NULL),
(9, 8, '2023-03-08', 'Cartão Crédito', 'Enviado', NULL),
(10, 2, '2023-03-09', 'PIX', 'Entregue', 'Entregar após 18h'),
(8, 3, '2023-03-10', 'Dinheiro', 'Cancelada', 'Produto esgotado');

-- Inserindo itens de venda
INSERT INTO itens_venda (id_venda, id_produto, quantidade, preco_unitario, desconto) VALUES
(1, 1, 2, 49.90, 0), (1, 7, 3, 39.90, 5.00),
(2, 3, 1, 349.90, 20.00), (3, 5, 1, 279.90, 0),
(3, 9, 1, 129.90, 10.00), (4, 2, 1, 199.90, 0),
(5, 4, 1, 159.90, 0), (5, 6, 1, 189.90, 15.00),
(6, 8, 2, 79.90, 0), (7, 10, 1, 159.90, 0),
(8, 1, 1, 49.90, 0), (8, 2, 1, 199.90, 0),
(9, 3, 1, 349.90, 30.00), (10, 4, 1, 159.90, 0);

-- Inserindo promoções
INSERT INTO promocoes (id_produto, desconto, data_inicio, data_fim) VALUES
(1, 15.00, '2023-03-01', '2023-03-15'),
(3, 20.00, '2023-03-05', '2023-03-20'),
(5, 10.00, '2023-03-10', '2023-03-25'),
(7, 25.00, '2023-03-15', '2023-03-30'),
(9, 15.00, '2023-03-20', '2023-04-05'),
(2, 10.00, '2023-04-01', '2023-04-15'),
(4, 20.00, '2023-04-05', '2023-04-20'),
(6, 15.00, '2023-04-10', '2023-04-25'),
(8, 10.00, '2023-04-15', '2023-04-30'),
(10, 25.00, '2023-04-20', '2023-05-05');