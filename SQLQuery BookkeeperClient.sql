select * from PortfolioProject..Bookkeeper;

select * from PortfolioProject..Client;

--Query of Clients that have a bookkeeper of 22
select Name, Balance, [Bookkeeper Number]
from PortfolioProject..Client
where [Bookkeeper Number] = 22;

--Sum of all balances
select sum(Balance) as SumClientBalance
from PortfolioProject..Client
;


--Sum of all balances grouped by Bookkeeper Number
select sum(Balance) as SumClientBalance, [Bookkeeper Number]
from PortfolioProject..Client
group by [Bookkeeper Number]
having [Bookkeeper Number] = 22;


--Shows Name of companies that have a balance greater than $320
select Name, Balance
from PortfolioProject..Client
where Balance > 320;


--Shows Number , Name, and Address for any address that includes the keyword 'Maum'
select [Bookkeeper Number],Name, Address
from PortfolioProject..Client
where Address like '%Maum%';


--Shows all the unique city names
select Distinct(City)
from PortfolioProject..Client
order by City;


--Shows a list of the Clients Number , Name, and Balance in a descending order.
select [Client Number], Name, Balance
from PortfolioProject..Client
order by Balance desc;


--Shows Selected attributes if the Bookkeeper number is '23' or '34'
select [Client Number], Name, Balance, [Bookkeeper Number]
from PortfolioProject..Client
where Balance > 300
and [Bookkeeper Number] = 23 or [Bookkeeper Number] = 34;


--This is a joined query that includes the First Name, and Last Name of each bookkeeper and the related Clients and Client Balance
select B.[First Name], B.[Last Name],B.[Hourly Rate], C.[Client Number], C.Balance
from PortfolioProject..Bookkeeper B, PortfolioProject..Client C
order by B.[Last Name], C.Name;



--This shows attributes for Bookkeeper as well as their hours worked.
select [Bookkeeper Number], [First Name], [Last Name], [Hourly Rate], [YTD Earnings]/ [Hourly Rate] as HoursWorked
from PortfolioProject..Bookkeeper;