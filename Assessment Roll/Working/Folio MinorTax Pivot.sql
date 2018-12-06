
--USE AdventureWorks
--GO
--SELECT VendorID, [164] AS Emp1, [198] AS Emp2, [223] AS Emp3, [231] AS Emp4, [233] AS Emp5
--INTO #Test
--FROM 
--(SELECT PurchaseOrderID, EmployeeID, VendorID
--FROM Purchasing.PurchaseOrderHeader) AS p
--PIVOT
--(
--COUNT (PurchaseOrderID)
--FOR EmployeeID IN
--( [164], [198], [223], [231], [233] )
--) AS pvt;

WITH CUST_CTE([dimFolio_SK], 
              [CAT], 
              [CODE])
     AS (SELECT [dimFolio_SK], 
                [BTC].[Minor Tax Category] AS [CAT], 
                [TC].[BCA Code] AS [CODE]
         FROM [edw].[bridgeFolioMinorTax] AS [BTC]
              INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
              ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
         WHERE [dimFolio_SK] = 4621915)
     SELECT [dimFolio_SK], 
            [LA - LOCAL AREA], 
            [SM - SPECIFIED MUNICIPAL], 
            [SR - SPECIFIED REGIONAL ], 
            [SA - SERVICE AREA], 
            [DE - DEFINED], 
            [ID - IMPROVEMENT DISTRICT], 
            [GS - GENERAL SERVICE], 
            [IT - ISLANDS TRUST]
     FROM
     (
         SELECT [dimFolio_SK], 
                [CAT], 
                [CODE]
         FROM [CUST_CTE]
     ) [C] PIVOT(MAX([CODE]) FOR [CAT] IN([LA - LOCAL AREA], 
                                          [SM - SPECIFIED MUNICIPAL], 
                                          [SR - SPECIFIED REGIONAL ], 
                                          [SA - SERVICE AREA], 
                                          [DE - DEFINED], 
                                          [ID - IMPROVEMENT DISTRICT], 
                                          [GS - GENERAL SERVICE], 
                                          [IT - ISLANDS TRUST])) AS [PivotTable];

--SELECT [dimFolio_SK],[BTC].[Minor Tax Category Code], [TC].[BCA Code]
--FROM [edw].[bridgeFolioMinorTax] AS [BTC]
--     INNER JOIN [edw].[dimMinorTaxCode] AS [TC]
--     ON [BTC].[dimMinorTaxCode_SK] = [TC].[dimMinorTaxCode_SK]
--WHERE [dimFolio_SK] = 4621915;