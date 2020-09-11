SELECT cities.cityname, MIN(users.age)
FROM cities
JOIN users
  ON cities.id = users.city_id
GROUP BY cities.cityname
--
SELECT
    cities.cityname,
    SUM(users.age) AS sum,
    COUNT(users.id) AS count,
    SUM(users.age) / COUNT(users.id) AS average
FROM cities
LEFT JOIN users
  ON cities.id = users.city_id
GROUP BY cities.cityname

