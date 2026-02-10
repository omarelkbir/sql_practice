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


