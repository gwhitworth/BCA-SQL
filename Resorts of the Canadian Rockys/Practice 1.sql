SELECT DISTINCT 
       [edw].[FactPropertyInventorySummary].[Folio Number], 
       [edw].[dimOutbuilding].[Suppress], 
       [edw].[dimAssessmentGeography].[Roll Year]
FROM [edw].[FactPropertyInventorySummary]
     INNER JOIN [edw].[dimManualClass]
     ON [edw].[FactPropertyInventorySummary].[dimManualClass_SK] = [edw].[dimManualClass].[dimManualClass_SK]
     INNER JOIN [edw].[dimOutbuilding]
     ON [edw].[FactPropertyInventorySummary].[dimProperty_SK] = [edw].[dimOutbuilding].[dimProperty_SK]
     INNER JOIN [edw].[dimAssessmentGeography]
     ON [edw].[FactPropertyInventorySummary].[dimAssessmentGeography_SK] = [edw].[dimAssessmentGeography].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimActualUse]
     ON [edw].[FactPropertyInventorySummary].[dimActualUse_SK] = [edw].[dimActualUse].[dimActualUse_SK]
WHERE([edw].[dimManualClass].[Main Building Flag] = 'Y')
     AND ([edw].[dimAssessmentGeography].[Area Code] = '22')
     AND ([edw].[dimAssessmentGeography].[Neighbourhood Code] IN('701041', '718505'))
     AND (NOT([edw].[dimManualClass].[Manual Class Code] IN('C424', 'D424')))
AND (NOT([edw].[dimActualUse].[Actual Use Code] IN('287', '040')));