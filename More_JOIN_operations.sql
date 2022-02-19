-- List the films where the yr is 1962 [Show id, title] 
SELECT id, title
 FROM movie
 WHERE yr=1962

-- Give year of 'Citizen Kane'. 
SELECT yr
FRoM movie
WHERE title = 'Citizen Kane'

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- What is the id of the film 'Casablanca' 
SELECT id
from movie
WHERE title = 'Casablanca'

-- Obtain the cast list for 'Casablanca'. 
SELECT actor.name
FROM movie join casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movieid=11768

-- Obtain the cast list for the film 'Alien' 
SELECT actor.name
FROM movie join casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE title= 'Alien'

-- List the films in which 'Harrison Ford' has appeared 
SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 
SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
AND casting.ord != 1

-- List the films together with the leading star for all 1962 films. 
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962
AND casting.ord = 1

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
SELECT yr,COUNT(title) 
FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(yr) > 2

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in. 
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movieid IN (
  SELECT movieid FROM casting
  JOIN actor ON actor.id = casting.actorid
  WHERE name='Julie Andrews')
AND casting.ord=1

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles. 
SELECT actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
GROUP BY actor.name
HAVING 15 >= SUM(
CASE WHEN casting.ord = 1 THEN 1 ELSE 0 END )
ORDER BY actor.name

--  List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 
SELECT distinct movie.title, count(actorid)
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE yr = 1978
GROUP BY title
ORDER BY count(actorid) desc, title

-- List all the people who have worked with 'Art Garfunkel'. 
SELECT actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movieid IN (
  SELECT movieid FROM casting
  JOIN actor ON actor.id = casting.actorid
  WHERE name='Art Garfunkel')
AND actor.name != 'Art Garfunkel'
