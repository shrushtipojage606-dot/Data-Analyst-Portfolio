#created Database Zepto
Create database Zepto;

#Added id coloumn into zepto table
ALTER TABLE zepto
ADD column id int auto_increment
primary key first;

#Data Exploration
SELECT COUNT(*)
FROM zepto;

SELECT  *
FROM zepto
LIMIT 5;

#Product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

#Product in stock or Out of Stock
SELECT  outOfStock, COUNT(id)
FROM zepto
GROUP BY outOfStock;

# product name present maltiple times
SELECT  name, COUNT(id)
FROM zepto
GROUP BY name
HAVING COUNT(id) > 1
ORDER BY COUNT(id) DESC;

#checking rows whether values are null.
SELECT *
FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

#Data Cleaning
#Delete rows where mrp is 0
DELETE FROM zepto 
WHERE mrp = 0;

# convert into rupess
UPDATE zepto 
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

SELECT  mrp, discountedSellingPrice
FROM zepto;

#Bussiness Questions
#Q1. Find the top 10 best values product based on the discount percentage.

SELECT DISTINCT id, name, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

#Q2. Which are the Products with High MRP but Out of Stock.
SELECT DISTINCT name, mrp, outOfStock
FROM zepto
WHERE outOfStock = 'true' AND mrp > 300
ORDER BY mrp DESC;

#Q3. Calcualte Estimated revenue for each category.
SELECT category,
    SUM(discountedSellingPrice * availableQuantity) AS Total_revenue
FROM zepto
GROUP BY category
ORDER BY Total_revenue;

#Q4. Find all products where MRP is greater than ₹500 and discount is less than 10 %.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC , discountPercent DESC;

#Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT  category, ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY Category
ORDER BY avg_discount DESC
LIMIT 5;

#Q6. Find the price per gram for products above 100g and sort by best values.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
    discountedSellingPrice / weightInGms AS Price_Per_Gram
FROM zepto
WHERE weightInGms > 100
ORDER BY Price_Per_Gram DESC;

#Q7.Group the product into categories like Low, Medium, Bulk
SELECT DISTINCT name, weightInGms,
CASE
	WHEN weightInGms < 1000 THEN ' Low'
	WHEN weightIngms < 5000 THEN ' Medium'
	ELSE 'Bulk'
    END AS weight_category
FROM zepto;

#Q8. What is the total Inventory weight per Category.
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
from zepto
group by category 
order by total_weight desc;