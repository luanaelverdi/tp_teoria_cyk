DELETE FROM GLC_en_FNC;

--PARA SUMA 
--S --> SS
--S --> S VALSUMA
--S --> 0...9
--SUMA --> +
--VALSUMA --> VALSUMA S

--PARA RESTA
--S --> S VALRESTA
--RESTA --> -
--VALRESTA --> VALRESTA S 

INSERT INTO GLC_en_FNC VALUES (false, 'SUMA', '+', NULL, 1);

INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, tipo_produccion)
SELECT true, 'S', CAST(i AS text), 1
FROM generate_series(0, 9) AS i;

INSERT INTO GLC_en_FNC VALUES (true, 'S', 'S', 'S', 2);

INSERT INTO GLC_en_FNC VALUES (true, 'S', 'S', 'VALSUMA', 2);
INSERT INTO GLC_en_FNC VALUES (false, 'VALSUMA', 'SUMA', 'S', 2);

INSERT INTO GLC_en_FNC VALUES (false, 'RESTA', '-', NULL, 1);

INSERT INTO GLC_en_FNC VALUES (true, 'S', 'S', 'VALRESTA', 2);
INSERT INTO GLC_en_FNC VALUES (false, 'VALRESTA', 'RESTA', 'S', 2);
