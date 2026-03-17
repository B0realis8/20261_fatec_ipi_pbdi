CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    contador INT = 0;
BEGIN
    LOOP
        contador = contador +1; --não tem contador
        EXIT WHEN contador >100;

        IF contador % 7 = 0 THEN -- remove multiplos de 7
            CONTINUE;
        END IF;
        CONTINUE WHEN contador % 11 = 0; -- remove multiplos de 11
        RAISE NOTICE '%', contador;

    END LOOP;
END;
$$

DO $$
DECLARE
    i INT;
    j INT;
BEGIN
    i:= 0;
    <<externo>>
    LOOP

        i = i + 1;
        EXIT WHEN i > 10;
        j := 1;
        <<interno>>
        LOOP
            RAISE NOTICE '% , %', i, j;
            j := j+1;
            EXIT WHEN j> 10;
            CONTINUE externo WHEN j > 5;
        END LOOP;
    END LOOP;
END $$

DO $$ -- Nessa função, quando o valor selecionado é -1 o loop é interrompido e a média é calculada com base na quantidade de valores que foram gerados antes do -1 ser selecionado
DECLARE
    nota INT;
    media NUMERIC(10,2) := 0;
    contador INT := 0;

BEGIN
    SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;

    WHILE nota >= 0 LOOP
        RAISE NOTICE 'Nota desse aluno(a): %', nota;
        media := media + nota;
        contador := contador +1;
        SELECT valor_aleatorio_entre(0, 11) - 1 INTO nota;

    END LOOP;
    IF contador > 0 THEN
        RAISE NOTICE 'Média: %', media/contador;
    ELSE
        RAISE NOTICE 'Nenhuma nota gerada';
    END IF;
END $$

DO $$
BEGIN -- Nessa função, não declaramos o i
    RAISE NOTICE 'De 1 a 10, de um em um';
    FOR i IN 1..10 LOOP
        RAISE NOTICE '%',i;
    END LOOP;

    RAISE NOTICE 'E agora...?';
    FOR i IN REVERSE 10..1 LOOP -- IN REVERSE reverte a contagem
        RAISE NOTICE '%', i;
    END LOOP;

    RAISE NOTICE 'De 1 a 50, de dois em dois';
    FOR i IN 1..50 BY 2 LOOP
        RAISE NOTICE '%',i;
    END LOOP;

END $$

