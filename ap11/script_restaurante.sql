-- Active: 1742298013041@@127.0.0.1@5432@20261_fatec_ipi_pbdi_renanantonio
DROP TABLE tb_cliente;
CREATE TABLE tb_cliente (
    cod_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL
);

DROP TABLE tb_pedido;
CREATE TABLE IF NOT EXISTS tb_pedido(
    cod_pedido SERIAL PRIMARY KEY,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR DEFAULT 'aberto',
    cod_cliente INT NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES
    tb_cliente(cod_cliente)
);

DROP TABLE tb_tipo_item;
CREATE TABLE tb_tipo_item(
    cod_tipo SERIAL PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL
);

INSERT INTO tb_tipo_item (descricao) VALUES ('Bebida'), ('Comida');

DROP TABLE tb_item;
CREATE TABLE IF NOT EXISTS tb_item(
    cod_item SERIAL PRIMARY KEY,
    descricao VARCHAR(200) NOT NULL,
    valor NUMERIC (10, 2) NOT NULL,
    cod_tipo INT NOT NULL,
    CONSTRAINT fk_tipo_item FOREIGN KEY (cod_tipo) REFERENCES tb_tipo_item(cod_tipo)
);

INSERT INTO tb_item (descricao, valor, cod_tipo) VALUES
('Refrigerante', 7, 1), ('Suco', 8, 1), ('Hamburguer', 12, 2), ('Batata frita', 9, 2);
SELECT * FROM tb_item;

DROP TABLE tb_item_pedido;
CREATE TABLE IF NOT EXISTS tb_item_pedido(
    --surrogate key, assim cod_item pode repetir
    cod_item_pedido SERIAL PRIMARY KEY,
    cod_item INT,
    cod_pedido INT,
    CONSTRAINT fk_item FOREIGN KEY (cod_item) REFERENCES tb_item (cod_item),
    CONSTRAINT fk_pedido FOREIGN KEY (cod_pedido) REFERENCES tb_pedido
    (cod_pedido)
);

-- cadastro de cliente
-- se um parâmetro com valor DEFAULT é especificado, aqueles que aparecem depois dele
--também deve ter valor DEFAULT
CREATE OR REPLACE PROCEDURE sp_cadastrar_cliente (IN nome VARCHAR(200), IN
codigo INT DEFAULT NULL)
LANGUAGE plpgsql
AS $$
BEGIN
IF codigo IS NULL THEN
INSERT INTO tb_cliente (nome) VALUES (nome);
ELSE
INSERT INTO tb_cliente (codigo, nome) VALUES (codigo, nome);
END IF;
END;
$$;

CALL sp_cadastrar_cliente ('João da Silva');
CALL sp_cadastrar_cliente ('Maria Santos');
SELECT * FROM tb_cliente;


CREATE OR REPLACE PROCEDURE sp_criar_pedido (OUT cod_pedido INT, cod_cliente INT)
LANGUAGE plpgsql
AS $$
BEGIN
INSERT INTO tb_pedido (cod_cliente) VALUES (cod_cliente);
-- obtém o último valor gerado por SERIAL
SELECT LASTVAL() INTO cod_pedido;
END;
$$;

DO
$$
DECLARE
--para guardar o código de pedido gerado
cod_pedido INT;
-- o código do cliente que vai fazer o pedido
cod_cliente INT;
BEGIN
-- pega o código da pessoa cujo nome é "João da Silva"
SELECT c.cod_cliente FROM tb_cliente c WHERE nome LIKE 'João da Silva' INTO cod_cliente;
--cria o pedido
CALL sp_criar_pedido (cod_pedido, cod_cliente);
RAISE NOTICE 'Código do pedido recém criado: %', cod_pedido;
END;
$$