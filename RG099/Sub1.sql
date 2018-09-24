DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '213';
SELECT [FA].[Roll Year], 
       [AG].[Area], 
       [AG].[Jurisdiction Code], 
       [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc] AS [Jurisdiction Desc], 
       [FO].[School  District Code], 
       IIF([PC].[Property Sub Class Code] = '0202', 999, [PC].[RowSortOrder]) AS [RowSortOrder], 
       [PC].[Property Class Code],
       CASE
           WHEN [PC].[Property Class Code] = '01'
           THEN 'RES'
           WHEN [PC].[Property Class Code] <> '01'
           THEN 'NONRES'
       END AS [RESNONRES], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       ISNULL(SUM([Occur Count]), 0) AS [Occurrences], 
       IIF(COUNT(CASE
                     WHEN [FA].[Assessment Code] = '01'
                          AND [PC].[Property Class Code] = '01'
                     THEN [FA].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FA].dimFolio_SK), COUNT(CASE
                                                                       WHEN [FA].[Assessment Code] = '01'
                                                                            AND [PC].[Property Class Code] = '01'
                                                                       THEN [FA].[dimFolio_SK]
                                                                   END)) AS [Folio_Count], 
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
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND AG.[Roll Category Code] = '1'
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
    WHERE [FAV].[Roll Year] = @p_RY
          AND [FAV].[Cycle Number] <= @p_CN
          AND [Assessment Code] = '02'
          AND [AG].[Jurisdiction Code] = @p_JR
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [AG].[Jurisdiction Code] = @p_JR
GROUP BY [FA].[Roll Year], 
         [AG].[Area], 
         [AG].[Jurisdiction Code], 
         [AG].[Jurisdiction Code]+' '+[AG].[Jurisdiction Type Desc]+' of '+[AG].[Jurisdiction Desc], 
         [FO].[School  District Code], 
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
         [FO].[School  District Code], 
         [RESNONRES] DESC, 
         [RowSortOrder];