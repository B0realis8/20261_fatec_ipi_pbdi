-- Active: 1715688356851@@127.0.0.1@5432@20261_pbdi_renan


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
    limite_superior INTEGER := 17;
BEGIN
    n1 := random(); -- 0 <= n1 <1
    RAISE NOTICE '%',n1;
    n2 := floor(random() *10 +1)::int; -- 1<= n2 <= 10 com type cast para int
    RAISE NOTICE '%',n2;
    -- dados dois limites, calcule um número aleatório entre os dois:
    n2 := floor(random() * (limite_superior - limite_inferior) + 1 + limite_inferior)::int; -- 5 <= n2 <=17
    RAISE NOTICE '%',n2;
END;
$$

--DO
--$$
--BEGIN
--RAISE NOTICE '% + % = %', 2, 2, 2 + 2;
--END;

DO $$
DECLARE
--testar
--22/10/2022: valida
--29/02/2020: 2020 é bissexto, válida
--29/02/2021: inválida
--28/02/2021: válida
--31/06/2021: inválida
data INT := 31062021;
dia INT;
mes INT;
ano INT;
mesverificar INT;
data_valida BOOL := TRUE;
BEGIN
dia := data / 1000000;
mes := data % 1000000 / 10000;
mesverificar := data % 1000000;
ano := data % 10000;
RAISE NOTICE 'A data é %/%/%', dia, mes, ano;
RAISE NOTICE '%', mesverificar;
RAISE NOTICE 'Vejamos se é ela é válida...';

    IF ano >= 1 THEN
        CASE
            WHEN mes > 12 OR mes < 1 OR dia < 1 OR dia > 31 THEN
            data_valida := FALSE;
            ELSE
    --abril, junho, setembro e novembro não podem ter mais de 30 dias
            IF ((mes = 4 OR mes = 6 OR mes = 9 OR mes = 11) AND dia > 30) THEN
            data_valida := FALSE;
                ELSE
        --fevereiro
                IF mes = 2 THEN
                    CASE
    --se o ano for bissexto
                        WHEN ((ano % 4 = 0 AND ano % 100 <> 0)
                        OR ANO % 400 = 0) THEN
                        data_valida := FALSE;
                            IF dia > 29 THEN
                                data_valida := FALSE;
                            END IF;
                        ELSE
                            IF dia > 28 THEN
                                data_valida:=FALSE;
                    
                            END IF;
                    END CASE;
                END IF;
            END IF;
        END CASE;
    ELSE
        data_valida := FALSE;
    END IF;
    CASE
        WHEN data_valida THEN
            RAISE NOTICE 'Data válida';
        ELSE
            RAISE NOTICE 'Data inválida';
    END CASE;
END;
$$
