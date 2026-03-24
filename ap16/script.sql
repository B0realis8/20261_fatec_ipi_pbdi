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

--Exibir nomes dos youtubers que começaram à partir de um ano específico. desafio: fazer com query dinâmica. O crursor tem que ser não vinculado
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
