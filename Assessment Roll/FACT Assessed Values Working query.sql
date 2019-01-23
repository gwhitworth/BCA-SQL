
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT TOP (1000) [dimFolio_SK], 
                  [dimActualUse_SK], 
                  [dimPropertyClass_SK], 
                  [dimAssessmentGeography_SK], 
                  [dimManualClass_SK], 
                  SUM(CASE
                          WHEN [Assessment Code] = '01'
                          THEN [Assessed Value]
                      END) AS [Assessed Land Value], 
                  SUM(CASE
                          WHEN [Assessment Code] <> '01'
                          THEN [Assessed Value]
                      END) AS [Assessed Improvement Value], 
                  SUM([Net General Value] + [Net Other Value] + [Net School Value]) AS [Assessed Net Value], 
                  SUM([General Exemptions Value] + [Other Exemptions Value] + [School Exemptions Value]) AS [Assessed Exempt Value], 
                  SUM([Assessed Value]) AS [Assessed Total Value]
FROM [EDW].[edw].[FactAssessedValue]
WHERE [dimFolio_SK] > -1
GROUP BY [dimFolio_SK], 
         [dimActualUse_SK], 
         [dimPropertyClass_SK], 
         [dimAssessmentGeography_SK], 
         [dimManualClass_SK]
ORDER BY [dimFolio_SK];