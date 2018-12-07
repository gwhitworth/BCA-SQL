/*Year
Area
Area Desc
Jur Code 
Jur Name
Roll Number (Unformatted)
Roll Number (Formatted)
Neigh Code
Neigh Name
RD Code
RD Name
School District Code
School District Description
Regional Hospital District Code
Regional Hospital District Description
Electoral Area Code
Electoral Area Description
Specified Municipal Code
Improvement District Code
Improvement District Description
Service Area Code
General Service Area Code
General Service Area Description
Islands Trust Code
Islands Trust Description
Local Area Code
Indian Band (Reserve Number)
Indian Band (Reserve Description)
Equity Code*/







DECLARE @p_RY [INT];
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_NH = '234010';
SELECT DISTINCT
FACT.dimFolio_SK,
       [FACT].[Roll Year], 
	   [AG].[Area Code],
	   [AG].[Area Desc],
	   [AG].[Jurisdiction Code] AS [Jur Code],
	    [AG].[Jurisdiction Desc] AS [Jur Name],
		[FO].[Roll Number],
		SUBSTRING([FO].[Roll Number],1,5) + '.' +SUBSTRING([FO].[Roll Number],5,3) AS [Roll Number Formatted],
--		 [AG].[Neighbourhood Code] AS [Neigh Code],
--		  [AG].[Neighbourhood] AS [Neigh Name],
--[RD].[Regional District Code] AS [RD Code], 
--[RD].[Regional District] AS [RD Name], 
--      [SD].[School District Code], 
--[SD].[School District Desc] AS [School District Description],
--[HD].[Region Hospital District Code] AS [Regional Hospital District Code],
--[HD].[Region Hospital District] AS [Regional Hospital District Description],
--[FO].[Electoral Area Code],
--'??' AS [Electoral Area Description],
       CASE
           WHEN [BTC].[Minor Tax Category Code] = 'SM'
           THEN [TC].[BCA Code]
       END AS [Specified Municipal Code],
       [FO].[Improvement District Code], 


       [FO].[General Service Code], 
       CASE
           WHEN [BTC].[Minor Tax Category Code] = 'SA'
           THEN [TC].[BCA Code]
       END AS [Service Area Code], 
--	   '??' AS [General Service Area Description],
--	          [FO].[Island Trust Code], 
--       [AG].[Area Code] AS [Local Area Code], 
--	          [BR_FA].[Equity Type] AS [Equity Code], 

