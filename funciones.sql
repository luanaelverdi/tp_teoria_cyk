DROP FUNCTION IF EXISTS setear_matriz(INT);
DROP FUNCTION IF EXISTS cyk(TEXT);

CREATE OR REPLACE FUNCTION setear_matriz(fila INT)
RETURNS void AS $$
DECLARE
	longitud_string INT;
BEGIN
	SELECT length(string) INTO longitud_string FROM expresion_json LIMIT 1;
	
	IF fila = 1 THEN
		INSERT INTO matriz_cyk(i,j,x)
		SELECT 1, posicion, array_agg(g.parte_izq)
        FROM generate_series(1, longitud_string) AS posicion
        JOIN expresion_json ej ON true
       
        JOIN GLC_en_FNC g ON trim(g.parte_der1) = trim(substring(ej.string FROM posicion FOR 1)) AND g.tipo_produccion = 1
        GROUP BY posicion;
	ELSE
	-- CASO RECURSION
        INSERT INTO matriz_cyk (i, j, x)
        SELECT fila, j_pos, array_agg(DISTINCT g.parte_izq)
        FROM generate_series(1, longitud_string - fila + 1) AS j_pos
        CROSS JOIN generate_series(1, fila - 1) AS m
        JOIN matriz_cyk m1 ON m1.i = m AND m1.j = j_pos
        JOIN matriz_cyk m2 ON m2.i = fila - m AND m2.j = j_pos + m
        JOIN GLC_en_FNC g ON g.tipo_produccion = 2 
           	AND g.parte_der1 = ANY(m1.x) 
           	AND g.parte_der2 = ANY(m2.x)
        GROUP BY j_pos;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cyk(cadena TEXT)
RETURNS boolean AS $$
DECLARE
  	longitud_string INT;
	simbolo_inicial_valido BOOLEAN;
BEGIN
	DELETE FROM expresion_json;
   	DELETE FROM matriz_cyk;

    INSERT INTO expresion_json (string) VALUES (cadena);
    longitud_string := length(cadena);
    
    IF longitud_string = 0 THEN
        RETURN FALSE; 
    END IF;

    FOR fila IN 1..longitud_string LOOP
        PERFORM setear_matriz(fila);
    END LOOP;

    SELECT EXISTS (
        SELECT 1 
        FROM (
            SELECT unnest(x) AS variable 
            FROM matriz_cyk 
            WHERE i = longitud_string AND j = 1
        ) m
        JOIN GLC_en_FNC g ON g.start = TRUE AND trim(g.parte_izq) = trim(m.variable)
    ) INTO simbolo_inicial_valido;

    RETURN simbolo_inicial_valido;
END;
$$ LANGUAGE plpgsql;
