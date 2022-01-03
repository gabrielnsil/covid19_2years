SELECT *
FROM covid19_project..covidDeaths
WHERE continent is not NULL
ORDER BY 3,4

SELECT *
FROM covid19_project..covidDeaths
ORDER BY 3,4

--SELECT *
--FROM covid19_project..covidVaccinations
--ORDER BY 3,4

-- Selecionar os dados a serem utilizados

SELECT location, date, total_cases, new_cases, total_deaths, total_deaths_per_million, population
FROM covid19_project..covidDeaths
WHERE continent is not NULL
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
WHERE continent is not NULL
GROUP BY location, population
ORDER BY population_infected_percentage DESC


-- E em quais houve maior n�mero de mortes (%) nesses 2 anos de pandemia?
-- At� o momento o Peru lidera com 0.6% de sua popula��o perdida para o COVID-19, seguido da Bulgaria e Bosnia e Herzegovina

SELECT location, population, MAX(total_deaths) as max_total_deaths, MAX((total_deaths/population))*100 as population_deaths_percentage
FROM covid19_project..covidDeaths
WHERE continent is not NULL
GROUP BY location, population
ORDER BY population_deaths_percentage DESC

-- At� o momento, qual � o pa�s que tem mais mortes?
-- Vemos que o Estados Unidos, Brasil e India lideram o ranking de mortes

SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM covid19_project..covidDeaths
WHERE continent is not NULL
GROUP BY location
ORDER BY total_death_count DESC

-- Explorando os dados, n�s podemos perceber que a coluna 'location' tamb�m contem os continentes
-- Por�m h� uma coluna especifica somente para os continentes, logo, precisamos fazer uma corre��o
-- Para isso adicionamos em cada query que usa location:
-- WHERE continent is not NULL


-- Mudando de escala, podemos analisar por continentes tamb�m, usando a mesma l�gica e c�digo similar
-- Podemos ver que na Oceania, onde a COVID-19 intensamente controlada pelo governos locais, houve um n�mero de mortes irris�rio se comparados com outros
-- Continentes com pa�ses governados por negacionistas apresentaram um maior n�mero de mortes

SELECT continent, MAX(CAST(total_deaths as int)) as total_death_count
FROM covid19_project..covidDeaths
WHERE continent is not NULL
GROUP BY continent
ORDER BY total_death_count DESC

-- Aqui temos um pequeno problema com o dataset, os n�meros mais acurados est�o na coluna location por algum motivo

SELECT location, MAX(CAST(total_deaths as int)) as total_death_count
FROM covid19_project..covidDeaths
WHERE continent is NULL AND location NOT LIKE '%income%'
GROUP BY location
ORDER BY total_death_count DESC


-- Apesar disso, usaremos a vers�o que considera somente a coluna 'continent'

SELECT continent, MAX(CAST(total_deaths as int)) as total_death_count
FROM covid19_project..covidDeaths
WHERE continent is not NULL
GROUP BY continent
ORDER BY total_death_count DESC

-- E quando olhamos para o mundo como um todo? Qual cen�rio vemos?

SELECT date, SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths--, SUM(CAST(new_deaths as int)) / SUM(new_cases) * 100 as death_percentage
FROM covid19_project..covidDeaths
WHERE new_cases != 0 AND continent is not NULL AND location NOT LIKE '%income%' -- Remove high, medium and low income e continentes da contagem
GROUP BY date
ORDER BY 1,2

-- Quantos % da popula��o mundial infectada sucumbiu ao COVID-19 at� o momento?
-- Aproximadamente 1,87% dos infectados faleceu em decorr�ncia do coronav�rus.

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths as int)) as total_deaths, SUM(CAST(new_deaths as int)) / SUM(new_cases) * 100 as death_percentage
FROM covid19_project..covidDeaths



