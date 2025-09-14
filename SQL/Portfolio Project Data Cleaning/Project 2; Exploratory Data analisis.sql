-- PROJECT 2: EXPLORATORY DATA ANALYSIS
-- https://youtu.be/wQQR60KtnFY?t=14293  3:57:00


SELECT *
FROM layoffs_stageing2;

-- проверка за най-много съкратени
SELECT MAX(total_laid_off)
FROM layoffs_stageing2;


-- проверка коя компания е съкратила най-много хоро ОБЩО през годините
SELECT company, SUM(total_laid_off)
FROM layoffs_stageing2
GROUP BY company
ORDER BY 2 DESC;


-- проверка за от кога е започнало и кога е приключило
SELECT MIN(`date`), max(`date`)
FROM layoffs_stageing2;


-- проверка коя индустрия е съкратила най-много хоро ОБЩО през годините
SELECT industry, SUM(total_laid_off)
FROM layoffs_stageing2
GROUP BY industry
ORDER BY 2 DESC;


-- проверка коя държава е съкратила най-много хоро ОБЩО през годините
SELECT country, SUM(total_laid_off)
FROM layoffs_stageing2
GROUP BY country
ORDER BY 2 DESC;


-- проверка коя година са съкратили най-много хора
SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_stageing2
GROUP BY YEAR(`date`)
ORDER BY 2 desc;


-- проверка съкращенията по месециalter
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM layoffs_stageing2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 asc;


-- показва как нараства броя на уловнените през месеците и с колко
WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS total_off_per_month
FROM layoffs_stageing2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 asc
)
SELECT `month`, total_off_per_month, SUM(total_off_per_month) 
OVER (ORDER BY `month`) AS rolling_total
FROM Rolling_total;


-- проверка по колко души е уволнявала компанията на година
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_stageing2
GROUP BY company, YEAR(`date`);



-- Ранг лист коя година, коя компания е уволнила най-много
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_stageing2
GROUP BY company, YEAR(`date`)
ORDER BY sum(total_laid_off) DESC;


-- Преработка в СТЕ	4:21:00

WITH Company_Year_cte1 (company, years, total_laid_off)		-- създава два СТЕ блок 
AS (
SELECT company, YEAR(`date`), SUM(total_laid_off)		-- създава колоните
FROM layoffs_stageing2
GROUP BY company, YEAR(`date`)
), 
Company_Year_Rank_cte2 AS			 
(SELECT *, DENSE_RANK()			-- ползва колоните от СТЕ 1 и им слага ранк
OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year_cte1
WHERE years IS NOT NULL
)

SELECT *
FROM Company_Year_Rank_cte2
WHERE Ranking <= 3;			-- показва само първите 3 позиции















