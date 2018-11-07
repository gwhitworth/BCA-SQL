/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [dimRollCycle_SK]
      ,[dimRollCycle_BK]
      ,[Roll Year]
      ,[Roll Entry Transaction Date]
      ,[Cycle Number]
      ,[Roll Entry Run Date]
      ,[Final Roll Flag]
      ,[Preview Roll Flag]
      ,[Cycle Number Sort]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimRollCycle]
  WHERE [Roll Year] = 2017