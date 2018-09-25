DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT DISTINCT 
       [A1].[Jurisdiction Code], 
       [A2].[Neighbourhood Code], 
       [A2].[Neighbourhood Desc], 
       [A2].[Neighbourhood]
FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
     [EDW].[edw].[dimAssessmentGeography] AS [A2]
WHERE [A1].[Jurisdiction Code] = [A2].[Jurisdiction Code]
AND [A1].[Roll Year] = @p_RY
      AND [A2].[Roll Year] = @p_RY
      AND [A1].[Jurisdiction Code] > '199'
      AND [A2].[Jurisdiction Code] > '199'
ORDER BY [A1].[Jurisdiction Code];