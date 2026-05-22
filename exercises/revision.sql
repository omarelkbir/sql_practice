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

