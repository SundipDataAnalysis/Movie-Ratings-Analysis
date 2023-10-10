-- View the dataset

select * 
from dbo.imdbtop1000

-- which movie received the highest votes?
-- which movie had the highest number of votes?

select *
from imdbtop1000
order by IMDB_Rating DESC -- Shawshank redemption highest with 9.3

select 
	Series_Title,
	IMDB_Rating,
	No_of_Votes
from imdbtop1000
order by No_of_Votes DESC 


-- number of unique genres

select DISTINCT Genre
from dbo.imdbtop1000 -- 202 distinct genres


-- what is the average rating of the movies in the top 1000?

select AVG(IMDB_rating) as AVG_IMDB_rating
from dbo.imdbtop1000

-- meta score and IMDB rating are different - metascore are critic reviews, IMDB ratings are users
-- compare IMDB rating to meta score 

select 
	Series_Title,
	IMDB_Rating, 
	Meta_score
from dbo.imdbtop1000
where meta_score is not null -- 157 rows contain null values for meta score 

-- what is the correlation between runtime and IMDB rating?

select Series_title, runtime, IMDB_Rating
from dbo.imdbtop1000
where runtime is not null and IMDB_Rating is not null --create scatterplot in tableau


-- top 250 IMDB movies by IMDB rating

select top 250 -- use top instead of LIMIT
	row_number() OVER (Order by IMDB_rating DESC) AS rank_no,
	Series_Title, IMDB_Rating -- add runtime if necessary
from dbo.imdbtop1000


-- create a ranking table of all movies within the dataset by IMDB rating and metascore

select 
	Series_Title, Runtime, IMDB_Rating,
	RANK() OVER (Order by IMDB_rating DESC) 'Rank' 
from dbo.imdbtop1000
where 
	Runtime is not null
	and IMDB_Rating is not null -- Runtime vs IMDB_Rating

select 
	Series_Title, Runtime, Meta_score,
	RANK() OVER (Order by Meta_score DESC) 'Rank' 
from dbo.imdbtop1000
where 
	Runtime is not null
	and Meta_score is not null -- Runtime vs Meta_score

-- correlation between Gross and IMDB rating?

select Series_Title, IMDB_Rating, Gross
from dbo.imdbtop1000
where Gross is not null
order by Gross DESC 

-- which movies have the highest gross?

select 
	Series_Title, Gross
from dbo.imdbtop1000
where 
	Gross > 0 and Gross is not null
order by Gross DESC 

-- which movies have the lowest gross in the top 1000?

select 
	Series_Title, Gross
from dbo.imdbtop1000
where 
	Gross > 0 and Gross is not null
order by Gross ASC


-- average gross of movies in the top 1000


select avg(gross) as avg_gross
from dbo.imdbtop1000



-- explore the best directors or those with films of a high IMDB rating

select top 10
	Director, 
	round(AVG(IMDB_rating),2) AS avg_IMDB_rating -- 2 represents decimal places
from dbo.imdbtop1000
group by
	Director
order by
	avg_IMDB_rating DESC 


-- how many movies are under 2 hours or 120 minutes in the top 1000?

select count(*)  -- issue converting runtime to INT as min is written in the column
from dbo.imdbtop1000
where runtime <120 

-- how many movies are rated above 8 and below 8 in the top 1000?

select count(*) 
from dbo.imdbtop1000
where IMDB_Rating >8  

select count(*) 
from dbo.imdbtop1000
where IMDB_Rating <8 


-- TEMP TABLE -- not used in visualisation

Create table Movies_data_cleaned
	(
	Series_title nvarchar(100),
	runtime nvarchar(50),
	genre nvarchar(50),
	IMDB_rating float, 
	meta_score int,
	director nvarchar(50),
	no_of_votes int,
	gross float
	)

Insert into Movies_data_cleaned
select Series_title, runtime, genre, IMDB_rating, meta_score, 
	director, no_of_votes, gross 
from dbo.imdbtop1000
where Meta_score is not null and Gross is not null

select * from Movies_data_cleaned

-- create view (not used in visualisation)

--CREATE VIEW Movies_data_cleaned AS 
--select Series_Title, runtime, genre, IMDB_rating, meta_score, 
--director, no_of_votes, gross 
--from dbo.imdbtop1000
--where Meta_score is not null and Gross is not null


















	