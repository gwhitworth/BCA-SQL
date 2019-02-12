
/****** Script for SelectTopNRows command from SSMS  ******/

SELECT [dimFolio_SK],
       --,[dimRollYear_SK] 
       [dimRollCycle_SK], 
       [dimRollType_SK], 
       [AG].[dimAssessmentGeography_SK], 
       [dimAssessmentType_SK], 
       [Folio Number],
       --,[Roll Year] 
       [Cycle Number], 
       [Roll Type], 
       [Assessment Code], 
       [Property Class Occurrence], 
       [Jurisdiction Code]
FROM [EDW].[edw].[FactPropertyClassOccurrenceCount] AS [FA]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [AG].[dimAssessmentGeography_SK] = [FA].[dimAssessmentGeography_SK]
WHERE [dimFolio_SK] IN(619462, 6270826, 8916535, 10005871)
     AND [Assessment Code] = '01';