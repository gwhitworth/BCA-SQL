DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_RHD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_RHD = '20';
SELECT [AG].[Jurisdiction Code], 
       [PC].[Property Class Code], 
       ISNULL(SUM([Occur Count]), 0) AS [Occurrences], 
       IIF(COUNT(CASE
                     WHEN [FA].[Assessment Code] = '01'
                          AND [PC].[Property Class Code] = '01'
                     THEN [FA].[dimFolio_SK]
                 END) = 0, COUNT(DISTINCT [FA].dimFolio_SK), COUNT(CASE
                                                                       WHEN [FA].[Assessment Code] = '01'
                                                                            AND [PC].[Property Class Code] = '01'
                                                                       THEN [FA].[dimFolio_SK]
                                                                   END)) AS [Folio_Count], 
       IIF(SUM([FA].[Net General Land Value]) = 0, NULL, SUM([FA].[Net General Land Value])) AS [Net_Gen_Land], 
       IIF(SUM([FA].[Net General Building Value]) = 0, NULL, SUM([FA].[Net Other Building Value])) AS [Net_Gen_Improvements], 
       IIF(SUM([FA].[Net Other Land Value]) = 0, NULL, SUM([FA].[Net Other Land Value])) AS [Net_Land], 
       IIF(SUM([FA].[Net Other Building Value]) = 0, NULL, SUM([FA].[Net Other Building Value])) AS [Net_Improvements]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalHospitalDistrict] AS [RHD] ON [RHD].dimRegionalHospitalDistrict_SK = [FO].dimRegionalHospitalDistrict_SK
     LEFT OUTER JOIN
(
    SELECT [FAV].dimFolio_SK, 
           [FAV].[Property Class Code], 
           COUNT(*) - 1 AS [Occur Count]
    FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
    WHERE [FAV].[Roll Year] = @p_RY
          AND AG.[Roll Category Code] = '1'
          AND [FAV].[Cycle Number] <= @p_CN
          AND [Assessment Code] = '02'
    GROUP BY [FAV].dimFolio_SK, 
             [FAV].[Property Class Code]
    HAVING COUNT(*) > 1
) AS [OCCUR] ON [OCCUR].dimFolio_SK = [FA].dimFolio_SK
WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [FA].[Cycle Number] = @p_CN
      AND [RHD].[Region Hospital District Code] IN(@p_RHD)
     AND [PC].[Property Sub Class Code] = ('0202')
GROUP BY [AG].[Jurisdiction Code], 
         [PC].[Property Class Code]
ORDER BY [AG].[Jurisdiction Code], 
         [PC].[Property Class Code];