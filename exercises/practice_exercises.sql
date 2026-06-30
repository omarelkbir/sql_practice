
# Exercises 1 - 10: covers SELECT, FROM, WHERE, ORDER BY, LIMIT, GROUP BY, HAVING


SELECT * FROM employees;

SELECT first_name, last_name, salary AS annual_income
FROM employees;

SELECT * FROM employees
WHERE department = 'sales';

SELECT * FROM employees 
WHERE salary > 60000 AND years_exp > 2;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees 
WHERE department = 'engineering' 
ORDER BY salary DESC
LIMIT 3;

SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees 
GROUP BY department
HAVING avg_salary > 55000;

SELECT department, COUNT(id) AS employee_count, MAX(salary) AS highest_salary
FROM employees
GROUP BY department
HAVING employee_count >= 3 
ORDER BY employee_count DESC;

SELECT department, SUM(salary) AS total_payroll
FROM employees
WHERE hire_date < '2023-01-01'
GROUP BY department 
HAVING MIN(salary) >= 50000
ORDER BY total_payroll DESC;

# 10 exercises covering Data Definition Language (DDL): 
USE practice_db;

CREATE TABLE books (
	book_id INT NOT NULL auto_increment,
    title TEXT,
    price DECIMAL(10,2),
    PRIMARY KEY (book_id)
);
SELECT * FROM books;

CREATE TABLE customers (
	customer_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    signup_date DATE,
	PRIMARY KEY (customer_id)
);
SELECT * FROM customers;

ALTER TABLE customers
ADD last_name VARCHAR(50);

ALTER TABLE books
MODIFY price DECIMAL(10,2) NOT NULL;

ALTER TABLE books
ADD isbn VARCHAR(20) UNIQUE;

CREATE TABLE orders (
	order_id INT NOT NULL auto_increment,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id)
);
DROP TABLE orders;
SELECT * FROM orders;

CREATE TABLE orders (
	order_id INT NOT NULL auto_increment,
    customer_id INT NOT NULL,
    order_date DATE,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',# i used text at first but apparently u cant use DEFAULT with text so i just used VARCHAR 
    PRIMARY KEY (order_id)
);

ALTER TABLE inventory 
RENAME TO books;

ALTER TABLE books
ADD genre TEXT;

ALTER TABLE books
DROP COLUMN genre;

CREATE TABLE author (
	author_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year INT,
    PRIMARY KEY (author_id)
);

ALTER TABLE author
RENAME TO authors;

ALTER TABLE authors 
ADD nationality VARCHAR(50);

ALTER TABLE authors
MODIFY birth_year INT NOT NULL;

SELECT * FROM authors;

# 10 exercises covering Data Manipulation Language (DML).:

SELECT * FROM customers;

INSERT INTO books (title, price)
VALUES 
	("The Cat in the Hat", 10.99),
	("1984", 15.50),
	("To Kill a Mockingbird", 12.00);
    
INSERT INTO customers (first_name, email, signup_date)
VALUES 
	('John Doe', 'john@email.com', CURDATE()),
	('Jane Smith', 'jane@email.com', CURRENT_DATE);
# CURDATE() and CURRENT_DATE do the same in mysql so u can do whichever.

UPDATE books
SET price = '14.99'
WHERE title = '1984';
SELECT * FROM books WHERE title = '1984';# again, checking before updating or deleting.

UPDATE customers
SET email = 'jane.smith@newmail.com'
WHERE first_name = 'Jane Smith';
SELECT * FROM customers WHERE first_name = 'Jane Smith';

DELETE FROM books
WHERE title ='The Cat in the Hat';
SELECT * FROM books WHERE title ='The Cat in the Hat';

INSERT INTO books(title, price)
VALUES 
	('one piece', 23.99),
    ('AOT', 19.99);
SELECT * FROM books
ORDER BY price DESC;

UPDATE books SET price = 23.99 WHERE title = 'One Piece';
UPDATE books SET price = 19.99 WHERE title = 'AOT';
UPDATE books 
SET price = ROUND(price * 0.9, 2) 
WHERE price > 13.00;
SELECT * FROM books WHERE price > 13.00;

DELETE FROM customers
WHERE signup_date = CURRENT_DATE;
SELECT * FROM customers WHERE signup_date = CURRENT_DATE;

ALTER TABLE books
ADD genre VARCHAR(50);

ALTER TABLE books
MODIFY isbn VARCHAR(20) DEFAULT NULL,
MODIFY price DECIMAL(10,2) DEFAULT 10.00;

INSERT INTO books (title, genre) 
VALUES 
	('Fullmetal Alchemist', 'Fantasy'),
	('Cyberpunk','Sci-Fi'),
	('Gone Girl','Thriller'),
	('A Thousand Splendid Suns','Historical'),
	('Spy x Family','Comedy');

UPDATE books SET genre = 'Sci-Fi' WHERE book_id = 2;
UPDATE books SET genre = 'Fantasy' WHERE book_id = 3;
UPDATE books SET genre = 'Adventure' WHERE book_id = 4;
UPDATE books SET genre = 'Thriller' WHERE book_id = 5;

SELECT genre, COUNT(*) AS 'count' FROM books
GROUP BY genre
ORDER BY genre DESC;

INSERT INTO customers (first_name, email)
VALUES 
	('omar', 'omarelkbir@gmail.com');

UPDATE books
SET price = 30.00
WHERE title = 'one piece';
SELECT * FROM books WHERE title = 'one piece'; 
    
DELETE FROM books
WHERE title = 'spy x family';

SELECT * FROM books
ORDER BY title
LIMIT 3;

CREATE TABLE menu_items (
		item_id INT NOT NULL AUTO_INCREMENT,
        item_name VARCHAR(100) NOT NULL,
        category TEXT,
        price DECIMAL(10,2) NOT NULL,
        PRIMARY KEY (item_id)
);
SELECT * FROM menu_items;

ALTER TABLE menu_items
ADD calories INT; 

ALTER TABLE menu_items
MODIFY category TEXT NOT NULL;

ALTER TABLE menu_items
ADD is_available BOOLEAN DEFAULT TRUE;

ALTER TABLE menu_items
RENAME COLUMN is_available TO in_stock;

CREATE TABLE daily_sales (
	sale_id INT NOT NULL AUTO_INCREMENT,
    item_name TEXT NOT NULL,
    quantity_sold INT,
    total_price DECIMAL(10,2) NOT NULL,
    sale_date DATE,
    PRIMARY KEY (sale_id)
);
    
INSERT INTO menu_items(item_name, category, price, calories)
VALUES 
	('Espresso', 'beverage', 3.50, 10),
    ('Latte', 'beverage', 4.50, 150),
    ('Mocha', 'beverage', 5.00, 300),
    ('Cold Brew', 'beverage', 4.00, 5);

UPDATE menu_items
SET calories = 350
WHERE item_name = 'Mocha';

UPDATE menu_items
SET price = price + 0.50
WHERE price > 4.00;


SELECT item_name, MIN(calories)  FROM menu_items
GROUP BY item_name;
DELETE FROM menu_items
WHERE item_name = 'cold brew'; 

INSERT INTO menu_items(item_name, category, price, calories)
VALUES 
	('Croissant', 'Bakery', 3.00, 280),
    ('Bagel', 'Bakery', 2.50, 250),
    ('Muffin', 'Bakery', 3.50, 400);
    
SELECT * FROM menu_items
WHERE category = 'Bakery'
ORDER BY calories DESC;

UPDATE menu_items
SET price = (price * 8) / 10
WHERE price > 4.00;

ALTER TABLE menu_items
ADD original_price DECIMAL(10,2) NOT NULL;

UPDATE menu_items
SET original_price = (price * 12) / 10; 

SELECT * FROM menu_items
WHERE category = 'Bakery' AND calories > 300;
DELETE FROM menu_items
WHERE category = 'Bakery' AND calories > 300;

SELECT category,
	COUNT(*) AS num_of_items,
    AVG(price) AS avg_price
FROM menu_items
GROUP BY category
HAVING num_of_items > 1
ORDER BY avg_price DESC;

CREATE TABLE staff (
	staff_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE,
    hourly_wage DECIMAL(10,2),
    PRIMARY KEY(staff_id)
);
INSERT INTO staff (first_name, last_name, hire_date, hourly_wage) 
VALUES
    ('Alice', 'Johnson', '2023-01-15', 25.50),
    ('Bob', 'Smith', '2022-06-20', 22.00),
    ('Carol', 'Davis', '2024-03-10', 28.75);

ALTER TABLE staff
ADD is_active BOOLEAN DEFAULT TRUE;

UPDATE staff
SET is_active = FALSE
WHERE staff_id = 2;

ALTER TABLE staff
ADD phone VARCHAR(50);

ALTER TABLE staff
MODIFY phone VARCHAR(50) DEFAULT NULL;

CREATE TABLE inventory (
	product_id INT NOT NULL AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    quantity_in_stock INT,
    reorder_level INT DEFAULT 10,
    PRIMARY KEY(product_id)
);
SELECT * FROM inventory;

INSERT INTO inventory (product_name, quantity_in_stock, reorder_level) VALUES
    ('Laptop', 25, 10),
    ('Mouse Test Version', 5, 10),
    ('Keyboard', 8, 10),
    ('Monitor', 12, 10),
    ('USB Cable Test', 3, 10);

UPDATE inventory 
SET quantity_in_stock = 20
WHERE quantity_in_stock < reorder_level;
SELECT * FROM inventory;

DELETE FROM inventory
WHERE product_name LIKE '%Test%';
SELECT * FROM inventory WHERE product_name LIKE '%Test%';

SELECT product_name, quantity_in_stock, 'LOW STOCK' AS status
FROM inventory
WHERE quantity_in_stock <= 15;
  
SELECT product_name, quantity_in_stock, 'OK' AS status
FROM inventory
WHERE quantity_in_stock > 15;


CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT,
    category VARCHAR(50),
    date_added DATE
);


INSERT INTO products VALUES 
(1, 'Pro Laptop 500', 999.99, 50, 'Electronics', '2024-01-15'),
(2, 'Wireless Mouse', 25.00, 200, 'Electronics', '2024-02-10'),
(3, 'Coffee Maker', 89.99, 30, 'Appliances', '2024-03-05'),
(4, 'Novel: The Great Adventure', 15.00, 150, 'Books', '2024-01-20'),
(5, 'Kids Toy Car', 12.50, 75, 'Toys', '2024-04-12'),
(6, 'Pro Headphones', 199.99, 0, 'Electronics', '2024-02-28'),
(7, 'T-Shirt Blue', 19.99, 120, 'Clothing', '2024-05-01'),
(8, 'Budget Phone', 149.99, 45, 'Electronics', '2024-03-15'),
(9, 'Cookbook', 25.00, 60, 'Books', '2024-06-10'),
(10, 'Test_Product_A', 4.99, 5, 'Misc', '2024-01-01'),
(11, 'Max Pro Tablet', 450.00, 25, 'Electronics', '2024-04-20'),
(12, 'ABC', 8.00, 0, 'Misc', '2024-02-15'),
(13, 'Winter Jacket', 120.00, 8, 'Clothing', '2023-12-01'),
(14, 'Wireless Keyboard', 55.00, 90, 'Electronics', '2024-05-20'),
(15, 'Puzzle Set', 18.00, 40, 'Toys', '2024-03-30'),
(16, 'Test_B', 2.50, 0, 'Misc', '2024-01-10'),
(17, 'Pro Monitor 500', 300.00, 15, 'Electronics', '2024-06-01'),
(18, 'History Book', 22.00, 100, 'Books', '2024-02-05'),
(19, 'Running Shoes', 85.00, 3, 'Clothing', '2024-05-15'),
(20, 'Seasonal Ornament', 10.00, 500, 'Seasonal', '2023-11-15');

SELECT * FROM products
WHERE price = 25.00;

SELECT * FROM products
WHERE NOT category = 'electronics';

SELECT * FROM products 
WHERE stock_quantity > 100
ORDER BY price;

UPDATE products
SET price = price * 1.10
WHERE price > 50;
SELECT * FROM products WHERE price > 50;

SELECT * FROM products 
WHERE category = 'electronics' AND price > 200 AND stock_quantity > 50;

SELECT * FROM products 
WHERE category = 'Books' OR price < 10.00
ORDER BY price 
LIMIT 5;

SELECT * FROM products
WHERE (NOT category = 'clothing') AND stock_quantity BETWEEN 10 AND 100;

DELETE FROM products 
WHERE price < 5.00 OR stock_quantity = 0;

SELECT * FROM products 
WHERE price BETWEEN 20 AND 50 
AND NOT (price = 30 OR price = 40);

UPDATE products
SET stock_quantity = 7 
WHERE category = 'Electronics';

ALTER TABLE products
ADD status VARCHAR(20);

UPDATE products 
SET stock_quantity = 0,
	status = 'out_of_stock'
WHERE stock_quantity BETWEEN 1 AND 10;

SELECT * FROM products;

SELECT * FROM products
WHERE date_added BETWEEN '2024-01-01' AND '2024-06-30' AND category != 'seasonal';

SELECT * FROM products 
WHERE category NOT IN ('Electronics', 'Books', 'Toys');

DELETE FROM products
WHERE product_id IN (10,12,16);
SELECT * FROM products WHERE product_id IN (10,12,16);

SELECT * FROM products
WHERE product_name LIKE 'Pro%'; 

SELECT * FROM products
WHERE product_name LIKE '%max%'; 

SELECT * FROM products
WHERE product_name LIKE '___'; 

SELECT * FROM products
WHERE product_name LIKE '%500' AND NOT category = 'Electronics'; 

UPDATE products
SET price = price + 5
WHERE product_name LIKE '%wireless%'; 

DELETE FROM products
WHERE product_name LIKE '___' 
   OR (product_name LIKE 'Test\_%' ESCAPE '\\');
   
   
SELECT category, COUNT(*) AS products_count FROM products
WHERE stock_quantity > 0 AND price BETWEEN 10 AND 100
GROUP BY category
ORDER BY products_count DESC;



