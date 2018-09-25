DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR CHAR(3);
DECLARE @p_NEIGH CHAR(6);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
SET @p_NEIGH = '213100'
SELECT DISTINCT 
       [Area Code], 
       [Jurisdiction Code], 
       [Neighbourhood Code]
FROM [edw].[dimAssessmentGeography] AS [GEO]
WHERE(dimRollYear_SK = @p_RY)
     AND [Jurisdiction Code] IN(@p_JR)
	 AND [Neighbourhood Code] IN(@p_NEIGH)
UNION
SELECT DISTINCT 
       [AR].[Area Code], 
       NULL, 
       NULL
FROM [edw].[dimArea] AS [AR]
WHERE([AR].dimRollYear_SK = @p_RY)
     AND [AR].[Area Code] IN(@p_AR)
ORDER BY [Area Code], 
         [Jurisdiction Code], 
         [Neighbourhood Code];