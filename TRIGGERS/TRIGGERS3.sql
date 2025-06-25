-- 3. Trigger de Auditoria para Produtos (Depois do UPDATE)



DELIMITER //
CREATE TRIGGER tr_auditoria_produtos
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    IF OLD.preco != NEW.preco THEN
        INSERT INTO auditoria_produtos (
            id_produto, 
            campo_alterado, 
            valor_antigo, 
            valor_novo, 
            usuario, 
            data_alteracao
        ) VALUES (
            NEW.id_produto,
            'preco',
            OLD.preco,
            NEW.preco,
            CURRENT_USER(),
            NOW()
        );
    END IF;
END //
DELIMITER ;

-- Tabela de suporte
CREATE TABLE IF NOT EXISTS auditoria_produtos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT NOT NULL,
    campo_alterado VARCHAR(50) NOT NULL,
    valor_antigo TEXT,
    valor_novo TEXT,
    usuario VARCHAR(100) NOT NULL,
    data_alteracao DATETIME NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);