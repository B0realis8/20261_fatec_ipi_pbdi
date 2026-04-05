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