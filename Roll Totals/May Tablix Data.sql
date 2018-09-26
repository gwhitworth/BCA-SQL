DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR CHAR(3);
DECLARE @p_N CHAR(6);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
SET @p_N = '213100';
SELECT DISTINCT 
       [Area Code], 
       [Jurisdiction Code], 
       [Neighbourhood Code]
FROM [edw].[dimAssessmentGeography] AS [GEO]
WHERE(dimRollYear_SK = @p_RY)
     AND [Area Code] IN(@p_AR)
UNION
SELECT DISTINCT 
       [Area Code], 
       [Jurisdiction Code], 
       'NA' AS [Neighbourhood Code]
FROM [edw].[dimAssessmentGeography] AS [GEO]
WHERE([dimRollYear_SK] = @p_RY)
     AND [Area Code] IN(@p_AR)
UNION
SELECT DISTINCT 
       [AR].[Area Code], 
       'NA' AS [Jurisdiction Code], 
       'NA' AS [Neighbourhood Code]
FROM [edw].[dimArea] AS [AR]
WHERE([AR].dimRollYear_SK = @p_RY)
     AND [AR].[Area Code] IN(@p_AR)
ORDER BY [Area Code], 
         [Jurisdiction Code] DESC, 
         [Neighbourhood Code];