-- Customers table
CREATE TABLE customers1 (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO customers1 VALUES
(1, 'John', 'Smith', 'john@email.com', 'New York'),
(2, 'Sarah', 'Johnson', 'sarah@email.com', 'Los Angeles'),
(3, 'Mike', 'Brown', 'mike@email.com', 'Chicago'),
(4, 'Emma', 'Davis', 'emma@email.com', 'New York'),
(5, 'Chris', 'Wilson', 'chris@email.com', 'Miami'),
(6, 'Lisa', 'Garcia', 'lisa@email.com', 'Chicago');
-- Orders table (some customers have no orders, some orders have missing customers)
CREATE TABLE orders1 (
    order_id INT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);
INSERT INTO orders1 VALUES
(101, 1, '2024-01-15', 150.00),
(102, 2, '2024-01-20', 89.50),
(103, 1, '2024-02-05', 245.00),
(104, 4, '2024-02-10', 55.00),
(105, 2, '2024-03-01', 120.00),
(106, 7, '2024-03-15', 300.00),  -- customer 7 doesn't exist!
(107, 3, '2024-03-20', 75.00);
-- Products table
CREATE TABLE products1 (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
INSERT INTO products1 VALUES
(1, 'Laptop', 'Electronics', 999.00),
(2, 'Headphones', 'Electronics', 199.00),
(3, 'Coffee Maker', 'Appliances', 89.00),
(4, 'Running Shoes', 'Clothing', 120.00),
(5, 'Novel', 'Books', 15.00);
-- Order_Items table (links orders to products)
CREATE TABLE order_items1 (
    item_id INT,
    order_id INT,
    product_id INT,
    quantity INT
);
INSERT INTO order_items1 VALUES
(1, 101, 1, 1),
(2, 101, 2, 2),
(3, 102, 5, 3),
(4, 103, 3, 1),
(5, 103, 4, 2),
(6, 104, 5, 1),
(7, 105, 2, 1),
(8, 105, 3, 1),
(9, 107, 4, 1),
(10, 108, 1, 1);  -- order 108 doesn't exist!


SELECT c.first_name, c.last_name, o.total_amount 
FROM customers1 c
INNER JOIN orders1 o 
ON c.customer_id = o.customer_id;

SELECT o.order_id, oi.quantity
FROM orders1 o
INNER JOIN order_items1 oi 
ON o.order_id = oi.order_id;

SELECT c.first_name, oi.quantity
FROM customers1 c 
INNER JOIN orders1 o ON c.customer_id = o.customer_id
INNER JOIN order_items1 oi ON o.order_id = oi.order_id;

SELECT c.first_name, o.total_amount FROM customers1 c
LEFT JOIN orders1 o 
ON c.customer_id = o.customer_id;

SELECT * FROM customers1 c
RIGHT JOIN orders1 o 
ON c.customer_id = o.customer_id;

SELECT * FROM orders1 o
LEFT JOIN order_items1 oi 
ON o.order_id = oi.order_id
WHERE oi.item_id IS NULL;

SELECT * FROM customers1 c
LEFT JOIN orders1 o 
ON c.customer_id = o.customer_id
UNION 
SELECT * FROM orders1 o
LEFT JOIN customers1 c 
ON c.customer_id = o.customer_id;

SELECT * FROM customers1 c
LEFT JOIN orders1 o 
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT * FROM customers1 c
RIGHT JOIN orders1 o 
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT * FROM customers1 c
LEFT JOIN orders1 o 
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION 
SELECT * FROM  customers1 c
RIGHT JOIN orders1 o
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT c.first_name, p.product_name
FROM customers1 c
CROSS JOIN products1 p;

SELECT * FROM customers1 c 
CROSS JOIN customers1 c1
WHERE c.customer_id != c1.customer_id;



-- Table A: Online customers
CREATE TABLE online_customers (
    customer_id INT,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO online_customers VALUES
(1, 'Alice', 'alice@email.com', 'New York'),
(2, 'Bob', 'bob@email.com', 'Los Angeles'),
(3, 'Charlie', 'charlie@email.com', 'Chicago'),
(4, 'Diana', 'diana@email.com', 'New York'),
(5, 'Eve', 'eve@email.com', 'Miami');

-- Table B: In-store customers
CREATE TABLE store_customers (
    customer_id INT,
    name VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50)
);

INSERT INTO store_customers VALUES
(3, 'Charlie', 'charlie@email.com', 'Chicago'),  -- duplicate
(6, 'Frank', 'frank@email.com', 'Los Angeles'),
(7, 'Grace', 'grace@email.com', 'New York'),
(8, 'Henry', 'henry@email.com', 'Chicago'),
(1, 'Alice', 'alice@email.com', 'New York');  -- duplicate

-- Table C: Premium members
CREATE TABLE premium_members (
    customer_id INT,
    name VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO premium_members VALUES
(1, 'Alice', 'alice@email.com'),
(2, 'Bob', 'bob@email.com'),
(9, 'Ivy', 'ivy@email.com');

-- Table D: 2023 orders
CREATE TABLE orders_2023 (
    order_id INT,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO orders_2023 VALUES
(101, 'Alice', 150.00),
(102, 'Bob', 200.00),
(103, 'Charlie', 75.00);

-- Table E: 2024 orders
CREATE TABLE orders_2024 (
    order_id INT,
    customer_name VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO orders_2024 VALUES
(201, 'Alice', 300.00),
(202, 'Diana', 125.00),
(203, 'Frank', 450.00);

DESCRIBE online_customers;
-- or
DESC online_customers;

-- learned this to quickly get column names without the need to manually typing
-- them in every set operator query.
SELECT GROUP_CONCAT(COLUMN_NAME ORDER BY ORDINAL_POSITION) 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'practice_db' 
  AND TABLE_NAME = 'online_customers';


SELECT customer_id, name, email, city 
FROM online_customers
UNION 
SELECT customer_id, name, email, city
FROM store_customers;

SELECT customer_id, name, email, city 
FROM online_customers
UNION ALL
SELECT customer_id, name, email, city
FROM store_customers;

SELECT customer_id, name, email, city 
FROM online_customers
WHERE city IN('New york', 'Chicago')
UNION 
SELECT customer_id, name, email, city
FROM store_customers
WHERE city IN('New york', 'Chicago')
ORDER BY city, name;

SELECT 'online' AS type, email FROM online_customers
WHERE city = 'New york'
UNION ALL
SELECT 'store', email FROM store_customers
WHERE city = 'los angeles';

SELECT email FROM online_customers
UNION 
SELECT email FROM store_customers;

SELECT name FROM online_customers
EXCEPT 
SELECT name FROM store_customers;

SELECT name FROM store_customers
EXCEPT 
SELECT name FROM online_customers;

SELECT city FROM store_customers
EXCEPT 
SELECT city FROM online_customers;

SELECT name FROM orders_2023
EXCEPT 
SELECT name FROM orders_2024;

SELECT name FROM online_customers
EXCEPT 
SELECT name FROM premium_members;

SELECT name FROM online_customers
INTERSECT 
SELECT name FROM store_customers;

SELECT city FROM online_customers
INTERSECT 
SELECT city FROM store_customers;

SELECT customer_name FROM orders_2023
INTERSECT 
SELECT customer_name FROM orders_2024;

SELECT name FROM online_customers
INTERSECT 
SELECT name FROM premium_members;

(SELECT name FROM online_customers
EXCEPT
SELECT name FROM store_customers)
UNION ALL
(SELECT name FROM store_customers
EXCEPT
SELECT name FROM online_customers);

CREATE DATABASE practice;
USE practice;

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    membership_level VARCHAR(20)
);

INSERT INTO customers VALUES
(1, '  john  ', 'smith', 'JOHN.SMITH@EMAIL.COM', '555-123-4567', 'new york', 'GOLD'),
(2, 'SARAH', 'jones', 'sarah.jones@Email.com', '5559876543', '  Los Angeles  ', 'SILVER'),
(3, 'Mike', 'BROWN', 'mike.brown@test.com', '555-456-7890', 'chicago', 'BRONZE'),
(4, '  emily  ', '  davis  ', 'Emily.Davis@EMAIL.COM', '5551112222', 'New York', 'GOLD'),
(5, 'Chris', 'WILSON', 'chris@email', '5553334444', 'miami', 'SILVER'),
(6, 'Lisa', 'Anderson', 'LISA.ANDERSON@COMPANY.COM', '5557778888', '  CHICAGO  ', 'GOLD');

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    sku_code VARCHAR(20)
);

INSERT INTO products VALUES
(1, 'Wireless Mouse', 'Electronics', 29.99, 'ELEC-001-WM'),
(2, 'USB-C Cable', 'Electronics', 15.50, 'ELEC-002-CBL'),
(3, 'Mechanical Keyboard', 'Electronics', 89.99, 'ELEC-003-KB'),
(4, 'Running Shoes', 'Clothing', 120.00, 'CLTH-004-SHOE'),
(5, 'Coffee Maker', 'Appliances', 79.99, 'APPL-005-CF'),
(6, 'Yoga Mat', 'Fitness', 35.00, 'FIT-006-YG');

SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name FROM customers;

SELECT LOWER(email), UPPER(email) FROM customers;

SELECT CONCAT(
	LEFT(UPPER(TRIM(first_name)), 1),
    SUBSTRING(LOWER(TRIM(first_name)), 2))
    AS clean_name
FROM customers;

SELECT CONCAT (' Product: ', product_name, ' - Category: ', category) FROM products;
	
SELECT LEFT(last_name, 4), RIGHT(phone, 4) FROM customers;

SELECT SUBSTRING(sku_code, 6, 3) FROM products;
-- we start from position 6 and show 3 characters from there, so pos 6,7 and 8

SELECT CONCAT('xxx-xxx-', RIGHT(TRIM(phone), 4)) AS masked_phone FROM customers;

-- had to get help with this one, could not find that '@'. i just didnt learn the
-- position keyword yet.
SELECT 
    SUBSTRING(email, POSITION('@' IN email) + 1) AS domain
FROM customers;

SELECT REPLACE(product_name, ' ', '-'), REPLACE(category, 'Electronics', 'TECH')
FROM products;

SELECT product_name, REVERSE(product_name) FROM products;

SELECT MAX(LENGTH(email)), MIN(length(email)) FROM customers;

SELECT membership_level AS original, 
	REPLACE(REPLACE(REPLACE(membership_level, 'GOLD', 'PREMIUM'), 'SILVER', 'STANDARD'),
    'BRONZE', 'BASIC') AS display_only
FROM customers;

SELECT CONCAT(
	LEFT(UPPER(TRIM(last_name)), 3),
    RIGHT(REPLACE(phone, '-', ''), 4)) AS customer_code
FROM customers;

SELECT CONCAT(
	CONCAT(
	LEFT(UPPER(TRIM(first_name)), 1), 
    SUBSTRING(LOWER(TRIM(first_name)), 2, LENGTH(last_name))), ' ',
    LOWER(TRIM(last_name))) AS clean_full_name, 
    REPLACE(LOWER(email), ' ', '') AS clean_email,
    CONCAT(
	LEFT(UPPER(TRIM(city)), 1),
    SUBSTRING(LOWER(TRIM(city)), 2, LENGTH(city))) AS clean_city,
    CONCAT('[' , membership_level, ']') AS clean_membership 
FROM customers;
    
USE revision_db; 

SELECT full_name, department
FROM employees
WHERE manager_id IS NULL;

SELECT full_name, manager_id,  department
FROM employees
WHERE manager_id IS NOT NULL
	AND department IN('Engineering', 'Sales');
    
SELECT COUNT(*) emp_count
FROM employees;

SELECT COUNT(*) emp_count_with_manager
FROM employees
WHERE manager_id IS NOT NULL;

SELECT full_name, IFNULL(manager_id, 'Top level') manager
FROM employees;

ALTER TABLE employees
ADD bonus DECIMAL(10,2);

UPDATE employees
SET bonus = CASE full_name
	WHEN 'Alice Johnson' THEN 5000
    WHEN 'Carol White' THEN 3000
    WHEN 'Frank Miller' THEN 10000
    WHEN 'Karen Jackson' THEN 4500
    WHEN 'Leo Martinez' THEN 2000
    ELSE bonus
END;
    
SELECT 
	full_name,
    salary,
    bonus,
    salary + IFNULL(bonus, 0) total_compensation
FROM employees;

SELECT full_name, emp_id, COALESCE(manager_id, emp_id) reporting_identifier
FROM employees;

SELECT full_name, CONCAT('Boss-', IFNULL(manager_id, 'SELF'))
FROM employees;

SELECT e.full_name, IFNULL(m.full_name, 'No manager') manager
FROM employees e
LEFT JOIN employees m
	ON e.manager_id = m.emp_id;
    
SELECT 
	IFNULL(manager_id, 'Executive') manager, 
    COUNT(emp_id) team_size,
    ROUND(AVG(salary)) avg_salary,
    MAX(performance_score) top_performance
FROM employees
GROUP BY IFNULL(manager_id, 'Executive')
HAVING COUNT(emp_id) >= 2
ORDER BY team_size DESC;

SELECT 
	AVG(salary) avg_salary,
    AVG(salary + IFNULL(bonus,0)) avg_total_compensation
FROM employees;

SELECT sale_id, product_name, quantity FROM sales WHERE sale_id = 8;

UPDATE sales
SET quantity = 10
WHERE sale_id = 8;

SELECT 
	product_name,
    amount,
    quantity,
    amount / NULLIF(quantity, 0) unit_price
FROM sales; #amount / NULL = NULL

SELECT 
	product_name,
    amount,
    NULLIF(amount, 450) diff
FROM sales
WHERE NULLIF(amount, 450) IS NOT NULL;

SELECT 
	product_name,
    amount,
    quantity,
    amount / NULLIF(quantity, 1) revenue_score
FROM sales;

ALTER TABLE employees
ADD commission_rate DECIMAL(4,2);

UPDATE employees
SET commission_rate = CASE full_name
	WHEN 'Alice Johnson' THEN 0.10
	WHEN 'Bob Smith' THEN 0.05
	WHEN 'David Brown' THEN NULL
	WHEN 'Eve Davis' THEN 0.08
	WHEN 'Henry Taylor' THEN NULL
	WHEN 'Jack Thomas' THEN 0.03
	ELSE commission_rate
END;

SELECT 
	full_name,
    salary AS base,
	IFNULL(bonus,0) bonus,
    salary * IFNULL(commission_rate, 0) commission,
    salary + IFNULL(bonus,0) + salary * IFNULL(commission_rate, 0) AS total
FROM employees
ORDER BY total DESC;

SELECT 
	e.full_name,
    IFNULL(SUM(s.amount), 0) sales_made,
    IFNULL(COUNT(s.sale_id), 0) transactions
FROM employees e
LEFT JOIN sales s
	ON e.emp_id = s.salesperson_id
GROUP BY e.full_name;
 
SELECT
	e.full_name,
    e.department,
    IFNULL(e.bonus, 0) bonus,
    IFNULL(SUM(s.amount), 0) sales_made,
    IFNULL(COUNT(s.sale_id), 0) transactions,
    SUM(s.amount) / NULLIF(COUNT(s.sale_id), 0) sale_per_transaction # we make it null if it is 0 so we dont get devision by zero error.
FROM employees e
LEFT JOIN sales s
	ON e.emp_id = s.salesperson_id
GROUP BY e.emp_id, e.full_name, e.department, e.bonus
ORDER BY sales_made DESC;

SELECT 
	full_name,
    department,
    CASE department
		WHEN 'Engineering' THEN 'Technical'
		WHEN 'Sales' THEN 'Revenue'
		WHEN 'Marketing' THEN 'Growth'
		WHEN 'HR' THEN 'People'
		ELSE 'Other'
	END dept_category
FROM employees;

SELECT 
	product_name,
    region,
    CASE region
		WHEN 'North' THEN 'Cold Region'
		WHEN 'South' THEN 'Warm Region'
		WHEN 'East' THEN 'Coastal Region'
		WHEN 'West' THEN 'Pacific Region'
	END climate_zone
FROM sales;

SELECT 
	full_name,
    salary,
    CASE 
		WHEN salary >= 80000 THEN 'Executive'
        WHEN salary BETWEEN 60000 AND 79000 THEN 'Professional'
        WHEN salary BETWEEN 40000 AND 59000 THEN 'Associate'
        WHEN salary < 40000 THEN 'Entry'
		ELSE 'Other'
	END pay_grade
FROM employees;

SELECT 
	full_name,
    performance_score,
    CASE 
		WHEN performance_score >= 95 THEN 'Outstanding'
        WHEN performance_score BETWEEN 85 AND 94 THEN 'Strong'
        WHEN performance_score BETWEEN 75 AND 84 THEN 'Satisfactory'
        WHEN performance_score < 75 THEN 'Needs Improvement'
        ELSE 'Other'
	END rating
FROM employees
ORDER BY performance_score DESC;

SELECT 
	full_name,
    department,
    salary,
    performance_score,
    CASE 
		WHEN department = 'Engineering' AND salary >= 85000 THEN 'Senior Engineer'
        WHEN department = 'Engineering' AND salary < 85000 THEN 'Engineer'
        WHEN department = 'Sales' AND performance_score >= 90 THEN 'Top Salesperson'
        WHEN department = 'Sales' AND performance_score < 90 THEN 'Sales Rep'
        WHEN department = 'Marketing' THEN 'Marketer'
        WHEN department = 'HR' THEN 'HR Specialist'
        ELSE 'Other'
	END role_title
FROM employees;

SELECT 
	product_name,
    category,
    amount,
    quantity,
    CASE 
		WHEN category = 'Electronics' AND amount >= 1000 THEN 'flagship'
        WHEN category = 'Electronics' AND amount < 1000 THEN 'standard tech'
        WHEN category = 'Furniture' AND quantity >= 3 THEN 'bulk furniture'
        WHEN category = 'Furniture' AND quantity < 3 THEN 'retail furniture'
        ELSE 'Other'
	END priority_flag
FROM sales;

SELECT 
	full_name,
    manager_id,
    CASE 
		WHEN manager_id IS NULL THEN 'C-Level Executive'
		WHEN manager_id = 1 THEN 'Reports to CEO'
		WHEN manager_id = 3 THEN 'Reports to Sales Director'
        ELSE 'Standard Reporting'
	END reporting_line
FROM employees;

SELECT
	full_name,
	IFNULL(bonus,0),
    CASE 
		WHEN bonus is NULL THEN 'No Bonus Assigned'
		WHEN bonus < 3000 THEN 'Small Incentive'
		WHEN bonus BETWEEN 3000 AND 6999 THEN 'Standard Incentive'
		WHEN bonus >= 7000 THEN 'Executive Incentive'
		ELSE 'Other'
	END bonus_tier
FROM employees;

SELECT 
	full_name,
    department,
    performance_score
FROM employees
ORDER BY 
	CASE department
		WHEN 'Engineering' THEN 1
		WHEN 'Sales' THEN 2
		WHEN 'Marketing' THEN 3
		WHEN 'HR' THEN 4
		ELSE 5
	END, performance_score DESC;
    
SELECT 
	CASE MONTH(sale_date)
		WHEN 1 THEN 'Q1 Start'
		WHEN 2 THEN 'Q1 Mid'
		WHEN 3 THEN 'Q1 End'
		ELSE 'Not Q1'
	END period_name,
    SUM(amount) AS total_revenue,
    SUM(quantity) AS total_quantity_sold,
    ROUND(AVG(amount), 2) AS average_sale_amount 	 	 	
FROM sales
GROUP BY 
	CASE MONTH(sale_date)
		WHEN 1 THEN 'Q1 Start'
		WHEN 2 THEN 'Q1 Mid'
		WHEN 3 THEN 'Q1 End'
		ELSE 'Not Q1'
	END;
#Improvements:
#MONTH(sale_date) returns 1, 2, 3 — simpler than string matching using DATE_FORMAT when the month names arnt even in the output
#Uses Simple CASE (CASE expression WHEN value) instead of Searched CASE
#Added ROUND() and AS aliases for cleaner output

SELECT 
	product_name,
    category,
    amount,
    quantity,
    ROUND(CASE
		WHEN category = 'Electronics' AND amount >= 500 THEN amount * 0.10
        WHEN category = 'Electronics' AND amount < 500 THEN amount * 0.05
        WHEN category = 'Furniture' AND quantity >= 400 THEN amount * 0.08
        WHEN category = 'Furniture' AND quantity < 400 THEN amount * 0.03
        ELSE amount
	END, 2) calculated_commission
FROM sales;

SELECT 
	full_name,
    department,
    salary,
    performance_score,
    CASE department
		WHEN 'Engineering' THEN 
			CASE
				WHEN salary >= 90000 THEN 'Principal Engineer'
				WHEN salary >= 80000 THEN 'Staff Engineer'
                WHEN salary >= 70000 THEN 'Engineer'
				ELSE 'Junior Engineer'
			END
		WHEN 'Sales' THEN
			CASE 
				WHEN performance_score >= 95 THEN 'Elite Sales'
                WHEN performance_score >= 85 THEN 'Senior Sales'
                ELSE 'Sales Assosiate'
			END
		ELSE 'Support Staff'
	END classification
FROM employees;

SELECT 
	s.salesperson_id,
	e.full_name,
    SUM(s.quantity) AS total_quantity,
    SUM(s.amount) AS total_revenue,
    CASE
		WHEN SUM(s.quantity) >= 5 THEN 'High Volume'
        ELSE 'Standard Volume'
	END volume_tier,
    CASE
		WHEN SUM(s.amount) >= 2000 THEN 'High Value'
        ELSE 'Standard Value'
	END value_tier,
    CASE
        WHEN SUM(s.quantity) >= 5 AND SUM(s.amount) >= 2000 THEN 'Gold'
        WHEN SUM(s.quantity) >= 5 OR SUM(s.amount) >= 2000 THEN 'Silver'
        ELSE 'Bronze'
    END AS performance_badge
FROM employees e
LEFT JOIN sales s
	ON e.emp_id = s.salesperson_id
GROUP BY s.salesperson_id, e.full_name
ORDER BY SUM(s.amount) DESC;
    
SELECT 
	full_name,
    department,
    salary AS base_salary,
    IFNULL(bonus, 0) AS bonus,
    CASE 
		WHEN department = 'Sales' OR performance_score >= 90 THEN 'Yes'
        ELSE 'No'
	END commission_eligible,
    CASE 
		WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
        ELSE 0
	END commission_amount,
    salary + IFNULL(bonus,0) + 
		CASE 
			WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
			ELSE salary
		END AS total_compensation,
	CASE 
		WHEN salary + IFNULL(bonus,0) + 
			CASE 
				WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
				ELSE salary
			END >= 100000 THEN 'Executive'
		WHEN Salary + IFNULL(bonus,0) + 
			CASE 
				WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
				ELSE salary
			END >= 75000 THEN 'Senior'
		WHEN salary + IFNULL(bonus,0) + 
			CASE 
				WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
				ELSE salary
			END >= 55000 THEN 'Standard'
		ELSE 'Entry'
	END compensation_tier
FROM employees
ORDER BY salary + IFNULL(bonus,0) + 
		CASE 
			WHEN department = 'Sales' OR performance_score >= 90 THEN salary * 0.05
			ELSE salary
		END DESC;
# i calculated total_compensation 5 times during this exercise, which is redicilous,
# apparently it can be way cleaner and efficient with subqueries so i only have to 
# write total compensation once as a subquery then just use it whenever i need.

SELECT 
	product_name,
    amount,
    SUM(amount) OVER() grand_total
FROM sales;

SELECT
	full_name,
    salary,
    ROUND(AVG(salary) OVER(), 0) company_avg_salary
FROM employees;

SELECT
	product_name,
    amount,
    MAX(amount) OVER() highest_sale_amount
FROM sales;

SELECT
	full_name,
    department,
    COUNT(*) OVER() emp_count
FROM employees;

SELECT 
	product_name,
    category,
    amount,
    SUM(amount) OVER(partition by category) sales_per_category
FROM sales;

SELECT 
	full_name,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department) avg_salary_per_department
FROM employees;

SELECT 
	full_name,
    city,
    salary,
    SUM(salary) OVER(PARTITION BY city) total_city_payroll,
    AVG(salary) OVER(PARTITION BY city) avg_city_payroll,
    salary - AVG(salary) OVER(PARTITION BY city) salary_diff_from_avg
FROM employees;

SELECT 
	product_name,
    amount,
    sale_date,
    SUM(amount) OVER(ORDER BY sale_date) running_total
FROM sales;

SELECT 
	product_name,
    amount,
    sale_date,
    ROUND(AVG(amount) OVER(ORDER BY sale_date), 0) running_average
FROM sales;

SELECT 
	product_name,
    category,
    amount,
    sale_date,
    SUM(amount) OVER(PARTITION BY category ORDER BY sale_date) runningtotalpercategory
FROM sales;

SELECT 
	amount,
    sale_date,
    AVG(amount) OVER(ORDER BY sale_date
    ROWS 2 PRECEDING) 3sale_moving_average
FROM sales;

SELECT
	amount,
    sale_date,
    SUM(amount) OVER(ORDER BY sale_date
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) 1previous_current_1following_runningtotal
FROM sales;

SELECT 
	full_name,
    salary,
    SUM(salary) OVER(ORDER BY salary DESC
    ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) total_of_top3_salaries_including_current
FROM employees;# not the absolute top 3, but top 3 from each frame, 
# ofc only when current row is row 1 is when its the actual top 3, going forward from 
#that is just top 3 of each moving frame, useful  for moving averages, rolling sums


SELECT
	full_name,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department) dept_total_payroll,
    AVG(salary) OVER(PARTITION BY department) dept_avg_salary,
    AVG(salary) OVER() company_avg_salary,
    salary - AVG(salary) OVER(PARTITION BY department) diff_from_dept_avg_salary,
    ROUND(salary / SUM(salary) OVER(PARTITION BY department) * 100, 2) pct_from_dept_total
FROM employees;

SELECT 
	full_name,
    department,
    salary,
    DENSE_RANK() OVER(ORDER BY salary DESC) salary_ranked
FROM employees;

SELECT 
	full_name,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) salary_ranked
