DECLARE @p_JR CHAR(3);
DECLARE @p_RY INT;
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_JR = '213';
SET @p_BY = 'NH';


IF @p_BY = 'NH'
    BEGIN
        SELECT DISTINCT 
               [A1].[Jurisdiction Code], 
               [A2].[Neighbourhood Code], 
               [A2].[Neighbourhood Desc], 
               [A2].[Neighbourhood], 
               [A1].[RowSortOrder]
        FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
             [EDW].[edw].[dimAssessmentGeography] AS [A2]
        WHERE [A1].[Jurisdiction Code] = [A2].[Jurisdiction Code]
              AND [A1].[Roll Year] = @p_RY
              AND [A2].[Roll Year] = @p_RY
              AND [A1].[Jurisdiction Code] IN(@p_JR)
        AND [A2].[Jurisdiction Code] IN(@p_JR)
        AND [A2].[Neighbourhood] NOT LIKE '%DO NOT USE%'
        ORDER BY [RowSortOrder], 
                 [Neighbourhood Code];
    END;
    ELSE
    BEGIN
        SELECT 'NA' AS [Jurisdiction Code], 
               'NA' AS [Neighbourhood Code], 
               'Not Applicable' AS [Neighbourhood Desc], 
               'Not Applicable' AS [Neighbourhood], 
               -999 AS [RowSortOrder];
    END;












--SELECT DISTINCT 
--       [A1].[Jurisdiction Code], 
--       [A2].[Neighbourhood Code], 
--       [A2].[Neighbourhood Desc], 
--       [A2].[Neighbourhood], 
--       [A1].[RowSortOrder]
--FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
--     [EDW].[edw].[dimAssessmentGeography] AS [A2]
--WHERE [A1].[Jurisdiction Code] = [A2].[Jurisdiction Code]
--      AND [A1].[Roll Year] = @p_RY
--      AND [A2].[Roll Year] = @p_RY
--      AND [A1].[Jurisdiction Code] IN (@p_JR)
--      AND [A2].[Jurisdiction Code] IN (@p_JR)
--      AND [A2].[Neighbourhood] NOT LIKE '%DO NOT USE%'

--UNION
--SELECT
--       'NA', 
--       'NA', 
--       'Not Applicable', 
--       'Not Applicable', 
--       -999
--ORDER BY [RowSortOrder], 
--         [Neighbourhood Code];