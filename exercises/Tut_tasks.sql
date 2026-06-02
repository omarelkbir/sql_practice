select * from customers;

SELECT * FROM orders;

select 
first_name,
country,
score
from customers;

select * from customers 
where score != 0;

select first_name, country from customers 
where country = 'germany';

select * from customers 
order by score asc;

SELECT * FROM customers
ORDER BY country ASC, score DESC;

SELECT country, SUM(score) AS total_score
FROM customers
GROUP BY country
ORDER BY total_score DESC;

SELECT country, SUM(score) AS total_score, COUNT(id) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_score DESC;

SELECT country, avg(score) AS avg_score  
FROM customers
WHERE score != 0
GROUP BY country
HAVING avg_score > 430;

SELECT DISTINCT country
FROM customers;

SELECT * FROM customers
ORDER BY score DESC
LIMIT 3 ;

SELECT * FROM orders 
ORDER BY order_date DESC
LIMIT 2;

SELECT 123 AS a_number;

CREATE TABLE persons(
	id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);

SELECT * FROM persons;

ALTER TABLE persons 
ADD email VARCHAR(50) NOT NULL;

ALTER TABLE persons 
DROP COLUMN phone;

DROP TABLE persons;

INSERT INTO customers (id, first_name, country, score)
VALUES (6, 'anna', 'USA', NULL),
	   (7, 'sam', NULL, 100);

INSERT INTO persons (id, person_name, birth_date, phone)       
SELECT id, first_name, NULL, 'unknown' 
FROM customers;

SELECT * FROM persons;

UPDATE customers
SET score = 0
WHERE id = 6;

INSERT INTO customers (id, first_name, country, score)
VALUES (8, 'USA', 'max', NULL),
	   (9, 'andreas', 'germany', NULL),
       (10, 'sahra', NULL, NULL);
       
UPDATE customers
SET score = 0,
	country = 'UK'
WHERE id = 10;
SELECT * FROM customers WHERE id = 10;# this is good practice before executing the update command to see which rows will be affected, here it is only row 20 which is what we want. so we can feel confident and execute the update command bc if not filtered correctly, all rows will be updated.

UPDATE customers
SET score = 0 
WHERE score IS NULL;
SELECT * FROM customers WHERE score IS NULL;

DELETE FROM customers
WHERE id > 5;
SELECT * FROM customers WHERE id >5;

DELETE FROM persons; #to delete everything in the table
TRUNCATE TABLE persons; # it's faster than DELETE as it skips some extra steps that delete does.

USE mydatabase;

SELECT * FROM customers;

SELECT * FROM customers
WHERE country = 'germany';

SELECT * FROM customers 
WHERE country != 'germany';

SELECT * FROM customers
WHERE country = 'USA' AND score > 500;

SELECT * FROM customers
WHERE NOT score < 500;

SELECT * FROM customers 
WHERE score BETWEEN 100 AND 500;

SELECT * FROM customers
WHERE country IN ('Germany', 'USA');

SELECT * FROM customers 
WHERE first_name LIKE 'M%';

SELECT * FROM customers
WHERE first_name LIKE '%n';

SELECT * FROM customers
WHERE first_name LIKE '%r%';

SELECT * FROM customers
WHERE first_name LIKE '__r%';

SELECT * FROM customers;
SELECT * FROM orders;

SELECT * FROM customers 
INNER JOIN orders
ON customers.id = orders.customer_id;

SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id;

SELECT * FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;

SELECT * FROM customers c
RIGHT JOIN orders o 
ON c.id = o.customer_id;

SELECT * FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id;

SELECT * FROM customers c
LEFT JOIN orders o 
ON c.id = o.customer_id
UNION
SELECT * FROM orders o
LEFT JOIN customers c
ON c.id = o.customer_id;

SELECT * FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT * FROM customers c
RIGHT JOIN orders o  
ON o.customer_id = c.id
WHERE c.id IS NULL;

SELECT * FROM orders o 
LEFT JOIN customers c  
ON o.customer_id = c.id
WHERE c.id IS NULL;

SELECT * FROM customers c
LEFT JOIN orders o 
ON c.id = o.customer_id
WHERE o.customer_id IS NULL
UNION
SELECT * FROM orders o 
LEFT JOIN customers c 
ON c.id = o.customer_id
WHERE c.id IS NULL;

SELECT * FROM customers c 
LEFT JOIN orders o 
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

SELECT * FROM customers c 
CROSS JOIN orders o;
#somehow figured out this also makes a cross join lol.
SELECT * FROM customers c, orders o;

USE salesdb;

