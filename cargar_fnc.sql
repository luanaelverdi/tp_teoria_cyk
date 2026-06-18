-- script para cargar glc en fnc corregido

DROP TABLE IF EXISTS GLC_en_FNC;
DROP TABLE IF EXISTS matriz_cyk;
DROP TABLE IF EXISTS expresion_json;

CREATE TABLE GLC_en_FNC(
	start BOOLEAN,
	parte_izq TEXT,
	parte_der1 TEXT,
	parte_der2 TEXT,
	tipo_produccion SMALLINT
);

CREATE TABLE matriz_cyk(
	i SMALLINT,
	j SMALLINT,
	x TEXT[]
);

CREATE TABLE expresion_json(
	string TEXT
);

-- Raíz del JSON
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S1', '{', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S2', '}', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'S3', 'CONTENIDO', 'S2', 2);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S3', 2);
INSERT INTO GLC_en_FNC VALUES (TRUE, 'S', 'S1', 'S2', 2); -- Permite {}

-- Terminales Estructurales
INSERT INTO GLC_en_FNC VALUES (FALSE, 'COMILLA', '"', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'DOS_PUNTOS', ':', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'COMA', ',', '', 1);

-- Construcción de la CLAVE ("STRING")
INSERT INTO GLC_en_FNC VALUES (FALSE, 'STR_CIERRE', 'STRING', 'COMILLA', 2);     
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CLAVE', 'COMILLA', 'STR_CIERRE', 2);       

-- Tipos de datos asignados a VALOR
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'digito', '', 1);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'digito', 'NUM', 2); -- Permite que números largos sean VALOR
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'COMILLA', 'STR_CIERRE', 2);      -- Un String con comillas es un VALOR
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'S1', 'S2', 2);                   
INSERT INTO GLC_en_FNC VALUES (FALSE, 'VALOR', 'S1', 'S3', 2);                   

-- Estructura interna Clave-Valor ("clave": valor)
INSERT INTO GLC_en_FNC VALUES (FALSE, 'PUNTOS_VALOR', 'DOS_PUNTOS', 'VALOR', 2);  
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CLAVE_VALOR', 'CLAVE', 'PUNTOS_VALOR', 2); 

-- Manejo de Elementos Múltiples (CONTENIDO) - CORRECCIÓN LOGICA FNC
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CLAVE', 'PUNTOS_VALOR', 2);   -- Caso un único par (reemplaza la unitaria que fallaba)
INSERT INTO GLC_en_FNC VALUES (FALSE, 'COMA_CONTENIDO', 'COMA', 'CONTENIDO', 2);  
INSERT INTO GLC_en_FNC VALUES (FALSE, 'CONTENIDO', 'CLAVE_VALOR', 'COMA_CONTENIDO', 2); 

-- Estructuras Primitivas Lineales (Evita la ambigüedad infinita en el ciclo del CYK)
INSERT INTO GLC_en_FNC VALUES (FALSE, 'NUM', 'digito', 'NUM', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'NUM', 'digito', '', 1);

INSERT INTO GLC_en_FNC VALUES (FALSE, 'STRING', 'letra', 'STRING', 2);
INSERT INTO GLC_en_FNC VALUES (FALSE, 'STRING', 'letra', '', 1);

-- Generación Masiva de terminales para la Fila 1
INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion)
SELECT false, 'digito', CAST(i AS text), '', 1 FROM generate_series(0, 9) AS i;

INSERT INTO GLC_en_FNC (start, parte_izq, parte_der1, parte_der2, tipo_produccion)
SELECT false, 'letra', chr(i), '', 1 FROM generate_series(97, 122) AS i;

