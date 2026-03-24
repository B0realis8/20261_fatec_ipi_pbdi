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


