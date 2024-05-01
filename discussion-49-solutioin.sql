-- 1. Task: Query the country table to select the Name, Continent, and Population.
SELECT Name, Continent, Population FROM country;

-- 2. Task: Use aliases to rename the Name column to Country Name and the country table as c in your queries.
SELECT Name AS 'Country Name' FROM country AS c;

-- 3. Task: Find all countries in the 'Europe' continent with a population greater than 10 million.
SELECT Name, Population FROM country WHERE Continent = 'Europe' AND Population > 10000000;

-- 4. Task: Retrieve all cities in 'Poland' or 'Belgium'.
SELECT Name, CountryCode FROM city WHERE CountryCode = 'POL' OR CountryCode = 'BEL';

-- 5. Task: List all countries in 'South America' by their LifeExpectancy in descending order.
SELECT Name, LifeExpectancy FROM country WHERE Continent = 'South America' ORDER BY LifeExpectancy DESC;

-- 6. Task: Get the top 5 largest cities by population in the database.
SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 5;