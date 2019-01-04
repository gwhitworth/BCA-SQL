DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
DECLARE @p_NH CHAR(6);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SET @p_NH = '213101';
SELECT [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction Desc], 
       [FO].[School District Code], 
       [AG].[Neighbourhood Code], 
       [AG].[Neighbourhood], 
       IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]) AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       SUM([FA].[Actual Folio Count]) AS [Folio_Count], 
       SUM([OCRCNT]) AS [Occurrences], 
       SUM([FA].[Actual Land Value]) AS [Actual Land Value], 
       SUM([FA].[Actual Building Value]) AS [Actual Building Value], 
       SUM([FA].[Actual Land Value]) + SUM([FA].[Actual Building Value]) AS [Actual - Total], 
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
FROM [edw].[FactTotalAllAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN
(
    SELECT DISTINCT 
           [dimFolio_SK], 
           [Property Class Occurrence] AS [OCRCNT]
    FROM [edw].[FactPropertyClassOccurrenceCount]
) AS [OC]
     ON [FA].[dimFolio_SK] = [OC].[dimFolio_SK]
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [AG].[Neighbourhood Code] = @p_NH
GROUP BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [FO].[School District Code], 
         [AG].[Neighbourhood Code], 
         [AG].[Neighbourhood], 
         IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]), 
         [PC].[Property Class Code],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [FO].[School District Code], 
         [AG].[Neighbourhood Code], 
         [AG].[Neighbourhood], 
         [RESNONRES] DESC, 
         [RowSortOrder];