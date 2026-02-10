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





