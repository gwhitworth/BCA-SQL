SELECT TOP 200 [A].[Folio Number], 
(
    SELECT [dbo].[FNC_FORMAT_Property_ID_List]
    (STUFF(
    (
        SELECT '; '+CAST([B].[PID] AS VARCHAR(50))
        FROM [edw].[dimParcel] AS [B]
             INNER JOIN [edw].[bridgeParcelFolio] AS [C]
             ON [B].[dimParcel_SK] = [C].[dimParcel_SK]
        WHERE [C].[Folio Number] = [A].[Folio Number]
        ORDER BY [B].[PID] FOR XML PATH('')
    ), 1, 1, '')
    )
) AS [LST]
FROM [edw].[bridgeParcelFolio] AS [A]
WHERE [A].[Roll Year] = 2017
GROUP BY [A].[Folio Number];