FROM employees;

SELECT 
	full_name,
    department,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) salary_ranked
FROM employees;

SELECT 
	full_name,
    department,
    salary,
    RANK() OVER(PARTITION BY department ORDER BY salary DESC) salary_ranked
FROM employees;

SELECT 
	full_name,
    department,
    salary,
    NTILE(4) OVER(ORDER BY salary DESC) salary_ranked
FROM employees;

SELECT 
	e.full_name,
    s.region,
    SUM(s.amount) total_revenue,
    RANK() OVER (ORDER BY SUM(s.amount) DESC) overall_rank,
    RANK() OVER (PARTITION BY s.region ORDER BY SUM(s.amount) DESC) reigon_rank
FROM employees e
INNER JOIN sales s 
	ON e.emp_id = s.salesperson_id
GROUP BY e.emp_id, e.full_name, s.region;

#mini exercise to practice window + group by
SELECT 
	department,
    SUM(salary) total_payroll,
    RANK() OVER (ORDER BY SUM(salary) DESC) dept_pay_ranked
FROM employees
GROUP BY department;

SELECT 
	product_name,
    SUM(quantity) total_quantity_sold,
    RANK() OVER (ORDER BY SUM(quantity) DESC) sales_ranked
FROM sales
GROUP BY product_name;

SELECT
	department,
    AVG(performance_score) avg_performance,
    RANK() OVER (ORDER BY AVG(performance_score) DESC) dept_perf_ranked
FROM employees
GROUP BY department;

SELECT * FROM (
	SELECT 
		DATE_FORMAT(sale_date, '%c') month_num,
		DATE_FORMAT(sale_date, '%M') month_name,
		SUM(amount) month_sales,
		RANK() OVER (ORDER BY SUM(amount) DESC) month_rank
	FROM sales
	GROUP BY DATE_FORMAT(sale_date, '%c'),
		DATE_FORMAT(sale_date, '%M')
	) AS monthly_revenue WHERE month_rank <= 2;
    

SELECT * FROM (
	SELECT
		full_name,
		department,
		salary,
		RANK() OVER(PARTITION BY department ORDER BY salary DESC) dept_salary_rank
	FROM employees
    ) top_earners WHERE dept_salary_rank <= 2;
    
SELECT * FROM (
	SELECT 
		full_name,
		department,
		salary,
		performance_score,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) salary_dept_rank,
		DENSE_RANK() OVER (ORDER BY performance_score DESC) perf_overall_rank
	FROM employees
	)rankings WHERE salary_dept_rank <= 2 AND perf_overall_rank <= 3;
    
SELECT * FROM (
	SELECT
		category,
		product_name,
		SUM(amount) AS total_revenue,
		SUM(quantity) AS total_quantity,
		RANK() OVER (
			PARTITION BY category 
            ORDER BY SUM(amount) DESC, SUM(quantity) DESC
		) AS product_rank
	FROM sales
	GROUP BY category, product_name
    ) AS top_performing_product WHERE product_rank = 1;
    
SELECT
	full_name,
    department,
    salary,
    RANK() OVER (
		PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
    NULLIF(RANK() OVER (
		PARTITION BY department ORDER BY salary DESC) - 1, 0) next_higher_salary,
	NULLIF(RANK() OVER (
		PARTITION BY department ORDER BY salary DESC) + 1, 0) next_lower_salary
        # this third ranking doesnt count for the end of the window and returns null
        # it's impossible with value window functions which idk yet, but this is good enough
FROM employees;

SELECT department, salary, employees_at_salary
FROM (
    SELECT 
        department,
        salary,
        COUNT(*) AS employees_at_salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
    FROM employees
    GROUP BY department, salary
) AS dept_salary_counts
WHERE employees_at_salary >= 2;
# i gotta study the count function more bc i dont really know how it actually works

SELECT *,
	CASE 
		WHEN salary_rank <= 3 AND perf_rank <= 3 THEN 'Star'
        WHEN salary_rank > 3 AND perf_rank <= 3 THEN 'High potential'
        WHEN salary_rank <= 3 AND perf_rank > 3 THEN 'Overpaid'
        ELSE 'Standard'
	END classification
FROM (
	SELECT 
		full_name,
		department,
		salary,
		performance_score,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY performance_score DESC) AS perf_rank
	FROM employees
    ) AS rankings; 

# failed at this first then redid it by myself after some gathering some insights. proud of this one
SELECT *
FROM (
	SELECT 
		region,
		full_name,
		total_revenue,
		region_rank,
		CASE 
			WHEN region_rank = 1 THEN 'Yes' 
			ELSE 'No'
		END is_true_mvp,
		RANK() OVER (PARTITION BY full_name ORDER BY total_revenue DESC) AS best_region_rank
	FROM (
		SELECT 
			s.region,
			e.full_name,
			SUM(s.amount) AS total_revenue,
			DENSE_RANK() OVER (PARTITION BY region ORDER BY SUM(s.amount) DESC) AS region_rank
		FROM employees e 
		INNER JOIN sales s 
			ON e.emp_id = s.salesperson_id
		GROUP BY region, full_name
		) AS region_mvps
	) AS each_mvps_best_region
WHERE is_true_mvp = 'Yes' AND best_region_rank = 1;


SELECT 
	*,
    ABS(CAST(dept_salary_rank AS SIGNED) - CAST(dept_perf_rank AS SIGNED)) AS consistency_score
# we did cast here bc DENSE_RANK returns an unsigned value and when doing subtraction 
# on them and the result is negative, then it will cause an error. so we cast them
# to a different data type, like SIGNED to fix that issue.
FROM (
	SELECT
		full_name,
		department,
		salary,
		performance_score,
		DENSE_RANK() OVER (ORDER BY salary DESC) AS comp_salary_rank,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank,
		DENSE_RANK() OVER (PARTITION BY department ORDER BY performance_score DESC) AS dept_perf_rank,
		NTILE(4) OVER (ORDER BY salary DESC) AS salary_quartile
	FROM employees
    ) AS rankings;
    
SELECT 
	sale_id,
    product_name,
    sale_date,
    amount,
    LAG(amount, 1, 0) OVER (ORDER BY sale_date) AS prev_sale
FROM sales;

SELECT 
	sale_id,
    product_name,
    sale_date,
    amount,
    LEAD(amount, 1, 0) OVER (ORDER BY sale_date) AS next_sale
FROM sales;

SELECT 
	full_name,
    department,
    hire_date,
    salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) AS prev_salary_in_dept
FROM employees;

SELECT 
	*,
    curr_amount - prev_amount AS amount_change
FROM (
	SELECT
		product_name,
		sale_date,
		amount AS curr_amount,
		LAG(amount) OVER (ORDER BY sale_date) AS prev_amount
	FROM sales
	) AS sales_info;

SELECT
	*,
    ABS(salary - prev_higher_salary) AS gap_to_above
FROM (
	SELECT 
		full_name,
		department,
		salary,
		LAG(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS prev_higher_salary
	FROM employees
    )t;
SELECT
	*,
    ROUND((amount - prev_amount) / prev_amount * 100, 1) AS perc_change
FROM (
	SELECT
		product_name,
		category,
		sale_date,
		amount,
		LAG(amount) OVER (PARTITION BY category ORDER BY sale_date) AS prev_amount
	FROM sales
    )t;

SELECT
	full_name,
    department,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS highest_paid,
	salary - FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary DESC) AS salary_diff
FROM employees;

