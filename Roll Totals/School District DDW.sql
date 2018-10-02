DECLARE @p_RY INT;
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_BY = 'SD';
IF @p_BY = 'SD'
    BEGIN
        SELECT [dimSchoolDistrict_SK], 
               [dimSchoolDistrict_BK], 
               [Roll Year], 
               IIF([School District] = 'Unknown', 'Not Applicable', [School District]) AS [School District], 
               [School  District Code], 
               [School District Desc], 
               [RowSortOrder]
        FROM [EDW].[edw].[dimSchoolDistrict]
        WHERE [dimRollYear_SK] = @p_RY

        ORDER BY [RowSortOrder] DESC, 
                 [School  District Code];
    END;
    ELSE
    BEGIN
        SELECT-3 AS [dimSchoolDistrict_SK], 
              'Not Applicable' AS [dimSchoolDistrict_BK], 
              @p_RY [Roll Year], 
              'Not Applicable' AS [School District], 
              'NA' AS [School  District Code], 
              'Not Applicable' AS [School District Desc], 
              -999 AS [RowSortOrder];
    END