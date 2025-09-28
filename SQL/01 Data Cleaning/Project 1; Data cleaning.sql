## PROJECT 1: data cleaning
-- https://youtu.be/wQQR60KtnFY?t=11148 3:06:00

-- 1. Remove duplicates if any
-- 2. Standartize the data - грешки в думите ако има
-- 3. Populate Null or Blank value if possible
-- 4. Remove any colomns


--  ----------------------------------------------
#	Копираме таблицата за вс. случай
-- CREATE TABLE layoffs_stageing
-- LIKE world_layoffs.layoffs;


--  ----------------------------------------------
#	Kопирам записите от таблицата
-- INSERT world_layoffs.layoffs_stageing
-- SELECT *
-- FROM world_layoffs.layoffs;




--  ----------------------------------------------
#	Изчистване на дубликатите
-- добавяне на ROW_NUMBER, partition by всяка колона, защото няма ID. Ако числото е > 1 значи има повторение

SELECT *,
	ROW_NUMBER() OVER(
		PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
			stage, country, funds_raised_millions)
        AS row_num
FROM world_layoffs.layoffs_stageing;



--  ----------------------------------------------
#	вкарвам в CTE
WITH duplicate_cte AS 
	(
	SELECT *,
		ROW_NUMBER() OVER(
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
            stage, country, funds_raised_millions)
			AS row_num
	FROM world_layoffs.layoffs_stageing
	)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;





-- ---------------------------------------------
-- създавам нова таблица, където има колона row_num

CREATE TABLE `layoffs_stageing2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;





-- ---------------------------------------------
--  проверка дали я има новата таблица

SELECT *
FROM world_layoffs.layoffs_stageing2;





-- ---------------------------------------------
--  вкарвам данните вече с row_num

INSERT INTO world_layoffs.layoffs_stageing2
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
	stage, country, funds_raised_millions)
	AS row_num
FROM world_layoffs.layoffs_stageing;




-- ---------------------------------------------
-- проверка за дубликати

SELECT *
FROM world_layoffs.layoffs_stageing2
WHERE row_num > 1;




-- ---------------------------------------------
-- изтриване на дубликати

DELETE
FROM world_layoffs.layoffs_stageing2
WHERE row_num > 1;



-- ---------------------------------------------
-- проверка за дубликати - вече е чисто

SELECT *
FROM world_layoffs.layoffs_stageing2
WHERE row_num > 1;




-- =================================================
##  STANDARTIZING DATA - намиране на грешки в записите и оправяне




-- ---------------------------------------------
-- показва името на компанията в оригинал и след TRIM()

SELECT company, TRIM(company)
FROM world_layoffs.layoffs_stageing2;




-- ---------------------------------------------
-- Ъпдейтва името на компанията, като премахва шпация преди и след името на компанията

UPDATE layoffs_stageing2
SET company = TRIM(company);



SELECT company
FROM world_layoffs.layoffs_stageing2;




-- ---------------------------------------------
-- проверка дали в industry има двусмислени повторения

SELECT DISTINCT(industry)
FROM layoffs_stageing2
ORDER BY 1;			-- подредено по първата колона от селкцията

SELECT *
FROM layoffs_stageing2
WHERE industry LIKE 'Crypto_%';



-- ---------------------------------------------
-- премахване на повторенията

UPDATE layoff_stageing2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto';



-- ---------------------------------------------
-- проверка на следващите колони за каквито и да е било проблеми

SELECT DISTINCT country
FROM layoffs_stageing2
ORDER BY 1;

SELECT *
FROM layoffs_stageing2
WHERE country LIKE 'United States_%'
ORDER BY 1;

UPDATE layoffs_stageing2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States_%';


SELECT DISTINCT country
FROM layoffs_stageing2
ORDER BY 1;




-- ---------------------------------------------
-- DATE FORMATING
-- 3:34:12


-- конвертира стринга в дата формат
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM world_layoffs.layoffs_stageing2;


-- ъпдейтвам записите в колоната
UPDATE layoffs_stageing2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


-- проверка резултат
SELECT `date`
FROM world_layoffs.layoffs_stageing2;


-- промяна формата на колоната в дата
ALTER TABLE layoffs_stageing2
MODIFY COLUMN `date` DATE;



-- ---------------------------------------------
#	NULL & BLANK	3:39:50 - премахвам редовете с два NULL


-- проверка за null
SELECT *
FROM layoffs_stageing2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- проверка за null и blank
SELECT *
FROM layoffs_stageing2
WHERE industry IS NULL
OR industry = '';


-- попълване на липсващите данни
-- обединяваме таблицата със себе си за да сравним записите. Има записи с попълнена индуструя
-- и записи без попълнене. Обединяваме ги по името на компанията

SELECT t1.company, t1.industry, t2.company, t2.industry
FROM layoffs_stageing2 AS t1
JOIN layoffs_stageing2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;


-- обръщане на '' в NULL
UPDATE layoffs_stageing2
SET industry = NULL
WHERE industry = '';


-- попълване на клетките от редове с попълнени клетки, където името на компанията е еднакво
UPDATE layoffs_stageing2 t1
JOIN layoffs_stageing2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


-- проверка дали има редове с непопълнени клетки
SELECT *
FROM layoffs_stageing2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;



-- изтриване на редовете с непопълнени съкращения
DELETE 
FROM layoffs_stageing2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- премахване на колоната row_num
ALTER TABLE layoffs_stageing2
DROP COLUMN row_num;


SELECT *
FROM layoffs_stageing2;



##	ГОТОВО! 