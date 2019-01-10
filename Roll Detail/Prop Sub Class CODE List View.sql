
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'dimPSubClassCodeList'
AND [type] = 'v')
DROP VIEW [edw].[dimPSubClassCodeList];
GO
CREATE VIEW [edw].[dimPSubClassCodeList]
AS
     SELECT [FO].[dimFolio_BK], 
            [FO].[dimRollYear_SK], 
     (
         SELECT [dbo].[FNC_FORMAT_Property_SUBCLASS_CODE_List]
         (STUFF(
         (
             SELECT DISTINCT 
                    '; '+[B].[Property Sub Class Code]
             FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [B]
			 INNER JOIN [edw].[dimFolio] AS [FO]
			 ON [FO].[dimFolio_SK] = [B].[dimFolio_SK]
             WHERE [FO].[dimFolio_BK] = [FO].[dimFolio_BK]
             ORDER BY '; '+[B].[Property Sub Class Code] FOR XML PATH('')
         ), 1, 1, '')
         )
     ) AS [LST]
     FROM [edw].[factValuesByAssessmentCodePropertyClass] AS [A]
	 INNER JOIN [edw].[dimFolio] AS [FO]
			 ON [FO].[dimFolio_SK] = [A].[dimFolio_SK]
     GROUP BY [FO].[dimFolio_BK], 
              [FO].[dimRollYear_SK];