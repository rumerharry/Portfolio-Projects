-- %--------------------%
-- Exploratory Data Analysis (EDA)
-- Idea: Explore the dataset and discover patterns
-- %--------------------%

SELECT *
FROM layoffs_staging_2;


-- %--------------------%
-- Quick Look at Dataset
-- %--------------------%

SELECT *
FROM layoffs_staging_2;


-- %--------------------%
-- Maximum Values
-- %--------------------%

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging_2;


-- %--------------------%
-- Specific Percentage Layoffs
-- %--------------------%

SELECT *
FROM layoffs_staging_2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- %--------------------%
-- Total Layoffs by Company
-- %--------------------%

SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC;


-- %--------------------%
-- Date Range in Dataset
-- %--------------------%

SELECT MAX(`date`), MIN(`date`)
FROM layoffs_staging_2;


-- %--------------------%
-- Total Layoffs by Industry
-- %--------------------%

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY industry
ORDER BY 2 DESC;


-- %--------------------%
-- Total Layoffs by Country
-- %--------------------%

SELECT country, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC;


-- %--------------------%
-- Total Layoffs by Year
-- Dataset from March 2023
-- %--------------------%

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;


-- %--------------------%
-- Total Layoffs by Stage
-- %--------------------%

SELECT stage, SUM(total_laid_off) 
FROM layoffs_staging_2
GROUP BY stage
ORDER BY 2 DESC;


-- %--------------------%
-- Average Layoff Percentage by Company
-- (Total laid off may be more meaningful)
-- %--------------------%

SELECT company, AVG(percentage_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC;


-- %--------------------%
-- Rolling Total Layoffs by Month
-- %--------------------%

SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging_2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;


WITH rolling_total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS total_off
    FROM layoffs_staging_2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `MONTH`
    ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
       SUM(total_off) OVER (ORDER BY `MONTH`) AS Rolling_total
FROM rolling_total;


-- %--------------------%
-- Total Layoffs by Company 
-- %--------------------%

SELECT company, SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company
ORDER BY 2 DESC;


-- %--------------------%
-- Total Layoffs by Company and Year
-- %--------------------%

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging_2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;


-- %--------------------%
-- Top 5 Companies by Layoffs Per Year
-- %--------------------%

WITH company_year (company, years, total_laid_off) AS (
    SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging_2
    GROUP BY company, YEAR(`date`)
), company_year_rank AS (
    SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM company_year
    WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking <= 5;


-- %--------------------%
-- Quick Look Again
-- %--------------------%

SELECT *
FROM layoffs_staging_2;


-- %--------------------%
-- Company, Country, Funds Raised
-- %--------------------%

SELECT company, country, funds_raised_millions
FROM layoffs_staging_2;


-- %--------------------%
-- Total Funds Raised by Country
-- %--------------------%

SELECT country, SUM(funds_raised_millions) AS Total_funds_raised
FROM layoffs_staging_2
GROUP BY country
HAVING SUM(funds_raised_millions) IS NOT NULL
ORDER BY Total_funds_raised DESC;


-- %--------------------%
-- Total Funds Raised by Industry
-- %--------------------%

SELECT industry, SUM(funds_raised_millions) AS Total_funds_raised
FROM layoffs_staging_2
GROUP BY industry
HAVING SUM(funds_raised_millions) IS NOT NULL
ORDER BY Total_funds_raised DESC;


-- %--------------------%
-- Total Funds Raised by Country and Industry
-- %--------------------%

SELECT country, industry, SUM(funds_raised_millions) AS Total_funds_raised
FROM layoffs_staging_2
GROUP BY country, industry
HAVING SUM(funds_raised_millions) IS NOT NULL
ORDER BY country;
