SELECT   
      SUM(reserved_page_count) * 8.0 / 1024 [SizeInMB]
FROM    
      sys.dm_db_partition_stats

GO

SELECT    
      sys.objects.name, sum(reserved_page_count) * 8.0 / 1024 [SizeInMB]
FROM    
      sys.dm_db_partition_stats, sys.objects
WHERE    
      sys.dm_db_partition_stats.object_id = sys.objects.object_id
GROUP BY sys.objects.name
ORDER BY sum(reserved_page_count) DESC
