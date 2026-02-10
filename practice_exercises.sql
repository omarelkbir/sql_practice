
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




































































