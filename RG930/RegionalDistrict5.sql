DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [Regional District Code]
FROM edw.dimRegionalDistrict
WHERE([Roll Year] = @p_RY)
     AND ([Regional District Code] IN('03', '15'));