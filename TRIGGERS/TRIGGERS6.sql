-- 6. Trigger de Histórico de Status de Venda (AFTER UPDATE)

DELIMITER //
CREATE TRIGGER tr_historico_status_venda
AFTER UPDATE ON vendas
FOR EACH ROW
BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO historico_status_venda (
            id_venda,
            status_anterior,
            status_novo,
            data_alteracao,
            responsavel
        ) VALUES (
            NEW.id_venda,
            OLD.status,
            NEW.status,
            NOW(),
            CURRENT_USER()
        );
    END IF;
END //
DELIMITER ;

-- Tabela de suporte
CREATE TABLE IF NOT EXISTS historico_status_venda (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    status_anterior VARCHAR(50) NOT NULL,
    status_novo VARCHAR(50) NOT NULL,
    data_alteracao DATETIME NOT NULL,
    responsavel VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_venda) REFERENCES vendas(id_venda)
);