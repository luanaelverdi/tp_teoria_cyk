-- ================================================================
-- TRABAJO PRACTICO PARTE 3: Algoritmo CYK en PostgreSQL
-- SCRIPT 02: Implementacion de funciones PL/pgSQL
-- ================================================================

-- Limpieza previa de funciones si ya existen
DROP FUNCTION IF EXISTS setear_matriz(INT);
DROP FUNCTION IF EXISTS cyk_2(TEXT);

-- ================================================================
-- FUNCION: setear_matriz(fila int)
-- Construye una fila de la matriz CYK
-- ================================================================
CREATE OR REPLACE FUNCTION setear_matriz(p_fila INT)
RETURNS VOID AS $$
DECLARE
    v_n INT;
    v_i INT;
    v_j INT;
    v_k INT;
    v_simbolo TEXT;
    v_vars TEXT[];
    v_left_vars TEXT[];
    v_right_vars TEXT[];
    v_prod RECORD;
BEGIN
    -- Obtener longitud de la cadena actual
    SELECT length((SELECT string FROM expresion_json ORDER BY id DESC LIMIT 1)) INTO v_n;

    -- Eliminar posibles filas previas del mismo tamano
    DELETE FROM matriz_cyk m WHERE (m.j - m.i + 1) = p_fila;

    IF p_fila = 1 THEN
        -- CASO BASE: Var -> terminal
        FOR v_i IN 1..v_n LOOP
            v_simbolo := substring((SELECT string FROM expresion_json ORDER BY id DESC LIMIT 1) FROM v_i FOR 1);

            SELECT array_agg(parte_izq)
            INTO v_vars
            FROM GLC_en_FNC
            WHERE tipo_produccion = 1
              AND parte_der1 = v_simbolo;

            INSERT INTO matriz_cyk(i, j, x) VALUES (v_i, v_i, v_vars);
        END LOOP;

    ELSE
        -- CASO GENERAL: Var -> Var1 Var2
        FOR v_i IN 1..(v_n - p_fila + 1) LOOP
            v_j := v_i + p_fila - 1;
            v_vars := '{}';

            FOR v_k IN v_i..(v_j - 1) LOOP
                SELECT m.x INTO v_left_vars FROM matriz_cyk m WHERE m.i = v_i AND m.j = v_k;
                SELECT m.x INTO v_right_vars FROM matriz_cyk m WHERE m.i = v_k + 1 AND m.j = v_j;

                FOR v_prod IN
                    SELECT parte_izq, parte_der1, parte_der2
                    FROM GLC_en_FNC
                    WHERE tipo_produccion = 2
                LOOP
                    IF v_prod.parte_der1 = ANY(v_left_vars)
                       AND v_prod.parte_der2 = ANY(v_right_vars) THEN
                        v_vars := array_append(v_vars, v_prod.parte_izq);
                    END IF;
                END LOOP;
            END LOOP;

            INSERT INTO matriz_cyk(i, j, x) VALUES (v_i, v_j, v_vars);
        END LOOP;
    END IF;
END;
$$ LANGUAGE plpgsql;
-- ================================================================
-- FUNCION PRINCIPAL: cyk(cadena text)
-- Ejecuta el algoritmo CYK completo y retorna TRUE/FALSE
-- ================================================================
CREATE OR REPLACE FUNCTION cyk_2(cadena TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    n INT;
    simbolo_inicial TEXT;
    resultado TEXT[];
BEGIN
    -- Limpiar datos previos
    DELETE FROM expresion_json;
    INSERT INTO expresion_json (string) VALUES (cadena);

    DELETE FROM matriz_cyk;

    n := length(cadena);

    -- Construccion de la matriz
    FOR i IN 1..n LOOP
        PERFORM setear_matriz(i);
    END LOOP;

    -- Simbolo inicial
    SELECT parte_izq INTO simbolo_inicial FROM GLC_en_FNC WHERE start = TRUE LIMIT 1;

    -- Resultado final: X[1,n]
    SELECT x INTO resultado FROM matriz_cyk WHERE i = 1 AND j = n;

    -- Evaluacion final
    RETURN simbolo_inicial = ANY(resultado);
END;
$$ LANGUAGE plpgsql;
