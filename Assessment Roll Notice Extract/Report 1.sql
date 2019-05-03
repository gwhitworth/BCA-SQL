DECLARE @UniqueID VARCHAR(32)= REPLACE(NEWID(), '-', '');
DECLARE @RollYear [INT]= 2018;
SELECT TOP 20 'BCA00020' AS [Record ID], 
              [PR].[Area Code] + [PR].[Jurisdiction Code] + [PR].[Roll Number] AS [Area Jurisdiction Roll], 
              [PR].[SITUS Postal Code] AS [postal Code], 
              SUBSTRING([BAD].[Bulk Code], 1, 4) AS [Bulk mail code], 
              REPLICATE('?', 5) AS [Notice Type], 
              REPLICATE('?', 2) AS [Routing Type], 
              REPLICATE('?', 8) AS [Form Identification], 
              REPLICATE('?', 8) AS [AFP Resource], 
              '?' AS [Copy Requirement], 
              SPACE(5) AS [filler], 
              '' AS [Folio  Info], 
              [PR].[Area Code] AS [Area], 
              [BSD].[School District Code] AS [Sch Dist], 
              [PR].[Jurisdiction Code] AS [Jurisdiction Code], 
              CONCAT(SUBSTRING([PR].[Roll Number], 1, 3), '-', SUBSTRING([PR].[Roll Number], 4, 4), '-', CONCAT(REPLICATE('0', 3-LEN(SUBSTRING([PR].[Roll Number], 7, 3))), SUBSTRING([PR].[Roll Number], 7, 3)), SPACE(18-LEN([PR].[Roll Number]))) AS [Roll Number], 
              SUBSTRING([BSD].[Jurisdiction Desc], 1, (CHARINDEX('(', [BSD].[Jurisdiction Desc])-1)) AS [Jurisdiction Description], 
              CONCAT(SUBSTRING([BAD].[PIN Number], 1, 4), '-', SUBSTRING([BAD].[PIN Number], 5, 10)) AS [PIN], 
              SUBSTRING([AG].[Neighbourhood Code], 4, 3) AS [Office Use/Neighbourhood Code], 
              CONCAT('Bulk Mail: ', COALESCE(SUBSTRING([BAD].[Bulk Code], 1, 4), '')) AS [Bulk mail], 
              REPLICATE('?', 7) AS [TYPE_SEQNUM], 
              '' AS [Property Info], 
              [PD].[Legal Description List] AS [Legal Description], 
              CONCAT('PID: ', [dbo].[FN_GetPidList]([PD].[PID Display List], ';', 6)) AS [PID Nos], 
              '' AS [Property Value], 
              '?' AS [Bold Flag], 
              '' AS [Formatted Property Value], 
              SPACE(71) AS [Additional Information], 
              '?' AS [Bullet Flag], 
              SPACE(70) AS [Additional Information Text], 
              SPACE(59) AS [Return Address Info], 
              REPLICATE('?', 59) AS [Your Assessment Office Address], 
              '' AS [Folio  Info], 
              REPLICATE('?', 59) AS [Phone Numbers], 
              REPLICATE('?', 59) AS [Fax Number], 
              REPLICATE('?', 59) AS [Email Address], 
              CONCAT(ISNULL([Owner 1 Name], ''), SPACE(35-LEN(ISNULL([Owner 1 Name], ''))), ISNULL([Owner 2 Name], ''), SPACE(35-LEN(ISNULL([Owner 2 Name], '')))) AS [Owner Names], 
              [dbo].[FN_GetAllAddressLines]([ADD].[dimCity_BK], [ADD].[dimCountry_BK], NULL, [ADD].[dimStreetDirection_BK], [ADD].[Postal/Zip Code], [ADD].[dimProvince_BK], [ADD].[Address Street Name], [ADD].[Street Number], [ADD].[dimStreetType_BK], [ADD].[Address Unit], [ADD].[Floor Number], [BAD].[Care Of], [ADD].[Attention], [ADD].[Site], [ADD].[Compartment], [ADD].[Delivery Mode Desc], [ADD].[Delivery Mode Value], '', '') AS [Mail Address], 
              REPLICATE('?', 59) AS [OMR Marks], 
              @UniqueID AS [Unique ID], 
              CONCAT(
			  SPACE(17-LEN(ISNULL(FORMAT([Previous Year1 Total Assessed Value], 'C0', 'en-US'),''))), 
			  FORMAT([Previous Year1 Total Assessed Value], 'C0', 'en-US'),
			  SPACE(17-LEN(ISNULL(FORMAT([Previous Year2 Total Assessed Value], 'C0', 'en-US'),''))), 
			  FORMAT([Previous Year2 Total Assessed Value], 'C0', 'en-US'),
			  SPACE(17-LEN(ISNULL(FORMAT([Previous Year3 Total Assessed Value], 'C0', 'en-US'),''))), 
			  FORMAT([Previous Year3 Total Assessed Value], 'C0', 'en-US'),
			  SPACE(17-LEN(ISNULL(FORMAT([Previous Year4 Total Assessed Value], 'C0', 'en-US'),''))), 
			  FORMAT([Previous Year4 Total Assessed Value], 'C0', 'en-US'), 
			  SPACE(17-LEN(ISNULL(FORMAT([Previous Year5 Total Assessed Value], 'C0', 'en-US'),''))), 
			  FORMAT([Previous Year5 Total Assessed Value], 'C0', 'en-US')
			  ) AS [PREV_VALUE_SET], 
              '?' AS [EPIN Or Related Pin Number], 
              CONCAT(
			  SPACE(11-LEN(FORMAT(ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value])/[Previous Year2 Total Assessed Value],0),'P0'))),
			  REPLACE(FORMAT(ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value])/[Previous Year2 Total Assessed Value],0),'P0'),' %', '%'), 
			  SPACE(11-LEN(FORMAT(ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value])/[Previous Year3 Total Assessed Value],0),'P0'))),
			  REPLACE(FORMAT(ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value])/[Previous Year3 Total Assessed Value],0),'P0'),' %', '%'), 
			  SPACE(11-LEN(FORMAT(ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value])/[Previous Year4 Total Assessed Value],0),'P0'))),
			  REPLACE(FORMAT(ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value])/[Previous Year4 Total Assessed Value],0),'P0'),' %', '%'), 
			  SPACE(11-LEN(FORMAT(ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value])/[Previous Year5 Total Assessed Value],0),'P0'))),
			  REPLACE(FORMAT(ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value])/[Previous Year5 Total Assessed Value],0),'P0'),' %', '%')) 
			  AS [PCT_CHANGE_SET], 
              CONCAT([AG].[Area Desc], SPACE(30-LEN([AG].[Area Desc]))) AS [AREA_NAME], 
              CONCAT([BSD].[School District Desc], SPACE(30-LEN([BSD].[School District Desc]))) AS [SD_NAME], 
              CONCAT([AG].[Neighbourhood Desc], SPACE(50-LEN([AG].[Neighbourhood Desc]))) AS [NEIGH_NAME], 
              '?' AS [INSERT_1_YN], 
              '?' AS [INSERT_2_YN], 
              '?' AS [INSERT_3_YN], 
              '?' AS [INSERT_4_YN], 
              REPLICATE('?', 132) AS [PDF_File_Name], 
              '??' AS [AVERAGE PERCENT]
FROM [edw].[FactRollSummary] AS [FACT]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimProperty] AS [PR]
     ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeOwnerFolioAddress] AS [BAD]
     ON [BAD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [BSD]
     ON [BSD].[dimJurisdiction_SK] = [PR].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimPropertyDetails] AS [PD]
     ON [PD].[dimProperty_SK] = [PR].[dimProperty_SK]
     INNER JOIN [edw].[dimAddress] AS [ADD]
     ON [ADD].[dimAddress_SK] = [BAD].[dimAddress_SK]
     INNER JOIN [EDW].[edw].[dimPropertyOwnerAddresses] AS [POA]
     ON [POA].[dimProperty_SK] = [PR].[dimProperty_SK]
        AND [POA].[dimRollYear_SK] = @RollYear
WHERE [FACT].[dimRollYear_SK] = @RollYear
      --AND [BAD].[Bulk Code] IS NOT NULL
      --AND [BAD].[PIN Number] IS NOT NULL;