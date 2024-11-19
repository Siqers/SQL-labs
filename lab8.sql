--task1
CREATE DATABASE lab8;

--task2
CREATE TABLE salesman(
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(5, 2)
);

CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    cust_name   VARCHAR(50),
    city        VARCHAR(50),
    grade       INT,
    salesman_id INT REFERENCES salesman (salesman_id)
)

CREATE TABLE orders(
    ord_no SERIAL PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
)

INSERT INTO salesman VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', NULL, 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers VALUES
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES (70001, 150.50, '2012-10-05', 3005, 5002),
       (70009, 270.65, '2012-09-10', 3001, 5005),
       (70002, 65.26, '2012-10-05', 3002, 5001),
       (70004, 110.50, '2012-08-17', 3009, 5003),
       (70007, 948.50, '2012-09-10', 3005, 5002),
       (70005, 2400.60, '2012-07-27', 3007, 5001),
       (70008, 5760.00, '2012-09-10', 3002, 5001);

--task3
CREATE ROLE junior_dev LOGIN;

--task4
CREATE VIEW new_york_salesmen AS
SELECT * FROM salesman
WHERE  city = 'New York';

--task5
CREATE VIEW ord_details AS
SELECT
    o.ord_no,
    o.purch_amt,
    o.ord_date,
    s.name AS cust_name,
    s.name AS name
FROM
    orders o
JOIN
    customers c ON o.customer_id = c. customer_id
JOIN
    salesman s ON o.salesman_id  = s.salesman_id;
GRANT ALL PRIVILEGES ON ord_details TO junior_dev;

--task6
CREATE VIEW high_grade_cust AS
SELECT * FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON high_grade_cust TO junior_dev;

--task7
CREATE VIEW salesman_count_each_city AS
SELECT
    city,
    COUNT(salesman_id) AS salesman_count
FROM salesman GROUP BY city;

--task8
CREATE VIEW salesman_multiple_cust AS
SELECT
    s.salesman_id,
    s.name AS name,
    COUNT(c.customer_id) AS cust_count
FROM salesman s
JOIN
    customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(c.customer_id) > 1;

--task9
CREATE ROLE intern;
GRANT junior_dev TO intern;