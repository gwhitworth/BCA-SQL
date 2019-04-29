
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'vwGW'
AND [type] = 'v')
DROP VIEW [dbo].[vwGW];
GO
CREATE VIEW [dbo].[vwGW]
WITH SCHEMABINDING
AS
     SELECT [A].[dimProperty_SK], 
            [A].[Property Class Code], 
            COUNT_BIG(*) AS [JUNK]
     FROM [dbo].[factValuesByAssessmentCodePropertyClassTbl] [A]
          INNER JOIN [dbo].[dimAssessmentGeographyTbl] AS [AG]
          ON [A].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
             AND [AG].[Area Code] = '22'
             AND ([AG].[Neighbourhood Code] IN('701041', '718505'))
          INNER JOIN [dbo].[dimManualClassTbl] AS [MC]
          ON [A].[dimManualClass_SK] = [MC].[dimManualClass_SK]
             AND (NOT([MC].[Manual Class Code] IN('C424', 'D424')))
     WHERE [A].[dimRollYear_SK] = 2018
     GROUP BY [A].[dimProperty_SK], 
              [A].[Property Class Code];
GO
CREATE UNIQUE CLUSTERED INDEX [IDX_GW99w]
ON [dbo].[vwGW]
([dimProperty_SK], [Property Class Code]
);  
GO
SELECT [dimProperty_SK], 
       '0'+LEFT([listStr], LEN([listStr]) - 1) AS [PCodes]
FROM
(
    SELECT [A].[dimProperty_SK], 
           STUFF(
    (
        SELECT [Property Class Code]+' | '
        FROM [dbo].[vwGW] AS [B]
        WHERE [B].[dimProperty_SK] = [A].[dimProperty_SK] FOR XML PATH('')
    ), 1, 1, '') AS [listStr]
    FROM [dbo].[vwGW] AS [A]
    GROUP BY [A].[dimProperty_SK]
) AS [TBL];