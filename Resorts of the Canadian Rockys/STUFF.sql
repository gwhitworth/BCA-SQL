SELECT [A].[dimProperty_SK], 
       STUFF(
(
    SELECT [Property Class Code] +' | '
    FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] AS [B]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [B].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND [AG].[Area Code] = '22'
                                                              AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
         INNER JOIN [edw].[dimManualClass] AS [MC] ON [B].[dimManualClass_SK] = [MC].[dimManualClass_SK]
                                                      AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
         INNER JOIN [edw].[dimActualUse] AS [AU] ON [B].[dimActualUse_SK] = [AU].[dimActualUse_SK]
                                                    AND (NOT([AU].[Actual Use Code] IN('287', '040')))
    WHERE [B].[dimProperty_SK] = [A].[dimProperty_SK] FOR XML PATH('')
), 1, 1, '') AS [listStr]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] [A]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND [AG].[Area Code] = '22'
                                                          AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
     INNER JOIN [edw].[dimManualClass] AS [MC] ON [A].[dimManualClass_SK] = [MC].[dimManualClass_SK]
                                                  AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
     INNER JOIN [edw].[dimActualUse] AS [AU] ON [A].[dimActualUse_SK] = [AU].[dimActualUse_SK]
                                                AND (NOT([AU].[Actual Use Code] IN('287', '040')))
WHERE [A].[dimRollYear_SK] = 2018
      AND [Actual Total Value] > 0
GROUP BY [A].[dimProperty_SK];