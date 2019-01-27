DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SELECT TOP 50 [FA].[dimRollYear_SK], 
               [RD].[Regional District], 
               '(AA'+[AG].[Area Code]+')' AS [Area Code], 
               [AG].[Jurisdiction Code], 
               [AG].[Jurisdiction Desc], 
               [BMT].[Minor Tax Code], 
               [BMT].[Minor Tax Desc], 
               [PC].[Property Class Code], 
               [PC].[Property Class Desc], 
               [PC].[Property Conversion Factor], 
               ISNULL(SUM([OC].[Property Class Occurrence]), 0) AS [Hosp Folio], 
               SUM([FA].[Net Other Land Value]) AS [Hosp Land], 
               SUM([FA].[Net Other Building Value]) AS [Hosp Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FA].[dimRollCycle_SK]
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
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [RC].[Cycle Number] = @p_CN
      AND ([FA].[Current Cycle Flag] = 'Yes')
      AND [RD].[Regional District Code] = @p_RD
GROUP BY [FA].[dimRollYear_SK], 
         [RD].[Regional District], 
         '(AA'+[AG].[Area Code]+')', 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Desc], 
         [BMT].[Minor Tax Code], 
         [BMT].[Minor Tax Desc], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [PC].[Property Conversion Factor]
ORDER BY [FA].[dimRollYear_SK], 
         [RD].[Regional District], 
         [Area Code], 
         [AG].[Jurisdiction Code], 
         [BMT].[Minor Tax Code], 
         [PC].[Property Class Code];