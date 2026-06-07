# this is notes from the 30 hours sql tut
/* this is a multi line comment /* to open and  to close it */
-- this is also a comment. we have 3 in mysql
/* sorting with multiple columns only makes sense if theres repitition in the column,
for reference check the task with orderby country then score in the early tasks.
- if u alias a column in a query, it will only be aliased in THAT query, if u try to 
use it's aliased name in a different query, it will error.
- DATA DEFINITION LANGUAGE (DDL) has CREATE,ALTER,DROP. u can add columns or drop them
using ALTER or DROP respectively, but to insert new data like rows, u need
DATA MANIPULATION LANGUAGE(DML) which u can use insert to insert rows/values.
btw it has INSERT,UPDATE,DELETE 
-SELECT * FROM customers WHERE id = 10;this is good practice before executing the update
command to see which rows will be affected, here it is only row 20 which is what we want.
so we can feel confident and execute the update command bc if not filtered correctly,
all rows will be updated.
-if u want to delete everything from a table, use TRUNCATE TABLE persons instead of
DELETE FROM persons, DELETE has a lot of stuff happening in the background, while 
truncate skips all those extra steps and is way faster. 
-Need to change something?
    │
    ├── Change TABLE STRUCTURE? (columns, types, defaults)
    │       └── Use ALTER TABLE (DDL)
    │           ├── Add column → ALTER TABLE ... ADD COLUMN
    │           ├── Change type → ALTER TABLE ... MODIFY
    │           └── Remove table → DROP TABLE
    │
    └── Change DATA VALUES? (rows, records)
            └── Use UPDATE (DML)
                ├── Change prices → UPDATE ... SET price = ...
                ├── Fix names → UPDATE ... SET name = ...
                └── Delete rows → DELETE FROM ...

- INNER JOIN or just JOIN returns the matching data from both tables
- LEFT JOIN returns all the rows from the left table and only the matching rows from the
right table
- RIGHT JOIN returns all the rows from the right table and only the matching rows from the
left table
- FULL JOIN or (LEFT JOIN UNION RIGHT JOIN) or (LEFT JOIN UNION LEFT JOIN but switch the order)
returns EVERYTHING, literally both tables, now for mysql there is no FULL JOIN syntax
so we use the union method
- LEFT ANTI JOIN return rows from the left table that has no match in the right table
 the syntax for this is using a left join with a WHERE clause that says the B table's
 id column (or the column we combined tables on) IS NULL. ex: WHERE b.id IS NULL;
 - RIGHT ANTI JOIN same thing but switch it up ex: WHERE a.id IS NULL; basically, the
 column u put in the where clause belongs to the table that is not the primary one
 - FULL ANTI JOIN returns only rows that dont match in either table
 - CROSS JOIN combines every row from the left with every row from the right, so u can 
 essentially see every possible combination.
 
- RULES OF SET OPERATORS
#1 ORDER BY can be used only in the last query 
#2 Same Number of Columns
#3 Matching Data Types
#4 Same Order of Columns
#5 First Query Controls Aliases
#6 Mapping Correct Columns

- UNION : returns all rows from both table exclusing duplicates
- UNION ALL : returns all rows from both table including duplicates
- EXCEPT : return only distinct rows in first table with no matches from the second table
- INTERSECT : returns common rows between 2 tables, with no duplicates
only union all allows duplicates

- TRIM() function removes all leading and trailing white space

-keywords that are not fully compatible with mysql that i should for a more mysql 
replacement for: except, length, intersect, 

-LEFT(value, number_of_characters) for example: LEFT('maria', 2) is 'ma', first 2 chars
-RIGHT(value, number_of_characters) for example: RIGHT('maria', 2) is 'ia', last 2 chars
- SUBSTRING OR MID, SUBSTRING(value, start, length) for example: 
SUBSTRING('maria', 3, 2) is 'ri', a portion specified by a start and a length of the portion
they also use SUBSTRING('maria', 3, length(firt_name)) to retrieve whatever remains,
even if there is only 3 chars left after the start, it will work fine even if u did 20 not 3

-| Task                      | Functions/Syntax                                            |
| :------------------------ | :---------------------------------------------------------- |
| Get current datetime      | `NOW()`                                                     |
| Get today                 | `CURDATE()`                                                 |
| Get time now              | `CURTIME()`                                                 |
| Extract year/month/day    | `YEAR()`, `MONTH()`, `DAY()`                                |
| Format for display        | `DATE_FORMAT(date, '%Y-%m-%d')`                             |
| Parse string to date      | `STR_TO_DATE('15-03-2024', '%d-%m-%Y')`                     |
| Add days                  | `DATE_ADD(date, INTERVAL 5 DAY)` or `date + INTERVAL 5 DAY` |
| Subtract months           | `DATE_SUB(date, INTERVAL 3 MONTH)`                          |
| Days between dates        | `DATEDIFF(end_date, start_date)`                            |
| Years/months between      | `TIMESTAMPDIFF(YEAR, start, end)`                           |
| Last day of month         | `LAST_DAY(date)`                                            |
| Remove time from datetime | `DATE(datetime)`                                            |


- aliases can be used in the select clause (obviously to define them), and also in
the HAVING clause but only in MYSQL, in other dbms u have to write the whole function
time and time again, so it's best practice to just avoid using aliases in having too
to get used to it in case i pick up other dbms alongside mysql.

- dont use a date name like a month name or day of the week etc to search and filter 
data, use integers instead as it's way faster. for example u want to know how many orders
were in 'February', dont do WHERE month = 'February', search/filter using integers.

-concat can basically have unlimited arguments u can add, like this: 
-- Two arguments
SELECT CONCAT('Hello', ' World');  -- Hello World
-- Five arguments  
SELECT CONCAT('A', 'B', 'C', 'D', 'E');  -- ABCDE
-- Many arguments 
SELECT CONCAT(
  'Day ',
  'Wed ',
  'Jan ',
  'Q1 ',
  '2025 ',
  '21:43:56 ',
  'PM');
i also learned u can use CONCAT_WS (concat with seperator) if u want to add many 
arguments and they all have the same seperator, for example :
-- Instead of adding spaces manually:
SELECT CONCAT(first_name, ' ', last_name, ' ', email);  
-- Use CONCAT_WS:
SELECT CONCAT_WS(' ', first_name, last_name, email); 
but if u have any null value in the concat arguments, the whole result will be null
so be careful or just use coalesque alongside concat to handle potential nulls.

#TIMESTAMPDIFF(unit, start_date, end_date)
--              ↑      ↑           ↑
--           YEAR   birthdate   CURDATE()
#It calculates: end_date - start_date

COUNT(*)	Counts ALL rows, including NULLs
COUNT(column)	Counts only non-NULL values in that column
SUM(column)	Ignores NULLs (treats as 0 effectively)
AVG(column)	Ignores NULLs in count AND sum
MAX(column)	Ignores NULLs
MIN(column)	Ignores NULLs

-- Average salary (ignores NULL salaries if any)
SELECT AVG(salary) FROM employees;
-- Average with IFNULL (treats NULL as 0, lowering average)
SELECT AVG(IFNULL(salary, 0)) FROM employees;

#CASE is an expression that returns a single value.
#It can go anywhere a single value is expected:
#SELECT, WHERE, ORDER BY, GROUP BY, HAVING, or inside functions.
#You cannot put CASE as a standalone clause (like SELECT ... CASE ... FROM —
#it must be inside SELECT, not between SELECT and FROM).

#there is simple CASE and searched CASE, simple when u want to compare equality
# using '=' sign, and searched when more complex, like '< > <= >= AND OR etc'
# in the simple CASE u can do CASE column_name WHEN value THEN  value. like example above

# ROW_NUMBER doesnt handle ties in values, for example:
# 80 and 80 would get the rank 1 and 2 not 1 and 1. also it does not leave gaps in ranking.
# meanwhile RANK handles ties. but it does leave gaps
# dense_rank handles ties but does not leave gaps in ranking.

ROW_NUMBER USE CASES
#1 Top-N Analysis
#2 Bottom-N Analysis
#3 Assign unique IDs
#4 Quality Checks: Identify Duplicates

 ABS(CAST(dept_salary_rank AS SIGNED) - CAST(dept_perf_rank AS SIGNED)) AS consistency_score
# we did cast here bc DENSE_RANK returns an unsigned value and when doing subtraction 
# on them and the result is negative, then it will cause an error. so we cast them
# to a different data type, like SIGNED to fix that issue.

#ABS(CAST(dept_salary_rank AS SIGNED) - CAST(dept_perf_rank AS SIGNED)) AS consistency_score
# we did cast here bc DENSE_RANK returns an unsigned value and when doing subtraction 
# on them and the result is negative, then it will cause an error. so we cast them
# to a different data type, like SIGNED to fix that issue.

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


)t ON c.customerid = t.customerid;
    # = t.customerid not o.customerid because orders o is inside the subquery and the
    # ON part is outside the subquery so it doesnt work, so its t.customerid not o.
    # or u can just name the subquery o as in orders haha, so it's more logical
	# now we have customerid twice so we select everything from main query and only 
    # total orders from subquery

#Never use SELECT * in production queries. Always list the columns you actually need
#for example using it here caused having 2 customerid columns in the result table
#u can use USING(customerid), it auto solves duplicate columns issue at the result table

#I've realized, there is usually many ways to solve an sql problem
#this one for example was easier using window functions, so i decided that for every
#exercise from now on, i will solve it with all the methods possible, wether subqueries
#window functions or regular sql. its to hone my skills and not forget something while 
#learning something else, for example i forgot a lot abt window functions