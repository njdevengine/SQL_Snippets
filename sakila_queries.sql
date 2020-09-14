select * from actor where first_name like "%e%" order by first_name desc limit 10;

-- get actors that were in an action film
select * from actor where exists(select * from actor_info where actor.actor_id = actor_info.actor_id and actor_info.film_info like "%Action%");
