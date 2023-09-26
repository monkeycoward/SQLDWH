WITH base AS 
    (SELECT  
       DB_NAME() AS dbname, 
       o.type_desc AS referenced_object_type, 
       d1.referenced_schema_name,
       d1.referenced_entity_name, 
       d1.referenced_id, 
       STUFF( (SELECT ', ' + OBJECT_SCHEMA_NAME(d2.referencing_id) + '.' + OBJECT_NAME(d2.referencing_id)
               FROM sys.sql_expression_dependencies d2
               WHERE d2.referenced_id = d1.referenced_id
               ORDER BY OBJECT_NAME(d2.referencing_id)
               FOR XML PATH('')), 1, 1, '') AS dependent_objects_list
    FROM sys.sql_expression_dependencies  d1 
    INNER JOIN sys.objects o ON d1.referenced_id = o.[object_id]
    WHERE ISNULL(d1.referenced_schema_name, 'dbo') <> 'dbo'
    GROUP BY o.type_desc, d1.referenced_id,  d1.referenced_schema_name, d1.referenced_entity_name)
SELECT * 
FROM base
