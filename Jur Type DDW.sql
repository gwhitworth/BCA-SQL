/****** Script for SelectTopNRows command from SSMS  ******/
SELECT[dimJurisdictionType_SK]
      ,[dimJurisdictionType_BK]
      ,[Jurisdiction Type]
      ,[Jurisdiction Type Code]
      ,[Jurisdiction Type Desc]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimJurisdictionType]
  WHERE [Jurisdiction Type Code] IN ('C','D','T','V','R')
  ORDER BY [Jurisdiction Type Desc]