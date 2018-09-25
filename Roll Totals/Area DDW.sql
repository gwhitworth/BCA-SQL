DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT DISTINCT 
       [dimArea_SK], 
       [Area Code], 
       [Area Desc], 
       [Area]
FROM [EDW].[edw].[dimAssessmentGeography]
WHERE [Roll Year] = @p_RY
      AND [Area Code] BETWEEN 01 AND 27
ORDER BY [Area Code];