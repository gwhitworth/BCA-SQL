SELECT  AV.[Roll Year], 
		PC.[Property Class], 
		PC.[Property Sub Class], 
		SUM(AV.[Actual Building Value]) AS [Total Building Value], 
		SUM(AV.[Actual Land Value]) AS [Total Land Value],
		SUM(AV.[Actual Building Value]) + SUM(AV.[Actual Land Value]) AS [Total Actual Value], 
		SUM(AV.[Gross School Land Value]) AS [Gross School Land Value], 
		SUM(AV.[Gross School Building Value]) AS [Gross School Building Value], 
        SUM(AV.[Net School Land Value]) AS [Net School Land Value], 
		SUM(AV.[Net School Building Value]) AS [Net School Building Value], 
		SUM(AV.[School Exemptions Land Value]) AS [School Exemption Land Value], 
        SUM(AV.[School Exemptions Building Value]) AS [School Exemption Building Value], 
		COUNT(DISTINCT AV.dimFolio_SK) AS [Total Folios], 
        SUM(CASE WHEN PC.[Property Sub Class Code] = '0202' THEN AV.[Net General Building Value] ELSE 0 END) AS [PC0202 Only], 
        SUM(CASE WHEN PC.[Property Class Code] = '01' THEN AV.[Net School Land Value] ELSE 0 END) AS [Net School Res], 
        SUM(CASE WHEN PC.[Property Class Code] = '01' THEN 0 ELSE AV.[Net School Land Value] END) AS [Net School NonRes], 
		SUM(AV.[Net School Land Value] + AV.[Net School Building Value]) AS [Total Net School Value]

FROM edw.FactAllAssessedAmounts AS AV INNER JOIN
     edw.dimPropertyClass AS PC ON AV.dimPropertyClass_SK = PC.dimPropertyClass_SK INNER JOIN
     edw.dimAssessmentGeography AS AG ON AV.dimAssessmentGeography_SK = AG.dimAssessmentGeography_SK
WHERE AV.[Roll Year] = 2018
GROUP BY AV.[Roll Year], PC.[Property Class], PC.[Property Sub Class]
ORDER BY AV.[Roll Year], PC.[Property Class], PC.[Property Sub Class]