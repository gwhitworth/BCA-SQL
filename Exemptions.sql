/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [dimTaxExemptions_SK]
      ,[dimRollYear_SK]
      ,[Roll Year]
      ,[dimTaxExemptions_BK]
      ,[Exempt Tax]
      ,[Exempt Tax Code]
      ,[Exempt Tax Desc]
      ,[Exempt Value Code]
      ,[Group Number]
      ,[Exemption Group Type]
      ,[Permissive Municipal]
      ,[Permissive Rural]
      ,[Statutory Municipal]
      ,[Statutory Rural]
      ,[Value Code]
      ,[RowCurrentYN]
      ,[RowEffectiveDtm]
      ,[RowExpiryDtm]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimTaxExemptions]
  --where [Roll Year] = 2017
  --where [Exempt Tax] like '%transit%' and [Roll Year] = 2017
  where [Exempt Tax] like '%bc hydro%' and [Roll Year] = 2017