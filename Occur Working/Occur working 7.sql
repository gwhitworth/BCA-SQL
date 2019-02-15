DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
SELECT  TOP 1000 [FA].[dimFolio_SK],
                         --[FA].[dimAssessmentType_SK], 
                         [PC].[Property Class Code], 
                         [PC].[Property Sub Class Code], 
                         COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Occur Count]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
        AND [PC].[Property Sub Class Code] IS NULL
--INNER JOIN [edw].[dimRollCycle] AS [RC]
--ON [RC].[dimRollCycle_SK] = [FA].[dimRollCycle_SK]
WHERE [fa].[dimRollYear_SK] = @p_RY
      --AND [Cycle Number] = @p_CN
      --AND [FA].[dimRollType_SK] = 11
      --AND [FA].[dimAssessmentType_SK] = 10
      AND [FA].[dimFolio_SK] = 436
GROUP BY [FA].[dimFolio_SK], 
         --[FA].[dimAssessmentType_SK],
         [PC].[Property Class Code], 
         [PC].[Property Sub Class Code]
HAVING COUNT([FA].[dimFolio_SK]) > 1
ORDER BY [FA].[dimFolio_SK], 
         [PC].[Property Class Code];

--SELECT TOP 1000 [FA].*, 
--                [PC].[Property Class Code],[pc].[Property Sub Class Code]
--FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC]
--     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--        AND [PC].[Property Sub Class Code] IS NULL
--     INNER JOIN [edw].[dimRollCycle] AS [RC]
--     ON [RC].[dimRollCycle_SK] = [FA].[dimRollCycle_SK]
--WHERE [fa].[dimRollYear_SK] = @p_RY
--      AND [Cycle Number] = @p_CN
--      AND [FA].[dimRollType_SK] = 11
--      AND [FA].[dimFolio_SK] = 159
--      AND [FA].[dimAssessmentType_SK] = 11
--ORDER BY [FA].[dimFolio_SK], 
--         [PC].[Property Class Code];