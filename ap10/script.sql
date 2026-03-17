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