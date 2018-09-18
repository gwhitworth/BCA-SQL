/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [dimPropertyClass_SK]
      ,[dimPropertyClass_BK]
      ,[dimRollYear_SK]
      ,[Roll Year]
      ,[Property Class Code]
      ,[Property Class Desc]
      ,[Property Class]
      ,[Property Class Short Name]
      ,[Property Sub Class Code]
      ,[Property Sub Class]
      ,[Property Sub Class Desc]
      ,[Property Conversion Factor]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimPropertyClass]
  where [Roll Year] = 2017