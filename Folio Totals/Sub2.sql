DECLARE @p_RY INT;
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '234022';
SELECT DISTINCT [FACT].[Roll Year], 
       [AG].[Area Code], 
       [AG].[Area] AS [Area Name], 
       [AG].[Jurisdiction Code] AS [Jur Code], 
       [AG].[Jurisdiction] AS [Jur Name], 
       [AG].[Neighbourhood Code] AS [Neigh Code], 
       [AG].[Neighbourhood Desc] AS [Neigh Name], 
       [FO].[Roll Number], 
       [PL].[PID], 
       [Lot], 
       [Section], 
       [Block Number], 
       [Range], 
       [Plan Number], 
       [Township Code], 
       [Subdivision], 
       [PL].[Legal Text] AS [Legal Description], 
       [FO].[dimFolio_SK], 
       [FO].[SITUS Building/Unit Number] AS [Situs Unit No], 
       [FO].[SITUS Address Number Prefix], 
       [FO].[SITUS Street Number], 
       [FO].[SITUS Address Street Name], 
       [FO].[SITUS Street Suffix], 
       [FO].[SITUS Street Suffix #2], 
       [FO].[SITUS City] AS [Situs City], 
       [FO].[SITUS Prov/State] AS [Situs Province], 
       [FO].[SITUS Postal Code] AS [Situs Postal Code], 
       '??' AS [Situs Freeform Address],
       --[BR_FA].[Party Type],
       '??Owner??' AS [Party Type], 
       [ONA].[Company Name] AS [Owner CompName], 
       [ONA].[First Name] AS [Owner FName], 
       [ONA].[Last Name] AS [Owner LName], 
       [BR_FA].[Care Of], 
       [OAD].[dimAddress_SK], 
       [OAD].[Address Type Code], 
       [OAD].[Address Unit], 
       [OAD].[Street Number], 
       [OAD].[Address Street Name], 
       [OAD].[City Desc], 
       [OAD].[Province Desc], 
       [OAD].[Postal/Zip Code], 
       [OAD].[Address Line 1] AS [Owner Address 1], 
       [OAD].[Address Line 2] AS [Owner Address 2], 
       [OAD].[Address Line 3] AS [Owner Address 3], 
       [OAD].[Address Line 4] AS [Owner Address 4], 
       [OAD].[Address Line 5] AS [Owner Address 5], 
       '???' AS [Extended-Legal]
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FACT].[dimFolio_SK]
     AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimManualClass] AS [MC]
     ON [MC].[dimManualClass_SK] = [FACT].[dimManualClass_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeParcelFolio] AS [BR_PF]
     ON [BR_PF].[dimFolio_SK] = [FO].[dimFolio_SK]
     INNER JOIN [edw].[dimParcel] AS [PL]
     ON [PL].[dimParcel_SK] = [BR_PF].[dimParcel_SK]
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BR_FA]
     ON [BR_FA].[dimFolio_SK] = [FO].[dimFolio_SK]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [BR_FA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [BR_FA].[dimAddress_SK]
     LEFT OUTER JOIN [edw].[dimFolioCharacteristicTbl] AS [FC]
     ON [FC].[dimFolioCharacteristic_BK] = [FO].[Characteristic1_dimFolioCharacteristic_BK]
WHERE [FACT].[Roll Year] = @p_RY
      AND [AG].[Neighbourhood Code] = @p_NH
      AND [Roll Number] = '02101006'
ORDER BY [FACT].[Roll Year], 
         [AG].[Area Code], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction], 
         [AG].[Neighbourhood Code], 
         [AG].[Neighbourhood Desc]