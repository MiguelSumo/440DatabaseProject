if object_id('GetRevenueByLocation') is not null
drop proc GetRevenueByLocation;
go
create proc GetRevenueByLocation as
begin
if object_id('#temp') is not null
drop table #temp;
select locationid, city, stateorprovince, totaldue
into #temp
from locations join addresses on
locations.locationid = addresses.partyid
join rentals on rentals.pickuplocation = locations.locationid
join rentalorders on rentalorders.rentalid = rentals.rentalid;

declare @cols nvarchar(max);
declare @colsalias nvarchar(max);
declare @sql nvarchar(max);
select @cols = (select string_agg(location,',') from (select distinct concat('[',locationid,']') as location from #temp)t);
select @colsalias = (select string_agg(address,',') from (select distinct concat('[',locationid,']',' as "', city,', ',stateorprovince,'"') as address from #temp)t);

set @sql = N'select ''TotalRevenue'' as ''TotalRevenueByLocation'','+ @colsalias + '
from (select locationid, totaldue from #temp) as s
pivot (sum(totaldue) for locationid in ('+@cols+')) as p;'

exec(@sql);
drop table #temp;
end;
go
exec GetRevenueByLocation