SELECT
	product_name,
    category,
    sale_date,
    amount,
    FIRST_VALUE(amount) OVER(PARTITION BY category ORDER BY sale_date) AS firsteversale_inthecategory,
	LAST_VALUE(amount) OVER(PARTITION BY category ORDER BY sale_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS most_recent_sale_incategory
FROM sales;    
    
SELECT
	full_name,
    department,
    hire_date,
    FIRST_VALUE(full_name) OVER(PARTITION BY department ORDER BY hire_date) AS first_dept_hire,
	LAST_VALUE(full_name) OVER(PARTITION BY department ORDER BY hire_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS most_recent_hire
FROM employees;

SELECT 
	full_name,
    department,
    salary,
	NTH_VALUE(salary, 3) OVER (PARTITION BY department ORDER BY salary DESC
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_highest_paid
FROM employees;

SELECT
	product_name,
    sale_date,
    amount,
    AVG(amount) OVER(ORDER BY sale_date
    ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS five_day_moving_avg
FROM sales;

SELECT
	full_name,
    department,
    performance_score,
    LAG(performance_score, 2) OVER (
		PARTITION BY department ORDER BY performance_score DESC) AS two_positions_above,
	LEAD(performance_score, 2) OVER (
		PARTITION BY department ORDER BY performance_score DESC) AS two_positions_below
FROM employees;

SELECT
	*,
    CASE
		WHEN current_amount = prev_amount OR prev_amount IS NULL THEN 'Stable'
        WHEN current_amount > prev_amount THEN 'Increasing'
        WHEN current_amount < prev_amount THEN 'Decreasing'
	END trend
FROM (
	SELECT 
		sale_id,
		product_name,
		sale_date,
		amount AS current_amount,
		LAG(amount) OVER (ORDER BY sale_date) AS prev_amount,
		FIRST_VALUE(amount) OVER (ORDER BY sale_date) AS first_sale
	FROM sales
    ) AS sales_momentum_report;

SELECT 
	*,
    CASE
		WHEN prev_hire IS NULL OR next_hire IS NULL THEN 'No Comparison'
		WHEN salary > prev_hire AND salary > next_hire THEN 'Above Midpoint'
        WHEN salary < prev_hire AND salary < next_hire THEN 'Below Midpoint'
        ELSE 'At Midpoint'
	END salary_benchmark
FROM (
	SELECT 
		full_name,
		department,
		hire_date,
		salary,
		LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) AS prev_hire,
		LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) AS next_hire
	FROM employees
    ) AS salary_benchmarking_report;

SELECT 
	*,
    CASE 
		WHEN performance_score > dept_prev_score THEN 'Improving'
        WHEN performance_score < dept_prev_score THEN 'Declining'
        ELSE 'Stable'
	END AS performance_trend
FROM (
	SELECT 
		full_name,
		department,
		hire_date,
		salary,
		LAG(salary) OVER (ORDER BY hire_date) AS prev_hire_,
		LEAD(salary) OVER (ORDER BY hire_date) AS next_hire,
		FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY hire_date) AS dept_first_hire_salary,
		LAST_VALUE(salary) OVER (
			PARTITION BY department ORDER BY hire_date
			ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dept_most_recent_hire_salary,
		performance_score,
		LAG(performance_score) OVER (PARTITION BY department ORDER BY hire_date) AS dept_prev_score
	FROM employees
	) AS employee_timeline_analysis
ORDER BY hire_date;




#creating a new database with more tables for upcoming exercises
CREATE DATABASE IF NOT EXISTS revision2;
USE revision2;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50),
    budget DECIMAL(12,2),
    established_date DATE
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    dept_id INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    emp_id INT,
    customer_id INT,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'completed',
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO departments VALUES
(1, 'Engineering', 'New York', 2000000.00, '2015-01-15'),
(2, 'Sales', 'Chicago', 1500000.00, '2016-03-20'),
(3, 'Human Resources', 'New York', 800000.00, '2017-06-10'),
(4, 'Marketing', 'Los Angeles', 1200000.00, '2018-09-01'),
(5, 'Intern', 'Remote', 200000.00, '2023-01-01');

INSERT INTO employees VALUES
(101, 'John', 'Smith', 'john.smith@techcorp.com', '2019-03-10', 95000.00, 1, NULL),
(102, 'Sarah', 'Johnson', 'sarah.j@techcorp.com', '2020-07-15', 88000.00, 1, 101),
(103, 'Michael', 'Brown', 'mbrown@techcorp.com', '2018-11-20', 110000.00, 1, 101),
(104, 'Emily', 'Davis', 'emily.d@hrhub.com', '2021-01-10', 52000.00, 3, NULL),
(105, 'David', 'Wilson', 'dwilson@hrhub.com', '2017-05-22', 75000.00, 3, 104),
(106, 'Jessica', 'Miller', 'jmiller@hrhub.com', '2022-08-14', 48000.00, 3, 104),
(107, 'Daniel', 'Garcia', 'dgarcia@salespro.com', '2019-09-05', 82000.00, 2, NULL),
(108, 'Laura', 'Martinez', 'laura.m@salespro.com', '2020-04-18', 79000.00, 2, 107),
(109, 'James', 'Anderson', 'james.a@marketguru.com', '2021-06-30', 68000.00, 4, NULL),
(110, 'Linda', 'Thomas', 'linda.t@marketguru.com', '2023-02-10', 42000.00, 5, 109),
(111, 'Robert', 'Taylor', 'robert.t@techcorp.com', '2023-03-01', 38000.00, 5, 103),
(112, 'Patricia', 'White', 'pat.white@techcorp.com', '2020-10-05', 92000.00, 1, 101),
(113, 'Mark', 'Lee', 'mark.lee@salespro.com', '2022-01-20', 55000.00, 2, 107);

INSERT INTO customers VALUES
(201, 'Acme Corp', 'New York', '2020-01-15'),
(202, 'Global Tech', 'Chicago', '2019-06-20'),
(203, 'Bright Ideas', 'Los Angeles', '2021-03-10'),
(204, 'Fast Solutions', 'New York', '2022-07-01'),
(205, 'New Horizons', 'Miami', '2023-01-10'),
(206, 'Stellar Inc', 'Chicago', '2020-11-15'),
(207, 'Delta Systems', 'Boston', '2023-05-01');

INSERT INTO orders VALUES
(301, 102, 201, '2024-01-15', 4500.00, 'completed'),
(302, 103, 202, '2024-02-10', 8200.00, 'completed'),
(303, 107, 201, '2024-01-20', 3100.00, 'completed'),
(304, 108, 203, '2024-03-05', 2800.00, 'pending'),
(305, 102, 204, '2024-02-28', 5600.00, 'completed'),
(306, 109, 202, '2024-01-10', 1900.00, 'completed'),
(307, 112, 201, '2024-03-15', 7400.00, 'completed'),
(308, 107, 205, '2024-02-20', 4200.00, 'completed'),
(309, 103, 206, '2024-03-01', 9500.00, 'completed'),
(310, 108, 201, '2024-03-10', 3300.00, 'completed'),
(311, 105, 204, '2024-01-25', 2100.00, 'completed'),
(312, 110, 203, '2024-02-15', 1200.00, 'completed');
    

#exercises
SELECT
	first_name,
    last_name,
    salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT 
	first_name,
    last_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;

SELECT
	first_name,
    last_name,
    dept_id
FROM employees
WHERE dept_id IN (
				SELECT dept_id 
                FROM departments 
                WHERE location = 'New York');
                
SELECT customer_id, customer_name
FROM customers
WHERE customer_id NOT IN (
	SELECT customer_id
    FROM orders);

SELECT dept_id, dept_name
FROM departments d
WHERE EXISTS (
	SELECT 1 
    FROM employees e
    WHERE salary > 90000 AND e.dept_id = d.dept_id);

SELECT dept_name, total_payroll
FROM (
	SELECT d.dept_name, SUM(e.salary) AS total_payroll
	FROM employees e
	INNER JOIN departments d 
		ON e.dept_id = d.dept_id
	GROUP BY d.dept_name
) AS payrolls
WHERE total_payroll > (
	SELECT AVG(dept_total) 
	FROM (
		SELECT SUM(salary) AS dept_total
        FROM employees
        GROUP BY dept_id
	) AS dept_totals
);

SELECT dept_name, AVG(dept_payroll) AS dept_avg
FROM (
	SELECT d.dept_id, d.dept_name, AVG(e.salary) AS dept_payroll
    FROM employees e
    INNER JOIN departments d
		ON e.dept_id = d.dept_id
	GROUP BY d.dept_id, d.dept_name
    ) AS dept_payroll
GROUP BY dept_id
HAVING AVG(dept_payroll) > (SELECT AVG(salary) FROM employees);
# THIS TOOK ME LIKE 30-40 MINTUES TO DO FOR SOME REASON, BUT IT WAS ACTUALLY SIMPLE
# HERE IS THE HOW ITS SOVED WITHOUT OVER COMPLICATING IT: 

SELECT d.dept_name, AVG(e.salary) AS dept_avg
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);
# 30 mins for this bro...



SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
LEFT JOIN employees e
	ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > (SELECT AVG(salary) FROM employees);
# OK SOLVED IT AGAIN IN 5 MIN AFTER 2 DAYS BREAK WHILE LEARNING ON THE SIDE.

#this is exercise 8, and i've realized, there is usually many ways to solve an sql problem
#this one for example was easier using window functions, so i decided that for every
#exercise from now on, i will solve it with all the methods possible, wether subqueries
#window functions or regular sql. its to hone my skills and not forget something while 
#learning something else, for example i forgot a lot abt window functions

# ex8 using correlated subqueries
SELECT e.first_name, e.last_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.salary = (SELECT MAX(salary)
				  FROM employees e1
                  WHERE e1.dept_id = e.dept_id
);
# ex8 using joins (self join as well)
SELECT e.first_name, e.last_name, d.dept_name, e.salary
FROM employees e
JOIN departments d
	ON e.dept_id = d.dept_id
JOIN (
	SELECT dept_id, MAX(salary)
    FROM employees 
    GROUP BY dept_id
) m ON e.dept_id = m.dept_id AND e.salary = MAX(m.salary);
# ex8 using window functions

SELECT first_name, last_name, dept_name, salary
FROM (
	SELECT 
		e.first_name,
		e.last_name,
		d.dept_name,
		e.salary,
		RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rnk
	FROM employees e
	JOIN departments d
		ON e.dept_id = d.dept_id
) AS ranked WHERE rnk = 1;

#redoing the subquery exercises and solving them in all other possible methods too.
#ex1
SELECT first_name, last_name, salary
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT first_name, last_name, salary
FROM employees e
CROSS JOIN (SELECT AVG(salary) AS avg_salary FROM employees) company_wide_avg
ON e.salary > company_wide_avg.avg_salary;
#cross join joins each row in table 1 to each row in table 2 


SELECT first_name,
		last_name,
		salary
FROM (
	SELECT 
		first_name,
		last_name,
		salary,
		AVG(salary) OVER() AS avg_salary
	FROM employees
) AS avg_sal WHERE salary > avg_salary;

#exercise 2 
SELECT 
	first_name,
    last_name,
    salary,
    (SELECT AVG(salary) FROM employees) AS company_avg
FROM employees;

SELECT e.first_name, e.last_name, e.salary, avg_table.company_avg
FROM employees e
CROSS JOIN (SELECT AVG(salary) AS company_avg FROM employees) AS avg_table
ON 	e.salary > avg_table.company_avg;

SELECT * 
FROM (
	SELECT first_name, last_name, salary, AVG(salary) OVER() AS company_avg
	FROM employees
) AS avg_table WHERE salary > company_avg;

#exercise 3
SELECT first_name, last_name, d.dept_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id 
WHERE d.location = 'New York';

SELECT 
	e.first_name,
    e.last_name,
	(SELECT d.dept_name FROM departments d WHERE e.dept_id = d.dept_id) AS dept_name
FROM employees e
WHERE e.dept_id IN (
				SELECT dept_id
                FROM departments 
                WHERE location = 'New York'
); 

#exercise 4
SELECT customer_name, city 
FROM customers
WHERE customer_id NOT IN (
						SELECT customer_id
                        FROM orders
                        );

SELECT c.customer_name, c.city 
FROM customers c
WHERE NOT EXISTS (
				SELECT o.customer_id
                FROM orders o
                WHERE o.customer_id = c.customer_id
                );

SELECT c.customer_name, c.city
FROM orders o
LEFT JOIN customers c
	ON c.customer_id = o.customer_id;
#left join orders to customers so all customer_ids that are in orders show up
# and id's who havnt placed an orders dont show up bc htye're not in orders table

#exercise 5
SELECT dept_name
FROM departments d
WHERE EXISTS (
	SELECT salary 
    FROM employees e
    WHERE salary > 90000 AND e.dept_id = d.dept_id
);

SELECT dept_name
FROM departments 
WHERE dept_id IN (
				SELECT dept_id
                FROM employees 
                WHERE salary > 90000
);

SELECT d.dept_name
FROM departments d
INNER JOIN employees e
	ON d.dept_id = e.dept_id 
WHERE e.salary > 90000;

#exercise 6
SELECT 
    d.dept_name,
    m.total_payroll
FROM (
    SELECT 
        e.dept_id, 
        SUM(e.salary) AS total_payroll
    FROM employees e
    GROUP BY e.dept_id
) AS m
INNER JOIN departments d ON d.dept_id = m.dept_id
WHERE m.total_payroll > (
    SELECT AVG(dept_total) 
    FROM (
        SELECT SUM(salary) AS dept_total
        FROM employees
        GROUP BY dept_id
    ) AS all_depts
);	
	
SELECT *
FROM (	
	SELECT 
		d.dept_name,
		SUM(e.salary) OVER (PARTITION BY d.dept_id) AS total_payroll
	FROM employees e
	INNER JOIN departments d
		ON e.dept_id = d.dept_id
	) AS dept_total
WHERE total_payroll > ( 
	SELECT AVG(dept_total)
	FROM (
		SELECT dept_id, SUM(salary) AS dept_total
        FROM employees
        GROUP BY dept_id
	) AS dept_payroll
);

#exercise 7
SELECT 
	d.dept_name,
    AVG(e.salary) AS dept_avg
FROM employees e
INNER JOIN departments d
	ON e.dept_id = d.dept_id
GROUP BY e.dept_id
HAVING AVG(e.salary) > (
	SELECT AVG(salary)
    FROM employees
    );

SELECT d.dept_name, t.dept_avg
FROM departments d
INNER JOIN (
	SELECT dept_id, AVG(salary) AS dept_avg
    FROM employees
    GROUP BY dept_id
) AS t ON d.dept_id = t.dept_id
WHERE t.dept_avg > (
	SELECT AVG(salary)
    FROM employees
    );
   
SELECT *
FROM (   
	SELECT
		d.dept_name,
		AVG(salary) OVER (PARTITION BY e.dept_id) AS dept_avg
	FROM employees e
	INNER JOIN departments d 
		ON e.dept_id = d.dept_id
) AS t WHERE dept_avg > (
	SELECT AVG(salary)
    FROM employees
);

#exercise 8
SELECT e.first_name, e.last_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.salary = (
	SELECT MAX(salary)
    FROM employees e1
    WHERE e1.dept_id = e.dept_id
);

SELECT e.first_name, e.last_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d
	ON e.dept_id = d.dept_id 
INNER JOIN (
	SELECT dept_id, MAX(salary) AS max_salary
    FROM employees
    GROUP BY dept_id
) AS t ON e.dept_id = t.dept_id AND e.salary = t.max_salary;

SELECT 	first_name,	last_name, dept_name, salary
FROM (
    SELECT 
		e.first_name,	
        e.last_name,
        d.dept_name,
        e.salary,
        RANK() OVER (PARTITION BY e.dept_id ORDER BY e.salary DESC) AS rnk
	FROM employees e
    INNER JOIN departments d
		ON e.dept_id = d.dept_id
	) AS ranks WHERE rnk = 1;
	
#exercise 9 
SELECT first_name, last_name, email
FROM employees 
WHERE SUBSTRING(email, POSITION('@' IN email) + 1) = (
    SELECT 
		SUBSTRING(email, POSITION( '@' IN email) + 1) AS domains
	FROM employees 
	GROUP BY SUBSTRING(email, POSITION( '@' IN email) + 1)
	ORDER BY COUNT(*) DESC
	LIMIT 1
);

SELECT e.first_name, e.last_name, e.email
FROM employees e 
INNER JOIN (
	SELECT SUBSTRING_INDEX(email, '@', -1) AS domain
	FROM employees
	GROUP BY SUBSTRING_INDEX(email, '@', -1) 
	ORDER BY COUNT(*) DESC
	LIMIT 1
) AS most_common ON SUBSTRING_INDEX(e.email, '@', -1) = most_common.domain;

SELECT e.first_name, e.last_name, e.email
FROM employees e 
INNER JOIN (
	SELECT 
		SUBSTRING_INDEX(email, '@', -1) AS domain,
		COUNT(*) OVER (ORDER BY COUNT(*) DESC) AS ranks
	FROM employees
	GROUP BY SUBSTRING_INDEX(email, '@', -1)
) AS most_common ON SUBSTRING_INDEX(e.email, '@', -1) = most_common.domain
 AND most_common.ranks = 1;
 
 #exercise 10
 SELECT 
	o.order_id,
    o.order_date,
    o.amount,
    c.customer_name
FROM orders o
LEFT JOIN customers c 
	ON o.customer_id = c.customer_id
INNER JOIN (
	SELECT DATE_FORMAT(order_date, '%Y-%m') AS most_recent_order
	FROM orders
	ORDER BY DATE_FORMAT(order_date, '%Y-%m') DESC
    LIMIT 1
	) AS most_recent 
ON DATE_FORMAT(o.order_date, '%Y-%m') = most_recent.most_recent_order;
#this is prone to issues and is very fragile so heres another solution that is also much cleaner
# refer to internet to remember why this was a wrong approach, might be helpful
SELECT o.order_id, o.order_date, o.amount, c.customer_name
FROM orders o
LEFT JOIN customers c 
	ON o.customer_id = c.customer_id
WHERE DATE_FORMAT(o.order_date, '%Y-%m') = (
	SELECT DATE_FORMAT(MAX(order_date), '%Y-%m')
    FROM orders 
);

#exercise 11
SELECT 
	e.first_name,
    e.last_name,
    d.dept_name,
    e.salary
FROM employees e 
INNER JOIN departments d
	ON e.dept_id = d.dept_id
WHERE d.budget > (
	SELECT AVG(budget)
    FROM departments)
AND e.salary > (
	SELECT AVG(salary)
    FROM employees);
    
SELECT
	e.first_name,
    e.last_name,
    aab.dept_name,
    aas.salary
FROM employees e
INNER JOIN (
	SELECT dept_id, dept_name, budget 
    FROM departments
    WHERE budget > (SELECT AVG(budget) FROM departments)
) AS aab ON e.dept_id = aab.dept_id
INNER JOIN (
	SELECT emp_id, salary
	FROM employees
    WHERE salary > (SELECT AVG(salary) FROM employees)
) AS aas ON e.salary = aas.salary;

