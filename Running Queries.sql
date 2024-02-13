SELECT
  session_id as SPID,
  CONVERT(VARCHAR(50),start_time,100) AS start_time,
  percent_complete,
  CONVERT(VARCHAR(50),dateadd(second,estimated_completion_time/1000, getdate()),100) as estimated_completion_time,
  command, a.text AS Query,
  blocking_session_id
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a

---
select r.session_id, start_time, command, a.text, blocking_session_id, d.name, u.login_name
from sys.dm_exec_requests r
cross apply sys.dm_exec_sql_text (r.sql_handle) a
inner join sys.databases d on r.database_id = d.database_id
inner join sys.dm_exec_sessions u on r.session_id = u.session_id
