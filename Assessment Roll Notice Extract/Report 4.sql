DECLARE @UniqueID VARCHAR(32)= REPLACE(NEWID(), '-', '');
DECLARE @RollYear [INT]= 2018;

SELECT 'BCA00020' AS [Record ID],   -- [PR].[Folio Number], [PR].[Folio Number Display], 
              CONCAT([PR].[Area Code], [PR].[Jurisdiction Code], [PR].[Roll Number]) AS [Area Jurisdiction Roll], 
              ISNULL([PR].[Postal Code],SPACE(7)) AS [postal Code], 
              ISNULL(SUBSTRING([BAD].[Bulk Code], 1, 4),SPACE(4)) AS [Bulk mail code], 
              'STAND' AS [Notice Type], 
              '01' AS [Routing Type], 
              'AAN19   ' AS [Form Identification], 
              REPLICATE(' ', 8) AS [AFP Resource], 
              ' ' AS [Copy Requirement], 
              SPACE(5) AS [filler], 
              [PR].[Area Code] AS [Area], 
              [BSD].[School District Code] AS [Sch Dist], 
              [PR].[Jurisdiction Code] AS [Jurisdiction Code], 
              CONCAT(SUBSTRING([PR].[Roll Number], 1, 3), '-', SUBSTRING([PR].[Roll Number], 4, 4), '-', CONCAT(REPLICATE('0', 3-LEN(SUBSTRING([PR].[Roll Number], 7, 3))), SUBSTRING([PR].[Roll Number], 7, 3)), SPACE(18-LEN([PR].[Roll Number]))) AS [Roll Number], 
              CONCAT('City of ',SUBSTRING([BSD].[Jurisdiction Desc], 1, (CHARINDEX('(', [BSD].[Jurisdiction Desc])-1)),SPACE(22-LEN(SUBSTRING([BSD].[Jurisdiction Desc], 1, (CHARINDEX('(', [BSD].[Jurisdiction Desc])-1))))) AS [Jurisdiction Description], 

              CONCAT(SUBSTRING([BAD].[PIN Number], 1, 4), '-', SUBSTRING([BAD].[PIN Number], 5, 10)) AS [PIN], 
              SUBSTRING([AG].[Neighbourhood Code], 4, 3) AS [Office Use/Neighbourhood Code], 
              IIF(ISNULL(SUBSTRING([BAD].[Bulk Code], 1, 4),'') = '',
			  'BULK MAIL:0067',
			  CONCAT('BULK MAIL: ', COALESCE(SUBSTRING([BAD].[Bulk Code], 1, 4), ''))
			  ) AS [Bulk mail], 

              'B000015' AS [TYPE_SEQNUM], 
              
			  CONCAT([SITUS Address Number Prefix], ' ',[SITUS Street Number], ' ', [SITUS Street Direction], ' ',[SITUS Address Street Name], ' ',[SITUS Street Suffix], ' ',[SITUS Street Type],SPACE(70-LEN(ISNULL(CONCAT([SITUS Address Number Prefix], ' ',[SITUS Street Number], ' ', [SITUS Street Direction], ' ',[SITUS Address Street Name], ' ',[SITUS Street Suffix], ' ',[SITUS Street Type]), '')))) AS [Property Info], 
              [PD].[Legal Description List] AS [Legal Description], 
              CONCAT('PID: ', [dbo].[FN_GetPidList]([PD].[PID Display List], ';', 6),SPACE(101-LEN(CONCAT('PID: ', [dbo].[FN_GetPidList]([PD].[PID Display List], ';', 6))))) AS [PID Nos], 



     --         CONCAT('VALUE    CLASS            ',
			  --'LAND',
			  --SPACE(14),
			  --CONCAT(SPACE(17-LEN(FORMAT([Total Land Value], 'N0', 'en-US'))),FORMAT([Total Land Value], 'N0', 'en-US')),
			  --SPACE(4),

			 -- IIF(LEN([PD].[Property Class Code List]) > 2,

			 -- CONCAT(CASE SUBSTRING([PD].[Property Class Code List],1,2)
				--WHEN '01'
				--THEN 'RESIDENTIAL'
				--WHEN '02'
				--THEN 'UTILITIES'
				--WHEN '03'
				--THEN 'SUPPORTIVE HSG'
				--WHEN '04'
				--THEN 'MAJOR INDUSTRY'
				--WHEN '05'
				--THEN 'LIGHT INDUSTRY'
				--WHEN '06'
				--THEN 'BUSINESS/OTHER'
				--WHEN '07'
				--THEN 'MANAGED FOREST'
				--WHEN '08'
				--THEN 'REC/NON PROFIT'
				--WHEN '09'
				--THEN 'FARM'
				--WHEN '10'
				--THEN 'RESIDENTIAL'
				--WHEN '11'
				--THEN ''
				--ELSE 'UNCLASSIFY'
			 -- END,SPACE(16-LEN(CASE SUBSTRING([PD].[Property Class Code List],1,2)
				--WHEN '01'
				--THEN 'RESIDENTIAL'
				--WHEN '02'
				--THEN 'UTILITIES'
				--WHEN '03'
				--THEN 'SUPPORTIVE HSG'
				--WHEN '04'
				--THEN 'MAJOR INDUSTRY'
				--WHEN '05'
				--THEN 'LIGHT INDUSTRY'
				--WHEN '06'
				--THEN 'BUSINESS/OTHER'
				--WHEN '07'
				--THEN 'MANAGED FOREST'
				--WHEN '08'
				--THEN 'REC/NON PROFIT'
				--WHEN '09'
				--THEN 'FARM'
				--WHEN '10'
				--THEN 'RESIDENTIAL'
				--WHEN '11'
				--THEN ''
				--ELSE 'UNCLASSIFY'
			 -- END))),SPACE(16))
			 -- ) AS [Property Value], 
			  'Assessed Value                Value             Class   Buildings                 3,711,000                    ' AS [Property Value], 
			  'U' AS [Bold Flag], 
              '2019 Assessed Value      $3,711,000         Utilities  ' AS [Formatted Property Value], 
              'Buildings                18,271,000         Utilities                             1,522,600    Business/Other  U2019 Assessed Value    $103,678,000                    XTaxable Value             Municipal            School                           103,678,000       103,678,000   Less Exemptions         103,678,000            10,000  X2019 Taxable Value              NIL      $103,668,000                                                                                                                                                                                                                                                                                                                                                  ' AS [Additional Information], 
              '' AS [Bullet Flag], 
              '' AS [Additional Information Text], 
              'XDue to the specialized nature of your property, it is not              displayed on Assessment Search (bcassessment.ca).  Please contact      us if you require additional information.                             X2019 Property Tax Notices will be mailed out in May based on this      assessment value. Questions: tax_dept@dawsoncreek.ca or                250-784-3608.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ' AS [Return Address Info], 
              CONCAT(
			  [AOL].[Line1],SPACE(59-LEN(ISNULL([AOL].[Line1], ''))),
			  [AOL].[Line2],SPACE(59-LEN(ISNULL([AOL].[Line2], ''))),
			  [AOL].[Line3],SPACE(59-LEN(ISNULL([AOL].[Line3], '')))
			  ) AS [Your Assessment Office Address], 
              CONCAT([PR].[Area Code], '-',[BSD].[School District Code], '-', [PR].[Jurisdiction Code], '-',
			  SUBSTRING([PR].[Roll Number], 1, 3), '-', SUBSTRING([PR].[Roll Number], 4, 4), '-', CONCAT(REPLICATE('0', 3-LEN(SUBSTRING([PR].[Roll Number], 7, 3))), SUBSTRING([PR].[Roll Number], 7, 3)), SPACE(59-(LEN([PR].[Roll Number])+2)-10)
			  ) AS [Folio  Info], 
              CONCAT([AOL].[Line4],SPACE(59-LEN(ISNULL([AOL].[Line4], '')))) AS [Phone Numbers], 
              CONCAT([AOL].[Line5],SPACE(59-LEN(ISNULL([AOL].[Line5], '')))) AS [Fax Number], 
              CONCAT([AOL].[Line6],SPACE(59-LEN(ISNULL([AOL].[Line6], '')))) AS [Email Address], 
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
              'Y' AS [INSERT_1_YN], 
              'N' AS [INSERT_2_YN], 
              'N' AS [INSERT_3_YN], 
              'N' AS [INSERT_4_YN], 
              
			  --CONCAT([PR].[Area Code],'_',[PR].[Jurisdiction Code],'_',[PR].[Roll Number],'_',ISNULL([Owner 1 Name], 'NO OWNER1'),ISNULL('_'+[Owner 2 Name], ''),'.pdf') AS [PDF_File_Name], 
              SPACE(50) AS [PDF_File_Name],
			   
			  IIF(CHARINDEX([PD].[Property Class Code List],',')>0,'',
			  CONCAT(SPACE(10-LEN(REPLACE(FORMAT(((ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value])/[Previous Year2 Total Assessed Value],0) +
			  ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value])/[Previous Year3 Total Assessed Value],0) + 
			  ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value])/[Previous Year4 Total Assessed Value],0) + 
			  ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value])/[Previous Year5 Total Assessed Value],0)) / 4),'P0'),' %', '%')))
			  ,
			  REPLACE(FORMAT(((ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value])/[Previous Year2 Total Assessed Value],0) +
			  ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value])/[Previous Year3 Total Assessed Value],0) + 
			  ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value])/[Previous Year4 Total Assessed Value],0) + 
			  ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value])/[Previous Year5 Total Assessed Value],0)) / 4),'P0'),' %', '%')    
			  )
			  )
			  AS [AVERAGE PERCENT]
