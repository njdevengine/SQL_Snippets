SELECT cities.cityname, MIN(users.age)
FROM cities
JOIN users
  ON cities.id = users.city_id
GROUP BY cities.cityname
