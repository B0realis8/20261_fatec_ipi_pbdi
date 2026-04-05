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

DO
$$
DECLARE
    vetor INT[] := ARRAY[1, 2, 3];
    matriz INT[] := ARRAY[
                            [1, 2, 3],
                            [4, 5, 6],
                            [7, 8, 9]
                        ];
    var_aux INT;
    vet_aux INT[];
BEGIN
    RAISE NOTICE 'SLICE %, vetor', 0;-- exemplo sem slice com vetor
    FOREACH var_aux IN ARRAY vetor LOOP
        RAISE NOTICE '%', var_aux;
    END LOOP;--exemplo com slice igual a 1, com vetor--observe que a variável deve ser um vetor--com slice igual a 1, pegamos o vetor inteiro
    RAISE NOTICE 'SLICE %, vetor', 1;
    FOREACH vet_aux SLICE 1 IN ARRAY vetor LOOP
        RAISE NOTICE '%', vet_aux;--podemos percorrer vet_aux
    FOREACH var_aux IN ARRAY vet_aux LOOP
        RAISE NOTICE '%', var_aux;
    END LOOP;
    END LOOP;--exemplo com slice igual a 0, com matriz
    RAISE NOTICE 'SLICE %, matriz', 0;
    FOREACH var_aux IN ARRAY matriz LOOP
        RAISE NOTICE '%', var_aux;
    END LOOP;--exemplo com slice igual a 1, com matriz--com slice igual a 1, pegamos um vetor (linha) por vez
    RAISE NOTICE 'SLICE %, matriz', 1;
    FOREACH vet_aux SLICE 1 IN ARRAY matriz LOOP
        RAISE NOTICE '%', vet_aux;
    END LOOP;--exemplo com slice igual a 2, com matriz--com slice igual a 2, pegamos a matriz inteira numa única iteraçao
    RAISE NOTICE 'SLICE %, matriz', 2;
    FOREACH vet_aux SLICE 2 IN ARRAY matriz LOOP
        RAISE NOTICE '%', vet_aux;
    END LOOP;
END;
$$