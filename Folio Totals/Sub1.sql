DECLARE @p_RY INT;
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '234010';
SELECT [FACT].[Roll Year], 
       [AG].[Area Code], 
       [AG].[Jurisdiction Code] AS [Jur Code], 
       [FO].[Roll Number], 
       [AG].[Neighbourhood Code] AS [Neigh Code], 
       [FO].[Primary Actual Use Code] AS [Actual Use Code], 
       [MC].[Manual Class Code], 
       [FO].[School  District Code], 
       [RD].[Regional District Code], 
       '' AS [ALR Code], 
       [PL].[Tenure Code], 
       [FC].[Folio Characteristic Code] AS [Folio Char Code], 
       [FACT].[Total Actual Value] AS [Actual - Total], 
       [FACT].[School Exemptions Value] AS [Exempt_School_Improvements], 
       [FACT].[Gross General Value] AS [Gen Gr - Total], 
       [FACT].[General Exemptions Value] AS [Gen Ex - Total], 
       [FACT].[Gross School Value] AS [Sch Gr - Total], 
       [FACT].[School Exemptions Value] AS [Sch Ex - Total], 
       [FACT].[Net Other Value] AS [Hsp Gr - Total], 
       [FACT].[Other Exemptions Value] AS [Hsp Ex - Total]
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     -- AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FACT].[dimFolio_SK]
     -- AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimManualClass] AS [MC]
     ON [MC].[dimManualClass_SK] = [FACT].[dimManualClass_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeParcelFolio] AS [BR_PF]
     ON [BR_PF].[dimFolio_SK] = [FO].[dimFolio_SK]
     INNER JOIN [edw].[dimParcel] AS [PL]
     ON [PL].[dimParcel_SK] = [BR_PF].[dimParcel_SK]
     LEFT OUTER JOIN [edw].[dimFolioCharacteristicTbl] AS [FC]
     ON [FC].[dimFolioCharacteristic_BK] = [FO].[Characteristic1_dimFolioCharacteristic_BK]
WHERE [FACT].[Roll Year] = @p_RY
      AND [AG].[Neighbourhood Code] = @p_NH
ORDER BY [FACT].[Roll Year], 
         [AG].[Area Code], 
         [AG].[Jurisdiction Code], 
         [FO].[Roll Number], 
         [AG].[Neighbourhood Code], 
         [FO].[Primary Actual Use Code], 
         [MC].[Manual Class Code], 
         [FO].[School  District Code], 
         [RD].[Regional District Code], 
         [ALR Code], 
         [PL].[Tenure Code], 
         [FC].[Folio Characteristic Code];