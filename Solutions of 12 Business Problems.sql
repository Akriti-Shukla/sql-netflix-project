SELECT *
FROM netflix;

SELECT COUNT(*)
FROM netflix
WHERE rating = 'TV-14';

SELECT COUNT(DISTINCT type)
FROM netflix;

SELECT COUNT(*) AS Total_content
FROM netflix;

SELECT DISTINCT type
FROM netflix;

-- Netflix Data Analysis using SQL
-- Solutions of 12 business problems

-- 1. Count the number of Movies vs TV Shows

SELECT type, COUNT(*) as total_content
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows

SELECT type, rating, COUNT(show_id)
FROM netflix
GROUP BY 1,2
ORDER BY 1,3 DESC;

-- NOW USING A WINDOW FUNCTION RANK()

SELECT type, rating
FROM
(
	SELECT type, rating, COUNT(show_id),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(show_id) DESC) AS ranking
	FROM netflix
	GROUP BY 1,2) as t1
WHERE t1.ranking=1;

-- 3. List all movies released in a specific year (e.g., 2021)

SELECT *
FROM netflix
WHERE type = 'Movie' AND release_year = 2021;

-- 4. Find the top 5 countries with the most content on Netflix

SELECT country, COUNT(show_id) as total_content
FROM netflix
WHERE country is NOT NULL AND country != ''
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

-- but there are repeating countries in a group
-- this will run only on PostgreSQL

SELECT * 
FROM
(
	SELECT 
		UNNEST(STRING_TO_ARRAY(country, ',')) as country,
		COUNT(*) as total_content
	FROM netflix
	GROUP BY 1
)as t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;

-- 5. Identify the longest movie

SELECT *
FROM netflix
WHERE type = 'Movie'
       AND duration = (SELECT MAX(duration) FROM netflix);

-- 6. Find content added in the last 5 years

SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%d-%b-%y') >= (CURRENT_DATE - INTERVAL 5 YEAR);

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons

SELECT *
FROM netflix
WHERE type = 'TV Show'
AND REGEXP_SUBSTR(duration, '^[0-9]+') > 5;

-- 9. Count the number of content items in each genre

SELECT listed_in, COUNT(*) as total_content
FROM netflix
GROUP BY listed_in
ORDER BY total_content DESC;


-- 10. List all movies that are documentaries

SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries';


-- 11. Find all content without a director

SELECT * FROM netflix
WHERE director IS NULL OR director = '';

-- 12. Find how many movies actor 'Amitabh Bachchan' appeared in last 10 years!

SELECT * FROM netflix
WHERE 
	casts LIKE '%Amitabh Bachchan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;

