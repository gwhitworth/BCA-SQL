SELECT [dimMinorTaxCategory_SK], 
       [dimMinorTaxCategory_BK], 
       [Project Number Prefix], 
       [Minor Tax Category Code], 
       [Minor Tax Category Desc], 
       [Minor Tax Category], 
       [RowSortOrder]
FROM [EDW].[edw].[dimMinorTaxCategory]
WHERE [dimMinorTaxCategory_SK] > 0
      AND [Minor Tax Category Code] IN('GS', 'IT', 'ID', 'SA', 'LA')
ORDER BY [Minor Tax Category Code];