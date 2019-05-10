SELECT [LINE_NO], 
       [RET_ADDR], 
       [AREA_NAME_AND_ADDRESS]
FROM [Reporting].[dimOfficeAddresses]
WHERE [AREA_CODE] = '01';

WITH AreaOfficeLines
     AS (SELECT [AREA_CODE], 
                [RET_ADDR], 
                [Line1], 
                [Line2], 
                [Line3], 
                [Line4], 
                [Line5], 
                [Line6]
         FROM
         (
             SELECT [AREA_CODE], 
                    [RET_ADDR], 
                    'Line'+[LINE_NO] AS [LINE_NO], 
                    [AREA_NAME_AND_ADDRESS]
             FROM [Reporting].[dimOfficeAddresses]
         ) [SourceTable] PIVOT(MAX([AREA_NAME_AND_ADDRESS]) FOR [LINE_NO] IN([Line1], 
                                                                             [Line2], 
                                                                             [Line3], 
                                                                             [Line4], 
                                                                             [Line5], 
                                                                             [Line6])) AS [OfficeAddressLine])
     SELECT *
     FROM [AreaOfficeLines];