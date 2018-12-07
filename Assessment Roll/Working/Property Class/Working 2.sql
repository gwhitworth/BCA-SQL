/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [dimFolio_SK], 
       [Roll Year], 
       [Cycle Number], 
       [Roll Type], 
       [Folio Number], 
       [Folio Number Display], 
       [Assessment Code], 
       [Property Class Code], 
       [Property Sub Class Code], 
       [Gross General Value], 
       [Gross Other Value], 
       [Gross School Value], 
       [Net General Value], 
       [Net Other Value], 
       [Net School Value], 
       [General Exemptions Value], 
       [Other Exemptions Value], 
       [School Exemptions Value], 
       [Assessed Value]
FROM [EDW].[edw].[FactAssessedValue]
WHERE [dimFolio_SK] = 4166936
      AND [Cycle Number] = -1;