SELECT DISTINCT
	  [SD].[School District Code],[SD].dimJurisdiction_SK,[AG].dimJurisdiction_SK, [AG].Jurisdiction
	  ,[BTC].[Minor Tax Code]
  FROM [edw].[dimAssessmentGeography] AS [AG]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC] ON [AG].[Roll Year] = [BTC].[Roll Year]
														   AND [AG].dimJurisdiction_SK = [BTC].dimJurisdiction_SK



  LEFT OUTER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [SD] ON [AG].dimJurisdiction_SK = [SD].dimJurisdiction_SK

  WHERE [AG].[Roll Year] = 2017 
  AND [BTC].[Minor Tax Code] = '04-76403GA'
  ORDER BY [BTC].[Minor Tax Code]


