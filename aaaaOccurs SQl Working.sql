DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [FAV].[dimFolio_SK], 
       [FAV].[Property Class Code], 
       COUNT(*) - 1 AS [Occur Count]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimAssessmentType] AS [AT]
     ON [AT].[dimAssessmentType_SK] = [FAV].[dimAssessmentType_SK]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FAV].[dimRollCycle_SK]
     INNER JOIN [edw].[dimRollType] AS [RT]
     ON [RT].[dimRollType_SK] = [FAV].[dimRollType_SK]
WHERE [FAV].[dimRollYear_SK] = @p_RY
      AND [AG].[Roll Category Code] = '1'
      AND [RC].[Cycle Number] = @p_CN
      AND [Assessment Code] = '02'
	  AND [FAV].dimRollType_SK = 11 --Completed ROLL
GROUP BY [FAV].[dimFolio_SK], 
         [FAV].[Property Class Code]
HAVING COUNT(*) > 1
ORDER BY [FAV].[dimFolio_SK];