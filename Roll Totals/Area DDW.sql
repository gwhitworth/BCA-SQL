DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
IF @p_AR = 'NA'
BEGIN
SELECT DISTINCT 
       NULL AS [dimArea_SK], 
       'NA', 
       'Not Applicable', 
       'Not Applicable', 
       999
END
ELSE
BEGIN
SELECT DISTINCT 
       [dimArea_SK], 
       [Area Code], 
       [Area Desc], 
       [Area], 
       [RowSortOrder]
FROM [EDW].[edw].[dimAssessmentGeography]
WHERE [Roll Year] = @p_RY
      AND [Area Code] BETWEEN 01 AND 27
UNION
SELECT DISTINCT 
       NULL, 
       'NA', 
       'Not Applicable', 
       'Not Applicable', 
       999
ORDER BY [RowSortOrder] DESC, 
         [Area Code]
END