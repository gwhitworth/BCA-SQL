DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
SELECT DISTINCT 
       [FA].[dimFolio_SK], 
(
    SELECT ISNULL(MAX([Property Class Occurrence]-1),0)
    FROM [edw].[FactPropertyClassOccurrenceCount] AS [A]
    WHERE [A].[dimFolio_SK] = [FA].[dimFolio_SK]
          AND [Assessment Code] = '01'
          AND [Property Class Occurrence] > 1
) AS [OCCR_CNT]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
	 AND [dimRollCategory_BK] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[dimFolioStatus_BK] = '01'
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BJRD]
     ON [BJRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD]
     ON [RD].[dimRegionalDistrict_SK] = [BJRD].[dimRegionalDistrict_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [MT].[dimMinorTaxCode_SK] = [BMT].[dimMinorTaxCode_SK]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FA].[dimRollCycle_SK]
WHERE [fa].[dimRollYear_SK] = @p_RY
      AND [Cycle Number] = @p_CN
      AND [FA].[dimRollType_SK] = 11

      --AND ([Net Other Total Value] > 0)
      --AND [Net General Total Value] > 0
      AND ([Net Other Total Value] > 0
           OR [Net General Total Value] > 0)
      AND [RD].[Regional District Code] = @p_RD
      AND [MT].[Minor Tax Category Code] = 'SM'
      --AND [MT].[Minor Tax Code] IN('01-36103B', '01-36203B', '01-40103A')
      AND [FA].[Current Cycle Flag] = 'Yes'
      AND [MT].[Minor Tax Code] IN('01-36103B')
     --AND ([PC].[Property Sub Class Code]  <> '0202' OR [PC].[Property Sub Class Code] is null)
     AND [PC].[Property Class Code] = '01'
ORDER BY [FA].[dimFolio_SK];