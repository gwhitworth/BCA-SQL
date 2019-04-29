
DECLARE @listStr VARCHAR(MAX)
SELECT [A].[dimProperty_SK], COALESCE(@listStr+',' ,'') + A.[Property Class Code]
FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] [A]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
        AND [AG].[Area Code] = '22'
        AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
     INNER JOIN [edw].[dimManualClass] AS [MC]
     ON [A].[dimManualClass_SK] = [MC].[dimManualClass_SK]
        AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
     INNER JOIN [edw].[dimActualUse] AS [AU]
     ON [A].[dimActualUse_SK] = [AU].[dimActualUse_SK]
        AND (NOT([AU].[Actual Use Code] IN('287', '040')))
WHERE [A].[dimRollYear_SK] = 2018
GROUP BY [A].[dimProperty_SK],A.[Property Class Code]
--SELECT @listStr
GO

--SELECT DISTINCT STRING_AGG ( ISNULL([Property Class Code],'N/A'), ',') AS csv 
--FROM [EDW].[edw].[factValuesByAssessmentCodePropertyClass] [A]
--     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
--     ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
--        AND [AG].[Area Code] = '22'
--        AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
--     INNER JOIN [edw].[dimManualClass] AS [MC]
--     ON [A].[dimManualClass_SK] = [MC].[dimManualClass_SK]
--        AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
--     INNER JOIN [edw].[dimActualUse] AS [AU]
--     ON [A].[dimActualUse_SK] = [AU].[dimActualUse_SK]
--        AND (NOT([AU].[Actual Use Code] IN('287', '040')))
--WHERE [A].[dimRollYear_SK] = 2018
--GROUP BY [A].[dimProperty_SK];