DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
--SET @p_JR = '213';
SELECT [Assessment Code], 
       [Minor Tax Code], 
       [A].[Property Class Code], 
       COUNT([Occurrence]) AS CNT, 
       SUM([Occurrence]) AS OCR
FROM
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [Assessment Code], 
           [PC].[Property Class Code], 
           [MT].[Minor Tax Code], 
           (SELECT [Property Class Occurrence] FROM )  AS [Occurrence]
    FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
         INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
         ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
         INNER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA2].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
            --AND [dimRollCategory_BK] = '1'
            --AND [AG].[Area Code] BETWEEN '01' AND '27'
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
    --WHERE [Assessment Code] = '01'
    --      AND [fa].[Roll Year] = @p_RY
    WHERE [fa].[Roll Year] = @p_RY
          AND [Cycle Number] = @p_CN
          AND [FA].[dimRollType_SK] = 11
          --AND ([Net Other Total Value] > 0)
          --AND [Net General Total Value] > 0
		  --AND ([Net Other Total Value] > 0
    --           OR [Net General Total Value] > 0)
          AND [RD].[Regional District Code] = @p_RD
          AND [MT].[Minor Tax Category Code] = 'SM'
          AND [MT].[Minor Tax Code] IN('01-36103B', '01-36203B', '01-40103A')
		  AND [FA2].[Current Cycle Flag] = 'Yes'
		  --AND [MT].[Minor Tax Code] IN('01-36103B')
         AND ([PC].[Property Sub Class Code]  <> '0202' OR [PC].[Property Sub Class Code] is null)
--AND [PC].[Property Class Code] = '01'
) AS [A]
GROUP BY [Assessment Code], 
         [Minor Tax Code], 
         [Property Class Code]
--group by [MT].[Minor Tax Code]
ORDER BY [Assessment Code], 
         [Minor Tax Code], 
         [Property Class Code];