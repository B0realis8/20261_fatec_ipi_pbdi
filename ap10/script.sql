DO $$
DECLARE
    contador INT = 0;
BEGIN
    LOOP
        RAISE NOTICE '%', contador;
        contador = contador +1; --não tem contador
        IF contador > 10 THEN
            EXIT;
        END IF;
    END LOOP;
END;
$$