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
      AND [A2].[Neighbourhood] NOT LIKE 'DO NOT USE%'
UNION
SELECT DISTINCT 
       [Jurisdiction Code], 
       'NA', 
       'Not Applicable', 
       'Not Applicable'
FROM [EDW].[edw].[dimAssessmentGeography]
WHERE [Roll Year] = @p_RY
      AND [Jurisdiction Code] > '199'
UNION
SELECT DISTINCT 
       'NA', 
       'NA', 
       'Not Applicable', 
       'Not Applicable'
ORDER BY [Jurisdiction Code],[Neighbourhood Code] DESC;