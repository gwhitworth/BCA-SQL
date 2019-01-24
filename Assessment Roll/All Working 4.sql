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
                        [Gen Gross Land PC 01], 
                        [Gen Gross Impr PC 01], 
                        [Gen Gross Total PC 01], 
                        [Sch Gross Land PC 01], 
                        [Sch Gross Impr PC 01], 
                        [Sch Gross Total PC 01], 
                        [Hsptl Gross Land PC 01], 
                        [Hsptl Gross Impr PC 01], 
                        [Hsptl Gross Total PC 01], 
                        [Gen Exmpt Land PC 01], 
                        [Gen Exmpt Impr PC 01], 
                        [Gen Exmpt Total PC 01], 
                        [Sch Exmpt Land PC 01], 
                        [Sch Exmpt Impr PC 01], 
                        [Sch Exmpt Total PC 01], 
                        [Hsptl Exmpt Land PC 01], 
                        [Hsptl Exmpt Impr PC 01], 
                        [Hsptl Exmpt Total PC 01], 
                        [Gen Net Land PC 01], 
                        [Gen Net Impr PC 01], 
                        [Gen Net Total PC 01], 
                        [Sch Net Land PC 01], 
                        [Sch Net Impr PC 01], 
                        [Sch Net Total PC 01], 
                        [Hsptl Net Land PC 01], 
                        [Hsptl Net Impr PC 01], 
                        [Hsptl Net Total PC 01], 
                        [Gen Gross Land Psc 0101], 
                        [Gen Gross Impr Psc 0101], 
                        [Gen Gross Total Psc 0101], 
                        [Sch Gross Land Psc 0101], 
                        [Sch Gross Impr Psc 0101], 
                        [Sch Gross Total Psc 0101], 
                        [Hsptl Gross Land Psc 0101], 
                        [Hsptl Gross Impr Psc 0101], 
                        [Hsptl Gross Total Psc 0101], 
                        [Gen Exmpt Land Psc 0101], 
                        [Gen Exmpt Impr Psc 0101], 
                        [Gen Exmpt Total Psc 0101], 
                        [Sch Exmpt Land Psc 0101], 
                        [Sch Exmpt Impr Psc 0101], 
                        [Sch Exmpt Total Psc 0101], 
                        [Hsptl Exmpt Land Psc 0101], 
                        [Hsptl Exmpt Impr Psc 0101], 
                        [Hsptl Exmpt Total Psc 0101], 
                        [Gen Net Land Psc 0101], 
                        [Gen Net Impr Psc 0101], 
                        [Gen Net Total Psc 0101], 
                        [Sch Net Land Psc 0101], 
                        [Sch Net Impr Psc 0101], 
                        [Sch Net Total Psc 0101], 
                        [Hsptl Net Land Psc 0101], 
                        [Hsptl Net Impr Psc 0101], 
                        [Hsptl Net Total Psc 0101], 
                        [Gen Gross Land Psc 0102], 
                        [Gen Gross Impr Psc 0102], 
                        [Gen Gross Total Psc 0102], 
                        [Sch Gross Land Psc 0102], 
                        [Sch Gross Impr Psc 0102], 
                        [Sch Gross Total Psc 0102], 
                        [Hsptl Gross Land Psc 0102], 
                        [Hsptl Gross Impr Psc 0102], 
                        [Hsptl Gross Total Psc 0102], 
                        [Gen Exmpt Land Psc 0102], 
                        [Gen Exmpt Impr Psc 0102], 
                        [Gen Exmpt Total Psc 0102], 
                        [Sch Exmpt Land Psc 0102], 
                        [Sch Exmpt Impr Psc 0102], 
                        [Sch Exmpt Total Psc 0102], 
                        [Hsptl Exmpt Land Psc 0102], 
                        [Hsptl Exmpt Impr Psc 0102], 
                        [Hsptl Exmpt Total Psc 0102], 
                        [Gen Net Land Psc 0102], 
                        [Gen Net Impr Psc 0102], 
                        [Gen Net Total Psc 0102], 
                        [Sch Net Land Psc 0102], 
                        [Sch Net Impr Psc 0102], 
                        [Sch Net Total Psc 0102], 
                        [Hsptl Net Land Psc 0102], 
                        [Hsptl Net Impr Psc 0102], 
                        [Hsptl Net Total Psc 0102], 
                        [Gen Gross Land Psc 0103], 
                        [Gen Gross Impr Psc 0103], 
                        [Gen Gross Total Psc 0103], 
                        [Sch Gross Land Psc 0103], 
                        [Sch Gross Impr Psc 0103], 
                        [Sch Gross Total Psc 0103], 
                        [Hsptl Gross Land Psc 0103], 
                        [Hsptl Gross Impr Psc 0103], 
                        [Hsptl Gross Total Psc 0103], 
                        [Gen Exmpt Land Psc 0103], 
                        [Gen Exmpt Impr Psc 0103], 
                        [Gen Exmpt Total Psc 0103], 
                        [Sch Exmpt Land Psc 0103], 
                        [Sch Exmpt Impr Psc 0103], 
                        [Sch Exmpt Total Psc 0103], 
                        [Hsptl Exmpt Land Psc 0103], 
                        [Hsptl Exmpt Impr Psc 0103], 
                        [Hsptl Exmpt Total Psc 0103], 
                        [Gen Net Land Psc 0103], 
                        [Gen Net Impr Psc 0103], 
                        [Gen Net Total Psc 0103], 
                        [Sch Net Land Psc 0103], 
                        [Sch Net Impr Psc 0103], 
                        [Sch Net Total Psc 0103], 
                        [Hsptl Net Land Psc 0103], 
                        [Hsptl Net Impr Psc 0103], 
                        [Hsptl Net Total Psc 0103], 
                        [Gen Gross Land Psc 0104], 
                        [Gen Gross Impr Psc 0104], 
                        [Gen Gross Total Psc 0104], 
                        [Sch Gross Land Psc 0104], 
                        [Sch Gross Impr Psc 0104], 
                        [Sch Gross Total Psc 0104], 
                        [Hsptl Gross Land Psc 0104], 
                        [Hsptl Gross Impr Psc 0104], 
                        [Hsptl Gross Total Psc 0104], 
                        [Gen Exmpt Land Psc 0104], 
                        [Gen Exmpt Impr Psc 0104], 
                        [Gen Exmpt Total Psc 0104], 
                        [Sch Exmpt Land Psc 0104], 
                        [Sch Exmpt Impr Psc 0104], 
                        [Sch Exmpt Total Psc 0104], 
                        [Hsptl Exmpt Land Psc 0104], 
                        [Hsptl Exmpt Impr Psc 0104], 
                        [Hsptl Exmpt Total Psc 0104], 
                        [Gen Net Land Psc 0104], 
                        [Gen Net Impr Psc 0104], 
                        [Gen Net Total Psc 0104], 
                        [Sch Net Land Psc 0104], 
                        [Sch Net Impr Psc 0104], 
                        [Sch Net Total Psc 0104], 
                        [Hsptl Net Land Psc 0104], 
                        [Hsptl Net Impr Psc 0104], 
                        [Hsptl Net Total Psc 0104], 
                        [Gen Gross Land Psc 0105], 
                        [Gen Gross Impr Psc 0105], 
                        [Gen Gross Total Psc 0105], 
                        [Sch Gross Land Psc 0105], 
                        [Sch Gross Impr Psc 0105], 
                        [Sch Gross Total Psc 0105], 
                        [Hsptl Gross Land Psc 0105], 
                        [Hsptl Gross Impr Psc 0105], 
                        [Hsptl Gross Total Psc 0105], 
                        [Gen Exmpt Land Psc 0105], 
                        [Gen Exmpt Impr Psc 0105], 
                        [Gen Exmpt Total Psc 0105], 
                        [Sch Exmpt Land Psc 0105], 
                        [Sch Exmpt Impr Psc 0105], 
                        [Sch Exmpt Total Psc 0105], 
                        [Hsptl Exmpt Land Psc 0105], 
                        [Hsptl Exmpt Impr Psc 0105], 
                        [Hsptl Exmpt Total Psc 0105], 
                        [Gen Net Land Psc 0105], 
                        [Gen Net Impr Psc 0105], 
                        [Gen Net Total Psc 0105], 
                        [Sch Net Land Psc 0105], 
                        [Sch Net Impr Psc 0105], 
                        [Sch Net Total Psc 0105], 
                        [Hsptl Net Land Psc 0105], 
                        [Hsptl Net Impr Psc 0105], 
                        [Hsptl Net Total Psc 0105], 
                        [Gen Gross Land Psc 0106], 
                        [Gen Gross Impr Psc 0106], 
                        [Gen Gross Total Psc 0106], 
                        [Sch Gross Land Psc 0106], 
                        [Sch Gross Impr Psc 0106], 
                        [Sch Gross Total Psc 0106], 
                        [Hsptl Gross Land Psc 0106], 
                        [Hsptl Gross Impr Psc 0106], 
                        [Hsptl Gross Total Psc 0106], 
                        [Gen Exmpt Land Psc 0106], 
                        [Gen Exmpt Impr Psc 0106], 
                        [Gen Exmpt Total Psc 0106], 
                        [Sch Exmpt Land Psc 0106], 
                        [Sch Exmpt Impr Psc 0106], 
                        [Sch Exmpt Total Psc 0106], 
                        [Hsptl Exmpt Land Psc 0106], 
                        [Hsptl Exmpt Impr Psc 0106], 
                        [Hsptl Exmpt Total Psc 0106], 
                        [Gen Net Land Psc 0106], 
                        [Gen Net Impr Psc 0106], 
                        [Gen Net Total Psc 0106], 
                        [Sch Net Land Psc 0106], 
                        [Sch Net Impr Psc 0106], 
                        [Sch Net Total Psc 0106], 
                        [Hsptl Net Land Psc 0106], 
                        [Hsptl Net Impr Psc 0106], 
                        [Hsptl Net Total Psc 0106], 
                        [Gen Gross Land PC 02], 
                        [Gen Gross Impr PC 02], 
                        [Gen Gross Total PC 02], 
                        [Sch Gross Land PC 02], 
                        [Sch Gross Impr PC 02], 
                        [Sch Gross Total PC 02], 
                        [Hsptl Gross Land PC 02], 
                        [Hsptl Gross Impr PC 02], 
                        [Hsptl Gross Total PC 02], 
                        [Gen Exmpt Land PC 02], 
                        [Gen Exmpt Impr PC 02], 
                        [Gen Exmpt Total PC 02], 
                        [Sch Exmpt Land PC 02], 
                        [Sch Exmpt Impr PC 02], 
                        [Sch Exmpt Total PC 02], 
                        [Hsptl Exmpt Land PC 02], 
                        [Hsptl Exmpt Impr PC 02], 
                        [Hsptl Exmpt Total PC 02], 
                        [Gen Net Land PC 02], 
                        [Gen Net Impr PC 02], 
                        [Gen Net Total PC 02], 
                        [Sch Net Land PC 02], 
                        [Sch Net Impr PC 02], 
                        [Sch Net Total PC 02], 
                        [Hsptl Net Land PC 02], 
                        [Hsptl Net Impr PC 02], 
                        [Hsptl Net Total PC 02], 
                        [Gen Gross Land Psc 0201], 
                        [Gen Gross Impr Psc 0201], 
                        [Gen Gross Total Psc 0201], 
                        [Sch Gross Land Psc 0201], 
                        [Sch Gross Impr Psc 0201], 
                        [Sch Gross Total Psc 0201], 
                        [Hsptl Gross Land Psc 0201], 
                        [Hsptl Gross Impr Psc 0201], 
                        [Hsptl Gross Total Psc 0201], 
                        [Gen Exmpt Land Psc 0201], 
                        [Gen Exmpt Impr Psc 0201], 
                        [Gen Exmpt Total Psc 0201], 
                        [Sch Exmpt Land Psc 0201], 
                        [Sch Exmpt Impr Psc 0201], 
                        [Sch Exmpt Total Psc 0201], 
                        [Hsptl Exmpt Land Psc 0201], 
                        [Hsptl Exmpt Impr Psc 0201], 
                        [Hsptl Exmpt Total Psc 0201], 
                        [Gen Net Land Psc 0201], 
                        [Gen Net Impr Psc 0201], 
                        [Gen Net Total Psc 0201], 
                        [Sch Net Land Psc 0201], 
                        [Sch Net Impr Psc 0201], 
                        [Sch Net Total Psc 0201], 
                        [Hsptl Net Land Psc 0201], 
                        [Hsptl Net Impr Psc 0201], 
                        [Hsptl Net Total Psc 0201], 
                        [Gen Gross Land Psc 0202], 
                        [Gen Gross Impr Psc 0202], 
                        [Gen Gross Total Psc 0202], 
                        [Sch Gross Land Psc 0202], 
                        [Sch Gross Impr Psc 0202], 
                        [Sch Gross Total Psc 0202], 
                        [Hsptl Gross Land Psc 0202], 
                        [Hsptl Gross Impr Psc 0202], 
                        [Hsptl Gross Total Psc 0202], 
                        [Gen Exmpt Land Psc 0202], 
                        [Gen Exmpt Impr Psc 0202], 
                        [Gen Exmpt Total Psc 0202], 
                        [Sch Exmpt Land Psc 0202], 
                        [Sch Exmpt Impr Psc 0202], 
                        [Sch Exmpt Total Psc 0202], 
                        [Hsptl Exmpt Land Psc 0202], 
                        [Hsptl Exmpt Impr Psc 0202], 
                        [Hsptl Exmpt Total Psc 0202], 
                        [Gen Net Land Psc 0202], 
                        [Gen Net Impr Psc 0202], 
                        [Gen Net Total Psc 0202], 
                        [Sch Net Land Psc 0202], 
                        [Sch Net Impr Psc 0202], 
                        [Sch Net Total Psc 0202], 
                        [Hsptl Net Land Psc 0202], 
                        [Hsptl Net Impr Psc 0202], 
                        [Hsptl Net Total Psc 0202], 
                        [Gen Gross Land PC 03], 
                        [Gen Gross Impr PC 03], 
                        [Gen Gross Total PC 03], 
                        [Sch Gross Land PC 03], 
                        [Sch Gross Impr PC 03], 
                        [Sch Gross Total PC 03], 
                        [Hsptl Gross Land PC 03], 
                        [Hsptl Gross Impr PC 03], 
                        [Hsptl Gross Total PC 03], 
                        [Gen Exmpt Land PC 03], 
                        [Gen Exmpt Impr PC 03], 
                        [Gen Exmpt Total PC 03], 
                        [Sch Exmpt Land PC 03], 
                        [Sch Exmpt Impr PC 03], 
                        [Sch Exmpt Total PC 03], 
                        [Hsptl Exmpt Land PC 03], 
                        [Hsptl Exmpt Impr PC 03], 
                        [Hsptl Exmpt Total PC 03], 
                        [Gen Net Land PC 03], 
                        [Gen Net Impr PC 03], 
                        [Gen Net Total PC 03], 
                        [Sch Net Land PC 03], 
                        [Sch Net Impr PC 03], 
                        [Sch Net Total PC 03], 
                        [Hsptl Net Land PC 03], 
                        [Hsptl Net Impr PC 03], 
                        [Hsptl Net Total PC 03], 
                        [Gen Gross Land PC 04], 
                        [Gen Gross Impr PC 04], 
                        [Gen Gross Total PC 04], 
                        [Sch Gross Land PC 04], 
                        [Sch Gross Impr PC 04], 
                        [Sch Gross Total PC 04], 
                        [Hsptl Gross Land PC 04], 
                        [Hsptl Gross Impr PC 04], 
                        [Hsptl Gross Total PC 04], 
                        [Gen Exmpt Land PC 04], 
                        [Gen Exmpt Impr PC 04], 
                        [Gen Exmpt Total PC 04], 
                        [Sch Exmpt Land PC 04], 
                        [Sch Exmpt Impr PC 04], 
                        [Sch Exmpt Total PC 04], 
                        [Hsptl Exmpt Land PC 04], 
                        [Hsptl Exmpt Impr PC 04], 
                        [Hsptl Exmpt Total PC 04], 
                        [Gen Net Land PC 04], 
                        [Gen Net Impr PC 04], 
                        [Gen Net Total PC 04], 
                        [Sch Net Land PC 04], 
                        [Sch Net Impr PC 04], 
                        [Sch Net Total PC 04], 
                        [Hsptl Net Land PC 04], 
                        [Hsptl Net Impr PC 04], 
                        [Hsptl Net Total PC 04], 
                        [Gen Gross Land PC 05], 
                        [Gen Gross Impr PC 05], 
                        [Gen Gross Total PC 05], 
                        [Sch Gross Land PC 05], 
                        [Sch Gross Impr PC 05], 
                        [Sch Gross Total PC 05], 
                        [Hsptl Gross Land PC 05], 
                        [Hsptl Gross Impr PC 05], 
                        [Hsptl Gross Total PC 05], 
                        [Gen Exmpt Land PC 05], 
                        [Gen Exmpt Impr PC 05], 
                        [Gen Exmpt Total PC 05], 
                        [Sch Exmpt Land PC 05], 
                        [Sch Exmpt Impr PC 05], 
                        [Sch Exmpt Total PC 05], 
                        [Hsptl Exmpt Land PC 05], 
                        [Hsptl Exmpt Impr PC 05], 
                        [Hsptl Exmpt Total PC 05], 
                        [Gen Net Land PC 05], 
                        [Gen Net Impr PC 05], 
                        [Gen Net Total PC 05], 
                        [Sch Net Land PC 05], 
                        [Sch Net Impr PC 05], 
                        [Sch Net Total PC 05], 
                        [Hsptl Net Land PC 05], 
                        [Hsptl Net Impr PC 05], 
                        [Hsptl Net Total PC 05], 
                        [Gen Gross Land PC 06], 
                        [Gen Gross Impr PC 06], 
                        [Gen Gross Total PC 06], 
                        [Sch Gross Land PC 06], 
                        [Sch Gross Impr PC 06], 
                        [Sch Gross Total PC 06], 
                        [Hsptl Gross Land PC 06], 
                        [Hsptl Gross Impr PC 06], 
                        [Hsptl Gross Total PC 06], 
                        [Gen Exmpt Land PC 06], 
                        [Gen Exmpt Impr PC 06], 
                        [Gen Exmpt Total PC 06], 
                        [Sch Exmpt Land PC 06], 
                        [Sch Exmpt Impr PC 06], 
                        [Sch Exmpt Total PC 06], 
                        [Hsptl Exmpt Land PC 06], 
                        [Hsptl Exmpt Impr PC 06], 
                        [Hsptl Exmpt Total PC 06], 
                        [Gen Net Land PC 06], 
                        [Gen Net Impr PC 06], 
                        [Gen Net Total PC 06], 
                        [Sch Net Land PC 06], 
                        [Sch Net Impr PC 06], 
                        [Sch Net Total PC 06], 
                        [Hsptl Net Land PC 06], 
                        [Hsptl Net Impr PC 06], 
                        [Hsptl Net Total PC 06], 
                        [Gen Gross Land PC 07], 
                        [Gen Gross Impr PC 07], 
                        [Gen Gross Total PC 07], 
                        [Sch Gross Land PC 07], 
                        [Sch Gross Impr PC 07], 
                        [Sch Gross Total PC 07], 
                        [Hsptl Gross Land PC 07], 
                        [Hsptl Gross Impr PC 07], 
                        [Hsptl Gross Total PC 07], 
                        [Gen Exmpt Land PC 07], 
                        [Gen Exmpt Impr PC 07], 
                        [Gen Exmpt Total PC 07], 
                        [Sch Exmpt Land PC 07], 
                        [Sch Exmpt Impr PC 07], 
                        [Sch Exmpt Total PC 07], 
                        [Hsptl Exmpt Land PC 07], 
                        [Hsptl Exmpt Impr PC 07], 
                        [Hsptl Exmpt Total PC 07], 
                        [Gen Net Land PC 07], 
                        [Gen Net Impr PC 07], 
                        [Gen Net Total PC 07], 
                        [Sch Net Land PC 07], 
                        [Sch Net Impr PC 07], 
                        [Sch Net Total PC 07], 
                        [Hsptl Net Land PC 07], 
                        [Hsptl Net Impr PC 07], 
                        [Hsptl Net Total PC 07], 
                        [Gen Gross Land PC 08], 
                        [Gen Gross Impr PC 08], 
                        [Gen Gross Total PC 08], 
                        [Sch Gross Land PC 08], 
                        [Sch Gross Impr PC 08], 
                        [Sch Gross Total PC 08], 
                        [Hsptl Gross Land PC 08], 
                        [Hsptl Gross Impr PC 08], 
                        [Hsptl Gross Total PC 08], 
                        [Gen Exmpt Land PC 08], 
                        [Gen Exmpt Impr PC 08], 
                        [Gen Exmpt Total PC 08], 
                        [Sch Exmpt Land PC 08], 
                        [Sch Exmpt Impr PC 08], 
                        [Sch Exmpt Total PC 08], 
                        [Hsptl Exmpt Land PC 08], 
                        [Hsptl Exmpt Impr PC 08], 
                        [Hsptl Exmpt Total PC 08], 
                        [Gen Net Land PC 08], 
                        [Gen Net Impr PC 08], 
                        [Gen Net Total PC 08], 
                        [Sch Net Land PC 08], 
                        [Sch Net Impr PC 08], 
                        [Sch Net Total PC 08], 
                        [Hsptl Net Land PC 08], 
                        [Hsptl Net Impr PC 08], 
                        [Hsptl Net Total PC 08], 
                        [Gen Gross Land PC 09], 
                        [Gen Gross Impr PC 09], 
                        [Gen Gross Total PC 09], 
                        [Sch Gross Land PC 09], 
                        [Sch Gross Impr PC 09], 
                        [Sch Gross Total PC 09], 
                        [Hsptl Gross Land PC 09], 
                        [Hsptl Gross Impr PC 09], 
                        [Hsptl Gross Total PC 09], 
                        [Gen Exmpt Land PC 09], 
                        [Gen Exmpt Impr PC 09], 
                        [Gen Exmpt Total PC 09], 
                        [Sch Exmpt Land PC 09], 
                        [Sch Exmpt Impr PC 09], 
                        [Sch Exmpt Total PC 09], 
                        [Hsptl Exmpt Land PC 09], 
                        [Hsptl Exmpt Impr PC 09], 
                        [Hsptl Exmpt Total PC 09], 
                        [Gen Net Land PC 09], 
                        [Gen Net Impr PC 09], 
                        [Gen Net Total PC 09], 
                        [Sch Net Land PC 09], 
                        [Sch Net Impr PC 09], 
                        [Sch Net Total PC 09], 
                        [Hsptl Net Land PC 09], 
                        [Hsptl Net Impr PC 09], 
                        [Hsptl Net Total PC 09], 
                        [Gen Gross Land PC 10], 
                        [Gen Gross Impr PC 10], 
                        [Gen Gross Total PC 10], 
                        [Sch Gross Land PC 10], 
                        [Sch Gross Impr PC 10], 
                        [Sch Gross Total PC 10], 
                        [Hsptl Gross Land PC 10], 
                        [Hsptl Gross Impr PC 10], 
                        [Hsptl Gross Total PC 10], 
                        [Gen Exmpt Land PC 10], 
                        [Gen Exmpt Impr PC 10], 
                        [Gen Exmpt Total PC 10], 
                        [Sch Exmpt Land PC 10], 
                        [Sch Exmpt Impr PC 10], 
                        [Sch Exmpt Total PC 10], 
                        [Hsptl Exmpt Land PC 10], 
                        [Hsptl Exmpt Impr PC 10], 
                        [Hsptl Exmpt Total PC 10], 
                        [Gen Net Land PC 10], 
                        [Gen Net Impr PC 10], 
                        [Gen Net Total PC 10], 
                        [Sch Net Land PC 10], 
                        [Sch Net Impr PC 10], 
                        [Sch Net Total PC 10], 
                        [Hsptl Net Land PC 10], 
                        [Hsptl Net Impr PC 10], 
                        [Hsptl Net Total PC 10]
