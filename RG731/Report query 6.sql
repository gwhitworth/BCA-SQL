DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SET @p_JR = '213';
SELECT [RD].[Regional District Code], 
       [RD].[Regional District desc], 
       '(AA'+[AG].[Area Code]+')' AS [Area Code], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc] AS [Jurisdiction], 
       [MT].[BCA Code], 
       [MT].[Minor Tax desc] AS [Minor Tax], 
       [PC].[Property Class Code], 
       [PC].[Property Class Desc], 
       [PC].[Property Conversion Factor], 
       SUM([OC].[Occurrence]) AS [Hosp Folio], 
       SUM([Hosp Land]) AS [Hosp Land], 
       SUM([Hosp Improvements]) AS [Hosp Improvements]
FROM
(
    SELECT DISTINCT 
           [A].[dimFolio_SK], 
           [dimPropertyClass_SK], 
           [dimAssessmentGeography_SK], 
           [A].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           SUM([Net Other Land Value]) AS [Hosp Land], 
           SUM([Net Other Building Value]) AS [Hosp Improvements]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
         INNER JOIN [edw].[dimRollCycle] AS [B]
         ON [A].[dimRollCycle_SK] = [B].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [A].[dimFolio_SK]
    WHERE [Current Cycle Flag] = 'Yes'
          AND [A].[dimRollYear_SK] = @p_RY
          AND [B].[Cycle Number] = @p_CN
    GROUP BY [A].[dimFolio_SK], 
             [dimPropertyClass_SK], 
             [dimAssessmentGeography_SK], 
             [A].[dimJurisdiction_SK], 
             [BMT].[dimMinorTaxCode_SK]
) AS [FA]
INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
ON [BJRD].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
ON [MT].[dimMinorTaxCode_SK] = [FA].[dimMinorTaxCode_SK]
INNER JOIN
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [Property Class Code], 
           [Property Class Occurrence] AS [Occurrence]
    FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
         INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
         ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
    WHERE [Assessment Code] = '02'
          AND [fa].[Roll Year] = @p_RY
          --AND [Jurisdiction Code] = '361'
          AND [Cycle Number] = @p_CN
          AND [Property Sub Class Code] IS NULL
          AND [Current Cycle Flag] = 'Yes'
) AS [OC]
ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [RD].[Regional District Code] = @p_RD
GROUP BY [RD].[Regional District Code], 
         [RD].[Regional District desc], 
         '(AA'+[AG].[Area Code]+')', 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Type Desc]+' '+[AG].[Jurisdiction Desc], 
         [MT].[BCA Code], 
         [MT].[Minor Tax desc], 
         [PC].[Property Class Code], 
         [PC].[Property Class Desc], 
         [PC].[Property Conversion Factor]
ORDER BY [RD].[Regional District Code], 
         [Area Code], 
         [Jurisdiction Code], 
         [MT].[BCA Code], 
         [PC].[Property Class Code];