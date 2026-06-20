SELECT '--- VERDADEROS ---' AS EJEMPLOS;

\echo '>>> 1+2'
SELECT cyk('1+2');

\echo '>>> 20+300'
SELECT cyk('20+300');

\echo '>>> 20-2'
SELECT cyk('20-2');

\echo '>>> 20+2-6'
SELECT cyk('20+2-6');

SELECT '--- FALSOS ---' AS EJEMPLOS;

\echo '>>> 200*2'
SELECT cyk('');

\echo '>>> abc'
SELECT cyk('abc');
