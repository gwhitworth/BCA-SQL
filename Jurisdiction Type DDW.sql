DECLARE @RptType char(2)
SET @RptType = 'SD'

IF @RptType = 'SD'
BEGIN
SELECT [dimJurisdictionType_SK]
      ,[dimJurisdictionType_BK]
      ,[Jurisdiction Type]
      ,[Jurisdiction Type Code]
      ,[Jurisdiction Type Desc]
      ,[RowSortOrder]
  FROM [EDW].[edw].[dimJurisdictionType]
  WHERE [dimJurisdictionType_SK] > 0
  ORDER BY [RowSortOrder], [Jurisdiction Type Code]
END
ELSE
BEGIN
SELECT NULL AS [Jurisdiction Type Code]
      ,'N/A' AS [Jurisdiction Type Desc]
END