/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @p_RY int
DECLARE @p_CN int
SET @p_RY = 2017
SET @p_CN = -1
SELECT [FAV].[Roll Year]
		,[AG].[Area]
		,[AG].[Jurisdiction Code]
		,[AG].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		,[PC].[Property Sub Class Code]
		--,[PC].[Property Sub Class Desc]
		--,ISNULL([PC].[Property Sub Class Desc],[PC].[Property Class Desc]) AS [Property Class]
		,[FAV].[Assessment Code]
		--,[FAV].[Folio Number]
		,COUNT([FAV].[dimFolio_SK]) AS [Occurrences]
		--,COUNT(DISTINCT [FAV].[dimFolio_SK]) AS [Folio Count]
		--,COUNT(DISTINCT CASE WHEN PC.[Property Class Code] = '01'AND FAV.[Assessment Code] <> '01' THEN FAV.dimFolio_SK END) AS [Res Occur]
  FROM [edw].[FactAssessedValue] AS [FAV] 
		INNER JOIN [edw].[dimPropertyClass] AS [PC] 
			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		--INNER JOIN [edw].[dimJurisdiction] AS [JR]
		--	ON [AG].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
		--INNER JOIN [edw].[dimArea] AS [AR]
		--	ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
		INNER JOIN [edw].[dimFolio] AS [FO]
			ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE  [FAV].[Roll Year] = @p_RY

		AND AG.[Roll Category Code] = '1'
		AND [FAV].[Cycle Number] <= @p_CN
		AND [AG].[Area Code] IN ('01','08','09','10','11','14')
		AND [AG].[Jurisdiction Code] = '317'
		--AND [FO].[Roll Number] = '08285701'

GROUP BY [FAV].[Roll Year]
		,[AG].[Area]
		,[AG].[Jurisdiction Code]
		,[AG].[Jurisdiction Desc]
		,[PC].[Property Class Code]
		,[PC].[Property Sub Class Code]
		,[FAV].[Assessment Code]
HAVING Count(*) > 1


SELECT [dimRollType_SK]
      ,[dimRollCycle_SK]
      ,[dimAssessmentType_SK]
      ,[FAV].[dimPropertyClass_SK]
      ,[FAV].[dimRollYear_SK]
      ,[RollYearStart_dimDate_SK]
      ,[RollEffective_dimDate_SK]
      ,[Current Cycle Flag]
      ,[FAV].[dimFolio_SK]
      ,[FAV].[dimAssessmentGeography_SK]
      ,[Roll Object Id]
      ,[Roll Effective Date]
      ,[FAV].[Roll Year]
      ,[Cycle Number]
      ,[Roll Type]
      ,[FAV].[Folio Number]
      ,[Assessment Code]
      ,[FAV].[Property Class Code]
      ,[FAV].[Property Sub Class Code]
      ,[Gross General Land Value]
      ,[Gross General Building Value]
      ,[Gross Other Land Value]
      ,[Gross Other Building Value]
      ,[Gross School Land Value]
      ,[Gross School Building Value]
      ,[Net General Land Value]
      ,[Net General Building Value]
      ,[Net Other Land Value]
      ,[Net Other Building Value]
      ,[Net School Land Value]
      ,[Net School Building Value]
      ,[General Exemptions Land Value]
      ,[General Exemptions Building Value]
      ,[Other Exemptions Land Value]
      ,[Other Exemptions Building Value]
      ,[School Exemptions Land Value]
      ,[School Exemptions Building Value]
      ,[Actual Land Value]
      ,[Actual Building Value]
      ,[Folio Count]
  FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
  INNER JOIN [edw].[dimPropertyClass] AS [PC] 
			ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK] 
		INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		INNER JOIN [edw].[dimFolio] AS [FO]
			ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
WHERE   [FAV].[Roll Year] = @p_RY
		AND AG.[Roll Category Code] = '1'
		AND [FAV].[Cycle Number] <= @p_CN
		AND [AG].[Jurisdiction Code] = '317'
		AND [FO].[Roll Number] = '08285701'
ORDER BY [dimRollType_SK]


