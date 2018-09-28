DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_SD CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_SD = '05';
SELECT DISTINCT 
       [AG].dimJurisdiction_BK, 
       [AG].dimJurisdiction_SK, 
       [AG].[Jurisdiction Code]
FROM [EDW].[edw].[dimFolio] AS [FO]
     INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[School  District Code] = [FO].[School  District Code]
                                                     AND [SD].[Roll Year] = [FO].[Roll Year]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FO].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                          AND [AG].[Roll Category Code] = '1'
                                                          AND [AG].[Roll Year] = [FO].[Roll Year]
WHERE [FO].[Roll Year] = @p_RY
      AND [FO].[School  District Code] IN(@p_SD)
ORDER BY [AG].[Jurisdiction Code];