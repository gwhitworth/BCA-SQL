DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT [Cycle Number],
       CASE
           WHEN [Cycle Number] = -1
           THEN 'Completed Roll run on '+FORMAT([Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA')
           WHEN [Cycle Number] = 0
           THEN 'Revised Roll run on '+FORMAT([Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA')
           ELSE 'Cycle '+[Cycle Number]+' run on '+FORMAT([Roll Entry Run Date], 'dd-MMM-yyyy', 'en-CA')
       END AS [Cycle Display], 
       [Roll Entry Run Date]
FROM [edw].[dimRollCycle]
WHERE [Roll Year] = @p_RY
      AND [Cycle Number] >= 0
ORDER BY [Roll Entry Run Date] DESC;