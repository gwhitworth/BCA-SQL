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
SET @p_TYPE = 'RD';
IF @p_TYPE = 'RD'
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