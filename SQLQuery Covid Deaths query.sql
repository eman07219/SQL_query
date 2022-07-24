select * from PortfolioProject..CovidDeaths$

--This query shows the specific attributes I will be using
select Location, Date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths$;

--Shows the death percentage in the United States
select Location, Date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths$
where Location like '%states%'
;

--Shows the percentage infected
select Location, Date, Population, total_cases, (total_cases/Population)*100 as InfectedPercentage
from PortfolioProject..CovidDeaths$
order by 1,2
;


--Countries with the highest percentage rate
select Location, Population, date, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population))*100 as InfectedPercentage
from PortfolioProject..CovidDeaths$
group by Location, Population, date
order by InfectedPercentage desc;

--Countries with the highest death count
select Continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where Continent is not null
group by Continent
order by TotalDeathCount desc;

--Shows the total population versus the vaccinations
select d.location, d.continent, d.date, d.population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) over (partition by d.location) 
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths$ d 
join PortfolioProject..CovidVaccinations$ v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3;

--Global numbers
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int)) / SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
where continent is not null
order by 1,2;


--looking at total population vs vaccinations.
with PopvsVac ( Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
select d.location, d.continent, d.date, d.population, v.new_vaccinations,
SUM(CONVERT(int, v.new_vaccinations)) over (partition by d.location) 
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths$ d 
join PortfolioProject..CovidVaccinations$ v
on d.location = v.location
and d.date = v.date
where d.continent is not null);


SELECT * , (RollingPeopleVaccinated* Population)*100
FROM PopvsVac
;


--create table for percentage of population
DROP TABLE if exists PercentPopulationVaccination
CREATE TABLE PercentPopulationVaccination
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
);
--Entering the attributes 
insert into PercentPopulationVaccination
select
d.Continent, d.Location, d.Date, d.population, v.new_vaccinations, SUM(CONVERT(int, v.new_vaccinations)) OVER 
(Partition by d.Location, d.Date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths$ d
join
PortfolioProject..CovidVaccinations$ v
on d.Location = v.Location
and d.Date= v.Date

--
select *, (RollingPeopleVaccinated/Population)*100 
from PercentPopulationVaccination




--showing continents with highest death count per population
select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where continent is not null
Group by continent
Order By TotalDeathCount desc;



--CTE

Create View PercentPopulationVaccinated as
select d.continent, d.location, d.date , d.population, v.new_vaccinations
, SUM(convert(int, v.new_vaccinations)) over (Partition by d.location order by d.location, d.date) 
as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths$ d join
PortfolioProject..CovidVaccinations$ v
on d.location = v.location
and d.date = v.date
where d.continent is not null
;

Select * from PercentPopulationVaccinated;



select Location, SUM(cast(new_deaths as int)) as TotalDeathCount
from PortfolioProject..CovidDeaths$
where Continent is null
and location not in ('World', 'European Union', 'International')
group by Location
order by TotalDeathCount desc;