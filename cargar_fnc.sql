-- script para cargar glc en fnc

DROP TABLE IF EXISTS GLC_en_FNC;
DROP TABLE IF EXISTS matriz_cyk;
DROP TABLE IF EXISTS expresion_json;

CREATE TABLE GLC_en_FNC(
	start boolean,
	parte_izq text,
	parte_der1 text,
	parte_der2 text,
	tipo_produccion smallint 
);
 -- 1 = Var→terminal, 2 = Var→Var1Var2
CREATE TABLE matriz_cyk(
	i smallint,
	j smallint,
	x text[]
);

CREATE TABLE expresion_json(
	string text
);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'S1', '{', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S2', '}', '', 1);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S2', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'S3', 'CONTENIDO', 'S2', 2);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S3', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT0', ',', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT1', 'CLAVE_VALOR', 'CONT0', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CONT1', 'CONTENIDO', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT2', '"', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT3', ':', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT4', 'CONT2', 'CONT3', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT5', 'CONT2', 'STRING', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT6', 'CONT5', 'CONT4', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CONT6', 'VALOR', 2);
---3---