SELECT o.orderid, c.firstname, p.product, p.price , o.sales, e.firstname AS 'saleperson'
FROM orders o 
LEFT JOIN customers c ON o.customerid = c.customerid
INNER JOIN products p ON o.productid = p.productid
INNER JOIN employees e ON o.salespersonid = e.employeeid;


SELECT firstname, lastname FROM customers
UNION
SELECT firstname, lastname FROM employees;

SELECT firstname, lastname FROM customers
UNION ALL
SELECT firstname, lastname FROM employees;

SELECT firstname, lastname FROM employees
EXCEPT
SELECT firstname, lastname FROM customers;

SELECT firstname, lastname FROM employees
INTERSECT 
SELECT firstname, lastname FROM customers;

SELECT 'orders' AS type, orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus,
shipaddress, billaddress, quantity, sales, creationtime
FROM orders
UNION 
SELECT 'archived', orderid, productid, customerid, salespersonid, orderdate, shipdate, orderstatus,
shipaddress, billaddress, quantity, sales, creationtime
FROM orders_archive;

USE mydatabase;

SELECT CONCAT(first_name, ' ',  country) AS name_and_country
FROM customers;

SELECT LOWER(first_name) FROM customers;
SELECT UPPER(first_name) FROM customers;

SELECT first_name FROM customers
WHERE TRIM(first_name) != first_name;
-- to confirm
SELECT LENGTH(first_name) FROM customers
WHERE first_name LIKE '%john%';
-- THIS IS FROM THE TUT
SELECT first_name,
	LENGTH(first_name) AS len_name,
	LENGTH(TRIM(first_name)) AS len_trim_name,
    LENGTH(first_name) - LENGTH(TRIM(first_name)) AS flag
FROM customers;
-- WHERE LENGTH(first_name) != LENGTH(TRIM(first_name)); quick filter to only see the flagged ones
-- quickest one SELECT first_name FROM customers WHERE LENGTH(first_name) != LENGTH(TRIM(first_name));


SELECT '123-456-789',
REPLACE ('123-456-789', '-', '');
-- u specify the value, something to replace inside it, then whatever the replacement is
-- in my case replacing it with nothing/blankso it's '123456789'

-- Replace File Extence from txt to csv
SELECT 
    'report.txt' AS old_filename,
    REPLACE('report.txt', '.txt', '.csv') AS new_filename;
    
SELECT 
    first_name, LENGTH(first_name)
FROM
    customers;
    
SELECT first_name, LEFT(TRIM(first_name), 2) FROM customers;# first 2 characters
SELECT first_name, RIGHT(TRIM(first_name), 2) FROM customers;# last 2 characters

SELECT first_name, 
	SUBSTRING(TRIM(first_name), 2, LENGTH(first_name))
FROM customers;

SELECT DAY(NOW()) AS day;

SELECT YEAR(orderdate), COUNT(*) orders_count
FROM orders
GROUP BY YEAR(orderdate);

SELECT DATE_FORMAT(orderdate, '%M') month, COUNT(*) orders_count
FROM orders
GROUP BY DATE_FORMAT(orderdate, '%M');

SELECT * FROM orders
WHERE MONTH(orderdate) = 2;

SELECT YEAR(orderdate), COUNT(*)
FROM orders
GROUP BY YEAR(orderdate);

SELECT DATE_FORMAT(orderdate, '%M') month, COUNT(*) order_count
FROM orders
GROUP BY DATE_FORMAT(orderdate, '%M');

SELECT DATE_FORMAT(orderdate, '%M') month, COUNT(*) order_count
FROM orders
GROUP BY DATE_FORMAT(orderdate, '%M')
HAVING month ='February';#search/filtering using strings not integers is not recommended

#this is better practice: 

SELECT MONTH(orderdate) month, COUNT(*) order_count
FROM orders
WHERE MONTH(orderdate) = 2
GROUP BY month;

SELECT DATE_FORMAT(orderdate, 'day %a %b %Y %H:%i:%s %p') date_format
FROM orders;

SELECT * FROM salesdb.employees;

SELECT TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS emp_age
FROM employees; 
#TIMESTAMPDIFF(unit, start_date, end_date)
--              ↑      ↑           ↑
--           YEAR   birthdate   CURDATE()
#It calculates: end_date - start_date

SELECT 
	DATE_FORMAT(orderdate, '%M') month,
	CONCAT(ROUND(AVG(DATEDIFF(shipdate, orderdate))), ' Days') avg_delivery_time
FROM orders
GROUP BY DATE_FORMAT(orderdate, '%M');

USE mydatabase;

SELECT AVG(score)
FROM customers;

