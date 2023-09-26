SELECT 
    S.name AS SchemaName, 
    O.name AS ObjectName, 
    I.name AS IndexName,
	  I.type_desc AS IndexType, 
    P.data_compression_desc AS Compression
FROM sys.schemas AS S 
  INNER JOIN sys.objects AS O ON S.schema_id = O.schema_id 
  INNER JOIN sys.indexes AS I ON O.object_id = I.object_id 
  INNER JOIN sys.partitions AS P ON I.object_id = P.object_id AND I.index_id = P.index_id
WHERE O.TYPE = 'U' AND I.name IS NULL	
ORDER BY S.name, O.name, I.index_id;
