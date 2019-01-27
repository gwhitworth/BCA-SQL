SELECT DISTINCT 
       [FA].[dimFolio_SK], 
       [Property Class Code], 
       [Property Class Occurrence] AS [Occurrence]
FROM [edw].[FactPropertyClassOccurrenceCount] AS [FA]
     INNER JOIN [edw].[factValuesByAssessmentCodePropertyClass] AS [FA2]
     ON [fa].[dimFolio_SK] = [fa2].[dimFolio_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
WHERE [Assessment Code] = '02'
      AND [fa].[Roll Year] = 2017
      AND [Jurisdiction Code] = '361'
      AND [cycle number] = -1
      AND [Property Sub Class Code] IS NULL;