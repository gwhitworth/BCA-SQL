DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
DECLARE @p_JR2 CHAR(3);
DECLARE @p_TYPE CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '001';
SET @p_JR2 = '001';
SET @p_TYPE = 'AR';
IF @p_TYPE = 'RD'
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
              AND [Jurisdiction Code] IN(@p_JR2)
        ORDER BY [RowSortOrder], 
                 [Jurisdiction Code];
    END;
    ELSE
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
              AND [Jurisdiction Code] IN(@p_JR)
        ORDER BY [RowSortOrder], 
                 [Jurisdiction Code];
    END;