DECLARE @p_RY INT;
SET @p_RY = 2017;
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
         [Amalgamation Desc];