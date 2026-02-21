
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

# 10 exercises covering Data Manipulation Language (DML):

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

