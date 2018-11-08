DECLARE @p_RY [INT];
DECLARE @p_MTC CHAR(2);
SET @p_RY = 2017;
SET @p_MTC = 'GS';
SELECT DISTINCT [RD].[dimRegionalDistrict_SK], 
       [RD].[dimRegionalDistrict_BK], 
       [RD].[dimRollYear_SK], 
       [RD].[Roll Year], 
       [RD].[Regional District], 
       [RD].[Regional District Code], 
       [RD].[Regional District Desc], 
       IIF([RD].[Regional District Code] = 'XX', 999, [RD].[RowSortOrder]) AS [RowSortOrder]
FROM [edw].[dimRegionalDistrict] AS [RD]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [RD].[dimRegionalDistrict_SK] = [MT].[dimRegionalDistrict_SK]
WHERE([RD].[Roll Year] = @p_RY)
     AND [MT].[Minor Tax Category Code] = @p_MTC;