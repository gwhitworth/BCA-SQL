DECLARE @p_RY [INT];
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '361141';
SELECT DISTINCT TOP 300 [FACT].[dimFolio_SK], 
                        [FACT].[dimRollYear_SK], 
                        [AG].[Area Code], 
                        [AG].[Area Desc], 
                        [AG].[Jurisdiction Code] AS [Jur Code], 
                        [AG].[Jurisdiction Desc] AS [Jur Name], 
                        [FO].[Roll Number], 
                        SUBSTRING([FO].[Roll Number], 1, 6)+'.'+SUBSTRING([FO].[Roll Number], 6, 3) AS [Roll Number Formatted], 
                        [AG].[Neighbourhood Code] AS [Neigh Code], 
                        [AG].[Neighbourhood] AS [Neigh Name], 
                        [RD].[Regional District Code] AS [RD Code], 
                        [RD].[Regional District] AS [RD Name], 
                        [SD].[School District Code], 
                        [SD].[School District Desc] AS [School District Description], 
                        [HD].[Region Hospital District Code] AS [Regional Hospital District Code], 
                        [HD].[Region Hospital District] AS [Regional Hospital District Description], 
                        [ED].[Electoral District Code] AS [Electoral Area Code], 
                        [ED].[Electoral District Desc] AS [Electoral Area Description], 
                        [FMT].[SM - Specified Municipal BCA Codes] AS [Specified Municipal Code], 
                        [FMT].[ID - Improvement District BCA Codes] AS [Improvement District Code], 
                        [FMT].[SA - Service Area BCA Codes] AS [Service Area Code], 
                        [FMT].[GS - General Service BCA Codes] AS [General Service Area Code], 
                        [FMT].[IT - Islands Trust BCA Codes] AS [Island Trust Code], 
                        [FMT].[LA - Local Area BCA Codes] AS [Local Area Code], 
                        [PL].[FN Reserve Code] AS [Indian Band (Reserve Number)], 
                        '' AS [Indian Band (Reserve Description)], 
                        [BR_FA].[Equity Type Code] AS [Equity Code], 
                        [OWNCNT].[CNT] AS [Owner Count], 
                        [BR_FA].[Owner Sequence] AS [Owner Seq #], 
                        [ONA].[First Name] AS [Owner First Name], 
                        [ONA].[Middle Name] AS [Owner Middle Initial], 
                        [ONA].[Last Name] AS [Owner Last Name], 
                        [ONA].[Company Name] AS [Owner Company Name], 
                        [PT].[Party Type Code]+' - '+[Party Type Desc] AS [Party Type], 
                        [BR_FA].[Bulk Code] AS [Bulkmail Code], 
                        ([dbo].[FNC_FORMAT_ADDRESS]([OAD].[dimCity_BK], [OAD].[dimCountry_BK], NULL, [OAD].[dimStreetDirection_BK], [OAD].[Postal/Zip Code], [OAD].[dimProvince_BK], [OAD].[Address Street Name], [OAD].[Street Number], [OAD].[dimStreetType_BK], [OAD].[Address Unit], [OAD].[Floor Number], NULL, [OAD].[Attention], [OAD].[Site], [OAD].[Compartment], [OAD].[Delivery Mode Desc], [OAD].[Delivery Mode Value], '', '', 50, 1)) AS [Mailing Address Line 1], 
                        ([dbo].[FNC_FORMAT_ADDRESS]([OAD].[dimCity_BK], [OAD].[dimCountry_BK], NULL, [OAD].[dimStreetDirection_BK], [OAD].[Postal/Zip Code], [OAD].[dimProvince_BK], [OAD].[Address Street Name], [OAD].[Street Number], [OAD].[dimStreetType_BK], [OAD].[Address Unit], [OAD].[Floor Number], NULL, [OAD].[Attention], [OAD].[Site], [OAD].[Compartment], [OAD].[Delivery Mode Desc], [OAD].[Delivery Mode Value], '', '', 50, 2)) AS [Mailing Address Line 2], 
                        ([dbo].[FNC_FORMAT_ADDRESS]([OAD].[dimCity_BK], [OAD].[dimCountry_BK], NULL, [OAD].[dimStreetDirection_BK], [OAD].[Postal/Zip Code], [OAD].[dimProvince_BK], [OAD].[Address Street Name], [OAD].[Street Number], [OAD].[dimStreetType_BK], [OAD].[Address Unit], [OAD].[Floor Number], NULL, [OAD].[Attention], [OAD].[Site], [OAD].[Compartment], [OAD].[Delivery Mode Desc], [OAD].[Delivery Mode Value], '', '', 50, 3)) AS [Mailing Address Line 3], 
                        ([dbo].[FNC_FORMAT_ADDRESS]([OAD].[dimCity_BK], [OAD].[dimCountry_BK], NULL, [OAD].[dimStreetDirection_BK], [OAD].[Postal/Zip Code], [OAD].[dimProvince_BK], [OAD].[Address Street Name], [OAD].[Street Number], [OAD].[dimStreetType_BK], [OAD].[Address Unit], [OAD].[Floor Number], NULL, [OAD].[Attention], [OAD].[Site], [OAD].[Compartment], [OAD].[Delivery Mode Desc], [OAD].[Delivery Mode Value], '', '', 50, 4)) AS [Mailing Address Line 4], 
                        ([dbo].[FNC_FORMAT_ADDRESS]([OAD].[dimCity_BK], [OAD].[dimCountry_BK], NULL, [OAD].[dimStreetDirection_BK], [OAD].[Postal/Zip Code], [OAD].[dimProvince_BK], [OAD].[Address Street Name], [OAD].[Street Number], [OAD].[dimStreetType_BK], [OAD].[Address Unit], [OAD].[Floor Number], NULL, [OAD].[Attention], [OAD].[Site], [OAD].[Compartment], [OAD].[Delivery Mode Desc], [OAD].[Delivery Mode Value], '', '', 50, 5)) AS [Mailing Address Line 5], 
                        NULL AS [Mailing Address Line 6], 
                        [FMT].[DE - Defined BCA Codes] AS [Defined Code], 
                        [AG].[Region Code] AS [Specified Regional Code], 
                        [FO].[SITUS Building/Unit Number] AS [Situs Unit No], 
                        [FO].[SITUS Address Number Prefix], 
                        [FO].[SITUS Street Number], 
                        [FO].[SITUS Address Street Name], 
                        [FO].[SITUS Street Suffix], 
                        [FO].[SITUS Address Location Line 2], 
                        [FO].[SITUS City] AS [Situs City], 
                        [FO].[SITUS Province] AS [Situs Province], 
                        [FO].[SITUS Postal Code] AS [Situs Postal Code], 
                        ([dbo].[FNC_APPEND_DATA]([FO].[SITUS Building/Unit Number], ' ')+[dbo].[FNC_APPEND_DATA]([FO].[SITUS Street Number], ' ')+[dbo].[FNC_APPEND_DATA]([FO].[SITUS Address Street Name], ' ')+[dbo].[FNC_APPEND_DATA]([FO].[SITUS Street Type], ' ')+[dbo].[FNC_APPEND_DATA]([FO].[SITUS Street Direction], ' ')) AS [Situs Freeform Address], 
                        ISNULL([PL].[Legal Text], '') AS [Legal Description], 
                        [PID Cnt], 
                        ISNULL([PL].[PID Display], '') AS [First PID], 
                        '' AS [Additional PID], 
                        '??' AS [Supp Occupancy Date], 
                        '??' AS [Supp Occupancy Code], 
                        '' AS [Land Dimension Type], 
                        '' AS [Land Dimension Description], 
                        '' AS [Land Dimension], 
                        '' AS [Land Width], 
                        '' AS [Land Depth], 
                        [PL].[Land Branch File] AS [Lands Branch File Number], 
                        '??' AS [Dimensions], 
                        '??' AS [Document Number (LTSA Title No)], 
                        [Land PC 01], 
                        [Land Psc 0102], 
                        [Land Psc 0103], 
                        [Land Psc 0104], 
                        [Land Psc 0105], 
                        [Land Psc 0106], 
                        [Land PC 02], 
                        [Land Psc 0201], 
                        [Land Psc 0202], 
                        [Land PC 03], 
                        [Land PC 04], 
                        [Land PC 05], 
                        [Land PC 06], 
                        [Land PC 07], 
                        [Land PC 08], 
                        [Land PC 09], 
                        [Impr PC 01], 
                        [Impr Psc 0102], 
                        [Impr Psc 0103], 
                        [Impr Psc 0104], 
                        [Impr Psc 0105], 
                        [Impr Psc 0106], 
                        [Impr PC 02], 
                        [Impr Psc 0201], 
                        [Impr Psc 0202], 
                        [Impr PC 03], 
                        [Impr PC 04], 
                        [Impr PC 05], 
                        [Impr PC 06], 
                        [Impr PC 07], 
                        [Impr PC 08], 
                        [Impr PC 09], 
                        [TN].[Tenure Desc] AS [Tenure Code Description], 
                        [FO].[BC Transit Flag], 
                        [ALR].[Agricultural Land Reserve Code]+' - '+[ALR].[Agricultural Land Reserve] AS [ALR Code], 
                        [MC].[Manual Class Code]+' - '+[MC].[Manual Class] AS [Manual Class Code], 
                        [AU].[Actual Use Code]+' - '+[AU].[Actual Use Desc] AS [Actual Use Code], 
                        '' AS [Exempt Tax Code Land], 
                        '' AS [Exempt Tax Code Improvement], 
                        '' AS [Additional School Tax Flag], 
                        '' AS [Additional School Tax Value], 
                        CAST([FRS].[Previous Year1 Total Actual Value] AS NUMERIC(38, 0)) AS [Previous Roll Value], 
                        CAST([FRS].[Total Land Value] AS NUMERIC(38, 0)) AS [Assessed Land Value], 
                        CAST([FRS].[Total Building Value] AS NUMERIC(38, 0)) AS [Assessed Improvement Value], 
                        CAST(([FRS].[Net General Value] + [FRS].[Net Other Value] + [FRS].[Net School Value]) AS NUMERIC(38, 0)) AS [Assessed Net Value], 
                        CAST(([FRS].[General Exemptions Value] + [FRS].[Other Exemptions Value] + [FRS].[School Exemptions Value]) AS NUMERIC(38, 0)) AS [Assessed Exempt Value], 
                        CAST([FRS].[Total Assessed Value] AS NUMERIC(38, 0)) AS [Assessed Total Value], 
                        [Actual Land Value], 
                        [Actual Building Value], 
                        [General Gross Land], 
                        [General Gross Improvement], 
                        [General Gross Total], 
                        [School Gross Land], 
                        [School Gross Improvement], 
                        [School Gross Total], 
                        [Hospital Gross Land], 
                        [Hospital Gross Improvement], 
                        [Hospital Gross Total], 
                        [General Exempt Land], 
                        [General Exempt Improvement], 
                        [General Exempt Total], 
                        [School Exempt Land], 
                        [School Exempt Improvement], 
                        [School Exempt Total], 
                        [General Net Land], 
                        [General Net Improvement], 
                        [General Net Total], 
                        [School Net Land], 
                        [School Net Improvement], 
                        [School Net Total], 
                        [Hospital Exempt Land], 
                        [Hospital Exempt Improvement], 
                        [Hospital Exempt Total], 
                        [Hospital Net Land], 
                        [Hospital Net Improvement], 
                        [Hospital Net Total]
FROM
(
    SELECT [dimFolio_SK], 
           [dimRollYear_SK], 
           SUM([Actual Land Value]) AS [Actual Land Value], 
           SUM([Actual Building Value]) AS [Actual Building Value], 
           SUM([Gross General Land Value]) AS [General Gross Land], 
           SUM([Gross General Building Value]) AS [General Gross Improvement], 
           SUM([Gross General Land Value]) + SUM([Gross General Building Value]) AS [General Gross Total], 
           SUM([Gross School Land Value]) AS [School Gross Land], 
           SUM([Gross School Building Value]) AS [School Gross Improvement], 
           SUM([Gross School Land Value]) + SUM([Gross School Building Value]) AS [School Gross Total], 
           SUM([Gross Other Land Value]) AS [Hospital Gross Land], 
           SUM([Gross Other Building Value]) AS [Hospital Gross Improvement], 
           SUM([Gross Other Land Value]) + SUM([Gross Other Building Value]) AS [Hospital Gross Total], 
           SUM([General Exemptions Land Value]) AS [General Exempt Land], 
           SUM([General Exemptions Building Value]) AS [General Exempt Improvement], 
           SUM([General Exemptions Land Value]) + SUM([General Exemptions Building Value]) AS [General Exempt Total], 
           SUM([School Exemptions Land Value]) AS [School Exempt Land], 
           SUM([School Exemptions Building Value]) AS [School Exempt Improvement], 
           SUM([School Exemptions Land Value]) + SUM([School Exemptions Building Value]) AS [School Exempt Total], 
           SUM([Net General Land Value]) AS [General Net Land], 
           SUM([Net General Building Value]) AS [General Net Improvement], 
           SUM([Net General Land Value]) + SUM([Net General Building Value]) AS [General Net Total], 
           SUM([Net School Land Value]) AS [School Net Land], 
           SUM([Net School Building Value]) AS [School Net Improvement], 
           SUM([Net School Land Value]) + SUM([Net School Building Value]) AS [School Net Total], 
           SUM([Other Exemptions Land Value]) AS [Hospital Exempt Land], 
           SUM([Other Exemptions Building Value]) AS [Hospital Exempt Improvement], 
           SUM([Other Exemptions Land Value]) AS [Hospital Exempt Total], 
           SUM([Net Other Land Value]) AS [Hospital Net Land], 
           SUM([Net Other Building Value]) AS [Hospital Net Improvement], 
           SUM([Net Other Land Value]) + SUM([Net Other Building Value]) AS [Hospital Net Total]
    FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass]
    GROUP BY [dimFolio_SK], 
             [dimRollYear_SK]
) AS [FACT]
INNER JOIN [edw].[FactAssessedValue] AS [FAV]
ON [FAV].[dimFolio_SK] = [FACT].[dimFolio_SK]
INNER JOIN [edw].[dimActualUse] [AU]
ON [FAV].[dimActualUse_SK] = [AU].[dimActualUse_SK]
INNER JOIN [edw].[FactRollSummary] AS [FRS]
ON [FRS].[dimFolio_SK] = [FACT].[dimFolio_SK]
INNER JOIN [edw].[FactActualValue] AS [FVL]
ON [FVL].[dimFolio_SK] = [FACT].[dimFolio_SK]
INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC]
ON [FACT].[dimFolio_SK] = [BTC].[dimFolio_SK]
INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
----INNER JOIN [edw].[dimPropertyClass] AS [PC]
----ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
AND AG.[Roll Category Code] = '1'
INNER JOIN [edw].[dimFolio] AS [FO]
ON [FO].[dimFolio_SK] = [FACT].[dimFolio_SK]
   AND [FO].[Folio Status Code] = '01'
