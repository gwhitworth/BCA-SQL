SELECT TOP 20 [A].[Folio Number], 
(
    SELECT [dbo].[FNC_FORMAT_Property_Class_List]
    (STUFF(
    (
        SELECT DISTINCT '; '+[B].[Property Class]
        FROM [edw].[dimProperty] AS [B]
        WHERE [B].[Folio Number] = [A].[Folio Number]
        ORDER BY '; '+[B].[Property Class] FOR XML PATH('')
    ), 1, 1, '')
    )
) AS [LST]
FROM [edw].[dimProperty] AS [A]
WHERE [A].[Roll Year] = 2017
GROUP BY [A].[Folio Number];