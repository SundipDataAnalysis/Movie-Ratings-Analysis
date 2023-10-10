-- Data visualisations and views

-- top 250 IMDB movies by IMDB rating (show as a table) 

select DISTINCT top 250 -- use top instead of LIMIT
	row_number() OVER (Order by IMDB_rating DESC) AS rank_no,
	Series_Title, IMDB_Rating -- add runtime if necessary
from dbo.imdbtop1000


-- show correlation between the IMDB rating and number of votes

select
	DISTINCT(Series_Title),
	IMDB_Rating,
	No_of_Votes
from imdbtop1000
order by No_of_Votes DESC 

-- Ranking table of ratings by IMDB rating and meta score separately to support the question
select 
	DISTINCT(Series_Title), Runtime, IMDB_Rating,
	RANK() OVER (Order by IMDB_rating DESC) 'Rank' 
from dbo.imdbtop1000
where 
	Runtime is not null
	and IMDB_Rating is not null-- Runtime vs IMDB_Rating
order by IMDB_Rating DESC

select 
	DISTINCT(Series_Title), Runtime, Meta_score,
	RANK() OVER (Order by Meta_score DESC) 'Rank' 
from dbo.imdbtop1000
where 
	Runtime is not null
	and Meta_score is not null -- Runtime vs Meta_score
order by Meta_score DESC


-- comparison of IMDB ratings (users) and Meta score (critics)

select 
	DISTINCT(Series_Title),
	IMDB_Rating, 
	Meta_score
from dbo.imdbtop1000
where meta_score is not null

-- what is the correlation between runtime and IMDB rating? (scatterplot)

select DISTINCT(Series_Title), runtime, IMDB_Rating
from dbo.imdbtop1000


-- correlation between Gross and IMDB rating?

select DISTINCT(Series_Title), IMDB_Rating, Gross
from dbo.imdbtop1000
where Gross is not null
order by Gross DESC 





