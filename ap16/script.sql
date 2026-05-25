CREATE TABLE tb_top_youtubers(
    cod_top_youtubers SERIAL PRIMARY KEY,
    rank INT,
    youtuber VARCHAR(200),
    subscribers INT,
    video_views VARCHAR(200),
    video_count INT,
    category VARCHAR(200),
    started INT
);

SELECT * FROM tb_top_youtubers;

DO $$
DECLARE
    --declaração do CURSOR, inicialmente unbound por não estar vinculado a uma query
    cur_nomes_youtubers REFCURSOR;
    v_youtubers VARCHAR(200); --variável para armazenar os nomes dos youtubers
BEGIN
    -- abertura do cursor
    OPEN cur_nomes_youtubers FOR
        SELECT youtuber
            FROM
            tb_top_youtubers;
    LOOP
        -- Reuperando os dados e inserindo na variável
        FETCH cur_nomes_youtubers INTO v_youtubers;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', v_youtubers;
    END LOOP;
    CLOSE cur_nomes_youtubers;
END;
$$

--Exibir nomes dos youtubers que começaram à partir de um ano específico. desafio: fazer com query dinâmica. O cursor tem que ser não vinculado
DO $$
DECLARE
    cur_nomes_youtubers REFCURSOR;
    v_nome_tabela VARCHAR := 'tb_top_youtubers';
    v_youtubers VARCHAR(200);
    ano INT := 2010;
BEGIN
    OPEN cur_nomes_youtubers FOR EXECUTE
    format('SELECT youtuber FROM %s WHERE started >= $1 ',v_nome_tabela) USING ano;
    LOOP
        -- Reuperando os dados e inserindo na variável
        FETCH cur_nomes_youtubers INTO v_youtubers;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', v_youtubers;
    END LOOP;
    CLOSE cur_nomes_youtubers;
END;
$$

DO $$
DECLARE
    --cursor vinculado (bound)
    cur_nomes_e_inscritos CURSOR FOR SELECT youtuber, subscribers FROM tb_top_youtubers;
    --capaz de abrigar uma tupla inteira
    --tupla.youtuber nos dá o nome do youtuber
    --tupla.subscribers nos dá o número de inscritos
    tupla RECORD;
    resultado TEXT DEFAULT ''; --por padrão, inicia como um texto vazio
    BEGIN
        OPEN cur_nomes_e_inscritos;
            FETCH cur_nomes_e_inscritos INTO tupla;
            WHILE FOUND LOOP
                resultado := resultado || tupla.youtuber || ':' || tupla.subscribers || ','; --aqui o resultado serve para que a cada iteração, a variável mantenha o texto anterior e contatene com o próximo
                FETCH cur_nomes_e_inscritos INTO tupla;
            END LOOP;
        CLOSE cur_nomes_e_inscritos;
        RAISE NOTICE '%', resultado;
END;
$$

DO $$
    DECLARE
        v_ano INT := 2010;
        v_inscritos INT := 60000000;
        cur_ano_inscritos CURSOR (ano INT, inscritos INT) FOR SELECT youtuber FROM
        tb_top_youtubers WHERE started >= ano AND subscribers >= inscritos;
        v_youtuber VARCHAR(200);
    BEGIN
        --execute apenas um dos dois comandos OPEN a seguir
        -- passando argumentos pela ordem
        -- OPEN cur_ano_inscritos (v_ano, v_inscritos);
        --passando argumentos por nome
        OPEN cur_ano_inscritos (inscritos := v_inscritos, ano := v_ano);
        LOOP
            FETCH cur_ano_inscritos INTO v_youtuber;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE '%', v_youtuber;
        END LOOP;
        CLOSE cur_ano_inscritos;
END;
$$


DO $$
DECLARE
    cur_delete REFCURSOR;
    tupla RECORD;
BEGIN-- scroll para poder voltar ao início
    OPEN  cur_delete SCROLL FOR
    SELECT
    *
    FROM
    tb_top_youtubers;
        LOOP
            FETCH cur_delete INTO tupla;
            EXIT WHEN NOT FOUND;
            IF tupla.video_count IS NULL THEN
                DELETE FROM tb_top_youtubers WHERE CURRENT OF cur_delete;
            END IF;
        END LOOP;-- loop para exibir item a item, de baixo para cima
    LOOP
        FETCH BACKWARD FROM cur_delete INTO tupla;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', tupla;
    END LOOP;
    CLOSE cur_delete;
END;
$$
