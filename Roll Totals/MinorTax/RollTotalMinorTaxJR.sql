DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
--DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_MT = 'Saturna Recreation Prog DA#8';
--SET @p_JR = '771';
SELECT [FA].[dimRollYear_SK] AS [Roll Year], 
       [TC].[BCA Code] AS [Island Trust Code], 
       [TC].[Minor Tax Desc] AS [Island Trust], 
       [PC].[Property Class Code] AS [PC Code], 
       REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', '') AS [Property Class], 
       IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])) AS [PSC Code], 
       IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])) AS [Property Subclass], 
       --COUNT(distinct [OC].[dimFolio_SK]) AS [Occurrence],
       COUNT(DISTINCT CASE
                          WHEN [FA].[Actual Land Value] > 0
                               OR [FA].[Actual Building Value] > 0
                          THEN [FA].[dimFolio_SK]
                          ELSE 0
                      END) AS [Occurrence Count], 
       SUM([FA].[Actual Land Value]) AS [Actual - Land], 
       SUM([FA].[Actual Building Value]) AS [Actual - Impr], 
       SUM([FA].[Actual Land Value]) + SUM([FA].[Actual Building Value]) AS [Total], 
       COUNT(DISTINCT CASE
                          WHEN [General Net - Land] > 0
                               OR [General Net - Impr] > 0
                          THEN [FA].[dimFolio_SK]
                          ELSE 0
                      END) AS [General Occurrences], 
       SUM([General Net - Land]) AS [General Net - Land], 
       SUM([General Net - Impr]) AS [General Net - Impr], 
       COUNT(DISTINCT CASE
                          WHEN [School Net - Land] > 0
                               OR [School Net - Impr] > 0
                          THEN [FA].[dimFolio_SK]
                          ELSE 0
                      END) AS [School Occurrences], 
       SUM([School Net - Land]) AS [School Net - Land], 
       SUM([School Net - Impr]) AS [School Net - Impr], 
       COUNT(DISTINCT CASE
                          WHEN [Hospital Net - Land] > 0
                               OR [Hospital Net - Impr] > 0
                          THEN [FA].[dimFolio_SK]
                          ELSE 0
                      END) AS [Hospital Occurrences], 
       SUM([Hospital Net - Land]) AS [Hospital Net - Land], 
       SUM([Hospital Net - Impr]) AS [Hospital Net - Impr]
FROM
(
    SELECT DISTINCT 
           [dimRollYear_SK], 
           [dimRollCycle_SK], 
           [dimFolio_SK], 
           [dimPropertyClass_SK], 
           [dimAssessmentGeography_SK], 
           [Assessed Land Value] AS [Actual Land Value], 
           [Assessed Building Value] AS [Actual Building Value], 
           [Net General Land Value] AS [General Net - Land], 
           [Net General Building Value] AS [General Net - Impr], 
           [Net School Land Value] AS [School Net - Land], 
           [Net School Building Value] AS [School Net - Impr], 
           [Net Other Land Value] AS [Hospital Net - Land], 
           [Net Other Building Value] AS [Hospital Net - Impr]
    FROM [edw].[factValuesByAssessmentCodePropertyClass]
) AS [FA]
INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC]
ON [FA].[dimFolio_SK] = [BTC].[dimFolio_SK]
   AND [AG].[dimJurisdiction_SK] = [BTC].[dimJurisdiction_SK]
INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
INNER JOIN [edw].[dimFolio] AS [FO]
ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
   AND [FO].[Folio Status Code] = '01'
INNER JOIN [edw].[dimRollCycle] AS [RC]
ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
INNER JOIN
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [BMT].[dimJurisdiction_SK], 
           [BMT].[dimMinorTaxCode_SK], 
           [FA].[dimPropertyClass_SK], 
           [PC].[Property Class Code]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[dimFolioStatus_BK] = '01'
         LEFT OUTER JOIN [edw].[dimPropertyClass] AS [PC]
         ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
         INNER JOIN [edw].[bridgeFolioMinorTax] AS [BMT]
         ON [BMT].[dimFolio_SK] = [FA].[dimFolio_SK]
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = -1
          AND [FA].[Assessed Total Value] > 0
          AND [BMT].[Minor Tax Code] =
    (
        SELECT TOP 1 [Minor Tax Code]
        FROM [edw].[dimMinorTaxCode]
        WHERE [dimRollYear_SK] = @p_RY
              AND [Minor Tax Desc] = @p_MT
    )
          AND ([PC].[Property Class Code] > '02'
               OR [PC].[Property Sub Class Code] IS NOT NULL)
) AS [OC]
ON [OC].[dimFolio_SK] = [FA].[dimFolio_SK]
   AND [OC].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
   AND [oc].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
   AND [OC].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [Cycle Number] = -1
      AND [TC].[Minor Tax Code] =
(
    SELECT TOP 1 [Minor Tax Code]
    FROM [edw].[dimMinorTaxCode]
    WHERE [dimRollYear_SK] = @p_RY
          AND [Minor Tax Desc] = @p_MT
)
      AND ((([PC].[Property Class Code] = '01'
             OR [PC].[Property Class Code] = '02')
            AND [PC].[Property Sub Class Code] IS NOT NULL)
           OR [PC].[Property Class Code] BETWEEN '03' AND '09')
GROUP BY [FA].[dimRollYear_SK], 
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [PC].[Property Class Code], 
         REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', ''), 
         IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])), 
         IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]))
ORDER BY [FA].[dimRollYear_SK], 
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [PC].[Property Class Code], 
         [PSC Code];