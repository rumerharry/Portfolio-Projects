-- %--------------------%
-- Data Cleaning
-- %--------------------%

SELECT *
FROM layoffs;

-- %--------------------%
-- Cleaning Steps Outline
-- 1. Remove Duplicates
-- 2. Standardise the Data
-- 3. Handle Null or Blank Values
-- 4. Remove Unnecessary Columns
-- %--------------------%


-- %--------------------%
-- Create Staging Table (Preserve Raw Data)
-- %--------------------%

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;


-- %--------------------%
-- Identify Duplicates
-- %--------------------%

SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`
) AS row_num
FROM layoffs_staging;


WITH duplicate_cte AS (
    SELECT *, 
    ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, 
                 percentage_laid_off, `date`, stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
)
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;


SELECT *
FROM layoffs_staging
WHERE company = 'Casper';


-- %--------------------%
-- Remove Duplicates (Using Second Staging Table)
-- %--------------------%

CREATE TABLE layoffs_staging_2 (
  company TEXT,
  location TEXT,
  industry TEXT,
  total_laid_off INT DEFAULT NULL,
  percentage_laid_off TEXT,
  `date` TEXT,
  stage TEXT,
  country TEXT,
  funds_raised_millions INT DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB 
DEFAULT CHARSET=utf8mb4 
COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO layoffs_staging_2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, 
             percentage_laid_off, `date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging_2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging_2;

SELECT *
FROM layoffs_staging_2
WHERE company = 'Casper';

-- %--------------------%
-- Standardising Data
-- %--------------------%

SELECT company, TRIM(company)
FROM layoffs_staging_2;

UPDATE layoffs_staging_2
SET company = TRIM(company);


SELECT *
FROM layoffs_staging_2
WHERE industry LIKE '%Crypto%';

UPDATE layoffs_staging_2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT industry
FROM layoffs_staging_2;


SELECT DISTINCT location
FROM layoffs_staging_2
ORDER BY 1;


SELECT DISTINCT country
FROM layoffs_staging_2
ORDER BY 1;


SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging_2
ORDER BY 1;


UPDATE layoffs_staging_2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- %--------------------%
-- Date Formatting
-- %--------------------%

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging_2;


UPDATE layoffs_staging_2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


ALTER TABLE layoffs_staging_2
MODIFY COLUMN `date` DATE;


-- %--------------------%
-- Handling Null & Blank Values
-- %--------------------%

SELECT *
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging_2
WHERE industry IS NULL
OR industry = '';


SELECT *
FROM layoffs_staging_2
WHERE company = "Bally's Interactive";


UPDATE layoffs_staging_2
SET industry = NULL
WHERE industry = '';


UPDATE layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;


-- %--------------------%
-- Remove Unusable Rows
-- %--------------------%

DELETE 
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- %--------------------%
-- Final Cleanup
-- %--------------------%

ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging_2;
