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

--aca tengo una duda con S3, no se si va como true
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S1', '{', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S2', '}', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S3', 'CONTENIDO', 'S2', 2);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S3', 2);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S2', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT0', ',', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT1', 'CLAVE_VALOR', 'CONT0', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT2', '"', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT3', ':', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT4', 'CONT2', 'CONT3', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT5', 'CONT2', 'STRING', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONT6', 'CONT5', 'CONT4', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CONT1', 'CONTENIDO', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CONT6', 'VALOR', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'CLAVE_VALOR', 'CONT6', 'VALOR', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'VAL0', '"', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VAL1', 'VAL0', 'STRING', 2);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'digito', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'VALOR', 'NUM', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'S1', 'S2', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'S1', 'S3', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'VAL1', 'VAL0', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'VAL0', 'VAL0', 2);


INSERT INTO GLC_en_FNC VALUES (FALSE, 'NUM', 'NUM', 'NUM', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'NUM', 'digito', '', 1);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'STRING', 'STRING', 'STRING', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'STRING', 'letra', '', 1);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '0', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '1', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '2', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '3', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '4', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '5', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '6', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '7', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '8', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'digito', '9', '', 1);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'a', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'b', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'c', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'd', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'e', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'f', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'g', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'h', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'i', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'j', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'k', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'l', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'm', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'n', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'ñ', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'o', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'p', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'q', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'r', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 's', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 't', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'u', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'v', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'w', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'x', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'y', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'letra', 'z', '', 1);

--cantidad de producciones 64