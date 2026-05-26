-- Active: 1775146451821@@127.0.0.1@5432@pbdi_20261_ap12
--1.4.1 Exibe o número de estudantes maiores de idade.

CREATE OR REPLACE PROCEDURE estudantes_maiores_de_idade()
LANGUAGE plpgsql
AS $$
DECLARE
    idades INT;
BEGIN
    SELECT COUNT(*) FROM estudantes WHERE age >= 1 INTO idades;
    RAISE NOTICE '%', idades;
END;
$$;

CALL estudantes_maiores_de_idade();

-- 1.4.2 Exibe o percentual de estudantes de cada sexo.

CREATE OR REPLACE PROCEDURE estudantes_sexo()
LANGUAGE plpgsql
AS $$
DECLARE
    masculino INT;
    feminino INT;
    resultadoM NUMERIC;
    resultadoF NUMERIC;
BEGIN
    SELECT count(*) FROM estudantes WHERE gender = 2 INTO masculino;
    SELECT count(*) FROM estudantes WHERE gender = 1 INTO feminino;
    resultadoM := masculino * 100 / (masculino + feminino);
    resultadoF := feminino * 100 / (masculino + feminino);
    RAISE NOTICE '%', resultadoM;
    RAISE NOTICE '%', resultadoF;
END;
$$;

CALL estudantes_sexo();

--1.4.3 Recebe um sexo como parâmetro em modo IN e utiliza oito parâmetros em modo OUT
--para dizer qual o percentual de cada nota (variável grade) obtida por estudantes daquele
--sexo.

CREATE OR REPLACE PROCEDURE estudantes_nota(IN sexo INT, OUT nota0 INT, OUT nota1 INT, OUT nota2 INT, OUT nota3 INT,
OUT nota4 INT, OUT nota5 INT, OUT nota6 INT, OUT nota7 INT)
LANGUAGE plpgsql
AS $$
DECLARE
    n_total_notas INT;
BEGIN
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 0 INTO nota0;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 1 INTO nota1;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 2 INTO nota2;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 3 INTO nota3;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 4 INTO nota4;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 5 INTO nota5;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 6 INTO nota6;
        SELECT count(*) FROM estudantes WHERE gender = sexo AND grade = 7 INTO nota7;
        n_total_notas := nota0 + nota1 + nota2 + nota3 + nota4 + nota5 + nota6 + nota7;
        nota0 := nota0 * 100 / n_total_notas;
        nota1 := nota1 * 100 / n_total_notas;
        nota2 := nota2 * 100 / n_total_notas;
        nota3 := nota3 * 100 / n_total_notas;
        nota4 := nota4 * 100 / n_total_notas;
        nota5 := nota5 * 100 / n_total_notas;
        nota6 := nota6 * 100 / n_total_notas;
        nota7 := nota7 * 100 / n_total_notas;
END;
$$;

DO
$$
DECLARE
    nota0 INT;
    nota1 INT;
    nota2 INT;
    nota3 INT;
    nota4 INT;
    nota5 INT;
    nota6 INT;
    nota7 INT;
BEGIN
    CALL estudantes_nota(1, nota0, nota1, nota2, nota3, nota4, nota5, nota6, nota7);
    RAISE NOTICE 'Notas das estudantes mulheres: 0: % %%, 1: % %%, 2: % %%, 3: % %%, 4: % %%, 5: % %%, 6: % %%, 7: % %%', nota0, nota1, nota2, nota3, nota4, nota5, nota6, nota7;
    CALL estudantes_nota(2, nota0, nota1, nota2, nota3, nota4, nota5, nota6, nota7);
    RAISE NOTICE 'Notas dos estudantes homens: 0: % %%, 1: % %%, 2: % %%, 3: % %%, 4: % %%, 5: % %%, 6: % %%, 7: % %%', nota0, nota1, nota2, nota3, nota4, nota5, nota6, nota7;
END;
$$

--1.5 Escreva as seguintes functions (incluindo um bloco anônimo de teste para cada uma)

--1.5.1 Responde (devolve boolean) se é verdade que todos os estudantes de renda acima de
--410 são aprovados (grade > 0).

CREATE OR REPLACE FUNCTION estudantes_aprovados(IN nota INT) RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN (nota > 0);
END;
$$;

CREATE OR REPLACE FUNCTION fn_executar(IN fn_funcao TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    nota INT;
    notas RECORD;
    resultado boolean;
BEGIN
    FOR notas IN SELECT grade FROM estudantes WHERE salary = 5 LOOP
    EXECUTE format ('SELECT %s (%s)', fn_funcao, notas.grade) INTO resultado;
    IF resultado = FALSE THEN
        RETURN FALSE;
    END IF;
    END LOOP;
    RETURN TRUE;
END;
$$;

DO $$
DECLARE
    resultado BOOLEAN;
BEGIN
    SELECT  fn_executar ('estudantes_aprovados') INTO resultado;
    RAISE NOTICE '%', resultado;
END;
$$;

-- 1.5.2 Responde (devolve boolean) se é verdade que, entre os estudantes que fazem
-- anotações pelo menos algumas vezes durante as aulas, pelo menos 70% são aprovados
-- (grade > 0).

CREATE OR REPLACE FUNCTION fn_executar2(IN fn_funcao TEXT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    nota INT;
    notas RECORD;
    resultado boolean;
    n_estudantes INT := 0;
    estudantes_total INT := 0;
BEGIN
    FOR notas IN SELECT grade FROM estudantes WHERE notes >= 2 LOOP
    EXECUTE format ('SELECT %s (%s)', fn_funcao, notas.grade) INTO resultado;
    IF resultado = TRUE THEN
        n_estudantes := n_estudantes + 1;
    END IF;
    END LOOP;
    RETURN n_estudantes;
END;
$$;

DO $$
DECLARE
    resultado INT;
    estudantes_total INT;
    resposta BOOLEAN;
BEGIN
    SELECT fn_executar2 ('estudantes_aprovados') INTO resultado;
    SELECT count(*) FROM estudantes WHERE notes >= 2 INTO estudantes_total;
    resultado := resultado * 100 / estudantes_total;
    if resultado >= 70 THEN
        resposta := TRUE;
    ELSE
        resposta := FALSE;
    END IF;
    RAISE NOTICE '%', estudantes_total;
    RAISE NOTICE '% %%', resultado;
    RAISE NOTICE '%', resposta;
END;
$$;
