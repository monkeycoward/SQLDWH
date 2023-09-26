SELECT
  session_id as SPID,
  CONVERT(VARCHAR(50),start_time,100) AS start_time,
  percent_complete,
  CONVERT(VARCHAR(50),dateadd(second,estimated_completion_time/1000, getdate()),100) as estimated_completion_time,
  command, a.text AS Query,
  blocking_session_id
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a
