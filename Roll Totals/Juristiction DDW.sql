DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_BY CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_BY = 'JR';
IF @p_BY = 'JR'
    BEGIN
        SELECT DISTINCT 
               [A1].[Area Code], 
               [A2].[dimJurisdiction_SK], 
               [A2].[dimJurisdiction_BK], 
               [A2].[Jurisdiction Code], 
               [A2].[Jurisdiction Desc], 
               [A2].[Jurisdiction], 
               [A1].[RowSortOrder]
        FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
             [EDW].[edw].[dimAssessmentGeography] AS [A2]
        WHERE([A1].[Area Code] = [A2].[Area Code]
              AND [A1].[Roll Year] = @p_RY
              AND [A1].[Jurisdiction Code] > '199'
              AND [A2].[Roll Year] = @p_RY
              AND [A2].[Jurisdiction Code] > '199')
             AND [A1].[Area Code] IN(@p_AR)
        AND [A2].[Area Code] IN(@p_AR)
        ORDER BY [RowSortOrder], 
                 [Jurisdiction Code];
    END;
    ELSE
    BEGIN
        SELECT 'NA' AS [Area Code], 
               -3 AS [dimJurisdiction_SK], 
               'NA' AS [dimJurisdiction_BK], 
               'NA' AS [Jurisdiction Code], 
               'Not Applicable' AS [Jurisdiction Desc], 
               'Not Applicable' AS [Jurisdiction], 
               -999 AS [RowSortOrder];
    END;




--SELECT
--       'NA' AS [Area Code], 
--       -3 AS [dimJurisdiction_SK], 
--       'NA' AS [dimJurisdiction_BK], 
--       'NA' AS [Jurisdiction Code], 
--       'Not Applicable' AS [Jurisdiction Desc], 
--       'Not Applicable' AS [Jurisdiction], 
--       -999 AS [RowSortOrder]
--UNION
--SELECT DISTINCT 
--       [A1].[Area Code], 
--       [A2].[dimJurisdiction_SK], 
--       [A2].[dimJurisdiction_BK], 
--       [A2].[Jurisdiction Code], 
--       [A2].[Jurisdiction Desc], 
--       [A2].[Jurisdiction], 
--       [A1].[RowSortOrder]
--FROM [EDW].[edw].[dimAssessmentGeography] AS [A1], 
--     [EDW].[edw].[dimAssessmentGeography] AS [A2]
--WHERE([A1].[Area Code] = [A2].[Area Code]
--      AND [A1].[Roll Year] = @p_RY
--      AND [A1].[Jurisdiction Code] > '199'
--      AND [A2].[Roll Year] = @p_RY
--      AND [A2].[Jurisdiction Code] > '199')
--     AND [A1].[Area Code] IN(@p_AR)
--AND [A2].[Area Code] IN(@p_AR)
--ORDER BY [RowSortOrder], 
--         [Jurisdiction Code];
