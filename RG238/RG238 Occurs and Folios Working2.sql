
/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = 12;

SELECT [FAV].[Roll Year]
		,[AR].[Area]
		,[JR].[Jurisdiction Code]
		,[JR].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		--,[PC].[Property Sub Class Code]
		--,[PC].[Property Sub Class Desc]
		--,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc]) AS [Property Class]
		--,[FAV].[Assessment Code]
		--,[FAV].[Folio Number]
		,COUNT([FAV].[dimFolio_SK])/2 AS [Occurrences]
		,COUNT(DISTINCT [FAV].[dimFolio_SK]) AS [Folio Count]
  FROM [edw].[FactAssessedValue] AS [FAV] 
		INNER JOIN [edw].[dimPropertyClass] AS [PC] 
			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		INNER JOIN [edw].[dimJurisdiction] AS [JR]
			ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
		INNER JOIN [edw].[dimArea] AS [AR]
			ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
		INNER JOIN [edw].[dimFolio] AS [FO]
			ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE   [FAV].[Property Class Code] < 99
		AND [FAV].[Roll Year] = @p_RY
		AND FO.[Folio Status Code] ='01'
		AND AG.[Roll Category Code] = '1'
		AND [FAV].[Cycle Number] <= @p_CN
		AND [AR].[Area Code] IN ('01','08','09','10','11','14')
		AND [JR].[Jurisdiction Code] = '317'
		--AND [FO].[Roll Number] = '08285701'
		AND [PC].[Property Class Code] = '01'
GROUP BY [FAV].[Roll Year]
		,[AR].[Area]
		,[JR].[Jurisdiction Code]
		,[JR].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		--,[PC].[Property Sub Class Code]
		--,[PC].[Property Sub Class Desc]
		--,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc])
--ORDER BY [FAV].[Folio Number]
SELECT DISTINCT [FAV].[Roll Year]
		,[AR].[Area]
		,[JR].[Jurisdiction Code]
		,[JR].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		,[PC].[Property Sub Class Code]
		,[PC].[Property Sub Class Desc]
		,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc]) AS [Property Class]
		,[FAV].[Assessment Code]
		,[FAV].[Folio Number]
		,[FO].[dimFolio_SK]
		,[FO].[Roll Number]
  FROM [edw].[FactAssessedValue] AS [FAV] 
		INNER JOIN [edw].[dimPropertyClass] AS [PC] 
			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		INNER JOIN [edw].[dimJurisdiction] AS [JR]
			ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
		INNER JOIN [edw].[dimArea] AS [AR]
			ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
		INNER JOIN [edw].[dimFolio] AS [FO]
			ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE   [FAV].[Property Class Code] < 99
		AND [FAV].[Roll Year] = @p_RY
		AND FO.[Folio Status Code] ='01'
		AND AG.[Roll Category Code] = '1'
		AND [FAV].[Cycle Number] <= @p_CN
		AND [AR].[Area Code] IN ('01','08','09','10','11','14')
		AND [JR].[Jurisdiction Code] = '317'
		AND [FO].[Roll Number] = '01023600'
		AND [PC].[Property Class Code] = '01'
ORDER BY [FO].[Roll Number]

