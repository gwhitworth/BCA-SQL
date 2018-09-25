DECLARE @p_RY INT;
DECLARE @p_CN INT;
DECLARE @p_AR CHAR(2);
DECLARE @p_JR CHAR(3);
SET @p_RY = 2017;
SET @p_CN = -1;
SET @p_AR = '01';
SET @p_JR = '213';
SET @p_JR = '000';
SELECT DISTINCT 
       [AR].[Area Code], 
       [Jurisdiction Code]
FROM edw.dimJurisdiction AS [JR]
     INNER JOIN [edw].[dimArea] AS [AR] ON [JR].dimArea_SK = [AR].dimArea_SK
WHERE([JR].dimRollYear_SK = @p_RY)
     AND [Jurisdiction Code] IN(@p_JR)
UNION
SELECT DISTINCT 
       [AR].[Area Code], 
       NULL
FROM [edw].[dimArea] AS [AR]
WHERE([AR].dimRollYear_SK = @p_RY)
     AND [AR].[Area Code] IN(@p_AR)
ORDER BY [AR].[Area Code], 
         [Jurisdiction Code];