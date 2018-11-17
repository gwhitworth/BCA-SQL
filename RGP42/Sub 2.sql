DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [FA].[Roll Year], 
       [RD].[Regional District Code], 
       [RD].[Regional District], 
       [ED].[BCA Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       [PC].[Property Conversion Factor], 
       ISNULL(SUM([OC].[Property Class Occurrence]), 0) AS [Hosp Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN IIF([FA].[Net Other Land Value] = 0, NULL, [FA].[Net Other Land Value])
           END) AS [Hosp Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN IIF([FA].[Net Other Building Value] = 0, NULL, [FA].[Net Other Building Value])
           END) AS [Hosp Improvements]
FROM [EDW].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [EDW].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [EDW].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [EDW].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN [EDW].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrictElectoralDistrict] AS [ED]
     ON [ED].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE([FA].[Roll Year] = @p_RY)
     AND ([FA].[Cycle Number] = @p_CN)
     AND ([FA].[Current Cycle Flag] = 'Yes')
     AND ([RD].[Regional District Code] IN(@p_RD))
     AND ([AG].[Jurisdiction Type Code] = 'R')
     AND ([ED].[BCA Code] <> 'Z')
GROUP BY [FA].[Roll Year], 
         [RD].[Regional District Code], 
         [RD].[Regional District], 
         [ED].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [PC].[Property Conversion Factor]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District Code], 
         [ED].[BCA Code], 
         [AG].[Jurisdiction Code], 
         [PC].[Property Class Code];