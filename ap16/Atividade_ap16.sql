-- Active: 1775146451821@@127.0.0.1@5432@pbdi_20261@public

-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

DO $$
DECLARE
    cur_rank_nome CURSOR FOR SELECT rank, youtuber FROM tb_top_youtubers WHERE video_count > 1000 AND (category LIKE 'Sports%' OR category LIKE 'Music%');
    tupla RECORD;
BEGIN
    OPEN cur_rank_nome;
        FETCH cur_rank_nome INTO tupla;
        WHILE FOUND LOOP
            RAISE NOTICE 'Youtuber: % - Rank: %',tupla.youtuber,tupla.rank;
            FETCH cur_rank_nome INTO tupla;
        END LOOP; 
    CLOSE cur_rank_nome;
END;
$$

-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal--
-- O SELECT deverá ordenar em ordem não reversa
-- O Cursor deverá ser movido para a última tupla
-- Os dados deverão ser exibidos de baixo para cima

DO $$
DECLARE
    cur_nome SCROLL CURSOR FOR SELECT youtuber FROM tb_top_youtubers ORDER BY youtuber;
    tupla RECORD;
BEGIN
    OPEN cur_nome;
        LOOP
            FETCH cur_nome INTO tupla;
            EXIT WHEN NOT FOUND;
        END LOOP;
        LOOP
            FETCH BACKWARD FROM cur_nome INTO tupla;
            EXIT WHEN NOT FOUND;
                RAISE NOTICE '%',tupla.youtuber;
        END LOOP;
    CLOSE cur_nome;
END;
$$ 

--NOT BOUND
DO $$
DECLARE
    cur_nome REFCURSOR;
    tupla RECORD;
BEGIN
    OPEN cur_nome SCROLL FOR SELECT youtuber FROM tb_top_youtubers ORDER BY youtuber;
        LOOP
            FETCH cur_nome INTO tupla;
            EXIT WHEN NOT FOUND;
        END LOOP;
        LOOP
            FETCH BACKWARD FROM cur_nome INTO tupla;
            EXIT WHEN NOT FOUND;
                RAISE NOTICE '%',tupla.youtuber;
        END LOOP;
    CLOSE cur_nome;
END;
$$


