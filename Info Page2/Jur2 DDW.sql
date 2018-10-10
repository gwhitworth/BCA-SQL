DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_BY CHAR(2);
DECLARE @p_RD VARCHAR(255);
DECLARE @p_TYPE CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_RD = '01';
SET @p_TYPE = 'AR';
IF @p_TYPE = 'RD'
    BEGIN
        SELECT DISTINCT 
               [AG].[Area Code], 
               [dimJurisdiction_SK], 
               [dimJurisdiction_BK], 
               [AG].[Jurisdiction Code], 
               [Jurisdiction Desc], 
               [Jurisdiction], 
               [AG].[RowSortOrder], 
               [RD].[Regional District Code]
        FROM [edw].[FactAllAssessedAmounts] AS [FA]
             INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
             ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
             INNER JOIN [edw].[dimPropertyClass] AS [PC]
             ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
             INNER JOIN [edw].[dimFolio] AS [FO]
             ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                AND [FO].[Folio Status Code] = '01'
             INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
             ON [FO].[dimRegionalDistrict_SK] = [RD].[dimRegionalDistrict_SK]
        WHERE [AG].[Roll Year] = @p_RY
              AND [RD].[Regional District Code] = @p_RD
AND [AG].[Jurisdiction Code] > '199'
        ORDER BY [RowSortOrder], 
                 [Jurisdiction Code];
    END;
    ELSE
    BEGIN
        SELECT 'NA' AS [Area Code], 
               -3 AS [dimJurisdiction_SK], 
               'NA' AS [dimJurisdiction_BK], 
               'NA' AS [Jurisdiction Code], 
               'Not Applicable' AS [Jurisdiction Desc], 
               'Not Applicable' AS [Jurisdiction], 
               -999 AS [RowSortOrder];
    END;