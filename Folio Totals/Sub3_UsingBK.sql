DECLARE @p_RY [INT];
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '234022';
SELECT TOP 500 [FACT].[Roll Year], 
               [AG].[Area Code], 
               [AG].[Area] AS [Area Name], 
               [AG].[Jurisdiction Code] AS [Jur Code], 
               [AG].[Jurisdiction] AS [Jur Name], 
			    --[PC].[Property Class Code], 
			   [ED].[BCA Code],
               [AG].[Neighbourhood Code] AS [Neigh Code], 
               [AG].[Neighbourhood Desc] AS [Neigh Name], 
               [FO].[School  District Code], 
               [FO].[Roll Number], 
               ISNULL([PL].[PID], '') AS [PID], 
               ISNULL([Lot], '') AS [Lot], 
               ISNULL([Section], '') AS [Section], 
               ISNULL([Block Number], '') AS [Block Number], 
               ISNULL([Range], '') AS [Range], 
               ISNULL([Plan Number], '') AS [Plan Number], 
               ISNULL([Township Code], '') AS [Township Code], 
               ISNULL([Subdivision], '') AS [Subdivision], 
               ISNULL([PL].[Legal Text], '') AS [Legal Description], 
               [FO].[dimFolio_BK], 
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
               [ONA].[Middle Name] AS [Owner MName], 
               [ONA].[Last Name] AS [Owner LName], 
               IIF([BR_FA].[Care Of] IS NOT NULL, 'C/O '+[BR_FA].[Care Of], NULL) AS [Care Of], 
               IIF([OAD].[Attention] IS NOT NULL, 'ATTN '+[OAD].[Attention], NULL) AS [Attention], 
               [OAD].[dimAddress_BK], 
               [OAD].[Address Type Code], 
               ISNULL([OAD].[Address Unit], '') AS [Address Unit], 
               ISNULL([OAD].[Street Number], '') AS [Street Number], 
               ISNULL([OAD].[Address Street Name], '') AS [Address Street Name], 
               [OAD].[City Desc], 
               [OAD].[Province Desc], 
               [OAD].[Postal/Zip Code], 
               [CN].[Country Desc] AS [Country], 
               [OAD].[Country Code], 
               [OAD].[Address Line 1] AS [Owner Address 1], 
               [OAD].[Address Line 2] AS [Owner Address 2], 
               [OAD].[Address Line 3] AS [Owner Address 3], 
               [OAD].[Address Line 4] AS [Owner Address 4], 
               [OAD].[Address Line 5] AS [Owner Address 5], 
               '???' AS [Extended-Legal],
			   0 AS [COUNT-OWNER],	
			   0 AS [COUNT-MULTIPART],	
			   0 AS [COUNT-LESSEE],	
			   0 AS [COUNT-OCCUPIER],	
			   0 AS [COUNT-REG-CHARGE],	
			   0 AS [COUNT-FORFEITURE]

FROM [edw].[FactRollSummary] AS [FACT]
INNER JOIN [edw].[FactTotalAllAmounts] AS [FACT2] ON [FACT2].dimFolio_SK = [FACT].dimFolio_SK
--FROM [edw].[FactTotalAllAmounts] AS [FACT]
--FROM [edw].[FactAllAssessedAmounts] AS [FACT]
--FROM [edw].[FactAssessedValue] AS [FACT]


INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FACT2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_BK] = [FACT].[dimFolio_BK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimManualClass] AS [MC] ON [MC].[dimManualClass_BK] = [FACT].[dimManualClass_BK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].[dimRegionalDistrict_BK] = [FO].[dimRegionalDistrict_BK]
     INNER JOIN [edw].[bridgeParcelFolio] AS [BR_PF] ON [BR_PF].[dimFolio_BK] = [FO].[dimFolio_BK]
     INNER JOIN [edw].[dimParcel] AS [PL] ON [PL].[dimParcel_BK] = [BR_PF].[dimParcel_BK]
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BR_FA] ON [BR_FA].[dimFolio_BK] = [FO].[dimFolio_BK]
     INNER JOIN [edw].[dimName] AS [ONA] ON [ONA].[dimName_BK] = [BR_FA].[dimName_BK]
     INNER JOIN [edw].[dimAddress] AS [OAD] ON [OAD].[dimAddress_BK] = [BR_FA].[dimAddress_BK]
     INNER JOIN [edw].[dimCountry] AS [CN] ON [CN].[dimCountry_BK] = [OAD].[dimCountry_BK]
	 LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
     LEFT OUTER JOIN [edw].[dimFolioCharacteristicTbl] AS [FC] ON [FC].[dimFolioCharacteristic_BK] = [FO].[Characteristic1_dimFolioCharacteristic_BK]
WHERE [FACT].[Roll Year] = @p_RY
AND [FACT2].[Roll Year] = @p_RY
      AND [AG].[Neighbourhood Code] IN(@p_NH)
      --AND [ONA].[Company Name] like '%CROWN FEDERAL%'
      --AND [Roll Number] = '02101015'
      --AND [CN].[Country Desc] = 'HONG KONG'
      --AND [BR_FA].[Care Of] like '%PILT%'
      --AND [OAD].dimAddress_SK in (3196101)
      --AND  [OAD].dimAddress_SK in (732382,1816349,2132057)
      --AND [OAD].[Address Line 1] is not null
      --AND [OAD].[Address Line 1] LIKE '% DIV STR%'
      --AND [AG].[Jurisdiction Code] = '234'
ORDER BY [FACT].[Roll Year], 
         [AG].[Area Code], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction], 
         [AG].[Neighbourhood Code], 
         [AG].[Neighbourhood Desc], 
         [FO].[School  District Code], 
         [FO].[Roll Number];