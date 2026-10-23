show databases;
use superstore_db;
show tables;
select*from superstore_db
limit 5;
select sum(sales) as total_sales
from cleaned_retail_sales;
describe cleaned_retail_sales;
-- Task 2: Calculate Total Profit

SELECT SUM(Profit) AS Total_Profit
FROM cleaned_retail_sales;
-- Task 3: Total Orders
SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM cleaned_retail_sales;

-- Task 4: Total Customers
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM cleaned_retail_sales;

-- Task 5: Average Order Value
SELECT
    SUM(Sales) / COUNT(DISTINCT `Order ID`) AS Average_Order_Value
FROM cleaned_retail_sales;
-- Task 6: Sales by Category
SELECT Category, SUM(Sales) AS Total_Sales
FROM cleaned_retail_sales
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Task 7: Sales by Region
SELECT Region, SUM(Sales) AS Total_Sales
FROM cleaned_retail_sales
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Task 8: Profit by Category
SELECT Category, SUM(Profit) AS Total_Profit
FROM cleaned_retail_sales
GROUP BY Category
ORDER BY Total_Profit DESC;

-- Task 9: Profit by Region
SELECT Region, SUM(Profit) AS Total_Profit
FROM cleaned_retail_sales
GROUP BY Region
ORDER BY Total_Profit DESC;

-- Task 10: Sales by Month
SELECT
    DATE_FORMAT(`Order Date`, '%Y-%m') AS Sales_Month,
    SUM(Sales) AS Monthly_Sales
FROM cleaned_retail_sales
GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
ORDER BY Sales_Month;
-- Task 11: Top 10 Customers by Sales
SELECT
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS Total_Sales
FROM cleaned_retail_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Task 12: Repeat Customers
SELECT
    `Customer ID`,
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM cleaned_retail_sales
GROUP BY `Customer ID`, `Customer Name`
HAVING COUNT(DISTINCT `Order ID`) > 1
ORDER BY Total_Orders DESC;

-- Task 13: Average Customer Spending
SELECT
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS Total_Spending,
    AVG(Sales) AS Average_Sales_Per_Record
FROM cleaned_retail_sales
GROUP BY `Customer ID`, `Customer Name`
ORDER BY Total_Spending DESC;
-- Task 14: Top Products by Sales
SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales
FROM cleaned_retail_sales
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- Task 15: Bottom Products by Sales
SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales
FROM cleaned_retail_sales
GROUP BY `Product Name`
ORDER BY Total_Sales ASC
LIMIT 10;

-- Task 16: Most Profitable Products
SELECT
    `Product Name`,
    SUM(Profit) AS Total_Profit
FROM cleaned_retail_sales
GROUP BY `Product Name`
ORDER BY Total_Profit DESC
LIMIT 10;
-- Task 17: Customer Ranking by Sales
SELECT
    `Customer ID`,
    `Customer Name`,
    SUM(Sales) AS Total_Sales,
    DENSE_RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Customer_Rank
FROM cleaned_retail_sales
GROUP BY `Customer ID`, `Customer Name`;

-- Task 18: Product Ranking by Sales
SELECT
    `Product Name`,
    SUM(Sales) AS Total_Sales,
    DENSE_RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Product_Rank
FROM cleaned_retail_sales
GROUP BY `Product Name`;

-- Task 19: Monthly Sales Growth
WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(`Order Date`, '%Y-%m') AS Sales_Month,
        SUM(Sales) AS Total_Sales
    FROM cleaned_retail_sales
    GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
),
Sales_With_Previous AS (
    SELECT
        Sales_Month,
        Total_Sales,
        LAG(Total_Sales) OVER (
            ORDER BY Sales_Month
        ) AS Previous_Month_Sales
    FROM Monthly_Sales
)
SELECT
    Sales_Month,
    Total_Sales,
    Previous_Month_Sales,
    ROUND(
        (Total_Sales - Previous_Month_Sales)
        / NULLIF(Previous_Month_Sales, 0) * 100,
        2
    ) AS Growth_Percentage
FROM Sales_With_Previous
ORDER BY Sales_Month;

-- Task 20: Category Ranking by Sales
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    DENSE_RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Category_Rank
FROM cleaned_retail_sales
GROUP BY Category;