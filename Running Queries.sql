SELECT
  r.session_id as SPID,
  CONVERT(VARCHAR(50),start_time,100) AS start_time,
  percent_complete,
  CONVERT(VARCHAR(50),dateadd(second,estimated_completion_time/1000, getdate()),100) as estimated_completion_time,
  command, 
  a.text AS Query,
  blocking_session_id,
  d.name, 
  u.login_name
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a
INNER JOIN sys.databases d on r.database_id = d.database_id
INNER JOIN sys.dm_exec_sessions u on r.session_id = u.session_id
