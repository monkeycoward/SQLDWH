DECLARE @currentdate AS Date = '2000-01-01'
DECLARE @enddate AS Date = DATEADD(yy,10,DATEFROMPARTS(YEAR(GETDATE()),1,1))

WHILE @currentdate < @enddate 
BEGIN
	SET DATEFIRST 1
	
	INSERT INTO DWH.datum

	SELECT 
		YEAR(@currentdate) * 10000 + MONTH(@currentdate) * 100 + DAY(@currentdate)
		,@currentdate
		,DAY(@currentdate)
		,MONTH(@currentdate)
		,YEAR(@currentdate)
		,YEAR(@currentdate) * 100 + MONTH(@currentdate)
		,YEAR(@currentdate) * 100 + CASE 
			WHEN MONTH(@currentdate) <= 3	THEN 1
			WHEN MONTH(@currentdate) <= 6	THEN 2
			WHEN MONTH(@currentdate) <= 9	THEN 3
			WHEN MONTH(@currentdate) <= 12	THEN 4 END
		,CASE 
			WHEN MONTH(@currentdate) = 1	THEN 'Januari'
			WHEN MONTH(@currentdate) = 2	THEN 'Februari'
			WHEN MONTH(@currentdate) = 3	THEN 'Maart'
			WHEN MONTH(@currentdate) = 4	THEN 'April'
			WHEN MONTH(@currentdate) = 5	THEN 'Mei'
			WHEN MONTH(@currentdate) = 6	THEN 'Juni'
			WHEN MONTH(@currentdate) = 7	THEN 'Juli'
			WHEN MONTH(@currentdate) = 8	THEN 'Augustus'
			WHEN MONTH(@currentdate) = 9	THEN 'September'
			WHEN MONTH(@currentdate) = 10	THEN 'Oktober'
			WHEN MONTH(@currentdate) = 11	THEN 'November'
			WHEN MONTH(@currentdate) = 12	THEN 'December' END
		,CASE 
			WHEN MONTH(@currentdate) = 1	THEN 'Jan'
			WHEN MONTH(@currentdate) = 2	THEN 'Feb'
			WHEN MONTH(@currentdate) = 3	THEN 'Mrt'
			WHEN MONTH(@currentdate) = 4	THEN 'Apr'
			WHEN MONTH(@currentdate) = 5	THEN 'Mei'
			WHEN MONTH(@currentdate) = 6	THEN 'Jun'
			WHEN MONTH(@currentdate) = 7	THEN 'Jul'
			WHEN MONTH(@currentdate) = 8	THEN 'Aug'
			WHEN MONTH(@currentdate) = 9	THEN 'Sep'
			WHEN MONTH(@currentdate) = 10	THEN 'Okt'
			WHEN MONTH(@currentdate) = 11	THEN 'Nov'
			WHEN MONTH(@currentdate) = 12	THEN 'Dec' END
		,CASE 
			WHEN MONTH(@currentdate) <= 3	THEN 1
			WHEN MONTH(@currentdate) <= 6	THEN 2
			WHEN MONTH(@currentdate) <= 9	THEN 3
			WHEN MONTH(@currentdate) <= 12	THEN 4 END
		,DATEPART(dw, @currentdate)
		,CASE 
			WHEN DATEPART(dw, @currentdate) = 1 THEN 'Maandag'
			WHEN DATEPART(dw, @currentdate) = 2 THEN 'Dinsdag'
			WHEN DATEPART(dw, @currentdate) = 3 THEN 'Woensdag'
			WHEN DATEPART(dw, @currentdate) = 4 THEN 'Donderdag'
			WHEN DATEPART(dw, @currentdate) = 5 THEN 'Vrijdag'
			WHEN DATEPART(dw, @currentdate) = 6 THEN 'Zaterdag'
			WHEN DATEPART(dw, @currentdate) = 7 THEN 'Zondag' END
		,DATEPART(dy, @currentdate)
		,DATEPART(isowk, @currentdate)
		,YEAR(@currentdate) * 100 + DATEPART(isowk, @currentdate)
		,CASE 
			WHEN MONTH(@currentdate) <= 3	THEN 'Kwartaal 1'
			WHEN MONTH(@currentdate) <= 6	THEN 'Kwartaal 2'
			WHEN MONTH(@currentdate) <= 9	THEN 'Kwartaal 3'
			WHEN MONTH(@currentdate) <= 12	THEN 'Kwartaal 4' END
		,CASE WHEN DAY(@currentdate) = 1 THEN 1 END
		,CASE 
			WHEN DAY(@currentdate) = 31 AND MONTH(@currentdate) IN (1,3,5,7,8,10,12) THEN 1  
			WHEN DAY(@currentdate) = 30 AND MONTH(@currentdate) IN (4,6,9,11) THEN 1  
			WHEN DAY(@currentdate) = 29 AND MONTH(@currentdate) IN (2) AND (YEAR(@currentdate) % 4 = 0 AND YEAR(@currentdate) % 100 <> 0) OR YEAR(@currentdate) % 400 = 0 THEN 1  
			WHEN DAY(@currentdate) = 28 AND MONTH(@currentdate) IN (2) AND (YEAR(@currentdate) % 4 <> 0) THEN 1 END  
		,CASE WHEN DAY(@currentdate) = 1 AND MONTH(@currentdate) IN (1,4,7,10) THEN 1 END
		,CASE WHEN DAY(@currentdate) = 1 AND MONTH(@currentdate) IN (1,7) THEN 1 END
		,CASE WHEN DAY(@currentdate) = 1 AND MONTH(@currentdate) = 1 THEN 1 END

	SET @currentdate = DATEADD(DD, 1, @currentdate)
END
