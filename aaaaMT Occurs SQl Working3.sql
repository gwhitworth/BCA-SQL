DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT DISTINCT 
       [FAV].[dimFolio_SK], 
       [FO].[Folio Number], 
       [FAV].[Property Class Code], 
       [MT].[Minor Tax Code], 
       [MT].[Minor Tax desc] AS [Minor Tax], 
       [AG].[Jurisdiction Code]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Area Code] BETWEEN '01' AND '27'
        AND [dimRollCategory_BK] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
        AND [FO].[dimFolioStatus_BK] = '01'
     INNER JOIN [edw].[dimAssessmentType] AS [AT]
     ON [AT].[dimAssessmentType_SK] = [FAV].[dimAssessmentType_SK]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FAV].[dimRollCycle_SK]
     INNER JOIN [edw].[dimRollType] AS [RT]
     ON [RT].[dimRollType_SK] = [FAV].[dimRollType_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BRD]
     ON [BRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [FAV].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [MT].[dimMinorTaxCode_SK] = [BMT].[dimMinorTaxCode_SK]
WHERE [FAV].[dimRollYear_SK] = @p_RY
      AND [AG].[Roll Category Code] = '1'
      AND [RC].[Cycle Number] = @p_CN
      AND [Assessment Code] = '02'
      AND [FAV].[dimRollType_SK] = 11 --Completed ROLL
      AND [BRD].[Regional District Code] = @p_RD
      AND [FAV].[Property Class Code] = '06'
      AND [AG].[Jurisdiction Code] = '362'
      AND [MT].[Minor Tax Code] = '01-36203B'
	  
ORDER BY [FO].[Folio Number];
SELECT DISTINCT --[FAV].[dimFolio_SK], 
       [FAV].[Property Class Code], 
       [MT].[Minor Tax Code], 
       [MT].[Minor Tax desc] AS [Minor Tax], 
       [AG].[Jurisdiction Code], 
       COUNT(*) AS [Occur Count]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FAV]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Area Code] BETWEEN '01' AND '27'
        AND [dimRollCategory_BK] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
        AND [FO].[dimFolioStatus_BK] = '01'
     INNER JOIN [edw].[dimAssessmentType] AS [AT]
     ON [AT].[dimAssessmentType_SK] = [FAV].[dimAssessmentType_SK]
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [RC].[dimRollCycle_SK] = [FAV].[dimRollCycle_SK]
     INNER JOIN [edw].[dimRollType] AS [RT]
     ON [RT].[dimRollType_SK] = [FAV].[dimRollType_SK]
     INNER JOIN [edw].[bridgeJurisdictionRegionalDistrict] AS [BRD]
     ON [BRD].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
     ON [BMT].[dimFolio_SK] = [FAV].[dimFolio_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [MT]
     ON [MT].[dimMinorTaxCode_SK] = [BMT].[dimMinorTaxCode_SK]
WHERE [FAV].[dimRollYear_SK] = @p_RY
      AND [AG].[Roll Category Code] = '1'
      AND [RC].[Cycle Number] = @p_CN
      AND [Assessment Code] = '02'
      AND [FAV].[dimRollType_SK] = 11 --Completed ROLL
      AND [BRD].[Regional District Code] = @p_RD
      --AND [FAV].[Property Class Code] = '06'
      AND [AG].[Jurisdiction Code] = '362'
      AND [MT].[Minor Tax Code] = '01-36203B'
GROUP BY --[FAV].[dimFolio_SK], 
[FAV].[Property Class Code], 
[MT].[Minor Tax Code], 
[MT].[Minor Tax desc], 
[AG].[Jurisdiction Code]
HAVING COUNT(*) > 1
ORDER BY [FAV].[Property Class Code], 
         [MT].[Minor Tax Code], 
         [AG].[Jurisdiction Code];
SELECT DISTINCT 
       [FA].[dimFolio_SK], 
       [dimProperty_SK], 
       [Property Class Occurrence]-1 AS [Occurrence]
FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
     INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
     ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Area Code] BETWEEN '01' AND '27'
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
WHERE [Assessment Code] = '02'
      AND [AG].[Roll Category Code] = '1'
      AND [fa].[Roll Year] = @p_RY
      AND [Cycle Number] = @p_CN
      AND [FA].[dimRollType_SK] = 11
      AND ([Net Other Total Value] > 0
           OR [Net General Total Value] > 0)
      AND [RD].[Regional District Code] = @p_RD
      AND [PC].[Property Class Code] = '06'
      AND [AG].[Jurisdiction Code] = '362'
      AND [MT].[Minor Tax Code] = '01-36203B'
	  AND [Property Class Occurrence] > 1