-- 2. Trigger para Registrar Alterações de Preços (Depois do UPDATE)



DELIMITER //
CREATE TRIGGER tr_registrar_alteracao_preco
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.preco != NEW.preco THEN
        INSERT INTO historico_precos (id_produto, preco_antigo, preco_novo, data_alteracao)
        VALUES (NEW.id_produto, OLD.preco, NEW.preco, NOW());
    END IF;
END //
DELIMITER ;

-- Tabela auxiliar
CREATE TABLE IF NOT EXISTS historico_precos (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    preco_antigo DECIMAL(10,2),
    preco_novo DECIMAL(10,2),
    data_alteracao DATETIME,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

-- Teste
UPDATE produtos SET preco = preco * 1.1 WHERE id_produto = 1;
SELECT * FROM historico_precos;