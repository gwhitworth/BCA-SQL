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
IF @p_TYPE = 'AR'
    BEGIN
        SELECT DISTINCT 
               [Area Code], 
               [dimJurisdiction_SK], 
               [dimJurisdiction_BK], 
               [Jurisdiction Code], 
               [Jurisdiction Desc], 
               [Jurisdiction], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimAssessmentGeography]
        WHERE [Roll Year] = @p_RY
              AND [Area Code] = @p_AR
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