# sql-dbms-example
The `creating.sql` contains DDL queries that create the tables in a database.

The `functions.sql` contains the function that calculates total amount of order.

The `procedures.sql` contains procedures that create new orders and add items to the specified order

The `triggers.sql` contains triggers that update order total amount when new item is added and add new orders to log table.

The `test_script.sql` contains the test case script for all the functions, procedures, and triggers.

The `answers.md` contains answers to the questions from homework assignment.

The `explain_analyze_result_export.csv` is the output of `EXPLAIN ANALYZE`. SQL first conducts a sequential scan on the whole table `order_items` and filters them by `WHERE` clause. Next, it utilizes index to primary key of products table in order to find all the necessary values from products table by index referenced in `order_items.product_id`. In the end, the evaluated cost of execution is written as well as planning time and actual execution time.