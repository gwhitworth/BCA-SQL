SELECT TOP (200) dbo.dimAssessmentGeographyTbl.[Roll Year] AS Expr18, 
                 dbo.dimAssessmentGeographyTbl.[Jurisdiction Code] AS Expr22, 
                 dbo.dimAssessmentGeographyTbl.[Area Code] AS Expr28, 
                 dbo.dimPropertyTbl.[Roll Number], 
                 dbo.bridgeJurisdictionSchoolDistrictTbl.[School District Code], 
                 dbo.dimPropertyTbl.[SITUS Street Number], 
                 dbo.dimPropertyTbl.[SITUS Building/Unit Number], 
                 dbo.dimPropertyTbl.[SITUS Street Direction], 
                 dbo.dimPropertyTbl.[SITUS Address Street Name], 
                 dbo.dimManualClassTbl.[Manual Class Code], 
                 dbo.dimAssessmentGeographyTbl.[Neighbourhood Code], 
                 dbo.bridgeJurisdictionRegionalDistrictElectoralDistrictTbl.[Electoral District Code], 
                 dbo.dimActualUseTbl.[Actual Use Code], 
                 dbo.FactAssessedValueTbl.[Property Class Code]
FROM dbo.dimAssessmentGeographyTbl
     INNER JOIN dbo.dimPropertyTbl ON dbo.dimAssessmentGeographyTbl.dimAssessmentGeography_SK = dbo.dimPropertyTbl.dimAssessmentGeography_SK
     INNER JOIN dbo.bridgeJurisdictionSchoolDistrictTbl ON dbo.dimPropertyTbl.dimJurisdiction_SK = dbo.bridgeJurisdictionSchoolDistrictTbl.dimJurisdiction_SK
     INNER JOIN dbo.bridgeJurisdictionRegionalDistrictElectoralDistrictTbl ON dbo.dimAssessmentGeographyTbl.dimJurisdiction_SK = dbo.bridgeJurisdictionRegionalDistrictElectoralDistrictTbl.dimJurisdiction_SK
     INNER JOIN dbo.FactAssessedValueTbl ON dbo.dimAssessmentGeographyTbl.dimAssessmentGeography_SK = dbo.FactAssessedValueTbl.dimAssessmentGeography_SK
     INNER JOIN dbo.dimManualClassTbl ON dbo.FactAssessedValueTbl.dimManualClass_SK = dbo.dimManualClassTbl.dimManualClass_SK
     INNER JOIN dbo.dimActualUseTbl ON dbo.FactAssessedValueTbl.dimActualUse_SK = dbo.dimActualUseTbl.dimActualUse_SK;