DECLARE @p_RY AS INT
SET @p_RY = 2018
SELECT 
	[Cycle Number]   
	,CASE 
		WHEN [Cycle Number] = -1 THEN
			'Completed Roll run on ' + FORMAT( [Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA' )
		WHEN [Cycle Number] = 0 THEN
			'Revised Roll run on ' + FORMAT( [Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA' )
		ELSE
			'Cycle ' + [Cycle Number] + ' run on ' + FORMAT( [Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA' )
	 END AS [Cycle Display]
	 ,[Roll Entry Run Date]
FROM  [edw].[dimRollCycle]

WHERE [Roll Year] = @p_RY
	  AND [Cycle Number] = (SELECT Max(CAST([Cycle Number] AS int))
								FROM [edw].[dimRollCycle]
								WHERE [Roll Year] = @p_RY
								      AND CAST([Cycle Number] AS int) <= 12)

	  OR ([Cycle Number] IN (0,-1) AND [Roll Year] = @p_RY)
ORDER BY [Cycle Number Sort] DESC



--SELECT Max(CAST([Cycle Number] AS int))
--								FROM [edw].[dimRollCycle]
--								WHERE [Roll Year] = @p_RY
--								      AND CAST([Cycle Number] AS int) <= 12


--SELECT      [Cycle Number],  [Roll Entry Run Date], [Roll Entry Transaction Date], [Final Roll Flag], [Preview Roll Flag]
--FROM        edw.dimRollCycle RC1
--WHERE     RC1.[Roll Year] = @p_RY
--order by [Roll Entry Transaction Date] desc