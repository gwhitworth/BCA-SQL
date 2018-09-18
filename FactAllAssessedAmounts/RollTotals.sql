SELECT AV.[Roll Year], 
       PC.[Property Class], 
       PC.[Property Sub Class], 
       --SUM(AV.[Actual Building Value]) AS [Total Building Value], 
       --SUM(AV.[Actual Land Value]) AS [Total Land Value], 
       --SUM(AV.[Actual Building Value]) + SUM(AV.[Actual Land Value]) AS [Total Actual Value], 
       COUNT(DISTINCT AV.dimFolio_SK) AS [Total Folios], 
       --SUM(AV.[Gross General Land Value]) AS [Gross General Land Value], 
       SUM(AV.[Gross Other Land Value]) AS [Gross Other Land Value], 
       SUM(AV.[Gross Other Building Value]) AS [Gross Other Building Value], 
       SUM(AV.[Other Exemptions Land Value]) * -1 AS [Other Exemption Land Value], 
       SUM(AV.[Other Exemptions Building Value]) * -1 AS [Other Exemption Building Value], 
       --SUM(AV.[Gross General Building Value]) AS [Gross General Building Value], 
       --SUM(AV.[Net General Land Value]) AS [Net General Land Value], 
       --SUM(AV.[Net General Building Value]) AS [Net General Building Value], 
       --SUM(AV.[General Exemptions Land Value]) * -1 AS [General Exemption Land Value], 
       --SUM(AV.[General Exemptions Building Value]) * -1 AS [General Exemption Building Value], 
       --SUM(AV.[Gross School Land Value]) AS [Gross School Land Value], 
       --SUM(AV.[Gross School Building Value]) AS [Gross School Building Value], 
       --SUM(AV.[Net School Land Value]) AS [Net School Land Value], 
       --SUM(AV.[Net School Building Value]) AS [Net School Building Value], 
       --SUM(AV.[School Exemptions Land Value]) * -1 AS [School Exemption Land Value], 
       --SUM(AV.[School Exemptions Building Value]) * -1 AS [School Exemption Building Value], 
       SUM(AV.[Net Other Land Value]) AS [Net Other Land Value], 
       SUM(AV.[Net Other Building Value]) AS [Net Other Building Value]
       --SUM(CASE
       --        WHEN PC.[Property Sub Class Code] = '0202'
       --        THEN AV.[Net General Land Value]
       --        ELSE 0
       --    END) AS [PC0202 Only], 
       --SUM(CASE
       --        WHEN PC.[Property Class Code] = '01'
       --        THEN AV.[Net School Land Value]
       --        ELSE 0
       --    END) AS [Net School Res], 
       --SUM(CASE
       --        WHEN PC.[Property Class Code] = '01'
       --        THEN 0
       --        ELSE AV.[Net School Land Value]
       --    END) AS [Net School NonRes], 
       --SUM(AV.[Net General Land Value] + AV.[Net General Building Value]) AS [Net General Value], 
       --SUM(AV.[Net Other Land Value] + AV.[Net Other Building Value]) AS [Net Other Value], 
       --SUM(AV.[Net School Land Value] + AV.[Net School Building Value]) AS [Net School Value]
FROM edw.FactAllAssessedAmounts AS AV
     INNER JOIN edw.dimPropertyClass AS PC ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK
     INNER JOIN edw.dimAssessmentGeography AS AG ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
WHERE(AG.[Roll Year] = 2017)
 AND [AV].[Cycle Number] = -1
     AND (AG.[Jurisdiction Code] = '317')

     --AND (AV.[Current Cycle Flag] = 'Current Cycle Only')
GROUP BY AV.[Roll Year], 
         PC.[Property Class], 
         PC.[Property Sub Class]
		 ;