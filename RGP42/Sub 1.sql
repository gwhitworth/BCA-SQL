DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RD = '03';
SELECT
       1 AS [REC_NUM],
       AG.[Jurisdiction Code], 
       COUNT(DISTINCT CASE
                          WHEN [FA].[Assessment Code] = '01'
                      -- AND [FA].[Net General Land Value] > 1
                          THEN [FA].dimFolio_SK
                      END) AS [Gen Folio], 
       IIF(COUNT([OCCUR].[Occur Count]) = 0, NULL, COUNT([OCCUR].[Occur Count])) AS [Hosp Folio], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '01'
               THEN IIF([FA].[Net Other Land Value] = 0, NULL, [FA].[Net Other Land Value])
           END) AS [Land], 
       SUM(CASE
               WHEN [FA].[Assessment Code] = '02'
               THEN IIF([FA].[Net Other Building Value] = 0, NULL, [FA].[Net Other Building Value])
           END) AS [Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] 
			ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
			AND AG.[Roll Category Code] = '1'
    WHERE [FAV].[Roll Year] = @p_RY
          AND [FAV].[Cycle Number] <= @p_CN
          AND [FAV].[Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK

WHERE [FA].[Roll Year] = @p_RY
      AND [FA].[Cycle Number] = @p_CN
      AND [FA].[Current Cycle Flag] = 'Current Cycle Only'
GROUP BY [FA].[Roll Year], 
         '(AA'+[AG].[Area Code]+')', 
         AG.[Jurisdiction Code]+'   '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc]
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [Area Code], 
         [Jurisdiction], 
         [ED].[BCA Code];