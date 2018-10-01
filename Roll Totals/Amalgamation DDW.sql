DECLARE @p_RY INT;
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_BY = 'AM';
IF @p_BY = 'AM'
    BEGIN
SELECT DISTINCT 
       [dimArea_SK], 
       [dimJurisdictionType_SK], 
       [Amalgamation], 
       [Amalgamation Code], 
       [Amalgamation Desc], 
       [RowSortOrder]
FROM [EDW].[edw].[dimJurisdiction]
WHERE [Amalgamation Code] IS NOT NULL
      AND [dimRollYear_SK] = @p_RY
UNION
SELECT-1, 
      -3, 
      'Not Applicable', 
      'NA', 
      'Not Applicable', 
      -1
ORDER BY [RowSortOrder], 
         [Amalgamation Desc]
		 END
		 ELSE
		 BEGIN 
SELECT DISTINCT 
       -1 AS [dimArea_SK], 
       -3 AS [dimJurisdictionType_SK], 
       'Not Applicable' AS [Amalgamation], 
       'NA' AS [Amalgamation Code], 
       'Not Applicable' AS [Amalgamation Desc], 
       -1 AS [RowSortOrder]
		 END