-- Mostrar la gramatica cargada
CREATE OR REPLACE FUNCTION mostrar_glc()
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

CREATE OR REPLACE FUNCTION mostrar_triangulo_cyk()
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
    --devuelve el i maximo de la cadena
    SELECT MAX(mc.i) INTO n FROM matriz_cyk mc;
    IF n IS NULL THEN RETURN; END IF;

    --va desde la punta de la piramide para abajo <--
    FOR i_idx IN REVERSE n..1 LOOP
        fila_texto := '';

        FOR j_idx IN 1..(n - i_idx + 1) LOOP
        
            SELECT array_to_string(mc.x, ', ') 
            INTO vars
            FROM matriz_cyk mc
            WHERE mc.i = i_idx AND mc.j = j_idx;

	    --si no existe la celda mucha el vacio
            IF vars IS NULL THEN
                vars := '∅'; 
            END IF;

            fila_texto := fila_texto || '[' || vars || ']   ';
        END LOOP;

        --devuelve la fila armada
        fila := 'i=' ||  i_idx || ' | ' || fila_texto;
        RETURN NEXT;
    END LOOP;
END;
$$;