#SUBQUERY EXERCISES AGAIN
#EX1
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT first_name, last_name, salary
FROM (
	SELECT
		*,
		AVG(salary) OVER() AS avg_salary
	FROM employees
) AS avs
WHERE salary > avg_salary;

#EX2
SELECT 
	first_name, 
    last_name, 
    salary, 
    (SELECT AVG(salary) FROM employees) AS company_avg
FROM employees;

#EX3
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
INNER JOIN departments d
	ON e.dept_id = d.dept_id
WHERE e.dept_id IN (
	SELECT dept_id
    FROM departments 
    WHERE location = 'New York'
);

#EX4
SELECT customer_id 
FROM customers
WHERE customer_id NOT IN (
	SELECT customer_id 
    FROM orders
);

#EX5
SELECT d.dept_name
FROM departments d
WHERE EXISTS (
	SELECT 1
    FROM employees e
    WHERE e.salary > 90000
    AND e.dept_id = d.dept_id
);

#EX6
SELECT dept_name, total_payroll
FROM (
	SELECT d.dept_name, SUM(e.salary) AS total_payroll
    FROM employees e
    INNER JOIN departments d
		ON e.dept_id = d.dept_id
    GROUP BY d.dept_name
	) AS salaries
WHERE total_payroll > (
	SELECT AVG(total_payroll)
    FROM (
		SELECT SUM(salary) AS total_payroll
		FROM employees
		GROUP BY dept_id
		) AS avg_total_payroll
	);

SELECT dept_name, total_payroll
FROM (
	SELECT 
		d.dept_name,
        SUM(e.salary) AS total_payroll,
        AVG(SUM(e.salary)) OVER() AS avg_total_payroll
	FROM employees e
    INNER JOIN departments d
    ON e.dept_id = d.dept_id
    GROUP BY d.dept_id, d.dept_name
    ) AS dept_total
WHERE total_payroll > avg_total_payroll;

#EX7
SELECT d.dept_name, AVG(e.salary) AS dept_avg
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY e.dept_id
HAVING dept_avg > (
	SELECT AVG(salary)
    FROM employees
);

SELECT dept_name, dept_avg
FROM (
	SELECT 
		d.dept_name,
		AVG(e.salary) OVER(PARTITION BY e.dept_id) AS dept_avg
	FROM employees e
	INNER JOIN departments d
	ON e.dept_id = d.dept_id
) AS dept_salaries WHERE dept_avg > (SELECT AVG(salary) FROM employees);

#EX8
SELECT e.first_name, e.last_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d 
ON e.dept_id = d.dept_id
WHERE salary = (
	SELECT MAX(salary)
    FROM employees e1
    WHERE e.dept_id = e1.dept_id
);

SELECT first_name, last_name, dept_name, salary
FROM (
	SELECT 
		e.first_name,
		e.last_name,
		d.dept_name,
        e.salary,
		max(e.salary) OVER(PARTITION BY e.dept_id) AS max_salary
	FROM employees e
	INNER JOIN departments d
	ON e.dept_id = d.dept_id
	) AS ms 
WHERE salary = max_salary; 

#CTE's EXERCISES
#EX1
WITH company_stats AS (
	SELECT 
        AVG(salary) AS avg_salary
	FROM employees
    
)
SELECT 
	first_name,
    last_name,
    salary
FROM employees 
WHERE salary > (
	SELECT avg_salary
    FROM company_stats
);

WITH company_payroll AS (
	SELECT 
		d.dept_name,
        SUM(e.salary) AS total_payroll
	FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
    GROUP BY d.dept_id, d.dept_name
),
max_payroll AS (
	SELECT 
		MAX(total_payroll) AS max_total
	FROM company_payroll
)

SELECT 
	cp.dept_name,
    mp.max_total
FROM company_payroll cp
CROSS JOIN max_payroll mp
WHERE cp.total_payroll = mp.max_total;


WITH dept_total AS (
	SELECT
		d.dept_name,
        SUM(e.salary) AS total_payroll,
        RANK() OVER(ORDER BY SUM(e.salary) DESC) AS rnk
	FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
    GROUP BY d.dept_id, d.dept_name
)
SELECT
	dept_name,
    total_payroll
FROM dept_total
WHERE rnk = 1;

WITH domain_counts AS (
	SELECT
        SUBSTRING_INDEX(email, '@', -1) AS domain,
        COUNT(*) AS domain_count
	FROM employees
    GROUP BY SUBSTRING_INDEX(email, '@', -1)
),
top_domain AS (
	SELECT domain
	FROM domain_counts
    ORDER BY domain_count DESC
	LIMIT 1
)
SELECT 
	e.first_name,
    e.last_name,
    e.email
FROM employees e
WHERE SUBSTRING_INDEX(email, '@', -1) = (SELECT domain FROM top_domain);

WITH customer_orders AS (
	SELECT customer_id
	FROM orders
)
SELECT c.customer_id
FROM customers c
WHERE NOT EXISTS (
	SELECT 1
    FROM customer_orders co
    WHERE c.customer_id = co.customer_id
    );
#or use left join instead of not exists

WITH employees_2022_above AS (
	SELECT
		dept_id,
		first_name,
        last_name,
        hire_date
	FROM employees
    WHERE hire_date >= '2022-01-01'
),
dept_before_2019 AS (
	SELECT 
		dept_id,
		dept_name,
        established_date 
	FROM departments
	WHERE established_date < '2019-01-01'
)
SELECT 
	e.first_name,
    e.last_name,
    e.hire_date,
	d.dept_name,
    d.established_date
FROM employees_2022_above AS e
INNER JOIN dept_before_2019 AS d
ON e.dept_id = d.dept_id;

#EX6
WITH top_earners AS (
	SELECT
		dept_id,
		first_name,
        last_name,
        salary,
        RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk
	FROM employees
)
SELECT
	d.dept_name,
    te.first_name,
	te.last_name,
	te.salary,
    te.rnk
FROM top_earners te
INNER JOIN departments d ON te.dept_id = d.dept_id
WHERE rnk <= 2;

WITH month_over_month AS (
	SELECT
		DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
	FROM orders
    WHERE YEAR(order_date) = '2024'
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT 
	month,
    revenue,
    LAG(revenue) OVER(ORDER BY month) AS prev_month_revenue,
    revenue - LAG(revenue) OVER(ORDER BY month) AS change_amount
FROM month_over_month;

#EX8
WITH dept_avg_and_counts AS (
	SELECT
		dept_id,
        AVG(salary) AS dept_avg_salary,
        COUNT(*) AS headcount
	FROM employees
    GROUP BY dept_id
)
SELECT 
	d.dept_name,
    ac.dept_avg_salary,
    ac.headcount
FROM departments d
INNER JOIN dept_avg_and_counts ac
ON d.dept_id = ac.dept_id
WHERE ac.dept_avg_salary > (SELECT AVG(salary) FROM employees)
	AND ac.headcount > 2;

#EX9
WITH dept_salary AS (
	SELECT
		dept_id,
		first_name,
        last_name,
        salary,
        MAX(salary) OVER(PARTITION BY dept_id) AS dept_max_salary
	FROM employees
)
SELECT
	ds.first_name,
    ds.last_name,
    d.dept_name,
    ds.salary,
    ds.dept_max_salary
FROM dept_salary ds
INNER JOIN departments d ON ds.dept_id = d.dept_id
WHERE ds.salary > ds.dept_max_salary * 0.90;

#EX10
WITH all_employees AS (
    SELECT 
        emp_id,
        first_name,
        last_name,
        salary,
        manager_id
    FROM employees
)
SELECT 
    m.first_name AS manager_name,
    m.last_name AS manager_last,
    m.salary AS manager_salary,
    e.first_name AS employee_name,
    e.last_name AS employee_last,
    e.salary AS employee_salary
FROM all_employees m
JOIN all_employees e ON m.emp_id = e.manager_id
WHERE e.salary > m.salary;

#EX11
WITH RECURSIVE number_series AS (
	SELECT 
		'2024-01-01' AS dt
	UNION
	SELECT 
		dt + INTERVAL 1 DAY #or dt + DATE_ADD(dt, INTERVAL 1 DAY)
	FROM number_series
	WHERE dt < '2024-01-15'
)	
SELECT dt FROM 	number_series;

#EX12
WITH RECURSIVE emp_hierarchy AS (
	SELECT 
		emp_id,
        first_name,
        last_name,
        manager_id,
        0 AS level
	FROM employees 
    WHERE emp_id = 101
    UNION ALL
    SELECT
		e.emp_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        level + 1
	FROM employees e
    INNER JOIN emp_hierarchy eh ON e.manager_id = eh.emp_id
)
SELECT emp_id, first_name, last_name, manager_id, level
FROM emp_hierarchy;

#EX13
WITH lifetime_amount AS (
	SELECT 
		customer_id,
        SUM(amount) AS total_spent
	FROM orders
    GROUP BY customer_id
),
quartile AS (
	SELECT
		customer_id,
		total_spent,
		NTILE(4) OVER(ORDER BY total_spent DESC) AS customer_quartile
	FROM lifetime_amount
)
SELECT 
	c.customer_name,
    p.total_spent,
    p.customer_percentile
FROM customers c
INNER JOIN percentile p ON c.customer_id = p.customer_id
WHERE p.customer_percentile = 1;
    
#EX14
WITH dept_stats AS (
	SELECT
		e.dept_id,
        d.dept_name,
        MAX(e.salary) AS highest_salary,
        AVG(e.salary) AS dept_avg
	FROM employees e
    INNER JOIN departments d ON e.dept_id = d.dept_id
    GROUP BY e.dept_id, d.dept_name
)
SELECT 
	dept_name,
    highest_salary,
    dept_avg,
    highest_salary - dept_avg AS difference
FROM dept_stats;

#EX15
WITH avg_dept_budget AS (
	SELECT
		dept_id,
        AVG(budget) AS avg_budget
	FROM departments
    GROUP BY dept_id
),
emp_in_budget_departments AS (
	SELECT
		e.dept_id,
		e.emp_id,
        e.first_name,
        e.salary AS current_salary
	FROM employees e
    INNER JOIN avg_dept_budget adb 
    ON e.dept_id = adb.dept_id AND adb.avg_budget > (SELECT AVG(budget) FROM departments)
)
SELECT 
	emp_id,
    first_name,
    current_salary,
    current_salary * 0.15 AS proposed_new_salary
FROM emp_in_budget_departments;
#this is close and works but has a conceptual error, here is the cleaner correct code
# that AI provided after looking at my code

WITH overall_avg_budget AS (
    -- Step 1: One single average across all departments
    SELECT AVG(budget) AS avg_budget
    FROM departments
),
high_budget_depts AS (
    -- Step 2: Departments above that average
    SELECT dept_id, budget
    FROM departments
    WHERE budget > (SELECT avg_budget FROM overall_avg_budget)
)
-- Step 3 & 4: Employees in those departments, with proposed raise
SELECT 
    e.emp_id,
    e.first_name,
    e.salary AS current_salary,
    e.salary * 1.15 AS proposed_new_salary
FROM employees e
INNER JOIN high_budget_depts hbd ON e.dept_id = hbd.dept_id;

#VIEWS AND TEMP TABLES
CREATE VIEW high_earners AS (
	SELECT 
		first_name,
		last_name,
		salary,
		dept_id
	FROM employees
	WHERE salary > (SELECT AVG(salary) FROM employees)
);
SELECT 
	dept_id,
    COUNT(*) AS high_earners_count
FROM high_earners
GROUP BY dept_id;

#EX2
CREATE OR REPLACE VIEW order_details AS (
	SELECT 
		o.order_id,
        o.order_date,
        o.amount,
        c.customer_name,
        c.city,
		CONCAT(e.first_name, ' ', e.last_name) AS sales_rep_name,
        d.dept_name
	FROM orders o 
    INNER JOIN employees e
		ON o.emp_id = e.emp_id
	INNER JOIN customers c 
		ON o.customer_id = c.customer_id
	INNER JOIN departments d 
		ON e.dept_id = d.dept_id
); # WE PREFER INNER FOR REPORTING, LEFT FOR COMPLETE DATA FOR CHECKING. U DONT WANT EXECS SEEING NULLS IN THIER DASHBOARD OR EXCEL
SELECT * FROM order_details;
SELECT 
	dept_name,
    SUM(amount) AS total_revenue
FROM order_details
WHERE order_date > '2024-02-28' AND order_date < '2024-04-01'
GROUP BY dept_name;

#EX3
CREATE OR REPLACE VIEW employee_public AS (
	SELECT
		e.emp_id,
        e.first_name,
        e.last_name,
        e.hire_date,
        d.dept_name
	FROM employees e
    INNER JOIN departments d
		ON e.dept_id = d.dept_id
);
SELECT * FROM employee_public;

#EX1 TEMP TABLES
CREATE TEMPORARY TABLE temp_q1_sales AS
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_revenue,
    COUNT(*) AS order_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date >= '2024-01-01' AND o.order_date < '2024-04-01'
GROUP BY c.customer_id, c.customer_name;

#set the output of a temp table query to a variable so we dont open the temp table twice 
#or more in 1 query bc that will cause an error, tem tables can only be opened 1 time 
#in a query!!!
SET @avg_revenue = (SELECT AVG(total_revenue) FROM temp_q1_sales);

SELECT customer_name, total_revenue
FROM temp_q1_sales
WHERE total_revenue > @avg_revenue;
#apparently cant open the temp table twice in a query,
#the workaround (self-join, variable, or two temp tables).
# i used variable above bc i wanna learn it and its simplest here.

CREATE DATABASE revision3;
-- ============================================================
-- 1. CUSTOMERS
-- ============================================================
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    country VARCHAR(50),
    signup_date DATE,
    is_active TINYINT(1),
    tier VARCHAR(20) -- 'bronze', 'silver', 'gold', 'platinum'
);

INSERT INTO customers VALUES
(1, 'Alice Johnson', 'alice@email.com', '+1-555-0101', 'USA', '2022-03-15', 1, 'gold'),
(2, 'Bob Smith', NULL, '+1-555-0102', 'USA', '2023-01-10', 1, 'silver'),
(3, 'Carol White', 'carol@email.com', NULL, 'UK', '2023-06-20', 1, 'bronze'),
(4, 'David Brown', 'david@email.com', '+44-555-0103', 'UK', '2021-11-05', 0, 'silver'),
(5, 'Eva Green', 'eva@email.com', '+1-555-0104', 'Canada', '2023-09-01', 1, 'gold'),
(6, 'Frank Black', NULL, NULL, 'Germany', '2022-07-22', 1, 'bronze'),
(7, 'Grace Lee', 'grace@email.com', '+49-555-0105', 'Germany', '2023-02-14', 1, 'platinum'),
(8, 'Henry Wilson', 'henry@email.com', '+1-555-0106', 'USA', '2020-05-30', 0, 'silver'),
(9, 'Ivy Chen', 'ivy@email.com', '+86-555-0107', 'China', '2023-04-18', 1, 'bronze'),
(10, 'Jack Taylor', 'jack@email.com', '+44-555-0108', 'UK', '2023-08-25', 1, 'gold'),
(11, 'Karen Martinez', 'karen@email.com', '+1-555-0109', 'USA', '2023-10-05', 1, 'silver'),
(12, 'Leo Anderson', NULL, '+46-555-0110', 'Sweden', '2022-12-01', 1, 'bronze'),
(13, 'Mia Thompson', 'mia@email.com', '+1-555-0111', 'Canada', '2023-07-12', 0, 'gold'),
(14, 'Noah Garcia', 'noah@email.com', '+34-555-0112', 'Spain', '2023-03-08', 1, 'silver'),
(15, 'Olivia Rodriguez', 'olivia@email.com', '+1-555-0113', 'USA', '2023-11-20', 1, 'platinum');

-- ============================================================
-- 2. ORDERS
-- ============================================================
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20), -- 'completed', 'pending', 'cancelled', 'refunded'
    shipping_country VARCHAR(50)
);

