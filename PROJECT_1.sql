
#1. Create new schema as ecommerce.
CREATE DATABASE ecommerce;
USE ecommerce;

#3Run SQL command to see the structure of table.
DESC users_data; 

#4. Run SQL command to select first 100 rows of the database
SELECT * FROM users_data LIMIT 100;

#5. How many distinct values exist in table for field country and language?
SELECT COUNT(DISTINCT country) dist_country, COUNT(DISTINCT language) dist_language FROM users_data;

#6. Check whether male users are having maximum followers or female users.
SELECT  gender, SUM(socialNbFollowers) FROM users_data GROUP BY gender

#7. Calculate the total users those
# a. Uses Application for Ecommerce platform
# b. Uses Android app                                       
# c. Uses ios app
SELECT 'Description', 'Total Users' 
UNION SELECT 'Has Profile Picture', COUNT(hasProfilePicture) FROM users_data WHERE hasProfilePicture = 'TRUE' 
UNION SELECT 'Has any App', COUNT(hasAnyApp)  FROM users_data WHERE hasAnyApp = 'TRUE' 
UNION SELECT 'Has Andriod App', COUNT(hasAndroidApp)  FROM users_data WHERE hasAndroidApp = 'TRUE' 
UNION SELECT 'Has ios App', COUNT(hasIosApp)  FROM users_data WHERE hasIosApp = 'TRUE';

#8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only 
# those users having at least 1 product bought.)
SELECT country, COUNT(productsbought) Buyers FROM users_data WHERE productsBought > 0 GROUP BY country ORDER BY Buyers desc;

#9. Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only 
# those users having at least 1 product sold.)
SELECT country, COUNT(productsSold) Sellers FROM users_data Where productsSold > 0 GROUP BY country ORDER BY Sellers asc;

#10. Display name of top 10 countries having maximum products pass rate.
SELECT country, MAX(productsPassRate) ppr FROM users_data GROUP BY country ORDER BY ppr desc;

#11. Calculate the number of users on an ecommerce platform for different language choices.
SELECT COUNT(language) DiffLangChoices FROM users_data WHERE language <> 'en';

#12. Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. 
# (Hint: use UNION to answer this question.)
SELECT 'Description', 'No. of units' 
UNION SELECT  'Products Social Liked', SUM(socialProductsLiked) units FROM users_data WHERE gender = 'F' 
UNION SELECT 'Products wishlisted', SUM(productsWished) wishlisted FROM users_data WHERE gender = 'F';

#13. Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
SELECT 'Description', 'No. of units' 
UNION SELECT 'Number of male sellers', COUNT(productsSold) FROM users_data WHERE gender = 'M' AND productsSold > 0
UNION SELECT 'Number of male buyers', COUNT(productsBought) FROM users_data WHERE gender = 'M' AND productsBought > 0;

#14. Which country is having maximum number of buyers?
SELECT country, MAX(productsSold) maxbuyers FROM users_data GROUP BY country ORDER BY maxbuyers DESC;

#15. List the name of 10 countries having zero number of sellers.
SELECT country, productsSold FROM users_data WHERE productsSold = 0 LIMIT 10;

#16. Display record of top 110 users who have used ecommerce platform recently.
SELECT * FROM users_data WHERE daysSinceLastLogin < 30 LIMIT 110;

#17. Calculate the number of female users those who have not logged in since last 100 days.
SELECT COUNT(gender) FemaleUsers FROM users_data WHERE daysSinceLastLogin > 100 AND gender = 'F';

#18. Display the number of female users of each country at ecommerce platform.
SELECT country, COUNT(identifierHash) AS Femaleusers FROM users_data WHERE gender = 'F' GROUP BY country;

#19. Display the number of male users of each country at ecommerce platform.
SELECT country, COUNT(identifierHash) AS Maleusers FROM users_data WHERE gender = 'M' GROUP BY country;

#20. Calculate the average number of products sold and bought on ecommerce platform by male users for each country.
SELECT country, AVG(productsSold) AverageSold, AVG(productsBought) AverageBought FROM users_data WHERE gender = 'M' GROUP BY country;




