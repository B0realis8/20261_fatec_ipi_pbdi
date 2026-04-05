-- Active: 1775146451821@@127.0.0.1@5432@pbdi_20261
--1.1 Faça um programa que gere um valor inteiro e o exiba.

DO $$
DECLARE
    n INTEGER;
BEGIN
    n := 10;
    RAISE NOTICE 'O valor gerado é: %', n;
END;
$$

--1.2. Faça um programa que gere um valor real e o exiba.

DO $$
DECLARE
    n FLOAT;
BEGIN
    n := 10.123213;
    RAISE NOTICE 'O valor gerado é: %', n;
END;
$$

--1.3 Faça um programa que gere um valor real no intervalo [20, 30] que representa uma
--temperatura em graus Celsius. Faça a conversão para Fahrenheit e exiba.

DO $$
DECLARE
    n NUMERIC(4,2);
    f NUMERIC(5,2);
    limite_inferior INTEGER := 20;
    limite_superior INTEGER := 30;
BEGIN
    n := random() * (limite_superior - limite_inferior) + limite_inferior;
    RAISE NOTICE 'A temperatura em Celsius é: %°C', n;
    f := (n*9/5)+32;
    RAISE NOTICE 'A temperatura em Fahrenheit é: %°C', f;
END;
$$

--1.4 Faça um programa que gere três valores reais a, b, e c e mostre o valor de delta: aquele
--que calculamos para chegar às potenciais raízes de uma equação do segundo grau.

DO $$
DECLARE
    _a numeric(4,2);
    _b numeric(4,2);
    _c numeric(4,2);
    delta numeric(10,2);
    x1 numeric(10,2);
    x2 numeric(10,2);
BEGIN
    _a := random() * 10;
    RAISE NOTICE 'O valor de a é: %', _a;
    _b := random() * 10;
    RAISE NOTICE 'O valor de b é: %', _b;
    _c := random() * 10;
    RAISE NOTICE 'O valor de c é: %', _c;
    delta := (_b^2)-4*_a*_c;
    RAISE NOTICE 'Delta = %',delta;
    x1 := (-_b + sqrt(delta))/(2*_a);
    RAISE NOTICE 'A raiz x1 = %',x1;
    x2 := (-_b - sqrt(delta))/(2*_a);
    RAISE NOTICE 'A raiz x2 = %',x2;
END;
$$

--1.5 Faça umprograma que gere um número inteiro e mostre a raiz cúbica de seu antecessor
--e a raiz quadrada de seu sucessor

DO $$
DECLARE
    n INTEGER;
    rc NUMERIC;
    rq NUMERIC;
BEGIN
    n := floor(random()*100+1);
    RAISE NOTICE 'Número: %',n;
    rq := sqrt(n+1);
    RAISE NOTICE 'Raíz quadrada do sucessor: %',rq;
    rc := (n-1)^(1::numeric/3);
    RAISE NOTICE 'Raíz cúbica do antecessor: %',rc;
END;
$$

--1.6 Faça um programa que gere medidas reais de um terreno retangular. Gere também um
--valor real no intervalo [60, 70] que representa o preço por metro quadrado. O programa deve
--exibir o valor total do terreno.

DO $$
DECLARE
    _a NUMERIC(5,2);
    _b NUMERIC(5,2);
    metro_quadrado NUMERIC(10,2);
    preco NUMERIC(4,2);
    p_min INTEGER := 60;
    p_max INTEGER := 70;
    valor NUMERIC (10,2);
BEGIN
    _a := (random()*100);
    _b := (random()*100);
    metro_quadrado := _a * _b;
    RAISE NOTICE 'Dimensões do terreno: %m x %m',_a,_b;
    RAISE NOTICE 'Tamanho total: %m²',metro_quadrado;
    preco := random() * (p_max - p_min) + p_min;
    RAISE NOTICE 'Valor do metro quadrado: R$%',preco;
    valor := metro_quadrado*preco;
    RAISE NOTICE 'Valor total do terreno: R$%',valor;
END;
$$


--.7 Escreva um programa que gere um inteiro que representa o ano de nascimento de uma
--pessoa no intervalo [1980, 2000] e gere um inteiro que representa o ano atual no intervalo
--[2010, 2020]. O programa deve exibir a idade da pessoa em anos. Desconsidere detalhes
--envolvendo dias, meses, anos bissextos etc.

DO $$
DECLARE
    n INTEGER;
    n_min INTEGER := 1980;
    n_max INTEGER := 2000;
    ano INTEGER;
    ano_min INTEGER := 2010;
    ano_max INTEGER := 2020;
    idade INTEGER;
BEGIN
    n := random()*(n_max-n_min)+n_min;
    RAISE NOTICE 'Ano de nascimento: %',n;
    ano := random()*(ano_max-ano_min)+ano_min;
    RAISE NOTICE 'Ano atual: %',ano;
    idade := ano-n;
    RAISE NOTICE 'Idade: % anos',idade;
END;
$$
