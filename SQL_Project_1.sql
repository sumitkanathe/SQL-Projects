-- Project 1

-- Question-1 Create new schema as ecommerce
-- Ans

CREATE DATABASE ecommerce;
SHOW DATABASES;

-- Question-2  Import .csv file users_data into MySQL
--             (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file ->
--              Next -> choose options : Create a new table , select delete if exist -> next -> next)

-- Ans- Succesfully data uploaded.

-- Question-3 Run SQL command to see the structure of table.
-- Ans-

USE ecommerce;
SELECT * FROM users_data;

-- Question-4 Run SQL command to select first 100 rows of the database.
-- Ans-

SELECT * FROM users_data LIMIT 100;

-- Question-5 How many distinct values exist in table for field country and language.
-- Ans-

SELECT COUNT(DISTINCT country) distinct_country, COUNT(DISTINCT language) distinct_language FROM users_data;

-- Question-6 Check whether male users are having maximum followers or female users.
-- Ans-

SELECT * FROM users_data;
SELECT gender, SUM(socialnbfollowers) followers FROM users_data GROUP BY gender;
-- According to the result female users are maximum followers on ecommerce website.

-- Question-7 Calculate the total users those
--            A) Uses Profile Picture in their Profile
--            B) Uses Application for Ecommerce platform
--            C) Uses Android app
--            D) Uses ios app
-- Ans-
-- A) Uses Profile Picture in their Profile
SELECT * FROM users_data;
SELECT COUNT(type) total_users FROM users_data WHERE hasProfilePicture = 'True';

-- B) Uses Application for Ecommerce platform
SELECT COUNT(type) total_users FROM users_data WHERE hasAnyApp = 'True';

-- C) Uses Android app
SELECT COUNT(type) total_users FROM users_data WHERE hasAndroidApp = 'True';

-- D) Uses ios app
SELECT COUNT(type) total_users FROM users_data WHERE hasIosApp = 'True';

-- Question-8 Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. 
--            (Hint: consider only those users having at least 1 product bought.)
-- Ans-

SELECT * FROM users_data;
SELECT country, COUNT(productsbought) number_of_buyers FROM users_data 
WHERE productsbought > 0 GROUP BY country ORDER BY number_of_buyers DESC;

-- Question-9 Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. 
--            (Hint: consider only those users having at least 1 product sold.)
-- Ans- 
SELECT * FROM users_data;
SELECT country, COUNT(productsSold) number_of_sellers FROM users_data 
WHERE productsSold > 0 GROUP BY country ORDER BY number_of_sellers ASC;


-- Question-10 Display name of top 10 countries having maximum products pass rate.
-- Ans-
SELECT * FROM users_data;
SELECT country, MAX(productsPassRate) Product_pass_rate FROM users_data GROUP BY country ORDER BY  Product_pass_rate DESC LIMIT 10;

-- Question-11 Calculate the number of users on an ecommerce platform for different language choices.
-- Ans-

SELECT * FROM users_data;
SELECT language, COUNT(type) speakers FROM users_data GROUP BY language;

-- Question-12  Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.
--              (Hint: use UNION to answer this question.)
-- Ans- 
SELECT * FROM users_data;
SELECT 'female choices','count' UNION SELECT 'liked', COUNT(socialProductsLiked) FROM users_data WHERE socialProductsLiked > 0 AND gender = 'F'
UNION
SELECT 'wished', COUNT(productsWished) FROM users_data WHERE productsWished > 0 AND gender = 'F';

-- Question-13 Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
-- Ans-

SELECT 'male choices','count' UNION SELECT 'seller', COUNT(productsSold) FROM users_data WHERE productsSold > 0 AND gender = 'M'
UNION
SELECT 'buyer', COUNT(productsBought) FROM users_data WHERE productsBought > 0 AND gender = 'M';


-- Question-14 Which country is having maximum number of buyers?
-- Ans- According to the result france has maximum no of buyers.

SELECT * FROM users_data;
SELECT country, COUNT(productsbought) number_Of_buyers FROM users_data  GROUP BY country ORDER BY number_of_buyers DESC;
-- According to the result france has maximum no of buyers.

-- Question-15 List the name of 10 countries having zero number of sellers.
-- Ans-
SELECT * FROM users_data;
SELECT country, COUNT(productsSold) FROM users_data WHERE productsSold = 0 GROUP BY country LIMIT 10;

-- Question-16 Display record of top 110 users who have used ecommerce platform recently.
-- Ans-
SELECT * FROM users_data;
SELECT identifierHash, country, gender, daysSinceLastLogin FROM users_data ORDER BY daysSinceLastLogin ASC LIMIT 110;

-- Question-17 Calculate the number of female users those who have not logged in since last 100 days.
-- Ans-
SELECT * FROM users_data;
SELECT gender, COUNT(type) not_logged FROM users_data WHERE daysSinceLastLogin >= 100 AND gender = 'F';

-- Question-18 Display the number of female users of each country at ecommerce platform.
-- Ans-
SELECT * FROM users_data;
SELECT country, gender, COUNT(type) number_of_users  FROM users_data WHERE gender = 'F' GROUP BY country;

-- Question-19 Display the number of male users of each country at ecommerce platform.
-- Ans-
SELECT * FROM users_data;
SELECT country, gender, COUNT(type) number_of_users FROM users_data WHERE gender = 'M' GROUP BY country ORDER BY number_of_users DESC;

-- Question-20 Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
-- Ans-
SELECT * FROM users_data;
SELECT country, gender, AVG(productsSold) avg_of_sold_product, AVG(productsBought) avg_of_Bought_product FROM users_data 
WHERE gender = 'M' GROUP BY country;






























