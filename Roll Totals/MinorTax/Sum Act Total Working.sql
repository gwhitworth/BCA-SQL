DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
SET @p_RY = 2017;
SET @p_MT = 'Building Inspection SRVA#32';
SELECT distinct [FA].[Roll Year], 
       [TC].[Regional District Code] AS [RD Code], 
       REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', '') AS [Regional District], 
       [AG].[Area Code], 
       REPLACE([AG].[Area], [AG].[Area Code]+' - ', '') AS [Assessment Area], 
       [TC].[Jurisdiction Code] AS [Jur Code], 
       REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', '') AS [Jurisdiction], 
       [TC].[BCA Code] AS [Defined Area Code], 
       [TC].[Minor Tax Desc] AS [Defined Area],
       SUM([FA].[Actual Land Value]) AS [Actual - Land], 
       SUM([FA].[Actual Building Value]) AS [Actual - Impr], 
	   SUM([FA].[Actual Land Value]) + SUM([FA].[Actual Building Value]) AS [Total]
 FROM [edw].[FactActualAmounts] AS [FA]
     --INNER JOIN [edw].FactAssessedValue AS [FA2]
	 ------[edw].[FactActualAmounts] AS [FA]
     --ON [FA].[dimFolio_SK] = [FA2].[dimFolio_SK]-- AND [FA2].[Assessment Code] = '02'
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC]
     ON [FA].[dimFolio_SK] = [BTC].[dimFolio_SK]
        AND [AG].[dimJurisdiction_SK] = [BTC].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = -1
      AND [TC].[Minor Tax Code] IN
(
    SELECT [Minor Tax Code]
    FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
    WHERE [Roll Year] = @p_RY
          AND [Minor Tax Desc] IN(@p_MT)
)
group by [FA].[Roll Year], 
       [TC].[Regional District Code], 
       REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', ''), 
       [AG].[Area Code], 
       REPLACE([AG].[Area], [AG].[Area Code]+' - ', ''), 
       [TC].[Jurisdiction Code], 
       REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', ''), 
       [TC].[BCA Code], 
       [TC].[Minor Tax Desc]
