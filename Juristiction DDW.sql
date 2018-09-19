DECLARE @p_RY INT;
SET @p_RY = 2017;
SELECT dimJurisdiction_SK, 
       dimJurisdiction_BK, 
       dimArea_SK, 
       dimRollYear_SK, 
       dimJurisdictionType_SK, 
       [Jurisdiction Code], 
       [Jurisdiction Desc], 
       Jurisdiction, 
       Amalgamation, 
       [Amalgamation Code], 
       [Amalgamation Desc], 
       RowSortOrder
FROM edw.dimJurisdiction
WHERE(dimRollYear_SK = @p_RY)
     AND ([Jurisdiction Code] > '199')
ORDER BY [Jurisdiction Code];