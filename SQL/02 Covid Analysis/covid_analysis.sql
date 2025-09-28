Select location, date, new_cases, total_deaths, population
from CovidDeaths
Order by 1,2;



-- Looking at Total Cases vs Total deaths
  
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deaths_percentage
From CovidDeaths
where location = 'Afghanistan'
Order by 1,2;


-- toal cases vs Population
-- Show what persentage of population got Covid

Select location, date, total_cases, population, (total_cases/population)*100 as Persentage_of_population_infected
From covid..CovidDeaths
Where location like '%states%'
Order by 1,2;



-- looking for hihhest infection rate copare to the population

Select location, population, max(total_cases), population, max((total_cases/population))*100 as heighest_persanteage_infected
From covid..CovidDeaths
group by location, population
Order by heighest_persanteage_infected desc;



-- Showing Countries with highest Death count

Select location, MAX(total_deaths) as Total_deaths_count
From covid..CovidDeaths
Group by location
order by Total_deaths_count desc;

