/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FAV].[Roll Year], 
       [AR].[Area], 
       [JR].[Jurisdiction Code], 
       [JR].[Jurisdiction Desc], 
       [SD].[School  District Code], 
       [PC].[RowSortOrder], 
       [PC].[Property Class Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class]
	  ,SUM([Folio Count]) AS [Folio Count]
      ,SUM([Gross General Land Value]) AS [Gross General Land Value]
      ,SUM([Gross General Building Value]) AS [Gross General Building Value]
      ,SUM([Gross Other Land Value]) AS [Gross Other Land Value]
      ,SUM([Gross Other Building Value]) AS [Gross Other Building Value]
      ,SUM([Gross School Land Value]) AS [Gross School Land Value]
      ,SUM([Gross School Building Value]) AS [Gross School Building Value]
      ,SUM([Net General Land Value]) AS [Net General Land Value]
      ,SUM([Net General Building Value]) AS [Net General Building Value]
      ,SUM([Net Other Land Value]) AS [Net Other Land Value]
      ,SUM([Net Other Building Value]) AS [Net Other Building Value]
      ,SUM([Net School Land Value]) AS [Net School Land Value]
      ,SUM([Net School Building Value]) AS [Net School Building Value]
      ,SUM([General Exemptions Land Value]) AS [General Exemptions Land Value]	
      ,SUM([General Exemptions Building Value]) AS [General Exemptions Building Value]	
      ,SUM([Other Exemptions Land Value]) AS [Other Exemptions Land Value]
      ,SUM([Other Exemptions Building Value]) AS [Other Exemptions Building Value]
      ,SUM([School Exemptions Land Value]) AS [School Exemptions Land Value]
      ,SUM([School Exemptions Building Value]) AS [School Exemptions Building Value]
      ,SUM([Actual Land Value]) AS [Actual Land Value]
      ,SUM([Actual Building Value]) AS [Actual Building Value]
      
  FROM [EDW].[edw].[FactAllAssessedAmounts] AS [FAV]
         INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FAV].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
         INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FAV].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
                                                              AND AG.[Roll Category Code] = '1'
         INNER JOIN [edw].[dimJurisdiction] AS JR ON AG.dimJurisdiction_SK = JR.dimJurisdiction_SK
         INNER JOIN [edw].[dimSchoolDistrict] AS [SD] ON [SD].[dimJurisdiction_SK] = [JR].[dimJurisdiction_SK]
         INNER JOIN [edw].[dimArea] AS [AR] ON [JR].[dimArea_SK] = [AR].[dimArea_SK]
                                               AND [AR].[Area Code] IN('01', '08', '09', '10', '11', '14')
         INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FAV].[dimFolio_SK]
                                                AND [FO].[Folio Status Code] = '01'
												AND [FO].[BC Transit Flag] = 'Y'
WHERE [FAV].[Roll Year] = @p_RY
      AND [FAV].[Cycle Number] <= @p_CN
      AND [JR].[Jurisdiction Code] = '317'
      AND [Current Cycle Flag] = 'Yes'

GROUP BY [FAV].[Roll Year], 
       [AR].[Area], 
       [JR].[Jurisdiction Code], 
       [JR].[Jurisdiction Desc], 
       [SD].[School  District Code], 
       [PC].[RowSortOrder], 
       [PC].[Property Class Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc])
ORDER BY [FAV].[Roll Year], 
         [AR].[Area], 
         [JR].[Jurisdiction Code], 
         [JR].[Jurisdiction Desc], 
         [SD].[School  District Code], 
         [PC].[RowSortOrder], 
         [PC].[Property Class Code], 
         ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]);
