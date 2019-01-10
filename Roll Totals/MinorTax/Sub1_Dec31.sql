DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
SET @p_RY = 2017;
SET @p_MT = 'Building Inspection SRVA#32';
SELECT [FA].[Roll Year], 
       [TC].[Regional District Code] AS [RD Code], 
       REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', '') AS [Regional District], 
       REVERSE(RIGHT([TC].[Electoral District Code], 1)) AS [EA Code], 
       [AG].[Area Code], 
       REPLACE([AG].[Area], [AG].[Area Code]+' - ', '') AS [Assessment Area], 
       [TC].[Jurisdiction Code] AS [Jur Code], 
       REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', '') AS [Jurisdiction], 
       [TC].[BCA Code] AS [Defined Area Code], 
       [TC].[Minor Tax Desc] AS [Defined Area], 
       [TC].[Tax Base Code] AS [Tax Base], 
       [PC].[Property Class Code] AS [PC Code], 
       REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', '') AS [Property Class], 
       IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])) AS [PSC Code], 
       IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])) AS [Property Subclass], 
       COUNT([OCRCNT]) AS [Folio Count], 
       SUM(CASE
               WHEN [FA].[Actual Land Value] > 0
                    OR [FA].[Actual Building Value] > 0
               THEN [OCRCNT]
               ELSE 0
           END) AS [Occurrence Count], 
       SUM([FA].[Actual Land Value]) AS [Actual - Land], 
       SUM([FA].[Actual Building Value]) AS [Actual - Impr], 
       SUM([FA].[Actual Land Value]) + SUM([FA].[Actual Building Value]) AS [Total], 
       SUM(CASE
               WHEN [General Net - Land] > 0
                    OR [General Net - Impr] > 0
               THEN [OCRCNT]
               ELSE 0
           END) AS [General Occurrences], 
       SUM([General Net - Land]) AS [General Net - Land], 
       SUM([General Net - Impr]) AS [General Net - Impr], 
       SUM(CASE
               WHEN [School Net - Land] > 0
                    OR [School Net - Impr] > 0
               THEN [OCRCNT]
               ELSE 0
           END) AS [School Occurrences], 
       SUM([School Net - Land]) AS [School Net - Land], 
       SUM([School Net - Impr]) AS [School Net - Impr], 
       SUM(CASE
               WHEN [Hospital Net - Land] > 0
                    OR [Hospital Net - Impr] > 0
               THEN [OCRCNT]
               ELSE 0
           END) AS [Hospital Occurrences], 
       SUM([Hospital Net - Land]) AS [Hospital Net - Land], 
       SUM([Hospital Net - Impr]) AS [Hospital Net - Impr]
FROM [edw].[FactActualAmounts] AS [FA]
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           SUM(CASE
                   WHEN [Assessment Code] = '01'
                   THEN [Net General Value]
               END) AS [General Net - Land], 
           SUM(CASE
                   WHEN [Assessment Code] = '02'
                   THEN [Net General Value]
               END) AS [General Net - Impr], 
           SUM(CASE
                   WHEN [Assessment Code] = '01'
                   THEN [Net School Value]
               END) AS [School Net - Land], 
           SUM(CASE
                   WHEN [Assessment Code] = '02'
                   THEN [Net School Value]
               END) AS [School Net - Impr], 
           SUM(CASE
                   WHEN [Assessment Code] = '01'
                   THEN [Net Other Value]
               END) AS [Hospital Net - Land], 
           SUM(CASE
                   WHEN [Assessment Code] = '02'
                   THEN [Net Other Value]
               END) AS [Hospital Net - Impr]
    FROM [edw].[FactAssessedValue]
    GROUP BY [dimFolio_SK]
) AS [FA2]
     ON [FA].[dimFolio_SK] = [FA2].[dimFolio_SK]
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
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           SUM([Property Class Occurrence]) AS [OCRCNT]
    FROM [edw].[FactPropertyClassOccurrenceCount]
	WHERE [Roll Year] = @p_RY
    GROUP BY [dimFolio_SK]
) AS [OC]
     ON [FA2].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = -1
      AND [TC].[Minor Tax Code] IN
(
    SELECT [Minor Tax Code]
    FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
    WHERE [Roll Year] = @p_RY
          AND [Minor Tax Desc] IN(@p_MT)
)
GROUP BY [FA].[Roll Year], 
         [TC].[Regional District Code], 
         REPLACE([TC].[Regional District], [TC].[Regional District Code]+' - ', ''), 
         REVERSE(RIGHT([TC].[Electoral District Code], 1)), 
         [AG].[Area Code], 
         REPLACE([AG].[Area], [AG].[Area Code]+' - ', ''), 
         [TC].[Jurisdiction Code], 
         REPLACE(REPLACE([TC].[Jurisdiction], [TC].[Jurisdiction Code]+' - ', ''), '('+[TC].[Jurisdiction Code]+')', ''), 
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', ''), 
         IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])), 
         IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]))
ORDER BY [FA].[Roll Year], 
         [TC].[Regional District Code], 
         [EA Code], 
         [AG].[Area Code], 
         [TC].[Jurisdiction Code], 
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         [PSC Code];