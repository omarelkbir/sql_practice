
# Exercises 1 - 10:

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





































































































