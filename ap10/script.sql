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