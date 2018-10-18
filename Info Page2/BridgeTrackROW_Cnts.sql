
/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @p_RY [INT];;
DECLARE @p_CN INT
DECLARE @p_JR CHAR(3);
DECLARE @p_JR2 CHAR(3);
DECLARE @p_TYPE CHAR(2);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_JR = '001';
SET @p_JR2 = '001';
SET @p_TYPE = 'AR';
SELECT [Jurisdiction Code], 
       COUNT(CASE
                 WHEN [A].[Exempt Tax Code] = '24'
                 THEN [a].[dimTaxExemptions_SK]
             END) AS [BridgeCnt], 
       COUNT(CASE
                 WHEN [A].[Exempt Tax Code] = '25'
                 THEN [a].[dimTaxExemptions_SK]
             END) AS [TrackCnt], 
       COUNT(CASE
                 WHEN [A].[Exempt Tax Code] = '26'
                 THEN [a].[dimTaxExemptions_SK]
             END) AS [RightOfWayCnt]
FROM [EDW].[edw].[FactActualValue] AS [A]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG]
     ON [AG].[dimAssessmentGeography_SK] = [A].[dimAssessmentGeography_SK]
WHERE [A].[Roll Year] = @p_RY
      --AND [Jurisdiction Code] IN(@p_JR)
GROUP BY [Jurisdiction Code]
ORDER BY [Jurisdiction Code];