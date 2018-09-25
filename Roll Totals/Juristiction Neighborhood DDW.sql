DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR VARCHAR(255);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
SELECT [NEIGH].[Neighbourhood Code], 
       [NEIGH].Neighbourhood, 
       [NEIGH].[Neighbourhood Desc]
FROM [edw].[dimAssessmentGeography] AS [GEO]
     INNER JOIN [edw].[dimNeighbourhood] AS [NEIGH] ON [GEO].[dimNeighbourhood_SK] = [NEIGH].[dimNeighbourhood_SK]
WHERE([GEO].[Roll Year] = @p_RY)
     AND ([GEO].[Jurisdiction Code] = @p_JR)
UNION
SELECT '000', 
       'N/A', 
       'N/A'
ORDER BY [Neighbourhood Code];