0 AS [Owner Count],
0 AS [Owner Seq #],
       [ONA].[First Name] AS [Owner FName], 
       [ONA].[Middle Name] AS [Owner MName], 
       [ONA].[Last Name] AS [Owner LName], 
       [ONA].[Company Name] AS [Owner CompName],

       --CASE
       --    WHEN [BTC].[Minor Tax Category Code] = 'DE'
       --    THEN [TC].[BCA Code]
       --END AS [Defined Code], 
       --[AG].[Region Code] AS [Specified Regional Code], 
       --[PL].[Tenure Code] AS [Tenure Code], 
       --[FO].[BC Transit Flag], 
       --[ALR].[Agricultural Land Reserve Code] AS [ALR Code], 

       --[MC].[Manual Class Code], 
       --[FO].[Primary Actual Use Code] AS [Actual Use Code], 






       --[OAD].[Address Line 1] AS [Owner Address 1], 
       --[OAD].[Address Line 2] AS [Owner Address 2], 
       --[OAD].[Address Line 3] AS [Owner Address 3], 
       --[OAD].[Address Line 4] AS [Owner Address 4], 
       --[OAD].[Address Line 5] AS [Owner Address 5], 
       [FO].[SITUS Building/Unit Number] AS [Situs Unit No], 
       [FO].[SITUS Address Number Prefix], 
       [FO].[SITUS Street Number], 
       [FO].[SITUS Address Street Name], 
       [FO].[SITUS Street Suffix], 
       [FO].[SITUS Address Location Line 2], 
       [FO].[SITUS City] AS [Situs City], 
       [FO].[SITUS Province] AS [Situs Province], 
       [FO].[SITUS Postal Code] AS [Situs Postal Code] --, 
       --'??' AS [Situs Freeform Address], 
       --ISNULL([PL].[Legal Text], '') AS [Legal Description], 
       --ISNULL([PL].[PID], '') AS [PID], 
       --'??' AS [SUPP Occupancy Date], 

       
 



       --[FRS].[Previous Year1 Total Actual Value] AS [Previous Roll Value], 

       --[PL].[FN Reserve Code] AS [Indian Band (Reservation Number)],


       --'??' AS [Dimensions], 
       --[PL].[Land Branch File] AS [Lands Branch File Number], 
       --'??' AS [Document Number (LTSA Title No)], 
       --[PC].[Property Class Desc] AS [Property Class (Land)], 
       --[PC].[Property Sub Class Desc] AS [Property Sub-Class (Land)],
       --CASE
       --    WHEN [Actual Land Value] > 0
       --    THEN [FVL].[Exempt Tax Code]
       --END AS [Exempt Tax Code Land], 
       --[PC].[Property Class Desc] AS [Property Class (Improvement)],
       --CASE
       --    WHEN [Actual Building Value] > 0
       --    THEN [FVL].[Exempt Tax Code]
       --END AS [Exempt Tax Code Improvement], 
       --[PC].[Property Sub Class Desc] AS [Property Sub-Class (Improvement)], 
       --[BR_FA].[Bulk Code], 
       --[BR_FA].[Party Type], 
       --'??' AS [Additional School Tax Flag], 














       --[Actual Land Value], 
       --[Actual Building Value], 
       --[Gross General Land Value] AS [General Gross Land], 
       --[Gross General Building Value] AS [General Gross Improvement], 
       --[Gross General Land Value] + [Gross General Building Value] AS [General Gross Total], 
       --[Gross School Land Value] AS [School Gross Land], 
       --[Gross School Building Value] AS [School Gross Improvement], 
       --[Gross School Land Value] + [Gross School Building Value] AS [School Gross Total], 
       --[Gross Other Land Value] AS [Hospital Gross Land], 
       --[Gross Other Building Value] AS [Hospital Gross Improvement], 
       --[Gross Other Land Value] + [Gross Other Building Value] AS [Hospital Gross Total], 
       --[General Exemptions Land Value] AS [General Exempt Land], 
       --[General Exemptions Building Value] AS [General Exempt Improvement], 
       --[General Exemptions Land Value] + [General Exemptions Building Value] AS [General Exempt Total], 
       --[School Exemptions Land Value] AS [School Exempt Land], 
       --[School Exemptions Building Value] AS [School Exempt Improvement], 
       --[School Exemptions Land Value] + [School Exemptions Building Value] AS [School Exempt Total], 
       --[Net General Land Value] AS [General Net Land], 
       --[Net General Building Value] AS [General Net Improvement], 
       --[Net General Land Value] + [Net General Building Value] AS [General Net Total], 
       --[Net School Land Value] AS [School Net Land], 
       --[Net School Building Value] AS [School Net Improvement], 
       --[Net School Land Value] + [Net School Building Value] AS [School Net Total], 
       --[Other Exemptions Land Value] AS [Hospital Exempt Land], 
       --[Other Exemptions Building Value] AS [Hospital Exempt Improvement], 
       --[Other Exemptions Land Value] + [Other Exemptions Building Value] AS [Hospital Exempt Total], 
       --[Net Other Land Value] AS [Hospital Net Land], 
       --[Net Other Building Value] AS [Hospital Net Improvement], 
       --[Net Other Land Value] + [Net Other Building Value] AS [Hospital Net Total]
FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FACT]
     INNER JOIN [edw].[FactAssessedValue] AS [FAV]
     ON [FAV].[dimFolio_SK] = [FACT].[dimFolio_SK]
     INNER JOIN [edw].[FactRollSummary] AS [FRS]
     ON [FRS].[dimFolio_SK] = [FACT].[dimFolio_SK]
     INNER JOIN [edw].[FactActualValue] AS [FVL]
     ON [FVL].[dimFolio_SK] = [FACT].[dimFolio_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC]
     ON [FACT].[dimFolio_SK] = [BTC].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FACT].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     -- AND AG.[Roll Category Code] = '1'
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
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BR_FA]
     ON [BR_FA].[dimFolio_SK] = [FO].[dimFolio_SK]
     INNER JOIN [edw].[dimName] AS [ONA]
     ON [ONA].[dimName_SK] = [BR_FA].[dimName_SK]
     INNER JOIN [edw].[dimAddress] AS [OAD]
     ON [OAD].[dimAddress_SK] = [BR_FA].[dimAddress_SK]
     INNER JOIN [edw].[dimCountry] AS [CN]
     ON [CN].[dimCountry_SK] = [OAD].[dimCountry_SK]
	 INNER JOIN [edw].[dimSchoolDistrict] AS [SD]
     ON [SD].[dimSchoolDistrict_SK] = [FO].[dimSchoolDistrict_SK]
	 	 INNER JOIN [edw].[dimRegionalHospitalDistrict] AS [HD]
     ON [HD].[dimRegionalHospitalDistrict_SK] = [FO].[dimRegionalHospitalDistrict_SK]
--INNER JOIN [edw].[dimElectoralDistrict] AS [ED]
--     ON [ED].[E] = [FO].[Electoral Area Code]
     LEFT OUTER JOIN [edw].[dimFolioCharacteristicTbl] AS [FC]
     ON [FC].[dimFolioCharacteristic_BK] = [FO].[Characteristic1_dimFolioCharacteristic_BK]

WHERE [FACT].[Roll Year] = @p_RY
      AND [AG].[Neighbourhood Code] = @p_NH
	  and [FO].[SITUS Postal Code] is not null

order by [FO].[SITUS Postal Code],[FO].[SITUS Building/Unit Number]



--ORDER BY [FACT].[Roll Year], 
--         [FO].[School District Code], 
--         [AG].[Jurisdiction], 
--         [FO].[Roll Number], 
--         [BR_FA].[Equity Type], 
--         [ONA].[First Name], 
--         [ONA].[Middle Name], 
--         [ONA].[Last Name], 
--         [ONA].[Company Name];