--SELECT TOP 20 [ADD].[dimAddress_SK], 
--              ISNULL([ADD].[dimCity_BK], ''), 
--              ISNULL([ADD].[dimCountry_BK], ''), 
--              ISNULL([ADD].[Full Address], ''), 
--              ISNULL([ADD].[dimStreetDirection_BK], ''), 
--              ISNULL([ADD].[Postal/Zip Code], ''), 
--              ISNULL([ADD].[dimProvince_BK], ''), 
--              ISNULL([ADD].[Address Street Name], ''), 
--              ISNULL([ADD].[Street Number], ''), 
--              ISNULL([ADD].dimStreetType_BK, ''), 
--              ISNULL([ADD].[Address Unit], ''), 
--              ISNULL([ADD].[Floor Number], ''), 
--              ISNULL([BAD].[Care Of], ''), 
--              ISNULL([ADD].[Attention], ''), 
--              ISNULL([ADD].[Site], ''), 
--              ISNULL([ADD].[Compartment], ''), 
--              ISNULL([ADD].[Delivery Mode Desc], ''), 
--              ISNULL([ADD].[Delivery Mode Value], '')
--FROM [edw].[FactRollSummary] AS [FACT]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--     INNER JOIN [edw].[dimProperty] AS [PR] ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
--     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BAD] ON [BAD].[dimProperty_SK] = [PR].[dimProperty_SK]
--     INNER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [BSD] ON [BSD].[dimJurisdiction_SK] = [PR].[dimJurisdiction_SK]
--     INNER JOIN [edw].[dimPropertyDetails] AS [PD] ON [PD].[dimProperty_SK] = [PR].[dimProperty_SK]
--     INNER JOIN [edw].[dimCountry] AS [CTR] ON [CTR].[dimCountry_BK] = [PR].[SITUS_dimCountry_BK]
--     INNER JOIN [edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BAD].[dimAddress_SK]
--WHERE [FACT].[dimRollYear_SK] = 2018;


SELECT top 1 [ADD].*
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimProperty] AS [PR] ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BAD] ON [BAD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [BSD] ON [BSD].[dimJurisdiction_SK] = [PR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimPropertyDetails] AS [PD] ON [PD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[dimCountry] AS [CTR] ON [CTR].[dimCountry_BK] = [PR].[SITUS_dimCountry_BK]
     INNER JOIN [edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BAD].[dimAddress_SK]
WHERE [ADD].[dimAddress_SK] = 129261;

SELECT TOP 1 [dbo].[FN_GetAllAddressLines](ISNULL([ADD].[dimCity_BK], ''), ISNULL([ADD].[dimCountry_BK], ''), NULL, ISNULL([ADD].[dimStreetDirection_BK], ''), ISNULL([ADD].[Postal/Zip Code], ''), ISNULL([ADD].[dimProvince_BK], ''), ISNULL([ADD].[Address Street Name], ''), ISNULL([ADD].[Street Number], ''), ISNULL([ADD].dimStreetType_BK, ''), ISNULL([ADD].[Address Unit], ''), [ADD].[Floor Number], [BAD].[Care Of], [ADD].[Attention], ISNULL([ADD].[Site], ''), ISNULL([ADD].[Compartment], ''), ISNULL([ADD].[Delivery Mode Desc], ''), ISNULL([ADD].[Delivery Mode Value], ''), '', '') AS [Mail Address]
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimProperty] AS [PR] ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BAD] ON [BAD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [BSD] ON [BSD].[dimJurisdiction_SK] = [PR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimPropertyDetails] AS [PD] ON [PD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[dimCountry] AS [CTR] ON [CTR].[dimCountry_BK] = [PR].[SITUS_dimCountry_BK]
     INNER JOIN [edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BAD].[dimAddress_SK]
WHERE [ADD].[dimAddress_SK] = 129261;