INSERT INTO orders VALUES
(101, 1, '2023-01-15', 250.00, 'completed', 'USA'),
(102, 1, '2023-03-22', 180.50, 'completed', 'USA'),
(103, 2, '2023-02-10', 99.99, 'pending', 'USA'),
(104, 3, '2023-06-25', 450.00, 'completed', 'UK'),
(105, 4, '2023-01-05', 1200.00, 'cancelled', 'UK'),
(106, 5, '2023-09-10', 75.00, 'completed', 'Canada'),
(107, 7, '2023-02-20', 3200.00, 'completed', 'Germany'),
(108, 7, '2023-05-15', 890.00, 'completed', 'Germany'),
(109, 9, '2023-04-20', 55.00, 'pending', 'China'),
(110, 10, '2023-08-28', 670.00, 'completed', 'UK'),
(111, 11, '2023-10-10', 230.00, 'completed', 'USA'),
(112, 11, '2023-10-12', 150.00, 'refunded', 'USA'),
(113, 13, '2023-07-15', 500.00, 'cancelled', 'Canada'),
(114, 14, '2023-03-12', 89.00, 'completed', 'Spain'),
(115, 15, '2023-11-22', 1200.00, 'completed', 'USA'),
(116, 1, '2023-12-01', 340.00, 'pending', 'USA'),
(117, 5, '2023-12-05', 199.00, 'completed', 'Canada'),
(118, 7, '2023-12-10', 4500.00, 'completed', 'Germany'),
(119, 2, '2023-12-15', 45.00, 'cancelled', 'USA'),
(120, 10, '2023-12-20', 780.00, 'completed', 'UK');

-- ============================================================
-- 3. ORDER_ITEMS
-- ============================================================
CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2)
);

INSERT INTO order_items VALUES
(1, 101, 1, 2, 125.00),
(2, 101, 3, 1, 0.00),
(3, 102, 2, 1, 180.50),
(4, 103, 4, 1, 99.99),
(5, 104, 5, 3, 150.00),
(6, 105, 6, 2, 600.00),
(7, 106, 7, 1, 75.00),
(8, 107, 8, 1, 3200.00),
(9, 108, 9, 2, 445.00),
(10, 109, 10, 1, 55.00),
(11, 110, 1, 2, 125.00),
(12, 110, 5, 1, 150.00),
(13, 110, 11, 1, 295.00),
(14, 111, 2, 1, 180.50),
(15, 111, 12, 1, 49.50),
(16, 112, 13, 1, 150.00),
(17, 113, 14, 5, 100.00),
(18, 114, 15, 1, 89.00),
(19, 115, 8, 1, 1200.00),
(20, 116, 1, 2, 125.00),
(21, 116, 16, 1, 90.00),
(22, 117, 17, 1, 199.00),
(23, 118, 8, 1, 4500.00),
(24, 119, 4, 1, 45.00),
(25, 120, 5, 2, 150.00),
(26, 120, 18, 1, 480.00);

-- ============================================================
-- 4. PRODUCTS
-- ============================================================
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(200),
    category VARCHAR(50),
    description TEXT,
    base_price DECIMAL(10,2),
    is_discontinued TINYINT(1)
);

INSERT INTO products VALUES
(1, 'Aero Wireless Headphones', 'Electronics', 'Premium wireless headphones with active noise cancellation and 30-hour battery life. Includes 2-year warranty.', 125.00, 0),
(2, 'Ergo Office Chair', 'Furniture', 'Ergonomic mesh office chair with lumbar support and adjustable armrests.', 180.50, 0),
(3, 'USB-C Cable 2m', 'Accessories', 'Braided USB-C to USB-C cable, 2 meters, supports fast charging.', 12.99, 0),
(4, 'Basic Mouse Pad', 'Accessories', 'Standard cloth mouse pad, 25x30cm. No warranty included.', 9.99, 0),
(5, 'LED Desk Lamp', 'Electronics', 'Adjustable LED desk lamp with touch controls and USB charging port.', 150.00, 0),
(6, 'UltraWide Monitor 34"', 'Electronics', '34-inch curved ultrawide monitor, 144Hz, 1ms response. 3-year warranty included.', 600.00, 0),
(7, 'Organic Cotton T-Shirt', 'Apparel', '100% organic cotton, sustainably sourced. Available in multiple colors.', 25.00, 0),
(8, 'Pro Laptop Stand', 'Electronics', 'Aluminum laptop stand, adjustable height, compatible with all laptops up to 17".', 45.00, 0),
(9, 'Mechanical Keyboard', 'Electronics', 'Cherry MX switches, RGB backlight, programmable keys. 1-year warranty.', 445.00, 0),
(10, 'Eco Water Bottle', 'Accessories', 'BPA-free stainless steel water bottle, 750ml, keeps drinks cold 24h.', 22.00, 0),
(11, 'Noise Cancelling Earbuds', 'Electronics', 'True wireless earbuds with ANC and transparency mode.', 295.00, 0),
(12, 'Phone Grip Stand', 'Accessories', 'Collapsible phone grip and stand, universal compatibility.', 12.50, 0),
(13, 'Smart Watch Band', 'Accessories', 'Silicone replacement band for smart watches, multiple sizes.', 19.99, 0),
(14, 'Portable SSD 1TB', 'Electronics', 'External SSD, 1TB, USB 3.2 Gen 2, up to 1050MB/s read speed. 5-year warranty.', 100.00, 0),
(15, 'Blue Light Glasses', 'Apparel', 'Computer glasses with blue light filtering lenses.', 35.00, 0),
(16, 'Cable Management Box', 'Accessories', 'Bamboo cable organizer box, hides power strips and cables.', 24.99, 0),
(17, 'Webcam 4K', 'Electronics', '4K webcam with auto-focus and built-in microphone. 2-year warranty.', 199.00, 0),
(18, 'Standing Desk Converter', 'Furniture', 'Adjustable standing desk converter, 37" wide, no assembly required.', 480.00, 0),
(19, 'Ivy Smart Thermostat', 'Electronics', 'WiFi-enabled smart thermostat with app control. 2-year warranty.', 249.00, 1),
(20, 'Vintage Wall Clock', 'Decor', 'Minimalist wall clock, silent movement, 12-inch diameter.', 34.99, 1);

-- ============================================================
-- 5. DEPARTMENTS
-- ============================================================
CREATE TABLE departments (
    dept_name VARCHAR(50) PRIMARY KEY,
    budget DECIMAL(12,2),
    location VARCHAR(50),
    head_count INT
);

INSERT INTO departments VALUES
('Engineering', 2500000.00, 'New York', 45),
('Sales', 1800000.00, 'London', 32),
('Marketing', 1200000.00, 'New York', 28),
('HR', 600000.00, 'London', 12),
('Finance', 1500000.00, 'Singapore', 20),
('Operations', 900000.00, 'Berlin', 18),
('Product', 1100000.00, 'New York', 22),
('Customer Success', 700000.00, 'London', 25);

-- ============================================================
-- 6. EMPLOYEES
-- ============================================================
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT,
    is_full_time TINYINT(1)
);

INSERT INTO employees VALUES
(1, 'Sarah Connor', 'Engineering', 145000.00, '2019-03-15', NULL, 1),
(2, 'John Reese', 'Engineering', 125000.00, '2020-06-01', 1, 1),
(3, 'Harold Finch', 'Engineering', 155000.00, '2018-01-10', 1, 1),
(4, 'Joss Carter', 'Sales', 95000.00, '2021-02-20', 5, 1),
(5, 'Lionel Fusco', 'Sales', 110000.00, '2020-08-15', NULL, 1),
(6, 'Sameen Shaw', 'Engineering', 135000.00, '2020-11-30', 1, 0),
(7, 'Root', 'Marketing', 88000.00, '2022-04-10', 8, 1),
(8, 'Zoe Morgan', 'Marketing', 102000.00, '2019-09-01', NULL, 1),
(9, 'Carl Elias', 'Finance', 118000.00, '2020-03-22', 12, 1),
(10, 'Anthony Marconi', 'Finance', 92000.00, '2021-07-18', 12, 1),
(11, 'Donnelly', 'HR', 78000.00, '2022-01-05', 14, 1),
(12, 'Terrence King', 'Finance', 135000.00, '2018-06-15', NULL, 1),
(13, 'Hersh', 'Operations', 85000.00, '2021-10-12', 15, 1),
(14, 'Control', 'HR', 95000.00, '2019-12-01', NULL, 1),
(15, 'Greer', 'Operations', 105000.00, '2018-04-20', NULL, 1),
(16, 'Shaw (Contractor)', 'Engineering', 75000.00, '2023-01-15', 3, 0),
(17, 'Bear', 'Product', 65000.00, '2022-08-01', 18, 1),
(18, 'Nathan Ingram', 'Product', 128000.00, '2017-11-10', NULL, 1),
(19, 'Grace Hendricks', 'Customer Success', 82000.00, '2021-05-20', 20, 1),
(20, 'Danielle', 'Customer Success', 98000.00, '2020-02-14', NULL, 1);

-- ============================================================
-- 7. EMPLOYEE_HIERARCHY (self-referencing)
-- ============================================================
CREATE TABLE employee_hierarchy (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10,2),
    level INT
);

INSERT INTO employee_hierarchy VALUES
(1, 'CEO Alice', NULL, 300000.00, 1),
(2, 'CTO Bob', 1, 200000.00, 2),
(3, 'CFO Carol', 1, 190000.00, 2),
(4, 'VP Engineering Dave', 2, 160000.00, 3),
(5, 'VP Product Eve', 2, 150000.00, 3),
(6, 'Senior Dev Frank', 4, 130000.00, 4),
(7, 'Senior Dev Grace', 4, 135000.00, 4),
(8, 'Dev Henry', 6, 95000.00, 5),
(9, 'Dev Ivy', 6, 92000.00, 5),
(10, 'Dev Jack', 7, 98000.00, 5),
(11, 'Junior Dev Karen', 8, 65000.00, 6),
(12, 'Junior Dev Leo', 9, 62000.00, 6),
(13, 'Product Manager Mia', 5, 110000.00, 4),
(14, 'Analyst Noah', 3, 105000.00, 3),
(15, 'Accountant Olivia', 3, 88000.00, 4);

-- ============================================================
-- 8. WAREHOUSES
-- ============================================================
CREATE TABLE warehouses (
    warehouse_id INT PRIMARY KEY,
    city VARCHAR(50),
    country VARCHAR(50),
    capacity INT
);

INSERT INTO warehouses VALUES
(1, 'New York', 'USA', 50000),
(2, 'Los Angeles', 'USA', 35000),
(3, 'London', 'UK', 40000),
(4, 'Berlin', 'Germany', 30000),
(5, 'Madrid', 'Spain', 25000),
(6, 'Amsterdam', 'Netherlands', 20000),
(7, 'Milan', 'Italy', 22000),
(8, 'Toronto', 'Canada', 28000);

-- ============================================================
-- 9. INVENTORY
-- ============================================================
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    quantity INT,
    last_updated DATE
);

INSERT INTO inventory VALUES
(1, 1, 1, 150, '2023-12-01'),
(2, 1, 2, 80, '2023-11-15'),
(3, 2, 1, 45, '2023-12-05'),
(4, 2, 3, 30, '2023-10-20'),
(5, 3, 1, 500, '2023-12-10'),
(6, 3, 4, 0, '2023-09-01'),
(7, 4, 2, 200, '2023-11-30'),
(8, 5, 3, 75, '2023-12-03'),
(9, 5, 5, 0, '2023-08-15'),
(10, 6, 1, 25, '2023-12-01'),
(11, 7, 4, 300, '2023-11-20'),
(12, 8, 6, 120, '2023-10-10'),
(13, 9, 3, 40, '2023-12-08'),
(14, 10, 7, 250, '2023-09-25'),
(15, 11, 1, 60, '2023-12-05'),
(16, 12, 8, 400, '2023-11-15'),
(17, 13, 2, 0, '2023-07-20'),
(18, 14, 5, 35, '2023-12-02'),
(19, 15, 6, 180, '2023-10-30'),
(20, 16, 7, 90, '2023-11-10'),
(21, 17, 8, 55, '2023-12-01'),
(22, 18, 1, 15, '2023-11-25'),
(23, 19, 2, 0, '2023-06-15'),
(24, 20, 4, 0, '2023-08-01');

-- ============================================================
-- 10. SALES
-- ============================================================
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    salesperson_id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    region VARCHAR(50)
);

INSERT INTO sales VALUES
(1, 101, '2023-01-15', 5000.00, 'North'),
(2, 101, '2023-02-20', 7200.00, 'North'),
(3, 101, '2023-03-10', 3100.00, 'East'),
(4, 102, '2023-01-22', 8900.00, 'South'),
(5, 102, '2023-04-05', 12000.00, 'South'),
(6, 102, '2023-05-18', 4500.00, 'West'),
(7, 103, '2023-02-01', 6700.00, 'East'),
(8, 103, '2023-06-12', 9300.00, 'North'),
(9, 103, '2023-08-20', 1500.00, 'West'),
(10, 104, '2023-03-15', 11200.00, 'South'),
(11, 104, '2023-07-08', 7800.00, 'East'),
(12, 105, '2023-01-30', 5600.00, 'North'),
(13, 105, '2023-09-14', 13400.00, 'South'),
(14, 105, '2023-11-22', 3200.00, 'West'),
(15, 106, '2023-04-20', 8900.00, 'East'),
(16, 106, '2023-10-05', 10100.00, 'North'),
(17, 107, '2023-05-12', 4500.00, 'South'),
(18, 107, '2023-12-01', 16700.00, 'West'),
(19, 108, '2023-06-18', 7300.00, 'East'),
(20, 108, '2023-11-30', 5400.00, 'North');

-- ============================================================
-- 11. WEBSITE_VISITS
-- ============================================================
CREATE TABLE website_visits (
    visit_id INT PRIMARY KEY,
    user_id INT,
    page_url VARCHAR(200),
    visit_time DATETIME,
    session_id VARCHAR(50),
    device_type VARCHAR(20) -- 'mobile', 'desktop', 'tablet'
);

INSERT INTO website_visits VALUES
(1, 1, '/home', '2023-12-01 09:15:00', 'sess_a1', 'desktop'),
(2, 1, '/pricing', '2023-12-01 09:18:30', 'sess_a1', 'desktop'),
(3, 1, '/features', '2023-12-01 09:22:00', 'sess_a1', 'desktop'),
(4, 1, '/checkout', '2023-12-01 09:28:45', 'sess_a1', 'desktop'),
(5, 1, '/success', '2023-12-01 09:30:10', 'sess_a1', 'desktop'),
(6, 2, '/home', '2023-12-01 10:05:00', 'sess_b2', 'mobile'),
(7, 2, '/pricing', '2023-12-01 10:08:20', 'sess_b2', 'mobile'),
(8, 2, '/checkout', '2023-12-01 10:15:00', 'sess_b2', 'mobile'),
(9, 3, '/home', '2023-12-01 11:00:00', 'sess_c3', 'tablet'),
(10, 3, '/blog', '2023-12-01 11:05:00', 'sess_c3', 'tablet'),
(11, 3, '/pricing', '2023-12-01 11:12:00', 'sess_c3', 'tablet'),
(12, 4, '/home', '2023-12-01 14:20:00', 'sess_d4', 'desktop'),
(13, 4, '/pricing', '2023-12-01 14:23:00', 'sess_d4', 'desktop'),
(14, 4, '/checkout', '2023-12-01 14:30:00', 'sess_d4', 'desktop'),
(15, 5, '/home', '2023-12-01 16:00:00', 'sess_e5', 'mobile'),
(16, 5, '/features', '2023-12-01 16:04:00', 'sess_e5', 'mobile'),
(17, 5, '/pricing', '2023-12-01 16:10:00', 'sess_e5', 'mobile'),
(18, 5, '/checkout', '2023-12-01 16:18:00', 'sess_e5', 'mobile'),
(19, 5, '/success', '2023-12-01 16:20:00', 'sess_e5', 'mobile'),
(20, 6, '/home', '2023-12-02 09:00:00', 'sess_f6', 'desktop'),
(21, 6, '/pricing', '2023-12-02 09:05:00', 'sess_f6', 'desktop'),
(22, 6, '/checkout', '2023-12-02 09:15:00', 'sess_f6', 'desktop'),
(23, 7, '/home', '2023-12-02 10:30:00', 'sess_g7', 'tablet'),
(24, 7, '/pricing', '2023-12-02 10:35:00', 'sess_g7', 'tablet'),
(25, 7, '/features', '2023-12-02 10:42:00', 'sess_g7', 'tablet');

-- ============================================================
-- 12. EVENTS
-- ============================================================
CREATE TABLE events (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(200),
    start_time DATETIME,
    end_time DATETIME,
    timezone VARCHAR(50),
    event_type VARCHAR(50)
);

