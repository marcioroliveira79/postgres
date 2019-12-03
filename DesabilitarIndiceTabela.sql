--Desabilitar indices de tabelas com update
-- 03-12-2019
UPDATE pg_index
SET indisready=false
WHERE indrelid = (
    SELECT oid
    FROM pg_class
    WHERE relname='<TABLE_NAME>'
);
