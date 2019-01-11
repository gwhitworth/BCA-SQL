
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'dimPCodeList'
AND [type] = 'v')
DROP VIEW [edw].[dimPCodeList];
GO
CREATE VIEW [edw].[dimPCodeList]
AS
     SELECT [A].[Folio Number], 
            [A].[dimRollYear_SK], 
     (
         SELECT [dbo].[FNC_FORMAT_Property_Code_List]
         (STUFF(
         (
             SELECT DISTINCT 
                    '; '+[B].[Property Class Code]
             FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [B]
             WHERE [B].[Folio Number] = [A].[Folio Number]
             ORDER BY '; '+[B].[Property Class Code] FOR XML PATH('')
         ), 1, 1, '')
         )
     ) AS [LST]
     FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     GROUP BY [A].[Folio Number], 
              [A].[dimRollYear_SK];