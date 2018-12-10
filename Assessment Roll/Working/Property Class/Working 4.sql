;WITH CTE_Rank AS
    (
    SELECT p.[dimFolio_SK]
        , p.[Property Class Code]
        , iDayOfMonth 
        , dblTargetPercent 
        , sDateName = 'iDateTarget' + CAST(DENSE_RANK() OVER (PARTITION BY hPRop ORDER BY iDayOfMonth) AS VARCHAR(100))
        , sPercentName = 'dblPercentTarget' + CAST(DENSE_RANK() OVER (PARTITION BY hPRop ORDER BY iDayOfMonth) AS VARCHAR(100))
    FROM [edw].[FactAssessedValue] p
    )
--SELECT hProp 
--    , iDateTarget1 = MAX(iDateTarget1)
--    , dblPercentTarget1 = MAX(dblPercentTarget1)
--    , iDateTarget2 = MAX(iDateTarget2)
--    , dblPercentTarget2 = MAX(dblPercentTarget2)
--    , iDateTarget3 = MAX(iDateTarget3)
--    , dblPercentTarget3 = MAX(dblPercentTarget3)
--    , iDateTarget4 = MAX(iDateTarget4)
--    , dblPercentTarget4 = MAX(dblPercentTarget4)
--    , iDateTarget5 = MAX(iDateTarget5)
--    , dblPercentTarget5 = MAX(dblPercentTarget5)

--FROM CTE_Rank AS R
--    PIVOT(MAX(iDayOfMonth) FOR sDateName IN ([iDateTarget1], [iDateTarget2], [iDateTarget3], [iDateTarget4], [iDateTarget5])) AS DayOfMonthName 
--    PIVOT(MAX(dblTargetPercent) FOR sPercentName IN (dblPercentTarget1, dblPercentTarget2, dblPercentTarget3, dblPercentTarget4, dblPercentTarget5)) AS TargetPercentName
--GROUP BY hProp


--SELECT 
--[ID],
--       [Class Code], 
--       [Sub Class], 

--VAL1 =       MAX([GG Val]), 
--VAL2 =      MAX([GO Val]), 
--VAL3 =       MAX([GS Val])

--FROM (
--SELECT 
--      p.[dimFolio_SK]
--      , p.[Property Class Code]
--      , p.[Property Sub Class Code] 
--      , p.[Gross General Value]
--      , p.[Gross Other Value]
--	  , p.[Gross School Value]
--      --,pd.DetailType + CAST(DENSE_RANK() OVER (PARTITION BY p.OwnerID ORDER BY p.PetName ASC) AS NVARCHAR) AS [PetNumber]
--      --,'PetName' + CAST(DENSE_RANK() OVER (PARTITION BY p.OwnerID ORDER BY p.PetName ASC) AS NVARCHAR) AS [PetNamePivot]
--FROM[edw].[FactAssessedValue] p

--) AS query
--PIVOT (MAX([Gross General Value])
--      FOR PetNumber IN ([Gender1],[Gender2],[Gender3], [Breed1], [Breed2], [Breed3])) AS Pivot1
--PIVOT (MAX(PetName)
--      FOR PetNamePivot IN ([PetName1],[PetName2],[PetName3])) AS Pivot2
--GROUP BY
--  [dimFolio_SK]
--, [Property Class Code]
--, [Property Sub Class Code]
--ORDER BY [dimFolio_SK]