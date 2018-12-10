/** Build up a Table to work with. **/
DECLARE @T TABLE
    (
    ID INT NOT NULL PRIMARY KEY
    , hProp INT NOT NULL
    , iDayOfMonth INT NOT NULL
    , dblTargetPercent DECIMAL(6,4) NOT NULL
    )

INSERT INTO @T
(ID, hProp, iDayOfMonth, dblTargetPercent)
VALUES (117,10,5,0.1400)
        , (118, 10, 10, 0.0500) 
        , (119, 10, 15, 0.0100)
        , (120, 10, 20, 0.0100)
		, (121, 10, 25, 0.0200)

SELECT * FROM @T

/** Create a CTE and give us predictable names to work with for
    date and percentage
    **/
;WITH CTE_Rank AS
    (
    SELECT hProp
--        , iDayOfMonth 
        , dblTargetPercent 
--        , sDateName = 'iDateTarget' + CAST(DENSE_RANK() OVER (PARTITION BY hPRop ORDER BY iDayOfMonth) AS VARCHAR(10))
        , sPercentName = 'dblPercentTarget' + CAST(DENSE_RANK() OVER (PARTITION BY hPRop ORDER BY iDayOfMonth) AS VARCHAR(10))
    FROM @T
    )
SELECT hProp 

    , dblPercentTarget1 = MAX(dblPercentTarget1)

    , dblPercentTarget2 = MAX(dblPercentTarget2)

    , dblPercentTarget3 = MAX(dblPercentTarget3)

    , dblPercentTarget4 = MAX(dblPercentTarget4)

    , dblPercentTarget5 = MAX(dblPercentTarget5)

FROM CTE_Rank AS R

    PIVOT(MAX(dblTargetPercent) FOR sPercentName IN (dblPercentTarget1, dblPercentTarget2, dblPercentTarget3, dblPercentTarget4, dblPercentTarget5)) AS TargetPercentName
GROUP BY hProp

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