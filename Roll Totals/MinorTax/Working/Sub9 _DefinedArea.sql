DECLARE @p_RY [INT];
DECLARE @p_MT VARCHAR(100);
SET @p_RY = 2017;
SET @p_MT = 'Saturna Recreation Prog DA#8';
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
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          --AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[bridgeFolioMinorTax] AS [BTC] ON [FA].[dimFolio_SK] = [BTC].[dimFolio_SK]
                 --                                          AND [FA].[Roll Year] = [BTC].[Roll Year]
														   AND [AG].dimJurisdiction_SK = [BTC].dimJurisdiction_SK
     INNER JOIN [edw].[dimMinorTaxCode] AS [TC] ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
                	                                   --AND [BTC].[Roll Year] = [TC].[Roll Year]

	INNER JOIN [edw].[FactPropertyClassOccurrenceCount] AS [OC] ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
																   --AND [OC].[Assessment Code] ='02'
	INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [OC].[dimFolio_SK] AND [FO].[Folio Status Code] = '01'
	
	
	--INNER JOIN [edw].[bridgeJurisdictionRegionalHospitalDistrict] AS [BRH] ON [BTC].dimJurisdiction_SK = [BRH].dimJurisdiction_SK

WHERE [FA].[Roll Year] = @p_RY
	  AND [FA].[Cycle Number] <= (SELECT Max([Cycle Number]) FROM edw.dimRollCycle WHERE [Roll Year] = @p_RY )
      AND [TC].[Minor Tax Code] IN
(
    SELECT [Minor Tax Code]
    FROM [EDW].[dbo].[dimMinorTaxCodeTbl]
    WHERE [Roll Year] = @p_RY
          AND [Minor Tax Desc] = @p_MT
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
         [AG].[Area Code], 
         [TC].[Jurisdiction Code], 
         [TC].[BCA Code], 
         [TC].[Minor Tax Desc], 
         [TC].[Tax Base Code], 
         [PC].[Property Class Code], 
         [PSC Code];