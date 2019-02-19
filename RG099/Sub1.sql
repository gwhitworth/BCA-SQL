DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SELECT [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction Desc], 
       [FO].[School District Code],
       CASE
           WHEN [PC].[Property Sub Class Code] = '0202'
           THEN 999
           WHEN [PC].[Property Sub Class Code] = '0106'
           THEN 26
           ELSE [PC].[RowSortOrder]
       END AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       COUNT(DISTINCT [FA].[dimFolio_SK]) AS [Folio_Count], 
       COUNT([OC].[dimFolio_SK]) AS [Occurrences], 
       IIF(SUM([FA].[Gross General Land Value]) = 0, NULL, SUM([FA].[Gross General Land Value])) AS [Gross_Gen_Land], 
       IIF(SUM([FA].[Gross General Building Value]) = 0, NULL, SUM([FA].[Gross General Building Value])) AS [Gross_Gen_Improvements], 
       IIF(SUM([FA].[General Exemptions Land Value]) = 0, NULL, SUM([FA].[General Exemptions Land Value])) AS [Exempt_Gen_Land], 
       IIF(SUM([FA].[General Exemptions Building Value]) = 0, NULL, SUM([FA].[General Exemptions Building Value])) AS [Exempt_Gen_Improvements], 
       IIF(SUM([FA].[Net General Land Value]) = 0, NULL, SUM([FA].[Net General Land Value])) AS [Net_Gen_Land], 
       IIF(SUM([FA].[Net General Building Value]) = 0, NULL, SUM([FA].[Net General Building Value])) AS [Net_Gen_Improvements], 
       IIF(SUM([FA].[Gross Other Land Value]) = 0, NULL, SUM([FA].[Gross Other Land Value])) AS [Gross_Hosp_Land], 
       IIF(SUM([FA].[Gross Other Building Value]) = 0, NULL, SUM([FA].[Gross Other Building Value])) AS [Gross_Hosp_Improvements], 
       IIF(SUM([FA].[Other Exemptions Land Value]) = 0, NULL, SUM([FA].[Other Exemptions Land Value])) AS [Exempt_Hosp_Land], 
       IIF(SUM([FA].[Other Exemptions Building Value]) = 0, NULL, SUM([FA].[Other Exemptions Building Value])) AS [Exempt_Hosp_Improvements], 
       IIF(SUM([FA].[Net Other Land Value]) = 0, NULL, SUM([FA].[Net Other Land Value])) AS [Net_Hosp_Land], 
       IIF(SUM([FA].[Net Other Building Value]) = 0, NULL, SUM([FA].[Net Other Building Value])) AS [Net_Hosp_Improvements], 
       IIF(SUM([FA].[Gross School Land Value]) = 0, NULL, SUM([FA].[Gross School Land Value])) AS [Gross_School_Land], 
       IIF(SUM([FA].[Gross School Building Value]) = 0, NULL, SUM([FA].[Gross School Building Value])) AS [Gross_School_Improvements], 
       IIF(SUM([FA].[School Exemptions Land Value]) = 0, NULL, SUM([FA].[School Exemptions Land Value])) AS [Exempt_School_Land], 
       IIF(SUM([FA].[School Exemptions Building Value]) = 0, NULL, SUM([FA].[School Exemptions Building Value])) AS [Exempt_School_Improvements], 
       IIF(SUM([FA].[Net School Land Value]) = 0, NULL, SUM([FA].[Net School Land Value])) AS [Net_School_Land], 
       IIF(SUM([FA].[Net School Building Value]) = 0, NULL, SUM([FA].[Net School Building Value])) AS [Net_School_Improvements]
FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC]
     ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO]
     ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [FO].[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRollCycle] AS [RC]
     ON [FA].[dimRollCycle_SK] = [RC].[dimRollCycle_SK]
     INNER JOIN
(
    SELECT DISTINCT 
           [FA].[dimFolio_SK], 
           [FA].[dimJurisdiction_SK], 
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
         INNER JOIN [edw].[dimJurisdiction] AS [JR]
         ON [JR].[dimJurisdiction_SK] = [FA].[dimJurisdiction_SK]
    WHERE [FA].[Net General Total Value] > 0
          AND [FA].[dimRollYear_SK] = @p_RY
          AND [RC].[Cycle Number] = @p_CN
          AND [JR].[Jurisdiction Code] = @p_JR
          AND ([PC].[Property Class Code] > '02'
               OR [PC].[Property Sub Class Code] IS NOT NULL)
) AS [OC]
     ON [OC].[dimFolio_SK] = [FA].[dimFolio_SK]
        AND [OC].[dimJurisdiction_SK] = [AG].[dimJurisdiction_SK]
        AND [OC].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
WHERE [FA].[dimRollYear_SK] = @p_RY
      AND [RC].[Cycle Number] = @p_CN
      AND [AG].[Jurisdiction Code] = @p_JR
      AND (([PC].[Property Class Code] = '01'
            AND [FA].[Gross General Land Value] > 0)
           OR ([PC].[Property Class Code] <> '01'
               AND [FA].[Gross General Land Value] > 0
               OR [PC].[Property Sub Class Code] = '0202'))
GROUP BY [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [FO].[School District Code],
         CASE
             WHEN [PC].[Property Sub Class Code] = '0202'
             THEN 999
             WHEN [PC].[Property Sub Class Code] = '0106'
             THEN 26
             ELSE [PC].[RowSortOrder]
         END, 
         [PC].[Property Class Code],
         CASE
             WHEN [PC].[Property Class Code] = '01'
             THEN 'RES'
             WHEN [PC].[Property Class Code] <> '01'
             THEN 'NONRES'
         END, 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [FO].[School District Code], 
         [RESNONRES] DESC, 
         [RowSortOrder];