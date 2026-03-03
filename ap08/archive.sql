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

--DO
--$$
--BEGIN
--RAISE NOTICE '% + % = %', 2, 2, 2 + 2;
--END;
$$