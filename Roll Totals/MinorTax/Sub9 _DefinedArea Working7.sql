/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [OC].[dimFolio_SK]
      ,[Property Class Occurrence]
	  ,[SD].[School District Code]
	  ,[BTC].[Minor Tax Code]
	  ,[AG].dimJurisdiction_SK
  FROM [EDW].[edw].[FactPropertyClassOccurrenceCount] AS [OC]
  INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [OC].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC] ON [OC].[dimFolio_SK] = [BTC].[dimFolio_SK]
                                                           AND [OC].[Roll Year] = [BTC].[Roll Year]
														   AND [AG].dimJurisdiction_SK = [BTC].dimJurisdiction_SK



  LEFT OUTER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [SD] ON [AG].dimJurisdiction_SK = [SD].dimJurisdiction_SK

  WHERE [OC].[Roll Year] = 2017 
  AND [SD].[School District Code] is not null
  --AND [Cycle Number] = 0
  AND [OC].[Roll Type] = 'ROLL'
  AND [Assessment Code] = '01'
  AND [OC].[dimFolio_SK] IN (SELECT  [FA].[dimFolio_SK]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC] ON [FA].[dimFolio_SK] = [BTC].[dimFolio_SK]
                                                           AND [FA].[Roll Year] = [BTC].[Roll Year]
														   AND [AG].dimJurisdiction_SK = [BTC].dimJurisdiction_SK
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC] ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
                                                   AND [BTC].[Roll Year] = [TC].[Roll Year]
												   AND [AG].dimJurisdiction_SK = [TC].dimJurisdiction_SK
WHERE [FA].[Roll Year] = 2017
	  AND [FA].[Assessment Code] ='01')
	  --AND [BTC].[Minor Tax Code] = '04-76403GA')

  ORDER BY [dimFolio_SK]


