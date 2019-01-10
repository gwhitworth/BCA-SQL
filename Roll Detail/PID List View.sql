
IF EXISTS(SELECT 1
FROM [sys].[views]
WHERE [name] = 'dimPidList'
AND [type] = 'v')
DROP VIEW [edw].[dimPidList];
GO
CREATE VIEW [edw].[dimPidList]
AS
     SELECT [A].[dimFolio_SK], 
            [A].[dimRollYear_SK], 
     (
         SELECT [dbo].[FNC_FORMAT_Property_ID_List]
         (STUFF(
         (
             SELECT DISTINCT 
                    '; '+[B].[PID]
             FROM [edw].[dimParcel] AS [B]
                  INNER JOIN [edw].[bridgeParcelFolio] AS [C]
                  ON [B].[dimParcel_SK] = [C].[dimParcel_SK]
             WHERE [C].[dimFolio_SK] = [A].[dimFolio_SK]
             ORDER BY '; '+[B].[PID] FOR XML PATH('')
         ), 1, 1, '')
         )
     ) AS [LST]
     FROM [edw].[bridgeParcelFolio] AS [A]
     GROUP BY [A].[dimFolio_SK], 
              [A].[dimRollYear_SK];