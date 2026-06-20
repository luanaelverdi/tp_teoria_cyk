SELECT '--- VERDADEROS ---' AS EJEMPLOS;

\echo '>>> {”a”:10}'
SELECT cyk('{”a”:10}');

\echo '>>> {”a”:10,”b”:’hola’}'
SELECT cyk('{”a”:10,”b”:’hola’}');

\echo '>>> {”a”:’hola’,”b”:’chau’,”c”:’’}'
SELECT cyk('{”a”:’hola’,”b”:’chau’,”c”:’’}');

\echo '>>> {”a”:10,”b”:’hola’,”c”:{”d”:’chau’,”e”:99},”f”:{}}'
SELECT cyk('{”a”:10,”b”:’hola’,”c”:{”d”:’chau’,”e”:99},”f”:{}}');

\echo '>>> {}'
SELECT cyk('{}');

\echo '>>> {”a”:10,”b”:’hola’,”c”:{”d”:’chau’,”e”:99,”g”:{”h”:12}},”f”:{}}'
SELECT cyk('{”a”:10,”b”:’hola’,”c”:{”d”:’chau’,”e”:99,”g”:{”h”:12}},”f”:{}}');

SELECT '--- FALSOS ---' AS EJEMPLOS;

\echo '>>> '''
SELECT cyk('');

\echo '>>> {abc}'
SELECT cyk('abc');

\echo '>>> 123'
SELECT cyk('123');
