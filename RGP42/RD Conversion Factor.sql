DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT [AG].dimJurisdiction_SK, 
       SUM([FA].[Net Other Land Value] * ([PC].[Property Conversion Factor] / 100 / 100)) AS [Net Other Land Value], 
       SUM([FA].[Net Other Building Value] * ([PC].[Property Conversion Factor] / 100 / 100)) AS [Net Other Building Value]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Current Cycle Only')
      AND [RD].[Regional District Code] = @p_RD
      AND [ED].[BCA Code] IS NOT NULL
GROUP BY [AG].dimJurisdiction_SK
ORDER BY [AG].dimJurisdiction_SK;


SELECT [AG].dimJurisdiction_SK, 
      [FA].[Net Other Land Value] * ([PC].[Property Conversion Factor] / 100 / 100) AS [Net Other Land Value], 
       [FA].[Net Other Building Value] * ([PC].[Property Conversion Factor] / 100 / 100) AS [Net Other Building Value]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Current Cycle Only')
      AND [RD].[Regional District Code] = @p_RD
      AND [ED].[BCA Code] IS NOT NULL

ORDER BY [AG].dimJurisdiction_SK;