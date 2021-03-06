DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT [Region Hospital District], 
       [Region Hospital District Code], 
       [Region Hospital District Desc], 
       [RowSortOrder]
FROM [EDW].[edw].[dimRegionalHospitalDistrict]
WHERE [Roll Year] = @p_RY
      AND [Region Hospital District Code] BETWEEN '01' AND '40'
ORDER BY [Region Hospital District Code];