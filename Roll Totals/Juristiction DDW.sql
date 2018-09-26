DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT DISTINCT 
       [A1].[Area Code], 
       [A2].[dimJurisdiction_SK], 
       [A2].[dimJurisdiction_BK], 
       [A2].[Jurisdiction Code], 
       [A2].[Jurisdiction Desc], 
       [A2].[Jurisdiction]
FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
     [EDW].[edw].[dimAssessmentGeography] AS [A2]
WHERE([A1].[Area Code] = [A2].[Area Code]
      AND [A1].[Roll Year] = @p_RY
      AND [A1].[Jurisdiction Code] > '199'
      AND [A2].[Roll Year] = @p_RY
      AND [A2].[Jurisdiction Code] > '199')
UNION
SELECT DISTINCT 
       [Area Code], 
       -3, 
       'NA', 
       'NA', 
       'Not Applicable', 
       'Not Applicable'
FROM [EDW].[edw].[dimAssessmentGeography]
WHERE [Roll Year] = @p_RY
      AND [Jurisdiction Code] > '199'
ORDER BY [Area Code], 
         [dimJurisdiction_SK], 
         [Jurisdiction Code] DESC;