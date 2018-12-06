create table #customers ( IID INT IDENTITY(1,1),col0 varchar(90),col1 varchar(90))

GO

-- 1st set

insert into #customers values ( 'NAME','A_NM')

insert into #customers values ( 'ADDRESS','A_ADR')

insert into #customers values ( 'PHONE','A_PH')

insert into #customers values ( 'EMAIL','A_EMAIL')

-- 2nd set

insert into #customers values ( 'NAME','B_BM')

insert into #customers values ( 'ADDRESS','B_ADR')

insert into #customers values ( 'PHONE','B_XYZ')

insert into #customers values ( 'EMAIL','B_PH')

-- 3rd set

insert into #customers values ( 'NAME','C_BM')

insert into #customers values ( 'ADDRESS','C_ADR')

insert into #customers values ( 'PHONE','C_XYZ')

insert into #customers values ( 'EMAIL','C_EMAIL')
GO
WITH CUST_CTE(iid, COL0,COL1,RID)

AS

(

SELECT iid, COL0,COL1 , ROW_NUMBER() OVER (PARTITION BY (COL0)ORDER BY IID) AS RID FROM #customers

)

SELECT NAME,ADDRESS,PHONE,EMAIL

FROM

(SELECT COL0,COL1,RID

FROM CUST_CTE)C

PIVOT

(

max(COL1)

FOR COL0 IN (NAME,[ADDRESS],PHONE,EMAIL)

) AS PivotTable;
GO
SELECt * from PivotTable
