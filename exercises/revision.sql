# Revision.

CREATE DATABASE revision_db;
USE revision_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY, full_name VARCHAR(50), department VARCHAR(30),
    salary DECIMAL(10,2), hire_date DATE, city VARCHAR(30),
    performance_score INT, manager_id INT
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY, product_name VARCHAR(50), category VARCHAR(30),
    amount DECIMAL(10,2), sale_date DATE, region VARCHAR(20),
    salesperson_id INT, quantity INT
);

-- Insert data (12 employees, 15 sales records with varied attributes)
INSERT INTO employees VALUES
(1,'Alice Johnson','Engineering',85000,'2020-03-15','New York',92,NULL),
(2,'Bob Smith','Engineering',72000,'2021-06-20','San Francisco',88,1),
(3,'Carol White','Sales',65000,'2019-11-10','New York',95,1),
(4,'David Brown','Sales',58000,'2022-01-15','Chicago',76,3),
(5,'Eve Davis','Marketing',62000,'2020-08-05','San Francisco',85,1),
(6,'Frank Miller','Engineering',91000,'2018-05-22','New York',96,1),
(7,'Grace Wilson','Sales',55000,'2023-02-28','Chicago',72,3),
(8,'Henry Taylor','Marketing',48000,'2022-09-12','Austin',68,5),
(9,'Ivy Anderson','Engineering',78000,'2021-04-18','San Francisco',90,2),
(10,'Jack Thomas','HR',52000,'2020-12-01','Austin',82,NULL),
(11,'Karen Jackson','Sales',71000,'2019-07-30','New York',94,3),
(12,'Leo Martinez','Engineering',67000,'2022-11-15','Chicago',79,2);

INSERT INTO sales VALUES
(1,'Laptop Pro','Electronics',1200,'2024-01-15','North',3,2),
(2,'Office Chair','Furniture',350,'2024-01-16','South',4,5),
(3,'Laptop Pro','Electronics',1200,'2024-01-17','North',3,1),
(4,'Desk Lamp','Furniture',85,'2024-01-18','East',7,3),
(5,'Monitor 4K','Electronics',450,'2024-01-20','West',11,4),
(6,'Bookshelf','Furniture',220,'2024-02-05','North',4,2),
(7,'Laptop Pro','Electronics',1200,'2024-02-10','South',3,3),
(8,'Wireless Mouse','Electronics',45,'2024-02-12','East',7,10),
(9,'Standing Desk','Furniture',800,'2024-02-15','West',11,1),
(10,'Webcam HD','Electronics',120,'2024-03-01','North',3,6),
(11,'Filing Cabinet','Furniture',180,'2024-03-05','South',4,2),
(12,'Monitor 4K','Electronics',450,'2024-03-08','East',11,3),
(13,'Laptop Pro','Electronics',1200,'2024-03-10','West',3,2),
(14,'Ergonomic Chair','Furniture',650,'2024-03-12','North',4,1),
(15,'USB Hub','Electronics',60,'2024-03-15','South',7,8);

#exercises for revision

SELECT full_name, department, salary, hire_date, performance_score
FROM employees 
WHERE department IN ('Engineering', 'Sales') 
 AND salary BETWEEN 60000 AND 80000
 AND hire_date > '2020-01-01'
 AND performance_score >= 80
ORDER BY department DESC, salary ASC
LIMIT 5;

SELECT department, AVG(salary), COUNT(*), MAX(performance_score)
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000 AND COUNT(*) >= 2 AND MAX(performance_score) >= 90
ORDER BY AVG(salary) DESC;

SELECT city, department, COUNT(*) emp_count, AVG(performance_score) avg_performance
FROM employees
WHERE city != 'Chicago'
GROUP BY city, department
HAVING emp_count > 1 AND avg_performance > 85 
ORDER BY emp_count DESC, avg_performance DESC
LIMIT 3;