INSERT INTO events VALUES
(1, 'Product Launch Webinar', '2023-12-02 10:00:00', '2023-12-02 12:30:00', 'EST', 'webinar'),
(2, 'Weekend Hackathon', '2023-12-09 09:00:00', '2023-12-10 18:00:00', 'PST', 'competition'),
(3, 'Q4 Review Meeting', '2023-12-04 14:00:00', '2023-12-04 15:30:00', 'GMT', 'meeting'),
(4, 'Holiday Party', '2023-12-16 19:00:00', '2023-12-17 01:00:00', 'EST', 'social'),
(5, 'Year-End Sale', '2023-12-30 00:00:00', '2024-01-02 23:59:00', 'UTC', 'promotion'),
(6, 'Team Standup', '2023-12-01 09:00:00', '2023-12-01 09:15:00', 'CET', 'meeting'),
(7, 'Customer Workshop', '2023-12-03 13:00:00', '2023-12-03 17:00:00', 'PST', 'workshop'),
(8, 'Board Meeting', '2023-12-11 10:00:00', '2023-12-11 14:00:00', 'GMT', 'meeting'),
(9, 'New Year Countdown', '2023-12-31 22:00:00', '2024-01-01 02:00:00', 'EST', 'social'),
(10, 'Training Session', '2023-12-05 09:00:00', '2023-12-05 16:00:00', 'CET', 'workshop');

-- ============================================================
-- 13. LOGS
-- ============================================================
CREATE TABLE logs (
    log_id INT PRIMARY KEY,
    log_message TEXT,
    log_level VARCHAR(20),
    created_at DATETIME,
    service_name VARCHAR(50)
);

INSERT INTO logs VALUES
(1, 'User login successful for user_id=4521', 'INFO', '2023-12-01 08:15:00', 'auth-service'),
(2, 'ERR-1001: Database connection timeout after 30s', 'ERROR', '2023-12-01 09:30:00', 'db-service'),
(3, 'Cache miss for key: user_profile_4521', 'WARN', '2023-12-01 10:00:00', 'cache-service'),
(4, 'ERR-2042: Payment processing failed for transaction_id=78901', 'ERROR', '2023-12-01 11:45:00', 'payment-service'),
(5, 'Scheduled job completed: daily_report', 'INFO', '2023-12-01 12:00:00', 'scheduler'),
(6, 'ERR-1001: Database connection timeout after 45s', 'ERROR', '2023-12-01 13:20:00', 'db-service'),
(7, 'Memory usage at 85% threshold', 'WARN', '2023-12-01 14:10:00', 'monitoring'),
(8, 'ERR-5503: Invalid API key provided in request', 'ERROR', '2023-12-01 15:00:00', 'api-gateway'),
(9, 'User logout: session_id=sess_a1 expired', 'INFO', '2023-12-01 16:30:00', 'auth-service'),
(10, 'ERR-2042: Payment processing failed for transaction_id=78902', 'ERROR', '2023-12-01 17:15:00', 'payment-service'),
(11, 'Backup completed successfully', 'INFO', '2023-12-01 18:00:00', 'backup-service'),
(12, 'ERR-9999: Unknown error in module X', 'ERROR', '2023-12-01 19:30:00', 'legacy-service'),
(13, 'Rate limit exceeded for IP 192.168.1.100', 'WARN', '2023-12-01 20:00:00', 'api-gateway'),
(14, 'ERR-1001: Database connection timeout after 60s', 'ERROR', '2023-12-02 08:00:00', 'db-service'),
(15, 'Health check passed for all services', 'INFO', '2023-12-02 09:00:00', 'monitoring');

-- ============================================================
-- 14. STUDENTS
-- ============================================================
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    enrollment_date DATE,
    major VARCHAR(50)
);

INSERT INTO students VALUES
(1, 'Emma Watson', 'emma@uni.edu', '2021-09-01', 'Computer Science'),
(2, 'Daniel Radcliffe', 'daniel@uni.edu', '2022-01-15', 'Mathematics'),
(3, 'Rupert Grint', 'rupert@uni.edu', '2020-09-01', 'Physics'),
(4, 'Bonnie Wright', 'bonnie@uni.edu', '2023-01-10', 'Computer Science'),
(5, 'Tom Felton', 'tom@uni.edu', '2021-09-01', 'Chemistry'),
(6, 'Matthew Lewis', 'matthew@uni.edu', '2022-09-01', 'Biology'),
(7, 'Evanna Lynch', 'evanna@uni.edu', '2023-03-01', 'Mathematics'),
(8, 'Alfred Enoch', 'alfred@uni.edu', '2020-09-01', 'Physics'),
(9, 'Oliver Phelps', 'oliver@uni.edu', '2021-09-01', 'Computer Science'),
(10, 'James Phelps', 'james@uni.edu', '2022-01-15', 'Chemistry');

-- ============================================================
-- 15. COURSES
-- ============================================================
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT,
    department VARCHAR(50)
);

INSERT INTO courses VALUES
(101, 'Database Systems', 4, 'Computer Science'),
(102, 'Linear Algebra', 3, 'Mathematics'),
(103, 'Quantum Mechanics', 4, 'Physics'),
(104, 'Organic Chemistry', 3, 'Chemistry'),
(105, 'Data Structures', 4, 'Computer Science'),
(106, 'Machine Learning', 4, 'Computer Science'),
(107, 'Calculus III', 3, 'Mathematics'),
(108, 'Thermodynamics', 3, 'Physics'),
(109, 'Biochemistry', 3, 'Chemistry'),
(110, 'Cell Biology', 3, 'Biology');

-- ============================================================
-- 16. ENROLLMENTS
-- ============================================================
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    completion_date DATE,
    grade VARCHAR(5)
);

INSERT INTO enrollments VALUES
(1, 1, 101, '2021-09-01', '2022-01-15', 'A'),
(2, 1, 105, '2022-09-01', '2023-01-10', 'B+'),
(3, 2, 102, '2022-01-15', '2022-05-20', 'A-'),
(4, 3, 103, '2020-09-01', NULL, NULL),
(5, 4, 101, '2023-01-10', NULL, NULL),
(6, 5, 104, '2021-09-01', '2022-01-15', 'B'),
(7, 6, 110, '2022-09-01', '2023-01-10', 'A'),
(8, 7, 107, '2023-03-01', NULL, NULL),
(9, 8, 103, '2020-09-01', '2021-01-15', 'C+'),
(10, 8, 108, '2021-09-01', '2022-01-15', 'B'),
(11, 9, 101, '2021-09-01', NULL, NULL),
(12, 9, 106, '2022-09-01', NULL, NULL),
(13, 10, 104, '2022-01-15', '2022-05-20', 'A'),
(14, 2, 107, '2022-09-01', NULL, NULL),
(15, 3, 108, '2021-09-01', NULL, NULL),
(16, 5, 109, '2022-09-01', NULL, NULL),
(17, 1, 106, '2023-01-10', NULL, NULL);

-- ============================================================
-- 17. ACCOUNTS
-- ============================================================
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_holder VARCHAR(100),
    account_type VARCHAR(20), -- 'checking', 'savings', 'credit'
    balance DECIMAL(12,2),
    opened_date DATE,
    is_active TINYINT(1)
);

INSERT INTO accounts VALUES
(1, 'Alice Johnson', 'checking', 4520.50, '2020-03-15', 1),
(2, 'Alice Johnson', 'savings', 12500.00, '2020-03-15', 1),
(3, 'Bob Smith', 'checking', 890.25, '2021-06-01', 1),
(4, 'Bob Smith', 'credit', -2500.00, '2021-06-01', 1),
(5, 'Carol White', 'savings', 34000.00, '2019-11-20', 1),
(6, 'David Brown', 'checking', 150.00, '2022-01-10', 0),
(7, 'Eva Green', 'checking', 6780.00, '2021-09-01', 1),
(8, 'Eva Green', 'savings', 22000.00, '2021-09-01', 1),
(9, 'Frank Black', 'checking', 45.00, '2023-02-14', 1),
(10, 'Grace Lee', 'credit', -1500.00, '2020-08-15', 1);

-- ============================================================
-- 18. TRANSACTIONS
-- ============================================================
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20), -- 'debit', 'credit', 'transfer'
    amount DECIMAL(10,2),
    transaction_date DATE,
    is_flagged TINYINT(1),
    description VARCHAR(200)
);

INSERT INTO transactions VALUES
(1, 1, 'debit', 150.00, '2023-11-15', 0, 'Grocery store'),
(2, 1, 'debit', 89.50, '2023-11-20', 0, 'Gas station'),
(3, 1, 'credit', 2500.00, '2023-11-25', 0, 'Paycheck deposit'),
(4, 2, 'transfer', 500.00, '2023-11-18', 0, 'To checking'),
(5, 3, 'debit', 1200.00, '2023-11-10', 1, 'Large purchase'),
(6, 3, 'debit', 45.00, '2023-12-01', 0, 'Coffee shop'),
(7, 4, 'credit', 500.00, '2023-11-22', 0, 'Payment received'),
(8, 5, 'transfer', 10000.00, '2023-11-15', 1, 'Wire transfer'),
(9, 7, 'debit', 350.00, '2023-12-05', 0, 'Electronics'),
(10, 7, 'debit', 12000.00, '2023-12-08', 1, 'Car down payment'),
(11, 8, 'transfer', 2500.00, '2023-11-20', 0, 'Investment'),
(12, 9, 'debit', 25.00, '2023-12-10', 0, 'Fast food'),
(13, 10, 'credit', 800.00, '2023-11-28', 0, 'Refund'),
(14, 1, 'transfer', 15000.00, '2023-12-12', 1, 'Property purchase'),
(15, 3, 'debit', 6700.00, '2023-12-14', 1, 'Jewelry');

-- ============================================================
-- 19. Q1_SALES & Q2_SALES (for set operators)
-- ============================================================
CREATE TABLE q1_sales (
    product_id INT,
    amount DECIMAL(10,2),
    units_sold INT
);

CREATE TABLE q2_sales (
    product_id INT,
    amount DECIMAL(10,2),
    units_sold INT
);

INSERT INTO q1_sales VALUES
(1, 5000.00, 40),
(2, 3200.00, 18),
(3, 1800.00, 150),
(5, 7500.00, 50),
(7, 1200.00, 48),
(9, 4500.00, 10),
(11, 8900.00, 30),
(13, 2100.00, 105),
(15, 600.00, 17),
(17, 3400.00, 17);

INSERT INTO q2_sales VALUES
(1, 5200.00, 42),
(2, 6400.00, 36),
(4, 900.00, 90),
(5, 8000.00, 53),
(6, 15000.00, 25),
(8, 5400.00, 120),
(10, 2200.00, 100),
(11, 9500.00, 32),
(12, 4800.00, 384),
(14, 3500.00, 35);

-- ============================================================
-- 20. USERS, SUBSCRIPTIONS, PAYMENTS (capstone exercises)
-- ============================================================
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at DATE,
    country VARCHAR(50)
);

INSERT INTO users VALUES
(1, 'alpha_user', 'alpha@example.com', '2021-03-15', 'USA'),
(2, 'beta_dev', 'beta@example.com', '2022-07-20', 'UK'),
(3, 'gamma_tester', 'gamma@example.com', '2020-01-10', 'Germany'),
(4, 'delta_analyst', 'delta@example.com', '2023-05-01', 'Canada'),
(5, 'epsilon_trader', 'epsilon@example.com', '2022-11-30', 'USA'),
(6, 'zeta_designer', 'zeta@example.com', '2021-09-15', 'France'),
(7, 'eta_engineer', 'eta@example.com', '2023-02-28', 'Spain'),
(8, 'theta_manager', 'theta@example.com', '2020-06-20', 'Italy'),
(9, 'iota_writer', 'iota@example.com', '2022-04-10', 'Japan'),
(10, 'kappa_creator', 'kappa@example.com', '2021-12-01', 'Brazil'),
(11, 'lambda_ops', 'lambda@example.com', '2023-08-15', 'USA'),
(12, 'mu_research', 'mu@example.com', '2022-10-20', 'UK'),
(13, 'nu_crypto', 'nu@example.com', '2020-03-01', 'CN'),
(14, 'xi_data', 'xi@example.com', '2021-07-15', 'RU'),
(15, 'omicron_ai', 'omicron@example.com', '2023-01-20', 'IR');

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    plan_type VARCHAR(20), -- 'basic', 'pro', 'enterprise'
    start_date DATE,
    end_date DATE,
    monthly_amount DECIMAL(10,2)
);

INSERT INTO subscriptions VALUES
(1, 1, 'pro', '2022-01-01', '2023-12-31', 49.00),
(2, 1, 'enterprise', '2024-01-01', NULL, 199.00),
(3, 2, 'basic', '2022-08-01', '2023-08-01', 19.00),
(4, 2, 'pro', '2023-08-15', NULL, 49.00),
(5, 3, 'enterprise', '2020-02-01', NULL, 199.00),
(6, 4, 'basic', '2023-06-01', '2024-06-01', 19.00),
(7, 5, 'pro', '2023-01-01', NULL, 49.00),
(8, 6, 'basic', '2022-10-01', '2023-10-01', 19.00),
(9, 6, 'pro', '2023-10-15', NULL, 49.00),
(10, 7, 'basic', '2023-03-01', '2024-03-01', 19.00),
(11, 8, 'enterprise', '2020-07-01', NULL, 199.00),
(12, 9, 'pro', '2022-05-01', NULL, 49.00),
(13, 10, 'basic', '2022-01-01', '2023-01-01', 19.00),
(14, 11, 'pro', '2023-09-01', NULL, 49.00),
(15, 12, 'basic', '2023-01-01', '2024-01-01', 19.00),
(16, 1, 'basic', '2021-01-01', '2021-12-31', 19.00),
(17, 3, 'pro', '2019-01-01', '2019-12-31', 49.00);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    subscription_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(20) -- 'completed', 'failed', 'pending'
);

INSERT INTO payments VALUES
(1, 1, '2023-01-15', 49.00, 'completed'),
(2, 1, '2023-02-15', 49.00, 'completed'),
(3, 1, '2023-03-15', 49.00, 'failed'),
(4, 1, '2023-04-15', 49.00, 'completed'),
(5, 1, '2023-05-15', 49.00, 'completed'),
(6, 1, '2023-06-15', 49.00, 'failed'),
(7, 1, '2023-07-15', 49.00, 'failed'),
(8, 1, '2023-08-15', 49.00, 'completed'),
(9, 1, '2023-09-15', 49.00, 'completed'),
(10, 1, '2023-10-15', 49.00, 'completed'),
(11, 1, '2023-11-15', 49.00, 'failed'),
(12, 1, '2023-12-15', 49.00, 'completed'),
(13, 2, '2024-01-15', 199.00, 'completed'),
(14, 2, '2024-02-15', 199.00, 'completed'),
(15, 2, '2024-03-15', 199.00, 'failed'),
(16, 2, '2024-04-15', 199.00, 'failed'),
(17, 2, '2024-05-15', 199.00, 'failed'),
(18, 2, '2024-06-15', 199.00, 'completed'),
(19, 3, '2022-08-15', 19.00, 'completed'),
(20, 4, '2023-08-15', 49.00, 'completed'),
(21, 4, '2023-09-15', 49.00, 'failed'),
(22, 4, '2023-10-15', 49.00, 'failed'),
(23, 4, '2023-11-15', 49.00, 'failed'),
(24, 4, '2023-12-15', 49.00, 'completed'),
(25, 5, '2023-01-15', 199.00, 'completed'),
(26, 5, '2023-02-15', 199.00, 'completed'),
(27, 5, '2023-03-15', 199.00, 'completed'),
(28, 5, '2023-04-15', 199.00, 'completed'),
(29, 5, '2023-05-15', 199.00, 'completed'),
(30, 5, '2023-06-15', 199.00, 'completed'),
(31, 5, '2023-07-15', 199.00, 'completed'),
(32, 5, '2023-08-15', 199.00, 'completed'),
(33, 5, '2023-09-15', 199.00, 'completed'),
(34, 5, '2023-10-15', 199.00, 'completed'),
(35, 5, '2023-11-15', 199.00, 'completed'),
(36, 5, '2023-12-15', 199.00, 'completed'),
(37, 7, '2023-01-15', 49.00, 'completed'),
(38, 7, '2023-02-15', 49.00, 'failed'),
(39, 7, '2023-03-15', 49.00, 'failed'),
(40, 7, '2023-04-15', 49.00, 'failed'),
(41, 7, '2023-05-15', 49.00, 'completed'),
(42, 7, '2023-06-15', 49.00, 'completed'),
(43, 7, '2023-07-15', 49.00, 'completed'),
(44, 7, '2023-08-15', 49.00, 'completed'),
(45, 7, '2023-09-15', 49.00, 'completed'),
(46, 7, '2023-10-15', 49.00, 'completed'),
(47, 7, '2023-11-15', 49.00, 'failed'),
(48, 7, '2023-12-15', 49.00, 'failed'),
(49, 9, '2023-10-15', 49.00, 'completed'),
(50, 9, '2023-11-15', 49.00, 'failed'),
(51, 9, '2023-12-15', 49.00, 'failed'),
(52, 11, '2023-09-15', 49.00, 'completed'),
(53, 11, '2023-10-15', 49.00, 'failed'),
(54, 11, '2023-11-15', 49.00, 'failed'),
(55, 11, '2023-12-15', 49.00, 'failed'),
(56, 12, '2022-05-15', 49.00, 'completed'),
(57, 12, '2022-06-15', 49.00, 'completed'),
(58, 12, '2022-07-15', 49.00, 'failed'),
(59, 12, '2022-08-15', 49.00, 'completed'),
(60, 12, '2022-09-15', 49.00, 'failed');