FROM
(
    SELECT [FACT].[dimFolio_SK], 
           [FACT].[dimRollYear_SK], 
           [Gen Gross Land PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 01] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '01'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 01] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '01'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 01] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '01'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 01] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '01'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 01] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '01'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 01] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '01'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 01] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '01'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 01] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '01'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 01] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '01'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 01] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '01'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 01] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '01'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 01] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '01'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 01] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '01'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 01] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '01'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 01] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '01'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0101] = SUM(IIF([pc].[Property Sub Class Code] = '0101', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0102] = SUM(IIF([pc].[Property Sub Class Code] = '0102', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0103] = SUM(IIF([pc].[Property Sub Class Code] = '0103', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0104] = SUM(IIF([pc].[Property Sub Class Code] = '0104', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0105] = SUM(IIF([pc].[Property Sub Class Code] = '0105', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0106] = SUM(IIF([pc].[Property Sub Class Code] = '0106', [Net School Total Value], 0)), 
           [Gen Gross Land PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 02] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '02'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 02] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '02'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 02] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '02'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 02] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '02'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 02] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '02'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 02] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '02'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 02] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '02'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 02] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '02'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 02] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '02'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 02] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '02'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 02] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '02'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 02] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '02'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 02] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '02'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 02] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '02'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 02] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '02'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0201] = SUM(IIF([pc].[Property Sub Class Code] = '0201', [Net School Total Value], 0)), 
           [Gen Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Land Value], 0)), 
           [Gen Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Building Value], 0)), 
           [Gen Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross General Total Value], 0)), 
           [Sch Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Land Value], 0)), 
           [Sch Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Building Value], 0)), 
           [Sch Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross School Total Value], 0)), 
           [Hsptl Gross Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Land Value], 0)), 
           [Hsptl Gross Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Building Value], 0)), 
           [Hsptl Gross Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Gross Other Total Value], 0)), 
           [Gen Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Land Value], 0)), 
           [Gen Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Building Value], 0)), 
           [Gen Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [General Exemptions Total Value], 0)), 
           [Sch Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Land Value], 0)), 
           [Sch Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Building Value], 0)), 
           [Sch Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [School Exemptions Total Value], 0)), 
           [Hsptl Exmpt Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Land Value], 0)), 
           [Hsptl Exmpt Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Building Value], 0)), 
           [Hsptl Exmpt Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Other Exemptions Total Value], 0)), 
           [Gen Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Land Value], 0)), 
           [Gen Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Building Value], 0)), 
           [Gen Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net General Total Value], 0)), 
           [Sch Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Land Value], 0)), 
           [Sch Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Building Value], 0)), 
           [Sch Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Total Value], 0)), 
           [Hsptl Net Land Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net Other Land Value], 0)), 
           [Hsptl Net Impr Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Building Value], 0)), 
           [Hsptl Net Total Psc 0202] = SUM(IIF([pc].[Property Sub Class Code] = '0202', [Net School Total Value], 0)), 
           [Gen Gross Land PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 03] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '03'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 03] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '03'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 03] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '03'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 03] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '03'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 03] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '03'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 03] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '03'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 03] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '03'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 03] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '03'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 03] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '03'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 03] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '03'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 03] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '03'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 03] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '03'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 03] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '03'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 03] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '03'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 03] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '03'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 04] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '04'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 04] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '04'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 04] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '04'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 04] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '04'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 04] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '04'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 04] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '04'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 04] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '04'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 04] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '04'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 04] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '04'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 04] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '04'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 04] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '04'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 04] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '04'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 04] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '04'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 04] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '04'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 04] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '04'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 05] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '05'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 05] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '05'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 05] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '05'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 05] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '05'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 05] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '05'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 05] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '05'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 05] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '05'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 05] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '05'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 05] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '05'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 05] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '05'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 05] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '05'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 05] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '05'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 05] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '05'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 05] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '05'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 05] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '05'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 06] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '06'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 06] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '06'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 06] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '06'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 06] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '06'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 06] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '06'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 06] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '06'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 06] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '06'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 06] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '06'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 06] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '06'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 06] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '06'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 06] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '06'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 06] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '06'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 06] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '06'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 06] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '06'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 06] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '06'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 07] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '07'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 07] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '07'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 07] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '07'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 07] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '07'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 07] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '07'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 07] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '07'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 07] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '07'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 07] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '07'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 07] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '07'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 07] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '07'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 07] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '07'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 07] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '07'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 07] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '07'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 07] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '07'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 07] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '07'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 08] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '08'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 08] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '08'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 08] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '08'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 08] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '08'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 08] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '08'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 08] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '08'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 08] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '08'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 08] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '08'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 08] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '08'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 08] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '08'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 08] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '08'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 08] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '08'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 08] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '08'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 08] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '08'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 08] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '08'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 09] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '09'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 09] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '09'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 09] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '09'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 09] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '09'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 09] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '09'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 09] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '09'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 09] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '09'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 09] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '09'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 09] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '09'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 09] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '09'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 09] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '09'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 09] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '09'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 09] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '09'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 09] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '09'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 09] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '09'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END), 
           [Gen Gross Land PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Gross General Land Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Impr PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Gross General Building Value]
                                            ELSE 0
                                        END), 
           [Gen Gross Total PC 10] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '10'
                                             THEN [Gross General Total Value]
                                             ELSE 0
                                         END), 
           [Sch Gross Land PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Gross School Land Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Impr PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Gross School Building Value]
                                            ELSE 0
                                        END), 
           [Sch Gross Total PC 10] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '10'
                                             THEN [Gross School Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Gross Land PC 10] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '10'
                                              THEN [Gross Other Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Impr PC 10] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '10'
                                              THEN [Gross Other Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Gross Total PC 10] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '10'
                                               THEN [Gross Other Total Value]
                                               ELSE 0
                                           END), 
           [Gen Exmpt Land PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [General Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Impr PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [General Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Gen Exmpt Total PC 10] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '10'
                                             THEN [General Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Sch Exmpt Land PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [School Exemptions Land Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Impr PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [School Exemptions Building Value]
                                            ELSE 0
                                        END), 
           [Sch Exmpt Total PC 10] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '10'
                                             THEN [School Exemptions Total Value]
                                             ELSE 0
                                         END), 
           [Hsptl Exmpt Land PC 10] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '10'
                                              THEN [Other Exemptions Land Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Impr PC 10] = SUM(CASE
                                              WHEN [pc].[Property Class Code] = '10'
                                              THEN [Other Exemptions Building Value]
                                              ELSE 0
                                          END), 
           [Hsptl Exmpt Total PC 10] = SUM(CASE
                                               WHEN [pc].[Property Class Code] = '10'
                                               THEN [Other Exemptions Total Value]
                                               ELSE 0
                                           END), 
           [Gen Net Land PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Net General Land Value]
                                          ELSE 0
                                      END), 
           [Gen Net Impr PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Net General Building Value]
                                          ELSE 0
                                      END), 
           [Gen Net Total PC 10] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '10'
                                           THEN [Net General Total Value]
                                           ELSE 0
                                       END), 
           [Sch Net Land PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Net School Land Value]
                                          ELSE 0
                                      END), 
           [Sch Net Impr PC 10] = SUM(CASE
                                          WHEN [pc].[Property Class Code] = '10'
                                          THEN [Net School Building Value]
                                          ELSE 0
                                      END), 
           [Sch Net Total PC 10] = SUM(CASE
                                           WHEN [pc].[Property Class Code] = '10'
                                           THEN [Net School Total Value]
                                           ELSE 0
                                       END), 
           [Hsptl Net Land PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Net Other Land Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Impr PC 10] = SUM(CASE
                                            WHEN [pc].[Property Class Code] = '10'
                                            THEN [Net Other Building Value]
                                            ELSE 0
                                        END), 
           [Hsptl Net Total PC 10] = SUM(CASE
                                             WHEN [pc].[Property Class Code] = '10'
                                             THEN [Net Other Total Value]
                                             ELSE 0
                                         END)
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FACT]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
    WHERE [Current Cycle Flag] = 'Yes'
          AND [FACT].[dimRollYear_SK] = @p_RY
    GROUP BY [FACT].[dimFolio_SK], 
             [FACT].[dimRollYear_SK]
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
   AND [AG].[Roll Category Code] = '1'
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