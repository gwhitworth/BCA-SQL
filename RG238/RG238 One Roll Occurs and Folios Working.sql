/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @p_RY int
DECLARE @p_CN int
SET @p_RY = 2018
SET @p_CN = -1


SELECT [FAV].[Roll Year]
		,[AG].[Area]
		,[AG].[Jurisdiction Code]
		,[AG].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		--,[PC].[Property Sub Class Code]
		--,[PC].[Property Sub Class Desc]
		--,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc]) AS [Property Class]
		,[FAV].[Assessment Code]
		--,[FAV].[Folio Number]
		,COUNT([FAV].[dimFolio_SK]) AS [Occurrences]
		,COUNT(DISTINCT [FAV].[dimFolio_SK]) AS [Folio Count]
		,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] = '01'AND FAV.[Assessment Code] <> '01' THEN FAV.dimFolio_SK END) AS [Res Occur]
  FROM [edw].[FactAssessedValue] AS [FAV] 
		INNER JOIN [edw].[dimPropertyClass] AS [PC] 
			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		--INNER JOIN [edw].[dimJurisdiction] AS [JR]
		--	ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
		--INNER JOIN [edw].[dimArea] AS [AR]
		--	ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
		--INNER JOIN [edw].[dimFolio] AS [FO]
		--	ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE   [FAV].[Property Class Code] < 99
		AND [FAV].[Roll Year] = @p_RY

		AND AG.[Roll Category Code] = '1'
		AND [FAV].[Cycle Number] <= @p_CN
		AND [AG].[Area Code] IN ('01','08','09','10','11','14')
		AND [AG].[Jurisdiction Code] = '317'
		--AND [FAV].[Roll Number] = '08285701'
		AND [PC].[Property Class Code] = '01'
GROUP BY [FAV].[Roll Year]
		,[AG].[Area]
		,[AG].[Jurisdiction Code]
		,[AG].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		,[FAV].[Assessment Code]
		--,[PC].[Property Sub Class Code]
		--,[PC].[Property Sub Class Desc]
		--,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc])
--ORDER BY [FAV].[Folio Number]

--SELECT DISTINCT  [FAV].[Roll Year]
--		,[FAV].[Cycle Number]
--		,[AR].[Area]
--		,[JR].[Jurisdiction Code]
--		,[JR].[Jurisdiction Desc]
--		,[PC].[Property Class Code]
--		,[PC].[Property Sub Class Code]
--		,[PC].[Property Sub Class Desc]
--		,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc]) AS [Property Class]
--		,[FAV].[Assessment Code]
--		,[FAV].[Folio Number]
--		,[FO].[dimFolio_SK]
--		,[Gross Other Value]
--  FROM [edw].[edw].[FactAllAssessedAmounts] AS [FAV] 
--		INNER JOIN [edw].[dimPropertyClass] AS [PC] 
--			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
--		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
--			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]

--WHERE   [FAV].[Property Class Code] < 99
--		AND [FAV].[Roll Year] = @p_RY
--		AND AG.[Roll Category Code] = '1'
--		AND AG.[Cycle Number] <= @p_CN
--		AND AG.[Area Code] IN ('01','08','09','10','11','14')
--		AND AG.[Jurisdiction Code] = '317'
--		--AND [FO].[Roll Number] = '08285701'
--		AND AG.[Property Class Code] = '01'
--		AND AG.[Current Record Flag] = 'Y'

--ORDER BY [FO].[dimFolio_SK]