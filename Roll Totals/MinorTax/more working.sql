/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT
      [Minor Tax Category Code]
      ,[Minor Tax Category Desc]
      ,[Minor Tax Category]
      ,[Jurisdiction Code]
      ,[Jurisdiction Desc]
      ,[Jurisdiction]
      ,[Regional District Code]
      ,[Regional District Desc]
      ,[Regional District]
  FROM [EDW].[edw].[dimMinorTaxCode]
  WHERE [Minor Tax Category Code] = 'ID'