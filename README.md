## 📊 Netflix Movies & TV Shows Analysis (SQL Project)



![logo](https://github.com/user-attachments/assets/55663b0a-06c8-41e4-b1af-fb36c727889a)


### 🔍 Overview
This project presents a comprehensive analysis of Netflix's movies and TV shows dataset using **SQL**. The objective is to extract meaningful insights and answer various business-oriented questions that can help understand Netflix’s content strategy. This README outlines the project’s goals, the business problems addressed, the analytical approach, and key findings.

### 🎯 Objectives
- Analyze the distribution of content types (Movies vs. TV Shows).
- Identify the most common ratings for both Movies and TV Shows.
- Explore content trends based on release years, countries, and durations.
- Filter and categorize titles using specific criteria and keywords.

#### 📁 Dataset
The dataset used for this project was sourced from Kaggle:  
**🔗 [Netflix Movies and TV Shows Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows)**

### SAMPLE OF SQL QUERIES FROM THE PROJECT


- Find content added in the last 5 years
  
```SQL
SELECT *
FROM netflix
WHERE STR_TO_DATE(date_added, '%d-%b-%y') >= (CURRENT_DATE - INTERVAL 5 YEAR);
```


- Find the most common rating for movies and TV shows


```SQL
SELECT type, rating
FROM
(
	SELECT type, rating, COUNT(show_id),
	RANK() OVER(PARTITION BY type ORDER BY COUNT(show_id) DESC) AS ranking
	FROM netflix
	GROUP BY 1,2) as t1
WHERE t1.ranking=1;
```


### Findings and Conclusion

- Content Distribution
Netflix hosts a diverse mix of movies and TV shows, with movies making up the majority of its catalog.

- Common Ratings
Most content is rated for general audiences or teenagers, indicating Netflix’s focus on family-friendly and teen-oriented programming.

- Release Year Trends
A significant spike in content releases occurred after 2015, highlighting Netflix’s aggressive push into original content in recent years.

- Country-wise Content
The majority of Netflix’s content originates from the United States, but there is growing representation from countries like India, Canada, and the UK.

#### 🚀 This project is a key part of my data analytics portfolio, demonstrating my SQL skills in extracting insights, solving business problems, and working with real-world datasets.
