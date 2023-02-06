Select *
From PortfolioProject..CovidDeath
Where continent is not null
order by 3,4

Select *
From PortfolioProject..CovidVaccination
Where continent is not null
order by 3,4


Select continent, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeath
order by 1,2


Select continent, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
Where continent like '%Emirates%'
order by 1,2


Select continent, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
Where continent like '%Emirates%'
order by 1,2


Select continent, population, MAX(total_cases) as HighestInfictionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeath
--Where location like '%Emirates%'
Where continent is not null
Group by population, continent
order by PercentPopulationInfected desc


Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where location like '%Emirates%'
Where continent is not null
Group by continent
order by TotalDeathCount desc


Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where location like '%Emirates%'
Where continent is not null
Group by continent
order by TotalDeathCount desc

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeath
--Where location like '%Emirates%'
Where continent is not null
Group by continent
order by TotalDeathCount desc


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeath
--Where location like '%Emirates%'
where continent is not null 
--group by date
order by 1,2


Select * 
From PortfolioProject..CovidDeath  dea
Join PortfolioProject..CovidVaccination  vac
 on dea.location = vac.location
 and dea.date = vac.date


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeath  dea
Join PortfolioProject..CovidVaccination  vac
 on dea.location = vac.location
 and dea.date = vac.date
Where vac.continent is not null
order by 2,3




With PopVsVac (continent, location, date, population, new_vaccinations, PeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as int)) 
OVER (Partition by dea.location order by dea.location, dea.date) as PeopleVaccinated

From PortfolioProject..CovidDeath  dea
Join PortfolioProject..CovidVaccination  vac
 on dea.location = vac.location
 and dea.date = vac.date
Where vac.continent is not null
--order by 2,3
)
Select *, (PeopleVaccinated/population)
From PopVsVac


Create View PeopleVaccinated As
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CAST(vac.new_vaccinations as int)) 
OVER (Partition by dea.location order by dea.location, dea.date) as PeopleVaccinated

From PortfolioProject..CovidDeath  dea
Join PortfolioProject..CovidVaccination  vac
 on dea.location = vac.location
 and dea.date = vac.date
Where vac.continent is not null
--order by 2,3



Select*
From PeopleVaccinated