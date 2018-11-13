DECLARE @p_RY INT;
DECLARE @p_BY CHAR(2);
DECLARE @p_MTC CHAR(2);
SET @p_RY = 2017;
SET @p_BY = 'MT';
SET @p_MTC = 'DE'
IF @p_BY = 'MT'
    BEGIN
        SELECT [dimMinorTaxCategory_SK], 
               [dimMinorTaxCategory_BK], 
               [Minor Tax Category Code], 
               [Minor Tax Category Desc], 
               [Minor Tax Category], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimMinorTaxCategory]
        WHERE [dimMinorTaxCategory_SK] > 0
        ORDER BY [RowSortOrder], 
                 [Minor Tax Category Code];
    END;
    ELSE
    BEGIN
        SELECT
               -1 AS [dimMinorTaxCategory_SK], 
               'Not Applicable' AS [dimMinorTaxCategory_BK], 
               'Not Applicable' AS [Minor Tax Category], 
               'NA' AS [Minor Tax Category Code], 
               'Not Applicable' AS [Minor Tax Category Desc], 
               -1 AS [RowSortOrder];
    END

IF @p_BY = 'MT'
    BEGIN
	SELECT DISTINCT [RD].[dimRegionalDistrict_SK], 
       [RD].[dimRegionalDistrict_BK], 
       [RD].[dimRollYear_SK], 
       [RD].[Roll Year], 
       [RD].[Regional District], 
       [RD].[Regional District Code], 
       [RD].[Regional District Desc], 
       IIF([RD].[Regional District Code] = 'XX', 999, [RD].[RowSortOrder]) AS [RowSortOrder]
FROM [edw].[dimRegionalDistrict] AS [RD]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [RD].[dimRegionalDistrict_SK] = [MT].[dimRegionalDistrict_SK]
WHERE([RD].[Roll Year] = @p_RY)
     AND [MT].[Minor Tax Category Code] = @p_MTC;
    END;
    ELSE
    BEGIN
        SELECT
               -1 AS [dimMinorTaxCategory_SK], 
               'Not Applicable' AS [dimMinorTaxCategory_BK], 
               'Not Applicable' AS [Minor Tax Category], 
               'NA' AS [Minor Tax Category Code], 
               'Not Applicable' AS [Minor Tax Category Desc], 
               -1 AS [RowSortOrder];
    END






--IF @p_BY = 'SD'
--    BEGIN
--        SELECT [dimSchoolDistrict_SK], 
--               [dimSchoolDistrict_BK], 
--               [Roll Year], 
--               IIF([School District] = 'Unknown', 'Not Applicable', [School District]) AS [School District], 
--               [School District Code], 
--               [School District Desc], 
--               [RowSortOrder]
--        FROM [EDW].[edw].[dimSchoolDistrict]
--        WHERE [dimRollYear_SK] = @p_RY

--        ORDER BY [RowSortOrder] DESC, 
--                 [School District Code];
--    END;
--    ELSE
--    BEGIN
--        SELECT-3 AS [dimSchoolDistrict_SK], 
--              'Not Applicable' AS [dimSchoolDistrict_BK], 
--              @p_RY [Roll Year], 
--              'Not Applicable' AS [School District], 
--              'NA' AS [School District Code], 
--              'Not Applicable' AS [School District Desc], 
--              -999 AS [RowSortOrder];
--    END



	SELECT DISTINCT [RD].[dimRegionalDistrict_SK], 
       [RD].[dimRegionalDistrict_BK], 
       [RD].[dimRollYear_SK], 
       [RD].[Roll Year], 
       [RD].[Regional District], 
       [RD].[Regional District Code], 
       [RD].[Regional District Desc], 
       IIF([RD].[Regional District Code] = 'XX', 999, [RD].[RowSortOrder]) AS [RowSortOrder]
FROM [edw].[dimRegionalDistrict] AS [RD]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [RD].[dimRegionalDistrict_SK] = [MT].[dimRegionalDistrict_SK]
WHERE([RD].[Roll Year] = @p_RY)
     AND [MT].[Minor Tax Category Code] = @p_MTC;




IF @p_BY = 'MT' AND @p_MTC IN ('ID','IT', 'LA')
    BEGIN
        SELECT DISTINCT 
               [BCA Code]+' - '+[Minor Tax Desc] AS [Minor Tax Label], 
               [Minor Tax Desc], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimMinorTaxCode]
        WHERE [Roll Year] = @p_RY
              AND ([Minor Tax Category Code] = @p_MTC
                   AND [Minor Tax Desc] LIKE '% Trust Area%')
              OR [Minor Tax Category Code] = @p_MTC
        ORDER BY [RowSortOrder], 
                 [Minor Tax Label];
    END;
    ELSE
    BEGIN
        SELECT 'Not Applicable' AS [Minor Tax Label], 
               'Not Applicable' AS [Minor Tax Desc], 
               -1 AS [RowSortOrder];
    END;


IF @p_BY = 'MT'
    BEGIN
        SELECT DISTINCT 
               [dimJurisdiction_SK], 
               [dimJurisdiction_BK], 
               [Jurisdiction Code], 
               [Jurisdiction Desc], 
               [Jurisdiction], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimMinorTaxCode]
        WHERE [Roll Year] = @p_RY
              AND [Minor Tax Desc] = @p_MT
        ORDER BY [RowSortOrder], 
                 [Jurisdiction Code];
    END;
    ELSE
    BEGIN
        SELECT-3 AS [dimJurisdiction_SK], 
              'NA' AS [dimJurisdiction_BK], 
              'NA' AS [Jurisdiction Code], 
              'Not Applicable' AS [Jurisdiction Desc], 
              'Not Applicable' AS [Jurisdiction], 
              -999 AS [RowSortOrder];
    END;