CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior
INT) RETURNS INT AS
$$
BEGIN
RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

--1.2 Faça um programa que calcule o determinante de uma matriz quadrada de ordem 3
--utilizando a regra de Sarrus. Veja a regra aqui:
--https://en.wikipedia.org/wiki/Rule_of_Sarrus
--Preencha a matriz com valores inteiros aleatórios no intervalo de 1 a 12

DO
$$
DECLARE
valor INT;
valor_array INT[];

_a INTEGER := valor_aleatorio_entre(1, 12);
_b INTEGER := valor_aleatorio_entre(1, 12);
_c INTEGER := valor_aleatorio_entre(1, 12);
_d INTEGER := valor_aleatorio_entre(1, 12);
_e INTEGER := valor_aleatorio_entre(1, 12);
_f INTEGER := valor_aleatorio_entre(1, 12);
_g INTEGER := valor_aleatorio_entre(1, 12);
_h INTEGER := valor_aleatorio_entre(1, 12);
_i INTEGER := valor_aleatorio_entre(1, 12);

det INTEGER;

matriz INT[] := ARRAY[
                    [_a,_b,_c],
                    [_d,_e,_f],
                    [_g,_h,_i]
                ];
BEGIN
    RAISE NOTICE 'Matriz 3x3: %',matriz;
    det := (_a*_e*_i)+(_b*_f*_g)+(_c*_d*_h)-(_g*_e*_c)-(_h*_f*_a)-(_i*_d*_b);
    RAISE NOTICE 'Determinante da matriz: %',det;
END;
$$
            