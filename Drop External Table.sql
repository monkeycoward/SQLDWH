DECLARE @sql varchar(max) = ''
DECLARE @crlf varchar(2) = CHAR(13) + CHAR(10);

SELECT
  @sql = @sql + 'DROP EXTERNAL TABLE [' + CONCAT(SCHEMA_NAME(t.schema_id), '].[', t.name, ']') + ';' + @crlf
FROM
  sys.external_tables t
  INNER JOIN sys.external_data_sources ds ON t.data_source_id = ds.data_source_id

--PRINT (@sql)

EXEC (@sql)
