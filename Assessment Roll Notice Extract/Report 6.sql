DECLARE @UniqueID VARCHAR(32)= REPLACE(NEWID(), '-', '');
DECLARE @RollYear [INT]= 2018;

SELECT --DISTINCT * --,
DISTINCT [ROWNUM],
CONCAT([Record ID], [Area Jurisdiction Roll], [postal Code], [Bulk mail code], [Notice Type], [Routing Type], [Form Identification], [AFP Resource], [Copy Requirement], [filler], [Area], [Sch Dist], [Jurisdiction Code], [Roll Number], [Jurisdiction Description], [PIN], [Office Use/Neighbourhood Code], [Bulk mail], 
CONCAT('B',IIF(LEN([ROWNUM])>1,'000','0000'),[ROWNUM]), --
--[TYPE_SEQNUM], 
[Property Info], [Legal Description], [PID Nos], PROPERTY_BOLD_FLAG1, PROPERTY_VALUE1, PROPERTY_BOLD_FLAG2, PROPERTY_VALUE2, PROPERTY_BOLD_FLAG3, PROPERTY_VALUE3, PROPERTY_BOLD_FLAG4, PROPERTY_VALUE4, PROPERTY_BOLD_FLAG5, PROPERTY_VALUE5, PROPERTY_BOLD_FLAG6, PROPERTY_VALUE6, PROPERTY_BOLD_FLAG7, PROPERTY_VALUE7, PROPERTY_BOLD_FLAG8, PROPERTY_VALUE8, PROPERTY_BOLD_FLAG9, PROPERTY_VALUE9, PROPERTY_BOLD_FLAG10, PROPERTY_VALUE10, PROPERTY_BOLD_FLAG11, PROPERTY_VALUE11, PROPERTY_BOLD_FLAG12, PROPERTY_VALUE12, PROPERTY_BOLD_FLAG13, PROPERTY_VALUE13, PROPERTY_BOLD_FLAG14, PROPERTY_VALUE14, PROPERTY_BOLD_FLAG15, PROPERTY_VALUE15, PROPERTY_BOLD_FLAG16, PROPERTY_VALUE16, ADDITIONAL_BOLD_FLAG1, ADDITIONAL_INFO1, ADDITIONAL_BOLD_FLAG2, ADDITIONAL_INFO2, ADDITIONAL_BOLD_FLAG3, ADDITIONAL_INFO3, ADDITIONAL_BOLD_FLAG4, ADDITIONAL_INFO4, ADDITIONAL_BOLD_FLAG5, ADDITIONAL_INFO5, ADDITIONAL_BOLD_FLAG6, ADDITIONAL_INFO6, ADDITIONAL_BOLD_FLAG7, ADDITIONAL_INFO7, ADDITIONAL_BOLD_FLAG8, ADDITIONAL_INFO8, ADDITIONAL_BOLD_FLAG9, ADDITIONAL_INFO9, ADDITIONAL_BOLD_FLAG10, ADDITIONAL_INFO10, ADDITIONAL_BOLD_FLAG11, ADDITIONAL_INFO11, ADDITIONAL_BOLD_FLAG12, ADDITIONAL_INFO12, ADDITIONAL_BOLD_FLAG13, ADDITIONAL_INFO13
, SPACE(270)
, [Your Assessment Office Address], [Folio  Info], [Phone Numbers], [Fax Number], [Email Address], [Owner Names], [Mail Address], [OMR Marks], [Unique ID], [PREV_VALUE_SET], [EPIN Or Related Pin Number], [PCT_CHANGE_SET], [AREA_NAME], [SD_NAME], [NEIGH_NAME], [INSERT_1_YN], [INSERT_2_YN], [INSERT_3_YN], [INSERT_4_YN] --, CHAR(13) + CHAR(10)
--, [PDF_File_Name], [AVERAGE PERCENT]

) AS [DETAIL]