--SELECT DISTINCT 
--       [AR].[Area], 
--       [JR].[Jurisdiction Code], 
--       [JR].[Jurisdiction Desc], 
--       [PC].[Property Class Code], 
--       [PC].[Property Sub Class Code], 
--       [PC].[Property Sub Class Desc], 
--       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class],
--       --,[FAV].[Assessment Code] 
--       [FAV].[Folio Number], 
--       [FO].[dimFolio_SK], 
--       [FO].[Roll Number]
--FROM [edw].[FactAssessedValue] AS [FAV]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--     INNER JOIN [edw].[dimJurisdiction] AS [JR] ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
--     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
--     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
--WHERE [FAV].[Property Class Code] < 99
--      AND [FAV].[Roll Year] = @p_RY
--      AND FO.[Folio Status Code] = '01'
--      AND AG.[Roll Category Code] = '1'
--      AND [FAV].[Cycle Number] <= @p_CN
--      AND [AR].[Area Code] IN ('01', '08', '09', '10', '11', '14')
--     AND [JR].[Jurisdiction Code] = '317'
--     AND [FO].[Roll Number] IN
--(
--    SELECT [FO].[Roll Number]
--    FROM [edw].[FactAssessedValue] AS [FAV]
--         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--         INNER JOIN [edw].[dimJurisdiction] AS [JR] ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
--         INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
--         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
--    WHERE [FAV].[Property Class Code] < 99
--          AND [FAV].[Roll Year] = 2018
--          AND FO.[Folio Status Code] = '01'
--          AND AG.[Roll Category Code] = '1'
--          AND [FAV].[Cycle Number] <= 12
--          AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
--         AND [JR].[Jurisdiction Code] = '317'
--         --AND [FO].[Roll Number] = '08285701'
--    GROUP BY [FO].[Roll Number]
--    HAVING COUNT(1) > 2

--)
----AND [PC].[Property Class Code] = '01'
----GROUP BY [AR].[Area]
----		,[JR].[Jurisdiction Code]
----		,[JR].[Jurisdiction Desc]
----		,[PC].[Property Class Code]
----		,[PC].[Property Sub Class Code]
----		,[PC].[Property Sub Class Desc]
----		,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc])
----		,[FAV].[Assessment Code]
----		,[FAV].[Folio Number]
----		,[FO].[dimFolio_SK]
----		,[FO].[Roll Number]
----HAVING		COUNT(1) > 1
--ORDER BY [FO].[Roll Number];

--SELECT [FO].[Roll Number]
--FROM		[edw].[dimFolio] AS [FO]
--WHERE [FO].[Roll Number] = '08285701'
--GROUP BY	[FO].[Roll Number]
--HAVING		COUNT(1) > 1
--SELECT TOP 10 [FO].[Roll Number]
--  FROM  [edw].[dimFolio] AS [FO]
--SELECT		[FO].[Roll Number]
--FROM		[edw].[dimFolio] AS [FO]
--GROUP BY	[FO].[Roll Number]
--HAVING		COUNT(1) > 1;

SELECT  DISTINCT [FAV].[dimFolio_SK],--[FAV].[Property Class Code],[FAV].[Property Sub Class Code],
       COUNT(*) AS CNT
FROM [edw].[FactAssessedValue] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimJurisdiction] AS [JR] ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE [FAV].[Property Class Code] < 99
      AND [FAV].[Roll Year] = 2018
      AND FO.[Folio Status Code] = '01'
      AND AG.[Roll Category Code] = '1'
      AND [FAV].[Cycle Number] <= 12
      AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
     AND [JR].[Jurisdiction Code] = '317'
    AND [FO].[Roll Number] = '01023600'
	--and [FAV].[Assessment Code] = '01'
	-- AND [PC].[Property Class Code] = '01'
GROUP BY  [FAV].[dimFolio_SK]--,[FAV].[Property Class Code],[FAV].[Property Sub Class Code]
HAVING COUNT(*) > 1
ORDER BY [FAV].[dimFolio_SK]--,[FAV].[Property Class Code],[FAV].[Property Sub Class Code];

SELECT DISTINCT top 1000 [FAV].[dimFolio_SK],[FAV].[Property Class Code],[FAV].[Property Sub Class Code]
FROM [edw].[FactAssessedValue] AS [FAV]
--     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--     INNER JOIN [edw].[dimJurisdiction] AS [JR] ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
--     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
--     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
--WHERE [FAV].[Property Class Code] < 99
--      AND [FAV].[Roll Year] = 2018
--      AND FO.[Folio Status Code] = '01'
--      AND AG.[Roll Category Code] = '1'
--      AND [FAV].[Cycle Number] <= 12
--      AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
--     AND [JR].[Jurisdiction Code] = '317'
     
	 --AND [PC].[Property Class Code] = '01'