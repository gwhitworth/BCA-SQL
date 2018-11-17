DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [FA].[Roll Year], 
       [RD].[Regional District], 
       IIF([ED].[BCA Code] IS NULL, 'URBAN', 'RURAL') AS [BCA Code], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       PC.[Property Conversion Factor], 
       COUNT(DISTINCT [FA].dimFolio_SK) AS [Folio], 
       ISNULL(SUM([OC].[Property Class Occurrence]), 0) AS [Occurrences], 
       ISNULL(SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net Other Land Value]
           END),0) AS [Land], 
       ISNULL(SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN [FA].[Net Other Building Value]
           END),0) AS [Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
	 AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [ED]
     ON [ED].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Yes')
      AND [RD].[Regional District Code] = @p_RD
      AND ISNULL([ED].[BCA Code], '1') <> 'Z'
GROUP BY [FA].[Roll Year], 
         [RD].[Regional District], 
         IIF([ED].[BCA Code] IS NULL, 'URBAN', 'RURAL'), 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
       PC.[Property Conversion Factor]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [BCA Code] DESC, 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc];