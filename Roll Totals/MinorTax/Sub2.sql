DECLARE @p_RY [INT];
DECLARE @p_IT VARCHAR(100);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_IT = 'Denman Island Local Trust Area';
SET @p_JR = '771';
SELECT [FA].[Roll Year], 
       [TC].[BCA Code] AS [Island Trust Code], 
       [TC].[Minor Tax Desc] AS [Island Trust], 
       [PC].[Property Class Code] AS [PC Code], 
       REPLACE([PC].[Property Class], [PC].[Property Class Code]+' - ', '') AS [Property Class], 
       IIF([PC].[Property Sub Class Code] = '0202', '0201', ISNULL([PC].[Property Sub Class Code], [PC].[Property Class Code])) AS [PSC Code], 
       IIF([PC].[Property Sub Class Code] = '0202', 'Utilities', ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])) AS [Property Subclass], 
       COUNT([OC].[Property Class Occurrence]) AS [Folio Count], 
       SUM([OC].[Property Class Occurrence]) AS [Occurrence Count], 
       SUM([FA].[Actual Land Value]) AS [Actual - Land], 
       SUM([FA].[Actual Building Value]) AS [Actual - Impr], 
       SUM([OC].[Property Class Occurrence]) AS [General Occurrences], 
       SUM([FA].[Net General Land Value]) AS [General Net - Land], 
       SUM([FA].[Net General Building Value]) AS [General Net - Impr], 
       SUM([OC].[Property Class Occurrence]) AS [School Occurrences], 
       SUM([FA].[Net School Land Value]) AS [School Net - Land], 
       SUM([FA].[Net School Building Value]) AS [School Net - Impr], 
       SUM([OC].[Property Class Occurrence]) AS [Hospital Occurrences], 
       SUM([FA].[Net Other Land Value]) AS [Hospital Net - Land], 
       SUM([FA].[Net Other Building Value]) AS [Hospital Net - Impr]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC]
     ON [FA].[dimFolio_SK] = [BTC].[dimFolio_SK]
        AND [AG].[dimJurisdiction_SK] = [BTC].[dimJurisdiction_SK]
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
     INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [OC].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
WHERE [FA].[Roll Year] = @p_RY
      AND [TC].[Jurisdiction Code] IN(@p_JR)
     AND [FA].[Cycle Number] <=
(
    SELECT MAX([Cycle Number])
    FROM [edw].[dimRollCycle]
    WHERE [Roll Year] = @p_RY
)
     AND [TC].[Minor Tax Code] IN
(
    SELECT [Minor Tax Code]
    FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
    WHERE [Roll Year] = @p_RY
          AND [Minor Tax Desc] IN(@p_IT)
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
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         [PSC Code];