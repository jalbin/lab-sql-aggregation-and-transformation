/* Challenge 1
---------------*/
/* You need to use SQL built-in functions to gain insights relating to the duration of movies: */

use sakila ;

/* 1.1 Determine the shortest and longest movie durations and name the values as min_duration and max_duration.*/

select min(length) as min_duration , max(length) as max_duration from film;

/*1.2. Express the average movie duration in hours and minutes. Don't use decimals. */

select floor(avg(length)/60) as hours, round(avg(length)%60) as minutes from film;

/* 2.1 Calculate the number of days that the company has been operating.*/

select datediff((select rental_date from rental order by rental_date desc limit 1),(select rental_date from rental order by rental_date asc limit 1)) as "#days that the company has been operating";

/* 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.*/

select * , monthname(rental_date) as month,dayname(rental_date) as weekday from rental limit 20;

/* 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.*/


/*Hint: use a conditional expression. */
/*You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.*/

/*Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.*/
/* Hint: Look for the IFNULL() function.*/
/* Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.*/

/*Challenge 2 
--------------*/

/* Using the film table, determine:*/

/*1.1 The total number of films that have been released.*/

select count(distinct(film_id)) as films_released 
from film 
where release_year is not null;

/*1.2 The number of films for each rating.*/

select rating, count(film_id) as films_per_rating from film group by rating;

/*1.3 The number of films for each rating, sorting the results in descending order of the number of films. */

select rating, count(film_id) as films_per_rating 
from film 
group by rating 
order by films_per_rating desc;

/* Using the film table, determine:*/
/* 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
	Round off the average lengths to two decimal places.*/

select rating, round(avg(length),2) as mean_duration_per_rating 
from film 
group by rating 
order by mean_duration_per_rating desc;

/* 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.*/

select rating, round(avg(length),2) as mean_duration_per_rating 
from film 
group by rating 
having mean_duration_per_rating > 120 ;

/* Bonus: determine which last names are not repeated in the table actor.*/

select last_name from actor group by last_name having count(last_name) = 1;