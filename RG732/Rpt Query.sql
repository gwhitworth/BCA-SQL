DECLARE @PropConvFactBy INT
SET @PropConvFactBy = 1000
SELECT DISTINCT
[PR].[Roll Number] AS [Roll Number],
[BRD].[Regional District Code] AS [Regional District],
[BRD].[Electoral District Code] AS [Electorial Area Code],
'General Net Taxable (Land) is greater than $1,000,000,000' AS [Msg Text],
[Net General Land Value] AS [Gen Net - Land],
[Net General Building Value] AS [Gen Net - Impr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimProperty_SK] = [PC].[dimPropertyClass_SK]
	 INNER JOIN [edw].[dimProperty] AS [PR] ON [PR].dimProperty_SK = [FA].dimProperty_SK
	 LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [BRD] ON [BRD].dimJurisdiction_SK = [FA].dimJurisdiction_SK
WHERE [Net General Land Value] * ([PC].[Property Conversion Factor] / @PropConvFactBy) > 1000000
UNION
SELECT DISTINCT
[PR].[Roll Number] AS [Roll Number],
[BRD].[Regional District Code] AS [Regional District],
[BRD].[Electoral District Code] AS [Electorial Area Code],
'General Net Taxable (Impr) is greater than $1,000,000,000' AS [Msg Text],
[Net General Land Value] AS [Gen Net - Land],
[Net General Building Value] AS [Gen Net - Impr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimProperty_SK] = [PC].[dimPropertyClass_SK]
	 INNER JOIN [edw].[dimProperty] AS [PR] ON [PR].dimProperty_SK = [FA].dimProperty_SK
	 LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [BRD] ON [BRD].dimJurisdiction_SK = [FA].dimJurisdiction_SK
WHERE [Net General Building Value] * ([PC].[Property Conversion Factor] / @PropConvFactBy) > 1000000
UNION
SELECT DISTINCT
[PR].[Roll Number] AS [Roll Number],
[BRD].[Regional District Code] AS [Regional District],
[BRD].[Electoral District Code] AS [Electorial Area Code],
'Hospital Net Taxable (Land) is greater than $1,000,000,000' AS [Msg Text],
[Net Other Land Value] AS [Hsp Net - Land],
[Net Other Building Value] AS [Hsp Net - Impr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimProperty_SK] = [PC].[dimPropertyClass_SK]
	 INNER JOIN [edw].[dimProperty] AS [PR] ON [PR].dimProperty_SK = [FA].dimProperty_SK
	 LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [BRD] ON [BRD].dimJurisdiction_SK = [FA].dimJurisdiction_SK
WHERE [Net Other Building Value] * ([PC].[Property Conversion Factor] / @PropConvFactBy) > 1000000
UNION
SELECT DISTINCT
[PR].[Roll Number] AS [Roll Number],
[BRD].[Regional District Code] AS [Regional District],
[BRD].[Electoral District Code] AS [Electorial Area Code],
'Hospital Net Taxable (Impr) is greater than $1,000,000,000' AS [Msg Text],
[Net Other Land Value] AS [Hsp Net - Land],
[Net Other Building Value] AS [Hsp Net - Impr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimProperty_SK] = [PC].[dimPropertyClass_SK]
	 INNER JOIN [edw].[dimProperty] AS [PR] ON [PR].dimProperty_SK = [FA].dimProperty_SK
	 LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [BRD] ON [BRD].dimJurisdiction_SK = [FA].dimJurisdiction_SK
WHERE [Net Other Building Value] * ([PC].[Property Conversion Factor] / @PropConvFactBy) > 1000000
UNION
SELECT DISTINCT 
       [PR].[Roll Number] AS [Roll Number], 
       [BRD].[Regional District Code] AS [Regional District], 
       [BRD].[Electoral District Code] AS [Electorial Area Code], 
       'Electoral area is missing for rural jurisdiction' AS [Msg Text], 
       SUM([Net Other Land Value]) AS [Hsp Net - Land], 
       SUM([Net Other Building Value]) AS [Hsp Net - Impr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimProperty_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimProperty] AS [PR]
     ON [PR].[dimProperty_SK] = [FA].[dimProperty_SK]
     LEFT OUTER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [BRD]
     ON [BRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
     LEFT OUTER JOIN [edw].[dimJurisdiction] AS [JR]
     ON [JR].[dimJurisdiction_SK] = [BRD].[dimJurisdiction_SK]
     LEFT OUTER JOIN [edw].[dimJurisdictionType] AS [JT]
     ON [JT].[dimJurisdictionType_SK] = [JR].[dimJurisdictionType_SK]
        AND [JR].[dimJurisdiction_BK] = 'R'
WHERE [BRD].[Electoral District Code] IS NULL
GROUP BY [PR].[Roll Number], 
         [BRD].[Regional District Code], 
         [BRD].[Electoral District Code]
ORDER BY [Roll Number],[BRD].[Regional District Code],[Electoral District Code]
