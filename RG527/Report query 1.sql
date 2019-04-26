DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_MTC INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_MTC = 16;  --General SERVICE AREA

SELECT [RD].[Regional District Code], 
       [RD].[Regional District desc], 
       [MT].[BCA Code] AS [Code], 
       [AG].[Jurisdiction Code] AS [Jur Code], 
       [AG].[Area Code] AS [AA], 
       [MT].[Minor Tax desc] AS [Minor Tax Title], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folios], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN([FA].[Net General Value])
               ELSE 0
           END) AS [Net Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN([FA].[Net General Value])
               ELSE 0
           END) AS [Net Impr], 
       SUM([FA].[Net General Value]) AS [Net Total]
FROM [EDW].[edw].[FactAssessedValue] AS [FA]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD] ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BFMT] ON [BFMT].[dimFolio_SK] = [FA].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT] ON [MT].[dimMinorTaxCode_SK] = [BFMT].[dimMinorTaxCode_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                           AND [FO].[Folio Status Code] = '01'
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Net General Value]) > 0
      AND [MT].[dimMinorTaxCategory_SK] = @p_MTC
GROUP BY [RD].[Regional District Code], 
         [RD].[Regional District desc], 
         [MT].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Area Code], 
         [MT].[Minor Tax desc]
ORDER BY [RD].[Regional District Code], 
         [MT].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Area Code], 
         [MT].[Minor Tax desc];