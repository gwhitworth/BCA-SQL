DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
SET @p_RY = 2017;
SET @p_MT = 'Saturna Recreation Prog DA#8';
--SELECT top 10 [FA].[dimFolio_SK],[BTC].[Minor Tax Code]
SELECT DISTINCT [BTC].[Minor Tax Code]
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
WHERE [FA].[Roll Year] = @p_RY
--AND [FA].[Cycle Number] = -1
	  AND [FA].[Assessment Code] ='01'
	  --AND [BTC].[Minor Tax Code] = '04-76403GA'
	  AND  [TC].[Jurisdiction Code] = '764'
      --AND REPLACE([AG].[Area], [AG].[Area Code], '') LIKE '%'+REPLACE([TC].[Regional District], [TC].[Regional District Code], '')+'%'
