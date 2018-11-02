
/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @p_RY INT;
DECLARE @p_MTC CHAR(2);
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_MTC = 'DE';
SET @p_RD = '03';
SELECT DISTINCT 
       [Roll Year], 
       [Regional District Code], 
       [BCA Code]+' - '+[Minor Tax Desc] AS [Minor Tax Label], 
       [Minor Tax Desc], 
       [RowSortOrder]
FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
WHERE [Roll Year] = @p_RY
      AND [Minor Tax Category Code] = @p_MTC
      AND [Regional District Code] = @p_RD
ORDER BY [Minor Tax Label];

SELECT [Minor Tax Code]
FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
WHERE [Roll Year] = @p_RY
      AND [Minor Tax Desc] = 'Saturna Recreation Prog DA#8';

SELECT [Minor Tax Code]
FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
WHERE [Roll Year] = @p_RY
      AND [Minor Tax Desc] = 'Mayne Recreation Prog DA#9';
