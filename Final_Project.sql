# Selecting the database
USE guvi;

# Question 1 - 
# Write a query to get the customerid, full name of the customer and the present age of the customer
# Table required -> customers
SELECT CustomerID, CONCAT(FirstName, ' ', LastName) AS Full_Name, EXTRACT(YEAR FROM NOW()) - EXTRACT(YEAR FROM Date_of_Birth) AS Present_Age
FROM Customers;


# Question 2 - 
# Write a query to get the number of characters in first name and the respective count of customers 
# Table required -> customers
SELECT 
  LENGTH(FirstName) AS Number_of_Characters,
  COUNT(*) AS Count_of_Customers
FROM Customers
GROUP BY LENGTH(FirstName)
ORDER BY Number_of_Characters DESC;


# Question 3 - 
# Write a query to get the distinct number of customers from United States that made orders in 1st quarter of year 2021
# Table required -> customers and orders
SELECT 
  COUNT(DISTINCT Customers.CustomerID) AS Distinct_Number_of_Customers
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '2021-01-01' AND '2021-03-31'
AND Customers.Country = 'United States';

# Question 4 - 
# Write a query to get the total number of orders made in year 2020 and 2021 every week
SELECT 
  YEAR(OrderDate) AS Year,
  WEEK(OrderDate) AS Week,
  COUNT(*) AS Total_Orders
FROM Orders
WHERE YEAR(OrderDate) IN (2020, 2021)
GROUP BY YEAR(OrderDate), WEEK(OrderDate);

# Question 5 - 
# Get the Description of customer along with the Customerid and Domain of their email
# The Final output should contain this columns Customerid, Domain of their email, Description.
# Get the details of description from the below attached sample output Description_ column.
# Sort the result by DateEntered desc, if date entered is same then CustomerId in ascending.

# Description Sample -
# Malcom Julian was born on 8th March 1985 has ordered 12 orders yet.

# Note- All letters are case sensetive take same case letters as given in sample output Description_. 
# Every Day value will have 'th' in front of it.
# Tables needed -> customers, orders 
SELECT
    c.CustomerId,
    SUBSTRING_INDEX(SUBSTR(c.Email, INSTR(c.Email, '@') + 1),'.',1) as Domain,
	CONCAT(c.FirstName, ' ', c.LastName, ' born on ', DAY(c.Date_of_Birth), 'th',' ', MONTHNAME(c.Date_of_Birth),' ', YEAR(c.Date_of_Birth), ' has ordered ',COUNT(o.OrderId), ' orders yet.') AS Description
FROM
customers c
LEFT JOIN orders o ON c.CustomerId = o.CustomerId
GROUP BY
c.CustomerId, c.Email, c.FirstName, c.LastName, c.Date_of_Birth, c.DateEntered
ORDER BY
c.DateEntered DESC,
c.CustomerId ASC;


# Question 6 - 
# The company wants to see if the shippers are delivering the orders on weekends or not.
# So for that, they want to see the number of orders delivered on a particular weekday.
# Print DayName, count of orders delivered on that day in the descending order of count of orders.
SELECT 
  DAYNAME(DeliveryDate) AS Day_Name,
  COUNT(*) AS Count_of_Orders
FROM Orders
GROUP BY DAYNAME(DeliveryDate)
ORDER BY Count_of_Orders DESC;


# Question 7 - 
# Write a query to find the average revenue for each order whose difference between 
# the order date and ship date is 3.
# Use the total order amount to calculate the revenue. 
# Print the order ID, customer ID, average revenue, and sort them in increasing order of the order ID.
# Tables needed -> orders
SELECT 
  OrderID,
  CustomerID,
  AVG(Total_order_amount) AS Average_Revenue
FROM orders
WHERE DATEDIFF(ShipDate, OrderDate) = 3
GROUP BY OrderID, CustomerID
ORDER BY OrderId;


# Question 8 -
# Count the number of Suppliers based out of each Country.
# Print the following sentence:
# For Example : if the number of suppliers are more than 1 then print 
# 'There are 100 Suppliers from France' else print 'There is 1 Supplier from France'
# Order the output in ascending order of country.
# Note: All characters are case sensitive.
# Tables needed -> suppliers

SELECT
    COUNT(*) AS SupplierCount,
    Country,
    CONCAT(
        'There ',
        CASE WHEN COUNT(*) > 1 THEN 'are ' ELSE 'is ' END,
        COUNT(*),
        ' Supplier',
        CASE WHEN COUNT(*) > 1 THEN 's ' ELSE ' ' END,
        'from ',
        Country
    ) AS Sentence
FROM
    Suppliers
GROUP BY
    Country
ORDER BY
    Country ASC;








