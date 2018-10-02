DECLARE @p_RY INT;
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_BY = 'RF';
IF @p_BY = 'RD'
    BEGIN
        SELECT dimRegionalDistrict_SK, 
               dimRegionalDistrict_BK, 
               [Roll Year], 
               [Regional District], 
               [Regional District Code], 
               [Regional District Desc], 
               [RowSortOrder]
        FROM edw.dimRegionalDistrict
        WHERE([Roll Year] = @p_RY)
             AND (NOT([Regional District Code] IN('00', '88', '99', 'XX')))
        UNION
        SELECT -1, 
               'PROV', 
               @p_RY, 
               'Provincial Totals' AS [Regional District], 
               'PROV' AS [Regional District Code], 
               'Provincial Totals' AS [Regional District Desc], 
               -1 AS RowSortOrder
    END;
    ELSE
    BEGIN
        SELECT -1 AS dimRegionalDistrict_SK, 
               'NA' AS dimRegionalDistrict_BK, 
               @p_RY, 
               'Not Applicable' AS [Regional District], 
               'NA' AS [Regional District Code], 
               'Not Applicable' AS [Regional District Desc], 
               -1 AS RowSortOrder;
    END;