SELECT YEAR(hire_date) hire_year, department,
SUM(salary) total_salary,
COUNT(*) emp_count
FROM employees
WHERE hire_date >= '2021-01-01' AND hire_date <= '2022-12-31'
GROUP BY YEAR(hire_date), department
HAVING total_salary > 50000
ORDER BY total_salary DESC
LIMIT 3;

SELECT * FROM revision_db.sales;
SELECT SUM(amount * quantity) total_revenue,
AVG(amount) avg_amount,
COUNT(*) transactions,
SUM(quantity) total_quantity
FROM sales
GROUP BY category
HAVING total_revenue > 2000 AND avg_amount > 100
ORDER BY total_revenue DESC;

SELECT * FROM revision_db.employees;
SELECT * FROM revision_db.sales;

ALTER TABLE employees
ADD email VARCHAR(100);

UPDATE employees
SET email = CONCAT(LOWER(SUBSTRING(full_name, 1, 3)), emp_id, '@company.com');

SELECT sale_id, product_name, category, amount, quantity FROM sales
WHERE category = 'Furniture' AND amount < 200 AND quantity < 3;

DELETE FROM sales
WHERE category = 'Furniture' AND amount < 200 AND quantity < 3;

SELECT * FROM employees 
WHERE department IN ('Engineering', 'Sales') 
AND salary BETWEEN 60000 AND 90000
AND performance_score >= 80
AND city != 'Chicago'
ORDER BY salary DESC, performance_score
LIMIT 5;

SELECT full_name, department FROM employees
WHERE length(full_name) - length(replace(full_name, ' ', '')) = 1;

SELECT 
	department,
    COUNT(emp_id),
    ROUND(AVG(salary), 2) avg_salary,
    MAX(performance_score)
FROM employees
GROUP BY department
HAVING COUNT(emp_id) >= 3 AND ROUND(AVG(salary)) > 65000
ORDER BY avg_salary DESC;

SELECT 
	category,
    SUM(amount) total_revenue,
    SUM(quantity) total_quantity,
    ROUND(AVG(amount)) avg_amount
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

SELECT 
	e.full_name,
    s.product_name,
    s.amount,
    s.region
FROM employees e
INNER JOIN sales s
	ON e.emp_id = s.salesperson_id
WHERE s.amount > 100
ORDER BY e.full_name;

SELECT e.full_name, SUM(s.amount)
FROM employees e
LEFT JOIN sales s
	ON e.emp_id = s.salesperson_id
GROUP BY e.full_name;

SELECT
	m.full_name AS manager_name,
    m.department AS manager_department
FROM employees e
JOIN employees m
	ON e.manager_id = m.emp_id
ORDER BY m.full_name;

SELECT 
	full_name,
    CONCAT(LOWER(LEFT(full_name, 3)), emp_id, LOWER(RIGHT(full_name, 2))) AS username
FROM employees;

SELECT 
	full_name,
    CONCAT(ROUND(salary / 1000) , 'k') AS my_salary
FROM employees;


SELECT 
	REPLACE(product_name, ' ', '_') AS modified_product_name,
    CONCAT(UPPER(category), '-', REPLACE(product_name, ' ', '_')) AS modified_category
FROM sales;

SELECT full_name, city, 'High Earner' AS status
FROM employees
WHERE city = 'New York' AND salary > 70000
UNION ALL
SELECT full_name, city, 'Top Performers' AS status
FROM employees
WHERE city = 'San Francisco' AND performance_score > 85;

SELECT 
    product_name,
    amount AS original_amount,
    ROUND(amount * 0.15, 2) AS bonus_amount
FROM sales;
SELECT 
	category, 
	ROUND(AVG(amount * 0.15), 2) AS avg_bonus
FROM sales
GROUP BY category;

SELECT salesperson_id 
FROM sales
WHERE region = 'North'
INTERSECT
SELECT salesperson_id 
FROM sales
WHERE region = 'South';