FROM
(
    SELECT DISTINCT 
	--row_number() OVER (ORDER BY [PR].[dimProperty_SK]) AS [ROWNUM],
	--[ROWNUM]=count(*),-- AS [ROWNUM]
	[PD].[dimProperty_SK],'BCA00020' AS [Record ID], 
           CONCAT([PR].[Area Code], [PR].[Jurisdiction Code], [PR].[Roll Number], SPACE(20-LEN(CONCAT([PR].[Area Code], [PR].[Jurisdiction Code], [PR].[Roll Number])))) AS [Area Jurisdiction Roll], 
           ISNULL([ADD].[Postal/Zip Code], SPACE(7)) AS [postal Code], 
           ISNULL(SUBSTRING([BAD].[Bulk Code], 1, 4), SPACE(4)) AS [Bulk mail code], 
           'STAND' AS [Notice Type], 
           '01' AS [Routing Type], 
           'AAN19   ' AS [Form Identification], 
           REPLICATE(' ', 8) AS [AFP Resource], 
           ' ' AS [Copy Requirement], 
           SPACE(5) AS [filler], 
           [PR].[Area Code] AS [Area], 
           [BSD].[School District Code] AS [Sch Dist], 
           [PR].[Jurisdiction Code] AS [Jurisdiction Code], 
           --CONCAT(SUBSTRING([PR].[Roll Number], 1, 3), '-', SUBSTRING([PR].[Roll Number], 4, 4), '-', CONCAT(REPLICATE('0', 3-LEN(SUBSTRING([PR].[Roll Number], 7, 3))), SUBSTRING([PR].[Roll Number], 7, 3)), SPACE(16-LEN([PR].[Roll Number]))) AS [Roll Number], 
		   CONCAT(SUBSTRING([PR].[Roll Number], 1, 5), '.', SUBSTRING([PR].[Roll Number], 6, 7), SPACE(19-LEN([PR].[Roll Number]))) AS [Roll Number], 
           CONCAT('City of ', SUBSTRING([BSD].[Jurisdiction Desc], 1, (CHARINDEX('(', [BSD].[Jurisdiction Desc])-1)), SPACE(22-LEN(SUBSTRING([BSD].[Jurisdiction Desc], 1, (CHARINDEX('(', [BSD].[Jurisdiction Desc])-1))))) AS [Jurisdiction Description], 
           --CONCAT(SUBSTRING([BAD].[PIN Number], 1, 4), '-', SUBSTRING([BAD].[PIN Number], 5, 10)) AS [PIN], 
           SPACE(21) AS [PIN], 
           SUBSTRING([AG].[Neighbourhood Code], 4, 3) AS [Office Use/Neighbourhood Code],

           --IIF(ISNULL(SUBSTRING([BAD].[Bulk Code], 1, 4), '') = '', 'BULK MAIL:0067', CONCAT('BULK MAIL: ', COALESCE(SUBSTRING([BAD].[Bulk Code], 1, 4), ''))) AS [Bulk mail], 
           SPACE(15) AS [Bulk mail],

           'B000015' AS [TYPE_SEQNUM], 
           --SPACE(7) AS [TYPE_SEQNUM], 
		   
		   --CONCAT('B',IIF(LEN(ROW_NUMBER() OVER (ORDER BY (SELECT 'BCA00020')))>1,'000','0000'),ROW_NUMBER() OVER (ORDER BY (SELECT 'BCA00020'))) AS [TYPE_SEQNUM],
           CONCAT(
		   LTRIM(RTRIM([SITUS Address Number Prefix])), IIF(LEN(RTRIM([SITUS Address Number Prefix]))>0,' ',''), 
		   LTRIM(RTRIM([SITUS Street Number])), IIF(LEN(RTRIM([SITUS Street Number]))>0,' ',''),
		   LTRIM(RTRIM([SITUS Street Direction])), IIF(LEN(RTRIM([SITUS Street Direction]))>0,' ',''),
		   LTRIM(RTRIM([SITUS Address Street Name])), IIF(LEN(RTRIM([SITUS Address Street Name]))>0,' ',''),
		   LTRIM(RTRIM([SITUS Street Suffix])), IIF(LEN(RTRIM([SITUS Street Suffix]))>0,' ',''),
		   LTRIM(RTRIM([SITUS Street Type])), 
		   SPACE(71-LEN(ISNULL(CONCAT([SITUS Address Number Prefix], ' ', [SITUS Street Number], ' ', [SITUS Street Direction], ' ', [SITUS Address Street Name], ' ', [SITUS Street Suffix], ' ', [SITUS Street Type]), '')))) AS [Property Info], 
           CONCAT([PD].[Legal Description List], SPACE(490-LEN([PD].[Legal Description List]))) AS [Legal Description], 
           CONCAT('PID: ', [dbo].[FN_GetPidList]([PD].[PID Display List], ';', 6), SPACE(70-LEN(CONCAT('PID: ', [dbo].[FN_GetPidList]([PD].[PID Display List], ';', 6))))) AS [PID Nos], 
           'X' AS PROPERTY_BOLD_FLAG1, 
           --'ASSESSED VALUE                VALUE             CLASS  ' AS PROPERTY_VALUE1, 
		   '                              VALUE             CLASS  ' AS PROPERTY_VALUE1, 
           SPACE(1) AS PROPERTY_BOLD_FLAG2, 
           --'LAND                      1,209,000                    ' AS PROPERTY_VALUE2, 
           CONCAT('LAND                        ',FORMAT([FACT].[Total Land Value],'N0'),'                    ') AS PROPERTY_VALUE2, 
		   SPACE(1) AS PROPERTY_BOLD_FLAG3, 
           --'BUILDINGS                   564,000                    ' AS PROPERTY_VALUE3, 
		   CONCAT('BUILDINGS                   ',FORMAT([FACT].[Total Building Value],'N0'),'                    ') AS PROPERTY_VALUE3,
		    
           --'U' AS PROPERTY_BOLD_FLAG4, 
           'X' AS PROPERTY_BOLD_FLAG4, 
		   
		   --'2018 ASSESSED VALUE      $1,773,000    BUSINESS/OTHER  ' AS PROPERTY_VALUE4, 

		   --CONCAT(@RollYear,' ASSESSED VALUE        ',FORMAT([FACT].[Total Assessed Value],'C0'),'    ',[PC].[Property Class Short Name],'  ', SPACE(35-LEN(CONCAT('2018 ASSESSED VALUE      ',FORMAT([FACT].[Total Assessed Value],'C0'),'    ',[PC].[Property Class Short Name],'  ')))) AS PROPERTY_VALUE4, 
		   CONCAT(@RollYear,' ASSESSED VALUE        ',FORMAT([FACT].[Total Assessed Value],'C0'),'       ',[PC].[Property Class Short Name],'  ', SPACE(35-LEN(CONCAT(@RollYear,' ASSESSED VALUE        ',FORMAT([FACT].[Total Assessed Value],'C0'),'       ',[PC].[Property Class Short Name],'  ')))) AS PROPERTY_VALUE4, 
           
		   
		   'X' AS PROPERTY_BOLD_FLAG5,
		    
           --'TAXABLE VALUE             MUNICIPAL                    '  AS PROPERTY_VALUE5, 
		   CONCAT('     TAXABLE VALUE         ',FORMAT([FACT].[Total Assessed Value]-[FACT].[General Exemptions Value],'C0'),'                    ')  AS PROPERTY_VALUE5, 
           
		   SPACE(1) AS PROPERTY_BOLD_FLAG6, 

           --'Less Exemptions              10,000                    ' AS PROPERTY_VALUE6, 
		   SPACE(35)  AS PROPERTY_VALUE6, 
		   --CONCAT('Less Exemptions              ',FORMAT([FACT].[General Exemptions Value],'N0'),'                    ') AS PROPERTY_VALUE6, 

		   SPACE(1) AS PROPERTY_BOLD_FLAG7, 
           --'X' AS PROPERTY_BOLD_FLAG7, 
           
		   
		   SPACE(35) AS PROPERTY_VALUE7, 
		   --CONCAT(@RollYear,' TAXABLE VALUE       ',FORMAT([FACT].[Total Assessed Value]-[FACT].[General Exemptions Value],'C0'),'                    ') AS PROPERTY_VALUE7, 


           SPACE(1) AS PROPERTY_BOLD_FLAG8, 
           SPACE(35) AS PROPERTY_VALUE8, 
           SPACE(1) AS PROPERTY_BOLD_FLAG9, 
           SPACE(35) AS PROPERTY_VALUE9, 
           SPACE(1) AS PROPERTY_BOLD_FLAG10, 
           SPACE(35) AS PROPERTY_VALUE10, 
           SPACE(1) AS PROPERTY_BOLD_FLAG11, 
           SPACE(35) AS PROPERTY_VALUE11, 
           SPACE(1) AS PROPERTY_BOLD_FLAG12, 
           SPACE(35) AS PROPERTY_VALUE12, 
           SPACE(1) AS PROPERTY_BOLD_FLAG13, 
           SPACE(35) AS PROPERTY_VALUE13, 
           SPACE(1) AS PROPERTY_BOLD_FLAG14, 
           SPACE(35) AS PROPERTY_VALUE14, 
           SPACE(1) AS PROPERTY_BOLD_FLAG15, 
           SPACE(35) AS PROPERTY_VALUE15, 
           SPACE(1) AS PROPERTY_BOLD_FLAG16, 
           SPACE(35) AS PROPERTY_VALUE16, 

           ' ' AS ADDITIONAL_BOLD_FLAG1, 
           SPACE(61)  AS ADDITIONAL_INFO1, 
           ' ' AS ADDITIONAL_BOLD_FLAG2, 
           SPACE(61) AS ADDITIONAL_INFO2, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG3, 
		   SPACE(94)  AS ADDITIONAL_INFO3, 
           --SPACE(55)  AS ADDITIONAL_INFO3, 
           'X' AS ADDITIONAL_BOLD_FLAG4,

		   CONCAT('Your property value has changed due to sales activity in your         ','') AS ADDITIONAL_INFO4, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG5, 
           CONCAT('area. Visit bcassessment.ca to review sales in your area.              ','') AS ADDITIONAL_INFO5, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG6, 
           SPACE(61) AS ADDITIONAL_INFO6, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG7, 
           SPACE(61) AS ADDITIONAL_INFO7, 

		    
          
		   --CONCAT('The average change for your property class is ','+5%,',' and your           ') AS ADDITIONAL_INFO4, 
     --      SPACE(1) AS ADDITIONAL_BOLD_FLAG5, 
     --      CONCAT('property changed by +',REPLACE(FORMAT(ISNULL(([FACT].[Total Assessed Value]-[Previous Year1 Total Assessed Value])/[Previous Year1 Total Assessed Value], 0), 'P0'), ' %', '%'),'.  Please visit                               ') AS ADDITIONAL_INFO5, 
     --      SPACE(1) AS ADDITIONAL_BOLD_FLAG6, 
     --      'bcassessment.ca/propertytax to learn about what this means for        ' AS ADDITIONAL_INFO6, 
     --      SPACE(1) AS ADDITIONAL_BOLD_FLAG7, 
     --      'your property taxes.                                                  ' AS ADDITIONAL_INFO7, 


           SPACE(1) AS ADDITIONAL_BOLD_FLAG8, 
           SPACE(61) AS ADDITIONAL_INFO8, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG9, 
           SPACE(61) AS ADDITIONAL_INFO9, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG10, 
           SPACE(61) AS ADDITIONAL_INFO10, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG11, 
           SPACE(61) AS ADDITIONAL_INFO11, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG12, 
           SPACE(61) AS ADDITIONAL_INFO12, 
           SPACE(1) AS ADDITIONAL_BOLD_FLAG13, 

		   SPACE(76) AS ADDITIONAL_INFO13,
           --SPACE(58) AS ADDITIONAL_INFO13,
           CONCAT([AOL].[Line1], SPACE(59-LEN(ISNULL([AOL].[Line1], ''))), [AOL].[Line2], SPACE(59-LEN(ISNULL([AOL].[Line2], ''))), [AOL].[Line3], SPACE(59-LEN(ISNULL([AOL].[Line3], '')))) AS [Your Assessment Office Address], 
           CONCAT([PR].[Area Code], '-', [BSD].[School District Code], '-', [PR].[Jurisdiction Code], '-', CONCAT(SUBSTRING([PR].[Roll Number], 1, 5), '.', SUBSTRING([PR].[Roll Number], 6, 7)), SPACE(59-(LEN([PR].[Roll Number])+1)-10)) AS [Folio  Info], 
--CONCAT([AOL].[Line4], SPACE(59-LEN(ISNULL([AOL].[Line4], '')))) AS [Phone Numbers], 
--CONCAT([AOL].[Line5], SPACE(59-LEN(ISNULL([AOL].[Line5], '')))) AS [Fax Number], 
--CONCAT([AOL].[Line6], SPACE(59-LEN(ISNULL([AOL].[Line6], '')))) AS [Email Address], 
           SPACE(59) AS [Phone Numbers], 
           SPACE(59) AS [Fax Number], 
           SPACE(59) AS [Email Address], 
           CONCAT(IIF(LEN([Owner 1 Name])>0, [Owner 1 Name], [Company Name]), SPACE(35-LEN(IIF(LEN([Owner 1 Name])>0, [Owner 1 Name], [Company Name]))), ISNULL([Owner 2 Name], ''), SPACE(59-LEN(ISNULL([Owner 2 Name], '')))) AS [Owner Names], 
           [dbo].[FN_GetAllAddressLines]([ADD].[dimCity_BK], [ADD].[dimCountry_BK], NULL, [ADD].[dimStreetDirection_BK], '', [ADD].[dimProvince_BK], [ADD].[Address Street Name], [ADD].[Street Number], [ADD].[dimStreetType_BK], [ADD].[Address Unit], [ADD].[Floor Number], [BAD].[Care Of], [ADD].[Attention], [ADD].[Site], [ADD].[Compartment], [ADD].[Delivery Mode Desc], [ADD].[Delivery Mode Value], '', '') AS [Mail Address], 
           CONCAT(SPACE(1), 'X', SPACE(13)) AS [OMR Marks], 
           @UniqueID AS [Unique ID], 
           CONCAT(
		   SPACE(17-LEN(ISNULL(FORMAT([FACT].[Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([FACT].[Total Assessed Value], 'C0', 'en-US'),
		   SPACE(17-LEN(ISNULL(FORMAT([Previous Year1 Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([Previous Year1 Total Assessed Value], 'C0', 'en-US'), 
		   SPACE(17-LEN(ISNULL(FORMAT([Previous Year2 Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([Previous Year2 Total Assessed Value], 'C0', 'en-US'), 
		   SPACE(17-LEN(ISNULL(FORMAT([Previous Year3 Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([Previous Year3 Total Assessed Value], 'C0', 'en-US'), 
		   SPACE(17-LEN(ISNULL(FORMAT([Previous Year4 Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([Previous Year4 Total Assessed Value], 'C0', 'en-US') --, 
		   --SPACE(17-LEN(ISNULL(FORMAT([Previous Year5 Total Assessed Value], 'C0', 'en-US'), ''))), FORMAT([Previous Year5 Total Assessed Value], 'C0', 'en-US')
		   ) AS [PREV_VALUE_SET], 
           SPACE(10) AS [EPIN Or Related Pin Number], 
           CONCAT(
		   SPACE(IIF(([FACT].[Total Assessed Value]-[Previous Year1 Total Assessed Value])/[Previous Year1 Total Assessed Value] > 0, 10, 11)-LEN(FORMAT(ISNULL(([FACT].[Total Assessed Value] - [Previous Year1 Total Assessed Value]) / [Previous Year1 Total Assessed Value], 0), 'P0'))), 
		   IIF(([FACT].[Total Assessed Value] - [Previous Year1 Total Assessed Value]) / [Previous Year1 Total Assessed Value] = 0, '+', ''), REPLACE(FORMAT(ISNULL(([FACT].[Total Assessed Value] - [Previous Year1 Total Assessed Value]) / [Previous Year1 Total Assessed Value], 0), 'P0'), ' %', '%'), 
		   SPACE(IIF(([Previous Year1 Total Assessed Value]-[Previous Year2 Total Assessed Value])/[Previous Year2 Total Assessed Value] > 0, 10, 11)-LEN(FORMAT(ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value]) / [Previous Year2 Total Assessed Value], 0), 'P0'))), 
		   IIF(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value]) / [Previous Year2 Total Assessed Value] > 0, '+', ''), REPLACE(FORMAT(ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value]) / [Previous Year2 Total Assessed Value], 0), 'P0'), ' %', '%'), 
		   SPACE(IIF(([Previous Year2 Total Assessed Value]-[Previous Year3 Total Assessed Value])/[Previous Year3 Total Assessed Value] > 0, 10, 11)-LEN(FORMAT(ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value]) / [Previous Year3 Total Assessed Value], 0), 'P0'))), 
		   IIF(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value]) / [Previous Year3 Total Assessed Value] > 0, '+', ''), REPLACE(FORMAT(ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value]) / [Previous Year3 Total Assessed Value], 0), 'P0'), ' %', '%'), 
		   SPACE(IIF(([Previous Year3 Total Assessed Value]-[Previous Year4 Total Assessed Value])/[Previous Year4 Total Assessed Value] > 0, 10, 12)-LEN(FORMAT(ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value]) / [Previous Year4 Total Assessed Value], 0), 'P0'))), 
		   IIF(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value]) / [Previous Year4 Total Assessed Value] > 0, '+', ''), REPLACE(FORMAT(ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value]) / [Previous Year4 Total Assessed Value], 0), 'P0'), ' %', '%'), 
		   SPACE(IIF(([Previous Year4 Total Assessed Value]-[Previous Year5 Total Assessed Value])/[Previous Year5 Total Assessed Value] > 0, 10, 11)-LEN(FORMAT(ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value]) / [Previous Year5 Total Assessed Value], 0), 'P0'))), 
		   IIF(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value]) / [Previous Year5 Total Assessed Value] > 0, '+', ''), REPLACE(FORMAT(ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value]) / [Previous Year5 Total Assessed Value], 0), 'P0'), ' %', '%')
		   ) AS [PCT_CHANGE_SET], 
           CONCAT([AG].[Area Desc], SPACE(30-LEN([AG].[Area Desc]))) AS [AREA_NAME], 
           CONCAT([BSD].[School District Desc], SPACE(30-LEN([BSD].[School District Desc]))) AS [SD_NAME], 
           CONCAT([AG].[Neighbourhood Desc], SPACE(50-LEN([AG].[Neighbourhood Desc]))) AS [NEIGH_NAME], 
           'N' AS [INSERT_1_YN], 
           'N' AS [INSERT_2_YN], 
           'N' AS [INSERT_3_YN], 
           'N' AS [INSERT_4_YN], 
           SPACE(50) AS [PDF_File_Name], 
           IIF(CHARINDEX([PD].[Property Class Code List], ',') > 0, '', CONCAT(SPACE(10-LEN(REPLACE(FORMAT(((ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value]) / [Previous Year2 Total Assessed Value], 0) + ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value]) / [Previous Year3 Total Assessed Value], 0) + ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value]) / [Previous Year4 Total Assessed Value], 0) + ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value]) / [Previous Year5 Total Assessed Value], 0)) / 4), 'P0'), ' %', '%'))), REPLACE(FORMAT(((ISNULL(([Previous Year1 Total Assessed Value] - [Previous Year2 Total Assessed Value]) / [Previous Year2 Total Assessed Value], 0) + ISNULL(([Previous Year2 Total Assessed Value] - [Previous Year3 Total Assessed Value]) / [Previous Year3 Total Assessed Value], 0) + ISNULL(([Previous Year3 Total Assessed Value] - [Previous Year4 Total Assessed Value]) / [Previous Year4 Total Assessed Value], 0) + ISNULL(([Previous Year4 Total Assessed Value] - [Previous Year5 Total Assessed Value]) / [Previous Year5 Total Assessed Value], 0)) / 4), 'P0'), ' %', '%'))) AS [AVERAGE PERCENT]
    FROM [edw].[FactRollSummary] AS [FACT]
         INNER JOIN [edw].[FactAssessedValue] AS [FACT2]
         ON [FACT].[dimFolio_SK] = [FACT2].[dimFolio_SK]
		 LEFT JOIN [edw].[dimManualClass] AS [MC] ON [FACT].[dimManualClass_SK] = [MC].[dimManualClass_SK]
         LEFT JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FACT].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
         LEFT JOIN [edw].[dimProperty] AS [PR] ON [FACT].[dimProperty_SK] = [PR].[dimProperty_SK]
		 LEFT JOIN [edw].[dimActualUse] AS [AU] ON [PR].[dimActualUse_SK] = [AU].[dimActualUse_SK]
         LEFT JOIN [edw].[dimPropertyClass] AS [PC] ON [FACT2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
		 LEFT JOIN [edw].[bridgeOwnerFolioAddress] AS [BAD] ON [BAD].[dimProperty_SK] = [PR].[dimProperty_SK]
		 --LEFT JOIN [edw].[edw].[bridgeNameAddress] AS [BNA] ON [BNA].[dimAddress_SK] = [BAD].[dimAddress_SK]
		 LEFT JOIN [edw].[dimPropertyAllOwners] AS [PAO] ON [FACT].[dimProperty_SK] = [PAO].[dimProperty_SK]
         LEFT JOIN [edw].[bridgeJurisdictionSchoolDistrict] AS [BSD] ON [BSD].[dimJurisdiction_SK] = [PR].[dimJurisdiction_SK]
         LEFT JOIN [edw].[dimPropertyDetails] AS [PD] ON [PD].[dimProperty_SK] = [PR].[dimProperty_SK]
         LEFT JOIN [edw].[dimAddress] AS [ADD] ON [ADD].[dimAddress_SK] = [BAD].[dimAddress_SK]
         LEFT JOIN [EDW].[edw].[dimPropertyOwnerAddresses] AS [POA] ON [POA].[dimProperty_SK] = [PR].[dimProperty_SK]
                                                                       AND [POA].[dimRollYear_SK] = @RollYear
         LEFT JOIN [edw].[dimAssessmentOfficeAddressLines] [AOL] ON [AOL].[dimArea_SK] = [AG].[dimArea_SK]
                                                                    AND [AOL].[Roll Year] = @RollYear
    WHERE [FACT].[Roll Year] = @RollYear
          AND [PR].[Area Code] = '01'
          AND [PR].[Jurisdiction Code] = '213'
		  AND [AG].[Neighbourhood Code] = '213108'
		  AND [AU].[Actual Use Code] = '000'
		  AND [MC].[Manual Class Code] = '0140'    
  
		  
		  --AND [PR].[Roll Number] = '03503030'  -- AND [postal code] is not null
) AS ASSESSMENT_DATA
ORDER BY [ROWNUM]

--AND [BAD].[Bulk Code] IS NOT NULL
--AND [BAD].[PIN Number] IS NOT NULL;