SELECT 
	firstname,
    lastname,
	CONCAT(IFNULL(firstname, lastname), ' ', IFNULL(lastname, '')) AS full_name,
    IFNULL(score, 0) + 10 AS updated_score
FROM customers;
# using this 2nd option here dont work, '+' is purely for math operations, it doesnt
# support string concats, so to merge strings together just use CONCAT() function
SELECT 
	firstname,
    lastname, 
	firstname + ' ' + lastname AS full_name,
    score
FROM customers; # doesnt work, it returns zero's and nulls in the full_name column

SELECT
	customerid,
    score,
    CASE WHEN score IS NULL THEN 1 ELSE 0 END flag #u can remove this from select and just keep it in the order by btw but i'm keeping it as reference.
FROM customers
ORDER BY CASE WHEN score IS NULL THEN 1 ELSE 0 END, score;
# this is to make the nulls appear last when ur sorting ASC instead of appearing
# first on the list. we make a flag that marks nulls as 1 then sort by it then score,
# so bunch of 0 flags while scores are sorted then we get 1 flags and all scored are 
# null anyway. this is a profissional way to handle null in sorting.

SELECT
	orderid,
    sales,
    quantity,
    sales / quantity AS price
FROM orders;

# customers who havnt placed any orders
SELECT c.*, o.orderid
FROM customers c
LEFT JOIN orders o 
	USING(customerid)
WHERE orderid IS NULL;

USE salesdb;

SELECT 
	orderid,
    sales,
    CASE
		WHEN sales > 50 THEN 'High'
		WHEN sales BETWEEN 20 AND 50 THEN 'Medium'
		ELSE 'Low'
	END sales_tier
FROM orders
ORDER BY sales DESC;

SELECT 
    CASE 
        WHEN sales > 50 THEN 'High'
        WHEN sales BETWEEN 20 AND 50 THEN 'Medium'
        ELSE 'Low'
    END AS sales_tier,
    COUNT(*) AS order_count,
    AVG(sales) AS avg_sales
FROM orders
GROUP BY sales_tier;

#CASE is an expression that returns a single value.
#It can go anywhere a single value is expected:
#SELECT, WHERE, ORDER BY, GROUP BY, HAVING, or inside functions.
#You cannot put CASE as a standalone clause (like SELECT ... CASE ... FROM —
#it must be inside SELECT, not between SELECT and FROM).

SELECT 
	firstname,
    lastname,
    CASE
		WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
        ELSE 'Other'
	END gender
FROM employees;

SELECT 
	firstname,
    lastname,
    country,
    CASE country 
		WHEN 'Germany' THEN 'GR'
        WHEN 'USA' THEN 'US'
	END abriviated_countries
FROM customers;
#there is simple CASE and searched CASE, simple when u want to compare equality
# using '=' sign, and searched when more complex, like '< > <= >= AND OR etc'
# in the simple CASE u can do CASE column_name WHEN value THEN  value. like example above

SELECT #my first attempt on the exercise from CASE tutorial
	c.customerid,
	COUNT(o.orderid) order_count,
    o.sales
FROM customers c
LEFT JOIN orders o
	ON c.customerid = o.customerid
GROUP BY c.customerid, o.sales;
    
SELECT #my second attempt after getting advice
	customerid,
    SUM(CASE
		WHEN sales > 30 THEN 1
        ELSE 0
	END) large_orders,
    COUNT(*) total_orders
FROM orders
GROUP BY customerid;

SELECT version();

SELECT 
	productid,
    orderid,
    orderdate,
    SUM(sales) OVER(PARTITION BY productid) total_sales
FROM orders;

SELECT 
    orderid,
    orderdate,
    productid,
    orderstatus,
    SUM(sales) OVER(PARTITION BY productid, orderstatus) total_sales
FROM orders;

SELECT
	orderid,
    orderdate,
    sales,
    RANK() OVER(ORDER BY sales DESC) TotalOrderSalesRanked
FROM orders;

SELECT 
	orderid,
    orderdate,
    sales,
    productid,
    SUM(sales) OVER(PARTITION BY productid ORDER BY sales 
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) total_sales
FROM orders
WHERE productid IN(101,102);
    
SELECT 
	orderid,
    orderdate,
    customerid,
	COUNT(*) OVER(PARTITION BY customerid) orders_per_customer,
    COUNT(*) OVER() orders_count
FROM orders;
    
SELECT 
	*,
	COUNT(*) OVER() customer_count,
    COUNT(score) OVER() scores_count
FROM customers;

SELECT 
	orderid,
	COUNT(orderid) OVER(PARTITION BY orderid) checkPK
