CREATE DATABASE practice_db;
USE practice_db;

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

SELECT * FROM employees;
SELECT * FROM sales;

/*Find employees in Engineering or Sales who earn between 60000-80000,
 were hired after 2020-01-01, and have performance ≥ 80.
 Sort by department DESC, then salary ASC. Return only top 5.*/

SELECT full_name, department, salary, hire_date, performance_score
FROM employees
WHERE department IN ('engineering', 'sales') 
	AND salary BETWEEN 60000 AND 80000
	AND hire_date > '2020-01-01'
    AND performance_score >= 80
ORDER BY department DESC, salary
LIMIT 5;

/* For each department, show: average salary, employee count, 
and max performance score. Only include departments where:
Average salary > 60000
At least 2 employees
Max performance ≥ 90
Sort by average salary DESC. */

SELECT department,
	   AVG(salary) AS avg_salary,
	   COUNT(*) AS employee_count,
       MAX(performance_score) AS max_performance
FROM employees
GROUP BY department
HAVING avg_salary >60000 AND employee_count >= 2 AND max_performance >= 90
ORDER BY avg_salary DESC;

/* For each category, calculate: total revenue (amount × quantity), 
average sale amount, transaction count, total quantity. Only show categories where:
Total revenue > 2000
Average amount > 100
Sort by total revenue DESC. */

SELECT category,
	   sum(amount * quantity) AS total_revenue,
       avg(amount) AS avg_sale_price,
       count(*) AS transaction_count,
       sum(quantity)
FROM sales
GROUP BY category
HAVING total_revenue > 2000 AND avg_sale_price >100
ORDER BY total_revenue DESC;
