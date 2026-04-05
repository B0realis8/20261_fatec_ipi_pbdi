-- Active: 1775146451821@@127.0.0.1@5432@pbdi_20261
CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

--1.1 Faça um programa que exibe se um número inteiro é múltiplo de 3.

DO $$
DECLARE
    n INTEGER;
BEGIN
    n := valor_aleatorio_entre(1,1000);
    IF n%3 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 3 (resto %)',n,n%3;
    ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 3 (resto %)',n,n%3;
    END IF;
END;
$$

DO $$
DECLARE
    n INTEGER;
BEGIN
    n := valor_aleatorio_entre(1,1000);
    CASE WHEN n%3 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 3 (resto %)',n,n%3;
        ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 3 (resto %)',n,n%3;
    END CASE;
END;
$$

--1.2 Faça um programa que exibe se um número inteiro é múltiplo de 3 ou de 5

DO $$
DECLARE
    n INTEGER;
BEGIN
    n := valor_aleatorio_entre(1,1000);
    IF n%3 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 3 (resto %)',n,n%3;
    ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 3 (resto %)',n,n%3;
    END IF;
    IF n%5 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 5 (resto %)',n,n%5;
    ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 3 (resto %)',n,n%5;
    END IF;
END;
$$

DO $$
DECLARE
    n INTEGER;
BEGIN
    n := valor_aleatorio_entre(1,1000);
    CASE WHEN n%3 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 3 (resto %)',n,n%3;
        ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 3 (resto %)',n,n%3;
    END CASE;
    CASE WHEN n%5 = 0 THEN
        RAISE NOTICE 'O valor % é múltiplo de 5 (resto %)',n,n%5;
        ELSE
        RAISE NOTICE 'O valor % não é múltiplo de 5 (resto %)',n,n%5;
    END CASE;
END;
$$

--1.3 Faça um programa que opera de acordo com o seguinte menu.
--Opções:
--1 - Soma
--2 - Subtração
--3 - Multiplicação
--4 - Divisão
--Cada operação envolve dois números inteiros. O resultado deve ser exibido no formato
--Exemplo:
--op1 op op2 = res

DO $$
DECLARE
    n1 INTEGER;
    n2 INTEGER;
    res NUMERIC(10,2);
    opcao NUMERIC;
BEGIN
    opcao := valor_aleatorio_entre(1,4);
    n1 := valor_aleatorio_entre(1,1000);
    n2 := valor_aleatorio_entre(1,1000);
    IF opcao = 1 THEN
        res := n1+n2;
        RAISE NOTICE 'Soma: % + % = %',n1,n2,res;
    ELSEIF opcao = 2 THEN
        res := n1-n2;
        RAISE NOTICE 'Subtração: % - % = %',n1,n2,res;
    ELSEIF opcao = 3 THEN
        res := n1*n2;
        RAISE NOTICE 'Multiplicação: % * % = %',n1,n2,res;
    ELSEIF opcao = 4 THEN
        res := (n1/n2::numeric);
        RAISE NOTICE 'Divisão: % / % = %',n1,n2,res;
    END IF;
END;
$$

DO $$
DECLARE
    n1 INTEGER;
    n2 INTEGER;
    res NUMERIC(10,2);
    opcao NUMERIC;
BEGIN
    opcao := valor_aleatorio_entre(1,4);
    n1 := valor_aleatorio_entre(1,1000);
    n2 := valor_aleatorio_entre(1,1000);
    CASE opcao
    WHEN 1 THEN
        res := n1+n2;
        RAISE NOTICE '% + % = %',n1,n2,res;
    WHEN 2 THEN
        res := n1-n2;
        RAISE NOTICE '% - % = %',n1,n2,res;
    WHEN 3 THEN
        res := n1*n2;
        RAISE NOTICE '% * % = %',n1,n2,res;
    WHEN 4 THEN
        res := (n1/n2::numeric);
        RAISE NOTICE '% / % = %',n1,n2,res;
    END CASE;
END;
$$

--1.4 Um comerciante comprou um produto e quer vendê-lo com um lucro de 45% se o valor
--da compra for menor que R$20. Caso contrário, ele deseja lucro de 30%. Faça um
--programa que, dado o valor do produto, calcula o valor de venda.

DO $$
DECLARE
    preco_compra numeric(10,2);
    preco_venda numeric(10,2);
BEGIN
    preco_compra := valor_aleatorio_entre(1,100);
    RAISE NOTICE 'Valor de compra do produto: R$%',preco_compra;
    IF preco_compra < 20 THEN
        preco_venda := preco_compra * 1.45;
        RAISE NOTICE 'Preço de venda com margem de 45%%: R$%',preco_venda;
    ELSE
        preco_venda := preco_compra * 1.30;
        RAISE NOTICE 'Preço de venda com margem de 30%%: R$%',preco_venda;
    END IF;
END;
$$

DO $$
DECLARE
    preco_compra numeric(10,2);
    preco_venda numeric(10,2);
BEGIN
    preco_compra := valor_aleatorio_entre(1,100);
    RAISE NOTICE 'Valor de compra do produto: R$%',preco_compra;
    CASE 
        WHEN preco_compra < 20 THEN
            preco_venda := preco_compra * 1.45;
            RAISE NOTICE 'Preço de venda com margem de 45%%: R$%',preco_venda;
        WHEN preco_compra >= 20 THEN
            preco_venda := preco_compra * 1.30;
            RAISE NOTICE 'Preço de venda com margem de 30%%: R$%',preco_venda;
    END CASE;
END;
$$

