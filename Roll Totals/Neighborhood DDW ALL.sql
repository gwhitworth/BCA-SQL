DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT DISTINCT 
       [Neighbourhood Code], 
       [Neighbourhood Desc], 
       [Neighbourhood]
FROM [EDW].[edw].[dimAssessmentGeography]
WHERE [Roll Year] = @p_RY
      AND [Jurisdiction Code] > '199'
      AND [Neighbourhood] NOT LIKE '%DO NOT USE%'
ORDER BY [Neighbourhood Code];