FROM orders; #this is to check data quality to ensure there are no duplicates for each PK

SELECT 
	orderid,
	COUNT(orderid) OVER(PARTITION BY orderid) checkPK
FROM orders_archive;#there is duplicates for order id's here, needs cleaning up 
# or it will mess up analytics and result in inaccurate reports/data thus decisions

SELECT 
	*
FROM (
	SELECT
		orderid,
		COUNT(orderid) OVER(PARTITION BY orderid) checkPK
	FROM orders_archive
) subquery_test WHERE checkPK > 1;
#this is to mark out checks that are higher than 1 because 1 is normal and correct
#but higher means a duplucate in the primary key, so in a large table this makes the 
# the process of finding them faster and more efficient.


SELECT 
	orderid, 
    orderdate,
    productid,
    SUM(sales) OVER(PARTITION BY productid) sales_per_product,
    SUM(sales) OVER() total_sales
FROM orders;

SELECT 
orderid, 
orderdate,
productid,
SUM(sales) OVER() total_sales,
CONCAT('%', ROUND(CAST(sales AS FLOAT) / SUM(sales)  OVER() * 100, 2)) AS percent_contribution
FROM orders;

SELECT 
	orderid,
    orderdate,
    sales,
    productid,
    AVG(COALESCE(sales, 0)) OVER() avg_sales,
    AVG(COALESCE(sales, 0)) OVER(PARTITION BY productid) avg_sales_per_product
FROM orders;

SELECT 
*
FROM (
	SELECT 
		orderid,
		orderdate,
		sales,
		AVG(COALESCE(sales, 0)) OVER() avg_sales
	FROM orders
)subquery_test WHERE sales > avg_sales;

SELECT
	orderid,
    orderdate,
    sales,
    productid,
	MAX(sales) OVER() maxsales,
    MIN(sales) OVER() minsales,
    MAX(sales) OVER(PARTITION BY productid) maxproductsales,
    MIN(sales) OVER(PARTITION BY productid) minproductsales
FROM orders;
    
#moving average
SELECT 
	orderid,
    orderdate,
	productid,
    sales,
    AVG(sales) OVER(PARTITION BY productid) avg_sales,
    AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate) moving_average
FROM orders;

SELECT 
	orderid,
    orderdate,
	productid,
    sales,
    ROUND(AVG(sales) OVER(PARTITION BY productid), 0) avg_sales,
    ROUND(AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate), 0) moving_average,
    ROUND(AVG(sales) OVER(PARTITION BY productid ORDER BY orderdate
    ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING), 0) rolling_average
FROM orders;

SELECT 
	orderid,
    sales,
    ROW_NUMBER() OVER(ORDER BY sales DESC) sales_row_ranking,
    RANK() 		 OVER(ORDER BY sales DESC) sales_ranking,
    DENSE_RANK() OVER(ORDER BY sales DESC) sales_dense_ranking
FROM orders; # ROW_NUMBER doesnt handle ties in values, for example:
# 80 and 80 would get the rank 1 and 2 not 1 and 1. also it does not leave gaps in ranking.
# meanwhile RANK handles ties. but it does leave gaps
# dense_rank handles ties but does not leave gaps in ranking.

SELECT 
	productid,
    sales,
    ROW_NUMBER() OVER(PARTITION BY productid ORDER BY sales DESC) top_highest_performers
FROM orders;

SELECT * FROM (
	SELECT	
    *,
	ROW_NUMBER() OVER(PARTITION BY orderid ORDER BY creationtime DESC) row_num
	
	FROM orders_archive
)t WHERE row_num = 1;

#ROW_NUMBER USE CASES
#1 Top-N Analysis
#2 Bottom-N Analysis
#3 Assign unique IDs
#4 Quality Checks: Identify Duplicates


SELECT
	orderid,
    sales,
    NTILE(3) OVER(ORDER BY sales DESC) buckets,
    CASE 
		WHEN NTILE(3) OVER(ORDER BY sales DESC) = 1 THEN 'High Sales'
        WHEN NTILE(3) OVER(ORDER BY sales DESC) = 2 THEN 'Medium Sales'
        WHEN NTILE(3) OVER(ORDER BY sales DESC) = 3 THEN 'Low Sales'
	END category
FROM orders;
# how to do it with subquery so u can avoid copy pasting in the case statements
SELECT 
	*,
	CASE buckets # doing case buckets instead of just case here is unecessary since we're already selecting everything with *
		WHEN 1 THEN 'High Sales'
		WHEN 2 THEN 'Medium Sales'
		WHEN 3 THEN 'Low Sales'
	END sales_segmentations
