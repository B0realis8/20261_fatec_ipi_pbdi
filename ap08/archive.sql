-- Active: 1742297457591@@127.0.0.1@5432@20261_ipi_pbdi


DO $$
DECLARE
    codigo := 1;
    nome_completo VARCHAR(100) := 'João Silva'
    salario NUERIC(11, 2) := 20.5;
BEGIN
    RAISE NOTICE 'Meu código é %, mechamo % e meu salário é R$%.', codigo, nome_completo, salario;
END
$$

DO $$
-- A função random gera valores reais no intervalo 0<= n <1
DECLARE
    n1 NUMERIC(5,2);
    n2 INTEGER;
    limite_inferior INTEGER := 5;
    lmite_superior INTEGER := 17;
BEGIN
    n1 := random(); -- 0 <= n1 <1
    RAISE NOTICE '%',n1;
END;
$$

--DO
--$$
--BEGIN
--RAISE NOTICE '% + % = %', 2, 2, 2 + 2;
--END;
