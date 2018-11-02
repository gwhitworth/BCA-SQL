DECLARE @p_RY [INT];
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '234022';
SELECT TOP 500 [ONA].[Company Name] AS [Owner CompName], 
               [ONA].[First Name] AS [Owner FName], 
               [ONA].[Middle Name] AS [Owner MName], 
               [ONA].[Last Name] AS [Owner LName], 
               [BR_FA].[Care Of], 
               [OAD].[Attention], 
               [OAD].[dimAddress_BK], 
               [OAD].[dimCountry_SK], 
               [dimProvince_SK], 
               [OAD].[dimCity_SK], 
               [dimStreetDirection_SK], 
               [dimStreetType_SK], 
               [dimUnitType_SK], 
               [OAD].[dimCountry_BK], 
               [dimProvince_BK], 
               [OAD].[dimCity_BK], 
               [dimStreetDirection_BK], 
               [dimStreetType_BK], 
               [dimUnitType_BK], 
               [OAD].[Country Code], 
               [OAD].[Country Desc], 
               [OAD].[Country], 
               [Province Desc], 
               [City Desc], 
               [Street Suffix], 
               [OAD].[Street Suffix 2], 
               [Street Direction Desc], 
               [Address Line 1], 
               [Address Line 2], 
               [Address Line 3], 
               [Address Type Code], 
               [Address Number Suffix], 
               [Grid Address Number], 
               [Street Number], 
               [Address Street Name], 
               [Carrier Route], 
               [Postal Index Number], 
               [Postal/Zip Code], 
               [Address Unit Description], 
               [Address Unit], 
               [Zip Code First 5 Digits], 
               [Zip Code Suffix Last 4 Digits], 
               [Attention], 
               [Floor Number], 
               [Delivery Mode Desc], 
               [Delivery Mode Value], 
               [Site], 
               [Compartment], 
               [Delivery Installation Type Code], 
               [Delivery Installation Type Value], 
               [Address Line 4], 
               [Address Line 5], 
               [Street Prefix]
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_BK] = [FACT].[dimFolio_BK]
        AND [FO].[Folio Status Code] = '01'
     
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BR_FA]
     ON [BR_FA].[dimFolio_BK] = [FO].[dimFolio_BK]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_BK] = [BR_FA].[dimName_BK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_BK] = [BR_FA].[dimAddress_BK]
     INNER JOIN [edw].[dimCountry] AS [CN]
     ON [CN].[dimCountry_BK] = [OAD].[dimCountry_BK]
WHERE [FACT].[Roll Year] = @p_RY
      AND [AG].[Neighbourhood Code] IN(@p_NH);