SELECT 
	CONCAT(UPPER(LEFT(full_name, 1)), SUBSTRING(full_name, 2)) AS cfull_name,
    CONCAT(UPPER(LEFT(department, 1)), SUBSTRING(full_name, 2)) AS cdepartment,
    salary,
    'Senior' AS tier
FROM employees
WHERE salary >= 80000
UNION ALL
SELECT
	CONCAT(UPPER(LEFT(full_name, 1)), SUBSTRING(full_name, 2)), 
    CONCAT(UPPER(LEFT(department, 1)), SUBSTRING(full_name, 2)),
    salary,
    'Mid' AS tier
FROM employees
WHERE salary BETWEEN 60000 AND 79000
UNION ALL 
SELECT
	CONCAT(UPPER(LEFT(full_name, 1)), SUBSTRING(full_name, 2)),
	CONCAT(UPPER(LEFT(department, 1)), SUBSTRING(full_name, 2)),
	salary,
	'Junior' AS tier
FROM employees
WHERE salary < 60000; 

SELECT  
	e.full_name,
    COUNT(s.sale_id) sale_count,
    CONCAT('$',ROUND(SUM(s.amount),0)) revenue_generated
FROM employees e
LEFT JOIN sales s
	ON e.emp_id = s.salesperson_id
WHERE s.category = 'Electronics'
GROUP BY e.emp_id, e.full_name
ORDER BY SUM(s.amount) DESC;

#REVISION 
#TASKS
SELECT
	country,
    AVG(score) AS avg_score
FROM customers
WHERE score > 0
GROUP BY country 
HAVING AVG(score) > 430;

SELECT 
	c.customer_name,
    o.order_amount
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
WHERE o.order_amount > 1000;
#THIS DOESNT GIVE U ALL CUSTOMERS. ONLY THOSE WITH 1000 DOLLAR PLUS PURCHASES.
#ESSENTIALLY MAKING THE LEFT JOIN OBSOLETE SINCE ALL CUSTOMERS RAN THROUGH A FILTER TO 
#SEE IF THEY ARE BIG SPENDERS OR NOT. 
#TO KEEP ALL CUSTOMERS. FILTER IN THE ON CLAUSE OF THE LEFT JOIN. THIS ENSURES ALL 
#CUSTOMERS ARE KEPT BUT THEY JUST HAVE THIER ORDER AMOUNT TURN TO NULL VALUES IF THEY
#DID NOT HAVE ABOVE 1000 DOLLARS PURCHASES. BASICALLY KEEPING ALL CUSTOMERS AND ONLY 
#SHOWING ORDER AMOUNT OF BIG SPENDERS,COMPARED TO FILTERING OUT ALL THE NON BIG SPENDERS
#WHEN FILTERING IN THE WHERE CLAUSE. HERE'S THE EXAMPLE:
SELECT
	c.customer_id,
    o.order_amount
FROM customers c
LEFT JOIN orders o 
	ON c.customer_id = o.customer_id 
    AND o.order_amount > 1000;
    
SELECT DISTINCT
	country
FROM customers;

SELECT order_id, order_date
FROM orders
ORDER BY order_date DESC
LIMIT 2;

CREATE TABLE persons (
	id INT NOT NULL,
    person_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL,
    CONSTRAINT pk_persons PRIMARY KEY (id)
);
SELECT * FROM persons;

ALTER TABLE persons 
ADD COLUMN email VARCHAR(50) NOT NULL;

ALTER TABLE persons
DROP COLUMN phone;

DROP TABLE persons;

INSERT INTO customers (id, first_name, country, score)
VALUES 
	(6, 'anna', 'norway', NULL),
    (7, 'tara', NULL, 100);

CREATE TABLE persons (
	id INT NOT NULL,
    person_name VARCHAR (50) NOT NULL,
    birthdate DATE,
    phone VARCHAR (15) NOT NULL
);
INSERT INTO persons (id, person_name, birthdate, phone)
SELECT id, first_name, NULL, 'Unknown'
FROM customers;

