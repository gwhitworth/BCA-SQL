create table #temp
(
  id int,
  teamid int,
  userid int,
  elementid int,
  phaseid int,
  effort decimal(10, 5)
)

insert into #temp values (1,1,1,3,5,6.74)
insert into #temp values (2,1,1,3,6,8.25)
insert into #temp values (3,1,1,4,1,2.23)
insert into #temp values (4,1,1,4,5,6.8)
insert into #temp values (5,1,1,4,6,1.5)

select elementid
  , [1] as phaseid1
  , [5] as phaseid5
  , [6] as phaseid6
from
(
  select elementid, phaseid, effort
  from #temp
) x
pivot
(
  max(effort)
  for phaseid in([1], [5], [6])
)p;


DECLARE @cols AS NVARCHAR(MAX),
    @query  AS NVARCHAR(MAX);

select @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.phaseid) 
            FROM #temp c
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

set @query = 'SELECT elementid, ' + @cols + ' from 
            (
                select elementid, phaseid, effort
                from #temp
           ) x
            pivot 
            (
                 max(effort)
                for phaseid in (' + @cols + ')
            ) p '


execute(@query)