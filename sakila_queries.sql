select * from actor where first_name like "%e%" order by first_name desc limit 10;

-- get actors that were in an action film
select * from actor where exists(select * from actor_info where actor.actor_id = actor_info.actor_id and actor_info.film_info like "%Action%");

-- Which actors have the first name ‘Scarlett’
select first_name,last_name from actor where first_name = "Scarlett";

-- Which actors have the last name ‘Johansson’
select first_name,last_name from actor where last_name = "Johansson";

-- Get length of actors last names, call the column len
select length(last_name) as len,last_name from actor group by last_name order by len desc;

-- How many distinct actors last names are there?
select count(distinct last_name) from actor;

-- Which last names are not repeated?
select last_name from actor group by last_name having count(last_name) = 1;

-- Which actors having 4 letter last names have names not repeated
select last_name from actor where length(last_name) = 4 group by last_name having count(last_name) = 1;

-- Which last names appear more than once?
select last_name from actor group by last_name having count(*) >=2;

-- Which actor has appeared in the most films?
select first_name, last_name, actor.actor_id, count(actor.actor_id) as films from actor left join film_actor on actor.actor_id = film_actor.actor_id group by actor.actor_id order by films desc limit 1;

-- Is ‘Academy Dinosaur’ available for rent from Store 1?
-- Insert a record to represent Mary Smith renting ‘Academy Dinosaur’ from Mike Hillyer at Store 1 today .
-- When is ‘Academy Dinosaur’ due?
-- What is that average running time of all the films in the sakila DB?
-- What is the average running time of films by category?
