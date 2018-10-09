DECLARE @p_RY INT
SET @p_RY = 2017;
SELECT MAX(CAST([Cycle Number] AS INT)) AS [Cycle Number]
FROM [edw].[dimRollCycle]
WHERE [Roll Year] = @p_RY;