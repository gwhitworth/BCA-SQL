DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT dimRegionalDistrict_SK, 
       dimRegionalDistrict_BK, 
       dimRollYear_SK, 
       [Roll Year], 
       [Regional District], 
       [Regional District Code], 
       [Regional District Desc], 
       IIF([Regional District Code] = 'XX', 999,RowSortOrder) AS [RowSortOrder]
FROM edw.dimRegionalDistrict
WHERE([Roll Year] = @p_RY)
     AND (NOT([Regional District Code] IN('00', '88', '99')))
UNION 
SELECT NULL AS dimRegionalDistrict_SK, 
       NULL AS dimRegionalDistrict_BK, 
       NULL AS dimRollYear_SK, 
       NULL AS [Roll Year], 
       'Provincial Totals' AS [Regional District], 
       'PROV' AS [Regional District Code], 
       'Provincial Totals' AS [Regional District Desc], 
       998 AS RowSortOrder
ORDER BY RowSortOrder;