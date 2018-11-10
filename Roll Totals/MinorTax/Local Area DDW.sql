/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @p_RY INT;
DECLARE @p_MTC CHAR(2);
DECLARE @p_MT VARCHAR(50);
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_MTC = 'ID';
SET @p_RD = '03';
SET @p_MT = 'Denman Island Local Trust Area'

--SELECT DISTINCT 
--       *
--FROM [EDW].[edw].[dimMinorTaxCode]
--WHERE [Roll Year] = @p_RY
--      AND [Minor Tax Category Code] LIKE '%LA%'
--ORDER BY [Minor Tax Desc];

--SELECT DISTINCT [dimJurisdiction_SK]
--      ,[dimJurisdiction_BK]
--      ,[Jurisdiction Code]
--      ,[Jurisdiction Desc]
--      ,[Jurisdiction]
--      ,[RowSortOrder]
--  FROM [EDW].[edw].[dimMinorTaxCode]
--WHERE [Roll Year] = @p_RY
--      AND [Minor Tax Desc] = @p_MT
--  ORDER BY [RowSortOrder],[Jurisdiction Code]


SELECT DISTINCT 
       [Minor Tax Desc]
FROM [EDW].[edw].[dimMinorTaxCode]
WHERE [Roll Year] = @p_RY
      AND ([Minor Tax Category Code] = @p_MTC
      AND [Minor Tax Desc] LIKE '% Trust Area%')
	  OR [Minor Tax Category Code] = @p_MTC
ORDER BY [Minor Tax Desc];