SELECT * FROM persons;
SELECT * FROM customers;

UPDATE customers
SET score = 0
WHERE id = 6;

SELECT * FROM customers 
WHERE id = 6;

UPDATE customers
SET country = 'Sweden', score = 15
WHERE id = 7;

DELETE FROM persons
WHERE id != 7;
TRUNCATE TABLE persons; #this is faster bc it skips bunch of steps like logs and protocols

SELECT c.id, c.first_name, o.order_id, o.sales
FROM customers c
INNER JOIN orders o
	ON c.id = o.customer_id;

SELECT * FROM orders o
RIGHT JOIN customers c
ON o.customer_id = c.id;

#LEFT ANTI JOIN 
SELECT * FROM customers c
LEFT JOIN orders o
	ON c.id = o.customer_id 
WHERE o.customer_id IS NULL;

#RIGHT ANTI JOIN
SELECT * FROM customers c
RIGHT JOIN orders o 
	ON c.id = o.customer_id
WHERE c.id IS NULL;

#FULL ANTI JOIN
SELECT * FROM customers c
LEFT JOIN orders o 
	ON c.id = o.customer_id
WHERE o.customer_id IS NULL
UNION 
SELECT * FROM customers c
RIGHT JOIN orders o
	ON c.id = o.customer_id
WHERE c.id IS NULL;

#INNER JOIN WITHOUT USING INNER JOIN KEYWORD
SELECT * FROM customers c
LEFT JOIN orders o
	ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;

#CROSS JOIN
SELECT * FROM customers 
CROSS JOIN orders; 

SELECT 
	o.orderid,
    CONCAT(c.firstname, c.lastname) AS customer_name,
    p.product AS product_name,
    o.sales,
    p.price,
    CONCAT(e.firstname, e.lastname) AS salesperson_name
FROM orders o
LEFT JOIN customers c 
	ON o.customerid = c.customerid
LEFT JOIN products p
	ON o.productid = p.productid
LEFT JOIN employees e
	ON o.salespersonid = e.employeeid;
    
#UNION
SELECT 
	customerid AS id,
    firstname,
    lastname
FROM customers 
UNION 
SELECT employeeid, firstname, lastname
FROM employees;

#workaround
SELECT 
	e.employeeid,
    e.firstname,
    e.lastname
FROM employees e
LEFT JOIN customers c
	ON e.firstname = c.firstname
WHERE c.firstname IS NULL;

#modern approach
SELECT e.firstname, e.lastname FROM employees e
EXCEPT
SELECT c.firstname, c.lastname FROM customers c;

#best workaround
SELECT
	e.employeeid,
    e.firstname,
    e.lastname
FROM employees e
WHERE NOT EXISTS (
	SELECT 1
    FROM customers c
    WHERE e.firstname = c.firstname AND e.lastname = c.lastname
);

SELECT
	CONCAT(firstname, '-', country) AS name_country,
    LOWER(firstname) AS lower_name
FROM customers;

SELECT firstname, LENGTH(firstname) FROM customers
WHERE firstname != TRIM(firstname);

SELECT 
	c.customerid,
    c.firstname,
    o.orderid
FROM customers c
LEFT JOIN orders o 
	ON c.customerid = o.customerid
WHERE o.customerid IS NULL;


SELECT 
	category,
    SUM(sales) AS total_sales
FROM (
	SELECT
		orderid,
		sales,
		CASE
			WHEN sales > 50 THEN 'High'
			WHEN sales > 20 THEN 'Medium'
			ELSE 'Low'
		END AS category
	FROM orders
)t
GROUP BY category
ORDER BY total_sales DESC;

SELECT 
	employeeid,
    firstname,
    lastname,
    CASE 
		WHEN gender = 'F' THEN 'Female'
        WHEN gender = 'M' THEN 'Male'
	END AS full_gender
FROM employees;

SELECT 
	customerid,
    firstname,
    country,
    CASE country 
		WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN country
        ELSE 'N/A'
	END AS country_code