FROM ( 
	SELECT
		orderid,
		sales,
		NTILE(3) OVER(ORDER BY sales DESC) buckets
	FROM orders
)t; # done, subqueries make work much more elegant and efficient.

SELECT 
	*,
	CONCAT('%', highest_prices * 100) AS top_prices_prcnt
FROM (
	SELECT
		productid,
		product,
		price,
		CUME_DIST() OVER (ORDER BY price DESC) highest_prices
	FROM products  
)t WHERE highest_prices <= 0.4;

# Value window functions

/*SELECT 
	DATE_FORMAT(orderdate, '%M') AS month,
    SUM(sales) AS current_month_sales,
    LAG(SUM(sales)) OVER (ORDER BY DATE_FORMAT(orderdate, '%M')) AS previous_month_sales
FROM orders
GROUP BY DATE_FORMAT(orderdate, '%M');
*/ # now the reason i didnt use the full month name instead of its number bc it has 
# an issue with order by, feburary shows up before january etc. numbers are more reliable
# and faster, just use the full name when reporting from now on and avoid it in general
SELECT 
	*,
    current_month_sales - previous_month_sales AS MoM_change,
    ROUND((current_month_sales - previous_month_sales) / previous_month_sales * 100, 2) AS MoM_perc
FROM (
	SELECT 
		MONTH(orderdate) AS month,
		SUM(sales) AS current_month_sales,
		LAG(SUM(sales)) OVER (ORDER BY MONTH(orderdate)) AS previous_month_sales
	FROM orders
	GROUP BY MONTH(orderdate)
    ) AS monthly_sales;
    

SELECT 
	customerid,
	AVG(days_between_orders) AS avg_days,
    RANK() OVER(ORDER BY AVG(days_between_orders)) AS most_loyal_customer
FROM (
	SELECT
		orderid,
		customerid,
		orderdate AS current_order,
		LEAD(orderdate) OVER (PARTITION BY customerid ORDER BY orderdate) AS next_order,
		DATEDIFF(LEAD(orderdate) OVER (PARTITION BY customerid ORDER BY orderdate), orderdate) AS days_between_orders
	FROM orders
) AS orders_info
GROUP BY customerid
HAVING AVG(days_between_orders) != 0;

SELECT
	o.productid,
    p.product,
    MIN(o.sales) AS lowest_sales,
    MAX(o.sales) AS highest_sales
FROM orders o 
JOIN products p
	ON o.productid = p.productid
GROUP BY productid, product;
# OR
SELECT 
	productid,
    sales,
    FIRST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales) AS lowest_sales,
    LAST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS highest_sales,
    # last_value with default frame literally useless, u have to change frame for it
    # to work as intended, here's proof with it with default frame:
    LAST_VALUE(sales) OVER (PARTITION BY productid ORDER BY sales) AS function_with_default_frame
	# or u can keep the frame as default but switch the sorting order for it to work too
    # for example above we sorted highest sales ASC, so just do DESC so it will as well.
FROM orders;

SELECT * FROM INFORMATION_SCHEMA.SCHEMATA;
#shows the metadata of our database, meaning data of our data, this is called a catalog 
#inside a database. 

SHOW DATABASES;                          -- All databases
SHOW TABLES FROM salesdb;                -- Tables in salesdb
SHOW COLUMNS FROM orders FROM salesdb;   -- Columns in orders
DESC salesdb.orders;                     -- Same as above
SHOW CREATE TABLE salesdb.orders;        -- Full CREATE TABLE statement

#subqueries tasks
SELECT 
	productid,
    product,
    price
FROM products
WHERE price > (SELECT AVG(price) FROM products);
# OR if u wanna see the avg price column too
SELECT
	*
FROM (
	SELECT
		productid,
		product,
		price,
		AVG(price) OVER () AS avg_price
	FROM products)t
WHERE price > avg_price;

SELECT 
	*,
    RANK() OVER(ORDER BY total_amount DESC) AS ranking
FROM (
	SELECT 
		customerid,
		SUM(sales) AS total_amount
	FROM orders
    GROUP BY customerid)t;

SELECT
	productid,
    product,
    price,
    (SELECT COUNT(*) FROM orders) AS orders_count
FROM products;

SELECT * FROM customers c
LEFT JOIN (
	SELECT 
		o.customerid,
		COUNT(orderid) AS total_orders
	FROM orders o
    GROUP BY o.customerid
    )t ON c.customerid = t.customerid;
    # = t.customerid not o.customerid because orders o is inside the subquery and the
    # ON part is outside the subquery so it doesnt work, so its t.customerid not o.
    
