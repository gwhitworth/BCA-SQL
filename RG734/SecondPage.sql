DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SELECT [FA].[Roll Year], 
       [RD].[Regional District], 
       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       [PC].[Property Conversion Factor], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                          THEN [FA].[dimFolio_SK]
                      END) AS [Gen Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net General Land Value]
           END) AS [Gen Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN IIF([FA].[Net General Building Value] = 0, NULL, [FA].[Net General Building Value])
           END) AS [Gen Improvements], 
       ISNULL(SUM([OC].[Property Class Occurrence]), 0) AS [Hosp Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN [FA].[Net Other Land Value]
           END) AS [Hosp Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN IIF([FA].[Net Other Building Value] = 0, NULL, [FA].[Net Other Building Value])
           END) AS [Hosp Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [FO].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Yes')
      AND [AG].[Jurisdiction Code] = @p_JR
GROUP BY [FA].[Roll Year], 
         [RD].[Regional District], 
         '(AA'+[AG].[Area Code]+')', 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [PC].[Property Conversion Factor]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [Area Code], 
         [Jurisdiction], 
         [PC].[Property Class Code];