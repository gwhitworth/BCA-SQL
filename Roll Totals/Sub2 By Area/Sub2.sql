DECLARE @p_RY [INT];
DECLARE @p_CN [INT];
DECLARE @p_AR CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SELECT [FA].[dimRollYear_SK], 
       [AG].[Area], 
       IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]) AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folio_Count], 
       COUNT([OCRCNT]) AS [Occurrences], 
       SUM([FA].[Actual Land Value]) AS [Actual Land Value], 
       SUM([FA].[Actual Building Value]) AS [Actual Building Value], 
       SUM([Actual - Total]) AS [Actual - Total], 
       SUM([Gross General Land Value]) AS [Gross_Gen_Land], 
       SUM([Gross General Building Value]) AS [Gross_Gen_Improvements], 
       SUM([General Exemptions Land Value]) AS [Exempt_Gen_Land], 
       SUM([General Exemptions Building Value]) AS [Exempt_Gen_Improvements], 
       SUM([Net General Land Value]) AS [Net_Gen_Land], 
       SUM([Net General Building Value]) AS [Net_Gen_Improvements], 
       SUM([Gross Other Land Value]) AS [Gross_Hosp_Land], 
       SUM([Gross Other Building Value]) AS [Gross_Hosp_Improvements], 
       SUM([Other Exemptions Land Value]) AS [Exempt_Hosp_Land], 
       SUM([Other Exemptions Building Value]) AS [Exempt_Hosp_Improvements], 
       SUM([Net Other Land Value]) AS [Net_Hosp_Land], 
       SUM([Net Other Building Value]) AS [Net_Hosp_Improvements], 
       SUM([Gross School Land Value]) AS [Gross_School_Land], 
       SUM([Gross School Building Value]) AS [Gross_School_Improvements], 
       SUM([School Exemptions Land Value]) AS [Exempt_School_Land], 
       SUM([School Exemptions Building Value]) AS [Exempt_School_Improvements], 
       SUM([Net School Land Value]) AS [Net_School_Land], 
       SUM([Net School Building Value]) AS [Net_School_Improvements]
FROM
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [dimPropertyClass_SK], 
           [FA].[dimRollYear_SK], 
           [Cycle Number], 
           COUNT([FA].[dimFolio_SK]) AS [FolioCnt], 
           SUM([Actual Land Value]) AS [Actual Land Value], 
           SUM([Actual Building Value]) AS [Actual Building Value], 
           SUM([Actual Land Value]) + SUM([Actual Building Value]) AS [Actual - Total], 
           SUM([Gross General Land Value]) AS [Gross General Land Value], 
           SUM([Gross General Building Value]) AS [Gross General Building Value], 
           SUM([General Exemptions Land Value]) * -1 AS [General Exemptions Land Value], 
           SUM([General Exemptions Building Value]) * -1 AS [General Exemptions Building Value], 
           SUM([Net General Land Value]) AS [Net General Land Value], 
           SUM([Net General Building Value]) AS [Net General Building Value], 
           SUM([Gross Other Land Value]) AS [Gross Other Land Value], 
           SUM([Gross Other Building Value]) AS [Gross Other Building Value], 
           SUM([Other Exemptions Land Value]) * -1 AS [Other Exemptions Land Value], 
           SUM([Other Exemptions Building Value]) * -1 AS [Other Exemptions Building Value], 
           SUM([Net Other Land Value]) AS [Net Other Land Value], 
           SUM([Net Other Building Value]) AS [Net Other Building Value], 
           SUM([Gross School Land Value]) AS [Gross School Land Value], 
           SUM([Gross School Building Value]) AS [Gross School Building Value], 
           SUM([School Exemptions Land Value]) * -1 AS [School Exemptions Land Value], 
           SUM([School Exemptions Building Value]) * -1 AS [School Exemptions Building Value], 
           SUM([Net School Land Value]) AS [Net School Land Value], 
           SUM([Net School Building Value]) AS [Net School Building Value]
    FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
         INNER JOIN [edw].[dimFolio] AS [FO]
         ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
            AND [FO].[Folio Status Code] = '01'
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
         ON [FO].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
		 INNER JOIN [edw].[dimRollCycle] AS [RC]
         ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
    WHERE [FA].[dimRollYear_SK] = @p_RY
          AND [Cycle Number] = @p_CN
          AND [AG].[Area Code] = @p_AR
    GROUP BY [FA].[dimFolio_SK], 
             [dimPropertyClass_SK], 
             [FA].[dimRollYear_SK], 
             [Cycle Number]
) AS [FA]
INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           [Property Class Occurrence] AS [OCRCNT]
    FROM [edw].[FactPropertyClassOccurrenceCount]
	WHERE [Assessment Code] = '01'
) AS [OC]
ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
INNER JOIN [edw].[dimPropertyClass] AS [PC]
ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
INNER JOIN [edw].[dimFolio] AS [FO]
ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
   AND [FO].[Folio Status Code] = '01'
INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
ON [FO].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [AG].[Area Code] = @p_AR
GROUP BY [FA].[dimRollYear_SK], 
         [AG].[Area], 
         IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]), 
         [PC].[Property Class Code],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FA].[dimRollYear_SK], 
         [AG].[Area], 
         [RESNONRES] DESC, 
         [RowSortOrder];