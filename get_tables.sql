USE MY_DATABASE;

SELECT NAME AS ObjectName
	,schema_name(o.schema_id) AS SchemaName
	,type
	,o.type_desc
FROM sys.objects o
WHERE o.is_ms_shipped = 0
ORDER BY o.NAME;
