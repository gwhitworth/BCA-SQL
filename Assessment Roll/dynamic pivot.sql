If(OBJECT_ID('tempdb..#Temp2') Is Not Null)
Begin
    Drop Table #Temp2
End
create table #Temp2
(
    ColumnName varchar(50), 
	Value varchar(50)
)
Insert into #Temp2 Values('Gen Gross Land','Gross General Value')
Insert into #Temp2 Values('Gen Gross Impr', 'Gross General Value')
Insert into #Temp2 Values('Sch Gross Land','Gross School Value')
Insert into #Temp2 Values('Sch Gross Impr','Gross School Value')
Insert into #Temp2 Values('Hsptl Gross Land','Gross Other Value')
Insert into #Temp2 Values('Hsptl Gross Impr','Gross Other Value')

DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX)

select @cols = STUFF((SELECT ',' + QUOTENAME(ColumnName) 
                    from #Temp2
                    group by ColumnName
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = N'SELECT ' + @cols + N' from 
             (
                select value, ColumnName
                from #Temp2
            ) x
            pivot 
            (
                max(value)
                for ColumnName in (' + @cols + N')
            ) p '

exec sp_executesql @query;