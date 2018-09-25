DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR VARCHAR(255);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
IF @p_JR = NULL
BEGIN
SELECT @p_JR AS [Jurisdiction Code], 
       '000' AS [Neighbourhood Code], 
       'N/A' AS Neighbourhood, 
       'N/A' AS [Neighbourhood Desc]
END
ELSE
BEGIN
SELECT [Jurisdiction Code], 
       [NEIGH].[Neighbourhood Code], 
       [NEIGH].Neighbourhood, 
       [NEIGH].[Neighbourhood Desc]
FROM [edw].[dimAssessmentGeography] AS [GEO]
     INNER JOIN [edw].[dimNeighbourhood] AS [NEIGH] ON [GEO].[dimNeighbourhood_SK] = [NEIGH].[dimNeighbourhood_SK]
WHERE([GEO].[Roll Year] = @p_RY)
     AND ([GEO].[Jurisdiction Code] = ISNULL(@p_JR, '000'))
ORDER BY [Neighbourhood Code]
END