#i used AI to create a dataset that i will use make and solve hundreds of exercices, 
# each of them contains a mix of all the concepts i learned thus far, so this will be
# both hard and the most fruitful learning experience i'l have, good practice.

#BATCH 1 OF OVER 270 INTERVIEW WORTHY EXERCISES:
#EXERCISE 1:
SELECT 
	name,
    email,
    phone,
    CASE
		WHEN email IS NOT NULL AND phone IS NULL THEN 'email_only'
        WHEN phone IS NOT NULL AND email IS NULL THEN 'phone_only'
        ELSE 'both'
	END AS contact_method
FROM customers
WHERE is_active = 1 AND country IN ('USA', 'UK', 'Canada')
ORDER BY name;

#EXERCISE 2:
SELECT 
	order_id,
    customer_id,
    order_date,
    amount,
	DATEDIFF((SELECT MAX(order_date) FROM orders), order_date) AS days_ago
FROM orders
WHERE
	status = 'completed'  
	AND order_date >= (SELECT MAX(order_date) FROM orders) - INTERVAL 90 DAY
ORDER BY days_ago;

#WITH CTE:
WITH max_order_date AS (
	SELECT MAX(order_date) AS latest_order
    FROM orders
)
SELECT
	o.order_id,
    o.customer_id,
    o.order_date,
    o.amount,
    DATEDIFF(m.latest_order, o.order_date) AS days_ago
FROM orders o
CROSS JOIN max_order_date m
WHERE 
	o.status = 'completed'
	AND o.order_date >= m.latest_order - INTERVAL 90 DAY
ORDER BY days_ago;
	
#EXERCISE 3:
SELECT 
	product_name,
    category
FROM products
WHERE category NOT IN ('Electronics', 'Gadgets')
	AND description NOT LIKE '%warranty%' 
    AND LEFT(product_name, 1) IN ('A', 'E', 'I', 'O','U')
ORDER BY product_name;

#EXERCISE 4:
SELECT
	e.name,
    e.department,
    e.salary,
    ROUND(e.salary - (
		SELECT AVG(salary) FROM employees 
		WHERE department = e.department), 2) AS above_avg_by 
FROM employees e
INNER JOIN departments d
ON e.department = d.dept_name
WHERE d.location IN ('New York', 'London')
	AND e.salary > (SELECT AVG(salary)
					FROM employees
                    WHERE department = e.department)
ORDER BY above_avg_by DESC;

#WITH CTE:
WITH dept_avg AS (
	SELECT 
		department,
		AVG(salary) AS avg_dept
    FROM employees
    GROUP BY department
)
SELECT 
	e.name,
    e.department,
    e.salary,
    ROUND(e.salary - a.avg_dept, 2) AS above_avg_by
FROM employees e
INNER JOIN dept_avg a
	ON e.department = a.department
INNER JOIN departments d 
	ON e.department = d.dept_name
WHERE d.location IN ('New York', 'London')
	AND e.salary > a.avg_dept
ORDER BY above_avg_by DESC;

#EXERCISE 5
SELECT
	transaction_id,
    account_id,
    transaction_type,
    amount,
    CASE
		WHEN amount > 20000 THEN 'High'
        WHEN amount > 10000 THEN 'Medium'
        ELSE 'Low'
	END AS risk_level
FROM transactions
WHERE 
	(transaction_type = 'transfer' AND amount > 10000) 
    OR 
	(transaction_type = 'debit' AND amount > 5000 AND 
     transaction_date >= (
		SELECT MAX(transaction_date) FROM transactions) - INTERVAL 30 DAY
	)
ORDER BY amount DESC;
	
#EXERCISE 6
SELECT 
	e.name,
    e.salary,
    m.name AS manager_name,
    m.salary AS manager_salary,
    e.salary - m.salary AS salary_diff
FROM employees e
JOIN employees m
	ON e.manager_id = m.employee_id
WHERE e.salary >= m.salary
ORDER BY salary_diff;

#EXERCISE 7
SELECT q1.product_id, 'New_In_Q1' AS status
FROM q1_sales q1
LEFT JOIN q2_sales q2
	ON q1.product_id = q2.product_id
WHERE q2.product_id IS NULL
UNION ALL
SELECT q1.product_id, 'Doubled' AS status
FROM q1_sales q1
INNER JOIN q2_sales q2 
	ON q1.product_id = q2.product_id
WHERE q2.amount >= q1.amount * 2;


SELECT product_id, 'New_In_Q1' AS status
FROM (
    SELECT product_id FROM q1_sales
    EXCEPT
    SELECT product_id FROM q2_sales
) AS exception_results

UNION ALL

SELECT product_id, 'Doubled' AS status
FROM (
    SELECT product_id FROM q1_sales
    INTERSECT
    SELECT product_id FROM q2_sales q2
    WHERE q2.amount >= (
        SELECT MIN(q1.amount) * 2 #we use min() to return a scalar value so it doesnt crash
        FROM q1_sales q1 
        WHERE q1.product_id = q2.product_id
    )
) AS intersection_results;

#EXERCISE 8 
SELECT *
FROM (
	SELECT 
		salesperson_id,
		sale_date,
		amount,
		ROW_NUMBER() OVER (PARTITION BY salesperson_id ORDER BY amount DESC) AS rank_in_year
	FROM sales
	WHERE sale_date >= '2023-01-01' AND sale_date <= '2023-12-31'
    ) AS t WHERE rank_in_year = 1
ORDER BY amount DESC;

#EXERCISE 9
SELECT
	user_id,
    session_id,
    ROUND(TIMESTAMPDIFF(SECOND, first_pricing, first_checkout) /60.0 , 2) AS time_to_checkout
FROM (
	SELECT 
		user_id,
		session_id,
		MIN(CASE WHEN page_url = '/pricing' THEN visit_time END) AS first_pricing,
		MIN(CASE WHEN page_url = '/checkout' THEN  visit_time END) AS first_checkout,
        MIN(CASE WHEN page_url = '/success' THEN visit_time END) AS success_visit
	FROM website_visits
	GROUP BY user_id, session_id
    ) AS t 
WHERE first_pricing IS NOT NULL 
	AND first_checkout IS NOT NULL 
    AND success_visit IS NULL
ORDER BY time_to_checkout;

#WITH CTE
WITH session_timestamps AS (
	SELECT 
		user_id,
        session_id,
        MIN(CASE WHEN page_url = '/pricing' THEN visit_time END) AS first_pricing,
        MIN(CASE WHEN page_url = '/checkout' THEN visit_time END) AS first_checkout,
        MIN(CASE WHEN page_url = '/success' THEN visit_time END) AS success_visit
	FROM website_visits
	GROUP BY user_id, session_id
)
SELECT 
	user_id,
    session_id,
    ROUND(TIMESTAMPDIFF(SECOND, first_pricing, first_checkout) / 60.0, 2) AS time_to_checkout
FROM session_timestamps
WHERE first_pricing IS NOT NULL
	AND first_checkout IS NOT NULL
    AND success_visit IS NULL
ORDER BY time_to_checkout ASC;

# EXTRA EXERCISE with 6 solutions
# SOLUTION 1
WITH active_parents AS (
	SELECT parent_id, status FROM parent_child_status
	WHERE status = 'Active'
	GROUP BY parent_id
),
inactive_parents AS (
	SELECT parent_id, status 
    FROM parent_child_status a
    WHERE a.parent_id NOT IN (SELECT parent_id FROM active_parents)
    #the NOT IN approach breaks and returns nothing if even a single null value 
    #is returned from the subquery here, NOT EXISTS is a better approach %90 of the time
)
SELECT * FROM active_parents
UNION 
SELECT * FROM inactive_parents
order by parent_id;

#SOLUTION 2
SELECT 
	parent_id,
    status
FROM (
	SELECT 
		parent_id,
        status,
		ROW_NUMBER() OVER (PARTITION BY parent_id ORDER BY status) AS rn
	FROM parent_child_status
) WHERE rn = 1;

#SOLUTION 3 (SAME AS 2 BUT CLEANER AS WE PUT IT IN A CTE) 
WITH parent_status AS (
	SELECT 
		parent_id,
		status,
        ROW_NUMBER() OVER (PARTITION BY parent_id ORDER BY status) AS rn 
	FROM parent_child_status
)
SELECT parent_id, status FROM parent_status
WHERE rn = 1;

#SOLUTION 4
SELECT 
	a.parent_id,
    CASE WHEN b.status IS NULL THEN 'Inactive' ELSE b.status END AS status
#the case statemnt is creating another temp column status, same name as the already
#existing status column, so dont get confused and think this case statement is insering
# its result value into the physical status column. no, its just creating another 
# temp result column with the same exact, but showing the results we wanted. another
# good use of case statements too.
FROM (SELECT DISTINCT parent_id FROM parent_child_status) a 
LEFT JOIN ( SELECT DISTINCT parent_id, status 
			FROM parent_child_status
			WHERE status = 'Active') b
			ON a.parent_id = b.parent_id
ORDER BY a.parent_id;

#SOLUTION 5
SELECT DISTINCT parent_id, status
FROM parent_child_status 
WHERE status = 'Active' 

UNION 
# BTW WE DONT NEED DISTINCT ANYMORE SINCE WE ARE USING UNION, IT REMOVE DUPES ANYWAY
# BUT U NEED THEM IF U DECIDE TO USE UNION ALL. I JUST KEPT THEM HERE FOR THE SAKE OF THIS NOTE 
SELECT DISTINCT parent_id, status
FROM parent_child_status a
WHERE LOWER(status) = 'inactive'
AND NOT EXISTS (SELECT 1 FROM parent_child_status b
						  WHERE b.status = 'Active'
                          AND a.parent_id = b.parent_id)
ORDER BY parent_id;

#SOLUTION 6, THE SIMPLIST ONE
SELECT parent_id, MIN(status) AS status
FROM parent_child_status
GROUP BY parent_id
ORDER BY parent_id;

#EXERCISE 10 
SELECT 
	order_id,
    COUNT(product_id) AS product_count,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(unit_price * quantity), 2) AS total_amount,
    ROUND(AVG(unit_price), 2) AS avg_unit_price
FROM order_items
GROUP BY order_id
HAVING COUNT(product_id) >= 3 
	AND SUM(quantity) >= 10
    AND AVG(unit_price) BETWEEN 50 AND 200
ORDER BY total_amount DESC;

#EXERCISE 11 
WITH overlap AS (
    SELECT 
        event_id,
        event_name,
        start_time,
        end_time,
        DAYOFWEEK(start_time) AS start_day,
        DAYOFWEEK(end_time)   AS end_day,
        DATEDIFF(end_time, start_time) AS days_spanned
    FROM events
)
SELECT 
    event_id,
    event_name,
    CASE 
        -- Rule 1: Starts on Saturday and spans to Sunday (2 days)
        WHEN start_day = 7 AND days_spanned >= 1 THEN 2
        -- Rule 2: Touches a single weekend day (Starts or ends on a weekend)
        WHEN start_day IN (1, 7) OR end_day IN (1, 7) THEN 1
        -- Rule 3: Spans over a weekend (e.g., Friday to Monday)
        WHEN start_day = 6 AND days_spanned >= 2 THEN 2 -- Friday to Sunday/Monday
        WHEN start_day = 5 AND days_spanned >= 3 THEN 2 -- Thursday to Sunday
        ELSE 0 
    END AS weekend_days
FROM overlap
ORDER BY weekend_days DESC, event_id ASC;

#EXERCISE 12
WITH formatting AS (
	SELECT
		log_id,
		REGEXP_SUBSTR(log_message, 'ERR-[0-9]{4}') AS error_code,
#i initialy did log_message as error code bc i wasnt that familiar with regex and relied
#on the LIKE keyword, but i can only use it in where clause, this an easy exercise if
#i learned more regex on mysql. but overall everything else is correct
		LEFT(log_message, 100) AS log_message,
		created_at
	FROM logs
)
SELECT * FROM formatting
WHERE created_at >= (
		SELECT MAX(created_at) - INTERVAL 7 DAY 
		FROM logs)
    AND error_code IS NOT NULL
ORDER BY created_at DESC;
    
#EXERCISE 13
SELECT *
FROM(
    SELECT 
		student_id,
		name,
		enrollment_date,
		DATEDIFF((SELECT MAX(enrollment_date) FROM students), enrollment_date) AS days_since_enrollment
	FROM students
) AS student_info 
WHERE days_since_enrollment > 180
AND  NOT EXISTS (
	SELECT 1 FROM enrollments 
    WHERE completion_date IS NOT NULL
    AND enrollments.student_id = student_info.student_id);
    
#EXERCISE 14
DROP TEMPORARY TABLE IF EXISTS low_stock_alerts;
CREATE TEMPORARY TABLE low_stock_alerts AS (
SELECT 
    product_id,
    SUM(quantity) AS total_quantity,
    MAX(CASE WHEN quantity = 0 THEN warehouse_id END) AS zero_stock_warehouse_id
    #MAX to ignore the nulls from the other rows
FROM inventory
GROUP BY product_id
HAVING SUM(quantity) < 100 
    OR MIN(quantity) = 0
);
SELECT zw.product_id, zw.total_quantity, zw.zero_stock_warehouse_id
FROM low_stock_alerts zw
JOIN warehouses w
	ON zw.zero_stock_warehouse_id = w.warehouse_id
WHERE LEFT(w.city, 1) BETWEEN 'A' AND 'M' #or WHERE city REGEXP '^[A-M]'
;
#EXERCISE 15
WITH system_anchors AS (
#THIS CTE IS TO ESTABLISH THE MAX DATE OF RELEVANT DATES THAT WE'RE GONNA DO CALCULATION
# ON, because this is a historical data we cant use current date so we make a cte of 
# max dates that we can use to calculate dates
    -- Establish the latest timeline points across the dataset
    SELECT 
        (SELECT MAX(created_at) FROM users) AS latest_user_date,
        (SELECT MAX(payment_date) FROM payments) AS latest_payment_date
),
active_users AS (
    SELECT
        u.user_id,
        u.username,
        u.country,
        u.created_at,
        s.plan_type AS current_plan_type
    FROM users u
    JOIN subscriptions s ON u.user_id = s.user_id
    CROSS JOIN system_anchors sa
    -- Active relative to the latest payment date in our data
    WHERE s.end_date IS NULL OR s.end_date > sa.latest_payment_date
),
payment_metrics AS (
    SELECT 
        s.user_id,
        SUM(CASE WHEN p.status = 'completed' THEN p.amount ELSE 0 END) AS lifetime_completed_amount,
        -- Measures 90 days backwards from the absolute latest payment recorded in the data
        COUNT(CASE WHEN p.status = 'failed' AND p.payment_date >= DATE_SUB(sa.latest_payment_date, INTERVAL 90 DAY) THEN 1 END) AS failed_payments_count_90d
    FROM subscriptions s
    JOIN payments p ON s.subscription_id = p.subscription_id
    CROSS JOIN system_anchors sa
    GROUP BY s.user_id, sa.latest_payment_date
)
SELECT 
    a.user_id,
    a.username,
    a.country,
    a.current_plan_type,
    p.lifetime_completed_amount,
    p.failed_payments_count_90d,
    CASE 
        WHEN p.failed_payments_count_90d >= 3 THEN 'churn_risk' 
        ELSE 'attention_needed'
    END AS risk_status
FROM active_users a
JOIN payment_metrics p ON a.user_id = p.user_id
CROSS JOIN system_anchors sa
WHERE 
    a.created_at < DATE_SUB(sa.latest_user_date, INTERVAL 1 YEAR)
    AND p.failed_payments_count_90d >= 2
    AND p.lifetime_completed_amount >= 500
    AND a.country NOT IN ('CN', 'RU', 'IR')
ORDER BY p.lifetime_completed_amount DESC;

#BATCH 2 OF OVER 270 INTERVIEW WORTHY EXERCISES:
#EXERCISE 1

