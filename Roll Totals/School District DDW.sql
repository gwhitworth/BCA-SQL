DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT [dimSchoolDistrict_SK], 
       [dimSchoolDistrict_BK], 
       [dimRollYear_SK], 
       [Roll Year], 
       IIF([School District] = 'Unknown','Not Applicable',[School District]) AS [School District],
       [School  District Code], 
       [School District Desc], 
       [RowSortOrder]
FROM [EDW].[edw].[dimSchoolDistrict]
WHERE [dimRollYear_SK] = @p_RY
      OR [dimSchoolDistrict_SK] = -3
ORDER BY [RowSortOrder] DESC, 
         [School  District Code];