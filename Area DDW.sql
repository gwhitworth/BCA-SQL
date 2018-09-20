
/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @p_RY AS INT;
SET @p_RY = 2017;
SELECT [dimArea_SK], 
       [dimArea_BK], 
       [dimRollYear_SK], 
       [dimRegion_SK], 
       [Area], 
       [Area Code], 
       [Area Desc], 
       [Roll Year], 
       [RowSortOrder]
FROM [EDW].[edw].[dimArea]
WHERE [Roll Year] = @p_RY
      AND [Area Code] BETWEEN 01 AND 27
ORDER BY [Area Code];