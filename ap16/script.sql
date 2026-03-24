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