INNER JOIN [edw].[dimAgriculturalLandReserve] AS [ALR]
ON [FO].[dimAgriculturalLandReserve_SK] = [ALR].[dimAgriculturalLandReserve_SK]
INNER JOIN [edw].[dimManualClass] AS [MC]
ON [MC].[dimManualClass_SK] = [FAV].[dimManualClass_SK]
INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
INNER JOIN [edw].[bridgeParcelFolio] AS [BR_PF]
ON [BR_PF].[dimFolio_SK] = [FO].[dimFolio_SK]
INNER JOIN [edw].[dimParcel] AS [PL]
ON [PL].[dimParcel_SK] = [BR_PF].[dimParcel_SK]
INNER JOIN [edw].[dimTenure] AS [TN]
ON [PL].[dimTenure_SK] = [TN].[dimTenure_SK]
INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BR_FA]
ON [BR_FA].[dimFolio_SK] = [FO].[dimFolio_SK]
INNER JOIN [edw].[dimName] AS [ONA]
ON [ONA].[dimName_SK] = [BR_FA].[dimName_SK]
INNER JOIN [edw].[dimAddress] AS [OAD]
ON [OAD].[dimAddress_SK] = [BR_FA].[dimAddress_SK]
INNER JOIN [edw].[dimSchoolDistrict] AS [SD]
ON [SD].[dimSchoolDistrict_SK] = [FO].[dimSchoolDistrict_SK]
INNER JOIN [edw].[dimRegionalHospitalDistrict] AS [HD]
ON [HD].[dimRegionalHospitalDistrict_SK] = [FO].[dimRegionalHospitalDistrict_SK]
INNER JOIN [edw].[dimElectoralDistrict] AS [ED]
ON [ED].[dimElectoralDistrict_SK] = [FO].[dimElectoralDistrict_SK]
INNER JOIN
(
    SELECT [FO].[dimFolio_SK], 
           COUNT(*) AS [CNT]
    FROM [EDW].[edw].[bridgeOwnerFolioAddress] AS [OFA]
         INNER JOIN [edw].[dimName] AS [ONA]
         ON [ONA].[dimName_SK] = [OFA].[dimName_SK]
         INNER JOIN [edw].[dimAddress] AS [OAD]
         ON [OAD].[dimAddress_SK] = [OFA].[dimAddress_SK]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [OFA].[dimFolio_SK]
            AND [FO].[Folio Status Code] = '01'
    WHERE [OFA].[Roll Year] = @p_RY
    GROUP BY [FO].[dimFolio_SK]
) AS [OWNCNT]
ON [OWNCNT].[dimFolio_SK] = [FO].[dimFolio_SK]
INNER JOIN [edw].[dimBCACodesDelimitedByCategory] AS [FMT]
ON [FMT].[dimFolio_SK] = [FO].[dimFolio_SK]
INNER JOIN [edw].[dimPartyType] AS [PT]
ON [BR_FA].[Party Type Code] = [PT].[Party Type Code]
INNER JOIN
(
    SELECT [BPF].[dimFolio_SK], 
           COUNT(*) AS [PID Cnt]
    FROM [EDW].[edw].[dimParcel] AS [P]
         INNER JOIN [edw].[bridgeParcelFolio] AS [BPF]
         ON [P].[dimParcel_SK] = [BPF].[dimParcel_SK]
    GROUP BY [BPF].[dimFolio_SK]
) AS [PCnt]
ON [PCnt].[dimFolio_SK] = [FACT].[dimFolio_SK]
--INNER JOIN [dbo].[NAME_ADDRESS_LINES] AS [NAL]
--ON [FACT].[dimFolio_SK] = [NAL].[dimFolio_SK]
INNER JOIN
(
    SELECT *
    FROM
    (
        SELECT DISTINCT 
               [dimFolio_SK], 
               (CASE [Assessment Code]
                    WHEN '01'
                    THEN 'Land PC '+[PC].[Property Class Code]
                    ELSE 'Impr PC '+[PC].[Property Class Code]
                END) AS [CODE], 
               [PC].[Property Class Code]+' - '+[PC].[Property Class Desc] AS [DESC]
        FROM [edw].[FactAssessedValue] AS [FACT]
             INNER JOIN [edw].[dimPropertyClass] AS [PC]
             ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
        UNION
        SELECT DISTINCT 
               [dimFolio_SK], 
               (CASE [Assessment Code]
                    WHEN '01'
                    THEN 'Land Psc '+[PC].[Property Sub Class Code]
                    ELSE 'Impr Psc '+[PC].[Property Sub Class Code]
                END) AS [CODE], 
               [PC].[Property Sub Class Code]+' - '+[PC].[Property Sub Class Desc] AS [DESC]
        FROM [edw].[FactAssessedValue] AS [FACT]
             INNER JOIN [edw].[dimPropertyClass] AS [PC]
             ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    ) [DataTable] PIVOT(MAX([DESC]) FOR [CODE] IN([Land PC 01], 
                                                  [Land Psc 0102], 
                                                  [Land Psc 0103], 
                                                  [Land Psc 0104], 
                                                  [Land Psc 0105], 
                                                  [Land Psc 0106], 
                                                  [Land PC 02], 
                                                  [Land Psc 0201], 
                                                  [Land Psc 0202], 
                                                  [Land PC 03], 
                                                  [Land PC 04], 
                                                  [Land PC 05], 
                                                  [Land PC 06], 
                                                  [Land PC 07], 
                                                  [Land PC 08], 
                                                  [Land PC 09], 
                                                  [Impr PC 01], 
                                                  [Impr Psc 0102], 
                                                  [Impr Psc 0103], 
                                                  [Impr Psc 0104], 
                                                  [Impr Psc 0105], 
                                                  [Impr Psc 0106], 
                                                  [Impr PC 02], 
                                                  [Impr Psc 0201], 
                                                  [Impr Psc 0202], 
                                                  [Impr PC 03], 
                                                  [Impr PC 04], 
                                                  [Impr PC 05], 
                                                  [Impr PC 06], 
                                                  [Impr PC 07], 
                                                  [Impr PC 08], 
                                                  [Impr PC 09])) AS [PIVOT_TMP]
) AS [PIVOTPC]
ON [PIVOTPC].[dimFolio_SK] = [FACT].[dimFolio_SK]
WHERE [FACT].[dimRollYear_SK] = @p_RY
      AND [AG].[Neighbourhood Code] = @p_NH
ORDER BY [FACT].[dimRollYear_SK], 
         [AG].[Area Code], 
         [AG].[Area Desc], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [FO].[Roll Number];
--, 
--      [BR_FA].[Owner Sequence];