DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_TYPE CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_TYPE = 'AR';
IF @p_TYPE = 'AR'
    BEGIN
        SELECT DISTINCT 
               [dimArea_SK], 
               [Area Code], 
               [Area Desc], 
               [Area], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimAssessmentGeography]
        WHERE [Roll Year] = @p_RY
              AND [Area Code] BETWEEN 01 AND 27
    END;
    ELSE
    BEGIN
        SELECT -1 AS [dimArea_SK], 
               'NA' AS [Area Code], 
               'Not Applicable' AS [Area Desc], 
               'Not Applicable' AS [Area], 
               999 AS [RowSortOrder];
    END;