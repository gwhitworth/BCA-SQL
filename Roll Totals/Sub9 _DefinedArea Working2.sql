DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
SET @p_RY = 2017;
SET @p_MT = 'Saturna Recreation Prog DA#8';
SELECT [FA].[Roll Year], 
       [BTC].[Regional District Code] AS [RD Code], 
       REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', '') AS [Regional District], 
       REVERSE(RIGHT([TC].[Electoral District Code], 1)) AS [EA Code], 
       [AG].[Area Code], 
       REPLACE([AG].[Area], [AG].[Area Code]+' - ', '') AS [Assessment Area], 
       [AG].[Jurisdiction Code] AS [Jur Code], 
       REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', '') AS [Jurisdiction], 
       --[TC].[BCA Code] AS [Defined Area Code], 
       [BTC].[Minor Tax Code] AS [Defined Area], 
       --[TC].[Tax Base Code] AS [Tax Base], 
       [PC].[Property Class Code] AS [PC Code], 
       REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', '') AS [Property Class], 
       IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])) AS [PSC Code], 
       IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])) AS [Property Subclass], 
       SUM([FA].[Actual Land Value]) AS [Actual - Land]
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
	  AND [FA].[Assessment Code] ='01'
	  AND [BTC].[Minor Tax Code] = '04-76403GA'
      --AND REPLACE([AG].[Area], [AG].[Area Code], '') LIKE '%'+REPLACE([TC].[Regional District], [TC].[Regional District Code], '')+'%'
GROUP BY [FA].[Roll Year], 
         [BTC].[Regional District Code], 
         REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', ''), 
         REVERSE(RIGHT([TC].[Electoral District Code], 1)), 
         [AG].[Area Code], 
         REPLACE([AG].[Area], [AG].[Area Code]+' - ', ''), 
         [AG].[Jurisdiction Code], 
         REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', ''), 
         --[TC].[BCA Code], 
         [BTC].[Minor Tax Code], 
         --[TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', ''), 
         IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])), 
         IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]))
ORDER BY [FA].[Roll Year], 
         [BTC].[Regional District Code], 
         [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         --[TC].[BCA Code], 
         --[TC].[Minor Tax Code], 
         --[TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         [PSC Code];