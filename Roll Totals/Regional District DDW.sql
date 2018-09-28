DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT dimRegionalDistrict_SK, 
       dimRegionalDistrict_BK, 
       dimRollYear_SK, 
       [Roll Year], 
       [Regional District], 
       [Regional District Code], 
       [Regional District Desc], 
       [RowSortOrder]
FROM edw.dimRegionalDistrict
WHERE([Roll Year] = @p_RY)
     AND (NOT([Regional District Code] IN('00', '88', '99', 'XX')))
UNION
SELECT NULL, 
       NULL, 
       NULL, 
       @p_RY, 
       'Provincial Totals' AS [Regional District], 
       'PROV' AS [Regional District Code], 
       'Provincial Totals' AS [Regional District Desc], 
       -1 AS RowSortOrder
UNION
SELECT NULL, 
       NULL, 
       NULL, 
       @p_RY, 
       'Regional District Provincial Totals' AS [Regional District], 
       'RDPROV' AS [Regional District Code], 
       'Regional District Provincial Totals' AS [Regional District Desc], 
       -2 AS RowSortOrder
UNION
SELECT NULL, 
       NULL, 
       NULL, 
       @p_RY, 
       'Not Applicable' AS [Regional District], 
       'NA' AS [Regional District Code], 
       'Not Applicable' AS [Regional District Desc], 
       -3 AS RowSortOrder
ORDER BY RowSortOrder, 
         [Regional District Code];

