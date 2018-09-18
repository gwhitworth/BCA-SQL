DECLARE @p_RY INT;
DECLARE @p_CN INT;
SET @p_RY = 2017;
SET @p_CN = -1;
SELECT [FA].[Roll Year], 
       [RD].[Regional District], 
       'AA'+[AG].[Area Code] AS [Area Code], 
       [AG].[Jurisdiction Code], 
       AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc] AS [Jurisdiction], 
       [PC].[Property Class Code], 
       [PC].[Property Sub Class Code], 
       [FA].[Assessment Code], 
       ISNULL([PC].[Property Sub Class Desc], [PC].[Property Class Desc]) AS [Property Class], 
       [ED].[BCA Code], 
       [FA].dimFolio_SK AS [Folio], 
       [PC].RowSortOrder
      ,[Gross General Land Value]
      ,[Gross General Building Value]
      ,[Gross Other Land Value]
      ,[Gross Other Building Value]
      ,[Gross School Land Value]
      ,[Gross School Building Value]
      ,[Net General Land Value]
      ,[Net General Building Value]
      ,[Net Other Land Value]
      ,[Net Other Building Value]
      ,[Net School Land Value]
      ,[Net School Building Value]
      ,[General Exemptions Land Value]
      ,[General Exemptions Building Value]
      ,[Other Exemptions Land Value]
      ,[Other Exemptions Building Value]
      ,[School Exemptions Land Value]
      ,[School Exemptions Building Value]
      ,[Actual Land Value]
      ,[Actual Building Value]
      ,[Folio Count]
FROM [edw].[FactAllAssessedAmounts] AS [FA]
     INNER JOIN [edw].[dimPropertyClass] AS [PC] ON [FA].[dimPropertyClass_SK] = [PC].[dimPropertyClass_SK]
     INNER JOIN [edw].[dimAssessmentGeography] AS [AG] ON [FA].[dimAssessmentGeography_SK] = [AG].[dimAssessmentGeography_SK]
     INNER JOIN [edw].[dimFolio] AS [FO] ON [FO].[dimFolio_SK] = [FA].[dimFolio_SK]
                                            AND FO.[Folio Status Code] = '01'
     INNER JOIN [edw].[dimRegionalDistrict] AS [RD] ON [RD].dimRegionalDistrict_SK = [FO].dimRegionalDistrict_SK
     LEFT OUTER JOIN [edw].[dimElectoralDistrict] AS [ED] ON [ED].dimJurisdiction_SK = [AG].dimJurisdiction_SK

WHERE [FA].[Roll Year] = @p_RY
      AND AG.[Roll Category Code] = '1'
      AND [AG].[Area Code] IN('01', '08', '09', '10', '11', '14', '15')
     AND [FA].[Cycle Number] = @p_CN
     AND [AG].[Jurisdiction Code] IN('213')
	 and [FA].[Net General Land Value] > 1
ORDER BY [FA].[Roll Year], 
         [RD].[Regional District], 
         [AG].[Area Desc], 
         [Area Code], 
         [AG].[Jurisdiction Code], 
         AG.[Jurisdiction Code]+' '+AG.[Jurisdiction Type Desc]+' of '+AG.[Jurisdiction Desc], 
         [PC].[Property Class Code], 
         [PC].RowSortOrder, 
         [ED].[BCA Code], 
         [FA].dimFolio_SK;
