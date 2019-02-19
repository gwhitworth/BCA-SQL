DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT DISTINCT [AG].[Area Code], 
       [JR].[Jurisdiction Code]
FROM [edw].[dimJurisdiction] AS [JR]
	 INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
	 ON [JR].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
WHERE([JR].[dimRollYear_SK] = @p_RY)
     AND [JR].[Jurisdiction Code] > '199'
     AND [AG].[Area Code] = @p_AR
ORDER BY [AG].[Area Code], 
         [Jurisdiction Code];