select A.Access_to_electricity_of_population,B.CountryName,A.[2000] from [dbo].[dataLongForm]as A left join [dbo].[Country]as B on 
 A.Country_Code=B.Country_Code left join [dbo].[dataWideForm]as C on 
 C.Country_Code=A.Country_Code left join [dbo].[Indicators]as D on 
 D.INDICATOR_CODE=C.Indicator_Code left join [dbo].[Region]as E on
 E.Region=B.Region left join [dbo].[Years]as F on F.Years=A.Years 


----Q-1-------------------------------------------------------------------------
select A.Access_to_electricity_of_population,A.Years,B.CountryName from
[dbo].[dataLongForm]as A left join [dbo].[Country]as B on 
A.Country_Code=B.Country_Code  where Years=2000

------Q-2--------------
select B.CountryName,B.Region,avg(A.Access_to_electricity_of_population)as avg_electricity from
[dbo].[dataLongForm]as A left join [dbo].[Country]as B on 
A.Country_Code=B.Country_Code group by B.CountryName,B.Region

------Q-3--------------
select B.CountryName,avg(A.Access_to_electricity_of_population)as avg_electricity, 
(select avg(Access_to_electricity_of_population)as avg_electricity from  [dbo].[dataLongForm]
where Country_Code='wld')as world_avg
from
[dbo].[dataLongForm]as A left join [dbo].[Country]as B on 
A.Country_Code=B.Country_Code group by B.CountryName

------------Q-4----------------------
select distinct A.Years,
count(A.Access_to_electricity_rural_of_rural_population)over(partition by A.years) from
[dbo].[dataLongForm]as A left join [dbo].[Country]as B on 
A.Country_Code=B.Country_Code where A.Access_to_electricity_rural_of_rural_population>=75 order by Years

----------Q-5--------------
select region,IncomeGroup,avg(B.[Electricity_production_from_nuclear_sources_of_total])as Nuclear from [dbo].[Country]
as A left join [dbo].[dataLongForm]as B on A.Country_Code=B.Country_Code
Where A.Region='Europe & Central Asia' or A.Region='Sub-Saharan Africa' group by region,IncomeGroup

---------Q-6

select [Years],avg(Electricity_production_from_nuclear_sources_of_total)as Nuclear
,avg(Electricity_production_from_oil_sources_of_total)as oil,
avg(Electricity_production_from_renewable_sources_excluding_hydroelectric_kWh)as renewable
 from [dbo].[dataLongForm] group by[Years] order by [Years]
