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
#somehow figured out this also makes a cross join lol
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