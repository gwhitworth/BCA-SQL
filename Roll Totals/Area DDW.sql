DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_BY = 'RD';
IF @p_BY = 'RD'
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
        UNION
        SELECT NULL, 
               'NA', 
               'Not Applicable', 
               'Not Applicable', 
               999
        ORDER BY [RowSortOrder] DESC, 
                 [Area Code];
    END;
    ELSE
    BEGIN
        SELECT NULL AS [dimArea_SK], 
               'NA' AS [Area Code], 
               'Not Applicable' AS [Area Desc], 
               'Not Applicable' AS [Area], 
               999 AS [RowSortOrder];
    END;