FROM customers;
        
SELECT
	customerid,
    lastname,
    score,
    AVG(CASE WHEN score IS NULL THEN 0 ELSE score END) OVER () AS avg_scores
FROM customers;
   
SELECT
	customerid,
    SUM(CASE WHEN sales > 30 THEN 1 ELSE 0 END) AS big_order_count,
	count(*) AS total_orders
FROM orders
GROUP BY customerid;

SELECT COUNT(*) FROM orders;

SELECT 
	productid,
    orderid,
    orderdate,
    sales,
    orderstatus,
	SUM(sales) OVER(PARTITION BY productid, orderstatus) AS total_sales
FROM orders; 

SELECT 
	orderid,
    orderdate,
    sales,
    RANK() OVER (ORDER BY sales DESC) AS rnk
FROM orders;

SELECT
	orderid,
    productid,
    orderstatus,
    sales,
    SUM(sales) OVER (PARTITION BY orderstatus) AS total_sales
FROM orders
WHERE productid IN (101, 102);
   
SELECT 
customerid,
SUM(sales) AS total_sales,
RANK() OVER (ORDER BY SUM(sales) DESC) AS rnk
FROM orders
GROUP BY customerid;
#In MySQL (and standard SQL), window functions are evaluated after the GROUP BY 
#and aggregation. That means:
#The result set at the point the window function runs is already grouped.
#Inside the OVER(...) clause of a window function, you can only reference columns
#that are either:
#In the GROUP BY list (because those columns survive the grouping), or
#Aggregate expressions (like SUM(sales), COUNT(*), AVG(amount), etc.) 
#whether they appear in the SELECT or not.
#You cannot reference a non‑grouped, non‑aggregated column inside the window function's
#ORDER BY or PARTITION BY, because that column no longer exists after grouping.

SELECT 
	customerid,
	orderid,
    orderdate,
    COUNT(*) OVER () AS order_count,
    COUNT(*) OVER (PARTITION BY customerid) AS orders_per_customer
FROM orders;

SELECT
	*,
	COUNT(*) OVER () AS customer_count,
    COUNT(score) OVER () AS score_count
FROM customers;

SELECT
	orderid,
    orderdate,
    sales,
    productid,
    SUM(sales) OVER () AS total_sales,
    SUM(sales) OVER (PARTITION BY productid) AS total_salesbyproduct
FROM orders;

SELECT 
	*,
    ROUND((total_productsales / total_sales) * 100, 2) AS perct_contribution
FROM (
	SELECT
		productid,
		sales,
		SUM(sales) OVER () AS total_sales,
		SUM(sales) OVER (PARTITION BY productid) AS total_productsales
	FROM orders
)t;  

SELECT
	orderid,
    orderdate,
    sales,
    productid,
    AVG(sales) OVER () AS avg_sales,
    AVG(sales) OVER (PARTITION BY productid) AS avg_salesByProduct
FROM orders;
    
SELECT
	customerid,
    lastname,
    score,
    AVG(COALESCE(score, 0)) OVER () AS avg_score
FROM customers;

SELECT
	*
FROM (
	SELECT
		orderid,
		sales,
		productid,
		AVG(sales) OVER() AS avg_sales
	FROM orders
)t WHERE sales > avg_sales;

SELECT
	orderid,
    orderdate,
    sales,
    productid,
    MIN(sales) OVER () AS lowest_sales,
    MAX(sales) OVER () AS highest_sales,
    MIN(sales) OVER (PARTITION BY productid) AS lowersalesByproduct,
    MAX(sales) OVER (PARTITION BY productid) AS highestsalesByproduct,
    sales - MIN(sales) OVER () AS deviationFrom_minimum,
    MAX(sales) OVER () - sales AS deviationFrom_maximum
FROM orders;

SELECT
	*
FROM (
	SELECT
		*,
		MAX(salary) OVER() AS highest_salary
	FROM employees
)t WHERE salary = highest_salary;


