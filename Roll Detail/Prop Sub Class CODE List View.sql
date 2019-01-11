
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'dimPSubClassCodeList'
AND [type] = 'v')
DROP VIEW [edw].[dimPSubClassCodeList];
GO
CREATE VIEW [edw].[dimPSubClassCodeList]
AS
     SELECT [A].[Folio Number], 
            [A].[dimRollYear_SK], 
     (
         SELECT [dbo].[FNC_FORMAT_Property_SUBCLASS_CODE_List]
         (STUFF(
         (
             SELECT DISTINCT 
                    '; '+[B].[Property Sub Class Code]
             FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [B]
             WHERE [B].[Folio Number] = [A].[Folio Number]
             ORDER BY '; '+[B].[Property Sub Class Code] FOR XML PATH('')
         ), 1, 1, '')
         )
     ) AS [LST]
     FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
     GROUP BY [A].[Folio Number], 
              [A].[dimRollYear_SK];