FROM [edw].[FactRollSummary] AS [FACT]
	 --INNER JOIN [edw].[FactAssessedValue] AS [FACT2]
	 --ON [FACT].[dimFolio_SK] = [FACT2].[dimFolio_SK]
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
	INNER JOIN [edw].[dimAssessmentOfficeAddressLines] [AOL] ON [AOL].[dimArea_SK] = [AG].[dimArea_SK] AND [AOL].[Roll Year] = @RollYear

WHERE 
--002-349-311

[FACT].[Roll Year] = @RollYear 
--[PR].[Roll Number] IN ('03503030') 
AND [PR].[Area Code] = '01'
AND [PR].[Jurisdiction Code] = '213'
AND [PR].[Roll Number] = '03523000'
--AND [PR].[Postal Code] = 
--[PR].[Roll Number] IN ('03503030','03503040','03504005','03505000','03508090', '03510010', '03510050') 
--AND [PR].[Jurisdiction Code] = '213'
--AND [PR].[SITUS Postal Code] IN ('V9B 6C8','V8W 3G3','N2E 3J2','V8W 3G3','V8W 2N8','V9K 1E1','V9B 5Z3', 'V9C 4A1')

      --AND [BAD].[Bulk Code] IS NOT NULL
      --AND [BAD].[PIN Number] IS NOT NULL;