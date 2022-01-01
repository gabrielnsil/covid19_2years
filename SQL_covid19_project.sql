SELECT *
FROM covid19_project..covidDeaths
ORDER BY 3,4

--SELECT *
--FROM covid19_project..covidVaccinations
--ORDER BY 3,4

-- Selecionar os dados a serem utilizados

SELECT location, date, total_cases, new_cases, total_deaths, total_deaths_per_million, population
FROM covid19_project..covidDeaths
ORDER BY 1,2

-- Calculando a porcentagem de mortes em rela��o ao total de casos

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM covid19_project..covidDeaths
WHERE location = 'Brazil'
ORDER BY 1,2

-- Qual foi a m�xima death_percentage vista no Brasil ao longo desses 2 anos de pandemia? 
-- Em abril, maio e junho de 2020 as chances de morrer em decorr�ncia de COVID-19 eram bem altas

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_percentage
FROM covid19_project..covidDeaths
WHERE location = 'Brazil'
ORDER BY death_percentage DESC

-- Calculando a porcentagem de popula��o que contraiu COVID-19 no Brasil
-- Aproximadamente 10% da popula��o brasileira foi contaminada ao longo desses 2 anos

SELECT location, date, population, total_cases, (total_cases/population)*100 as population_infected_percentage
FROM covid19_project..covidDeaths
WHERE location = 'Brazil'
ORDER BY 1,2

-- Comparativamente, quais pa�ses possuem a maior porcentagem de infec��o em rela��o a sua popula��o?

SELECT location, population, MAX(total_cases) as max_total_cases, MAX((total_cases/population))*100 as population_infected_percentage
FROM covid19_project..covidDeaths
GROUP BY location, population
ORDER BY population_infected_percentage DESC


-- E em quais houve maior n�mero de mortes (%) nesses 2 anos de pandemia?
-- At� o momento o Peru lidera com 0.6% de sua popula��o perdida para o COVID-19, seguido da Bulgaria e Bosnia e Herzegovina

SELECT location, population, MAX(total_deaths) as max_total_deaths, MAX((total_deaths/population))*100 as population_deaths_percentage
FROM covid19_project..covidDeaths
GROUP BY location, population
ORDER BY population_deaths_percentage DESC

