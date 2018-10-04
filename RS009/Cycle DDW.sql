DECLARE @p_RY AS [INT];
SET @p_RY = 2017;
SELECT [Cycle Number], 
       'Supplementary/PAAB Cycle '+[Cycle Number] AS [Cycle Display], 
       [Roll Entry Run Date]
FROM [edw].[dimRollCycle]
WHERE [Roll Year] = @p_RY
      AND [Cycle Number] > 0
ORDER BY [Cycle Number Sort] DESC;