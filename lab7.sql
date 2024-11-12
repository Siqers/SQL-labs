CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO countries (name) VALUES
('USA'),
('Germany'),
('France'),
('India'),
('Russia');

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    department_id INT NOT NULL
);

INSERT INTO employees (name, surname, salary, department_id) VALUES
('John', 'Doe', 5000.00, 1),
('Jane', 'Smith', 6000.00, 2),
('Alice', 'Johnson', 7000.00, 1),
('Bob', 'Brown', 8000.00, 3),
('Charlie', 'Davis', 9000.00, 2);

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    department_id INT UNIQUE,
    budget NUMERIC(10, 2) NOT NULL
);

INSERT INTO departments (department_id, budget) VALUES
(1, 100000.00),
(2, 200000.00),
(3, 300000.00);

CREATE INDEX index_name ON countries (name);
SELECT * FROM countries WHERE name = 'Germany';
DROP INDEX index_name;

CREATE INDEX index_surname_name ON employees (name, surname);
SELECT * FROM employees WHERE name = 'John' AND surname = 'Doe';
DROP INDEX index_surname_name;

CREATE UNIQUE INDEX index_salary ON employees (salary);
SELECT * FROM employees WHERE salary < 8000 AND salary > 5000;
DROP INDEX index_salary;

CREATE INDEX employees_substr_name_idx
    ON employees ((substring(name FROM 1 FOR 4)));
SELECT * FROM employees
    WHERE substring(name FROM 1 FOR 4) = 'John';
DROP INDEX employees_substr_name_idx;

CREATE INDEX employees_department_salary_idx ON employees (department_id, salary);
CREATE INDEX departments_department_budget_idx ON departments (department_id, budget);

SELECT * FROM employees e
JOIN departments d
ON d.department_id = e.department_id
WHERE d.budget > 150000 AND e.salary < 8000;

DROP INDEX employees_department_salary_idx;
DROP INDEX departments_department_budget_idx;
