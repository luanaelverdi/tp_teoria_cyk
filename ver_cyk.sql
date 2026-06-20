-- Mostrar la gramatica cargada
CREATE OR REPLACE FUNCTION fn_mostrar_glc()
RETURNS TABLE(regla TEXT)
LANGUAGE plpgsql AS
$$
BEGIN
    RETURN QUERY
    SELECT 
        parte_izq || ' →  ' || 
        STRING_AGG(
            CASE 
                WHEN parte_der2 IS NOT NULL THEN parte_der1 || ' ' || parte_der2
                ELSE parte_der1
            END,
            ' | ' ORDER BY parte_der1, parte_der2
        )
    FROM glc_en_fnc
    GROUP BY parte_izq
    ORDER BY parte_izq;
END;
$$;

-- Mostrar la matriz CYK en forma triangular
CREATE OR REPLACE FUNCTION fn_mostrar_matriz_cyk()
RETURNS TABLE(fila TEXT)
LANGUAGE plpgsql AS
$$
DECLARE
    n INTEGER;
    i_idx INTEGER;
    j_idx INTEGER;
    vars TEXT;
    fila_texto TEXT;
BEGIN
    -- Obtenemos el tamaño máximo de la cadena evaluada (Nivel i más alto)
    SELECT MAX(mc.i) INTO n FROM matriz_cyk mc;
    IF n IS NULL THEN RETURN; END IF;

    -- Recorremos en REVERSA: Desde la punta de la pirámide (n) hasta la base (1)
    FOR i_idx IN REVERSE n..1 LOOP
        fila_texto := '';

        -- Para una longitud 'i', existen 'n - i + 1' celdas posibles
        FOR j_idx IN 1..(n - i_idx + 1) LOOP

            -- Buscamos qué variables hay en esa celda
            SELECT array_to_string(mc.x, ', ') 
            INTO vars
            FROM matriz_cyk mc
            WHERE mc.i = i_idx AND mc.j = j_idx;

            -- Salvavidas anti-NULL: Si la celda no existe en la BD, mostramos un símbolo vacío
            IF vars IS NULL THEN
                vars := '∅'; 
            END IF;

            -- Concatenamos la celda a la fila actual
            fila_texto := fila_texto || '[' || vars || ']   ';
        END LOOP;

        -- Devolvemos la fila armada
        fila := 'i=' ||  i_idx || ' | ' || fila_texto;
        RETURN NEXT;
    END LOOP;
END;
$$;

