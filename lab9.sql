-- Создание таблицы employees
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    salary DECIMAL
);

-- Создание таблицы categories
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Создание таблицы products
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Task 1: Increase Value by 10
CREATE OR REPLACE FUNCTION increase_value(input INT)
RETURNS INT AS $$
BEGIN
    RETURN input + 10;
END;
$$ LANGUAGE plpgsql;

-- Task 2: Compare Two Numbers and Return 'Greater', 'Equal', or 'Lesser'
CREATE OR REPLACE FUNCTION compare_numbers(num1 INT, num2 INT)
RETURNS TEXT AS $$
DECLARE
    result TEXT;
BEGIN
    IF num1 > num2 THEN
        result := 'Greater';
    ELSIF num1 = num2 THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Task 3: Generate Number Series from 1 to n
CREATE OR REPLACE FUNCTION number_series(n INT)
RETURNS TABLE(series INT) AS $$
DECLARE
    i INT := 1;
BEGIN
    WHILE i <= n LOOP
        RETURN NEXT i;
        i := i + 1;
    END LOOP;
    RETURN;
END;
$$ LANGUAGE plpgsql;

-- Task 4: Find Employee by Name
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(id INT, name VARCHAR, position VARCHAR, salary DECIMAL) AS $$
BEGIN
    RETURN QUERY
    SELECT e.id, e.name, e.position, e.salary
    FROM employees e
    WHERE e.name = emp_name;
END;
$$ LANGUAGE plpgsql;

-- Task 5: List Products by Category
CREATE OR REPLACE FUNCTION list_products(category_id INT)
RETURNS TABLE(id INT, name VARCHAR, price DECIMAL) AS $$
BEGIN
    RETURN QUERY
    SELECT p.id, p.name, p.price
    FROM products p
    WHERE p.category_id = category_id;
END;
$$ LANGUAGE plpgsql;

-- Task 6: Calculate Bonus and Update Salary
-- Procedure to calculate bonus
CREATE OR REPLACE FUNCTION calculate_bonus(salary DECIMAL)
RETURNS DECIMAL AS $$
BEGIN
    RETURN salary * 0.10;  -- Example: 10% bonus
END;
$$ LANGUAGE plpgsql;

-- Procedure to update salary using the bonus
CREATE OR REPLACE FUNCTION update_salary(employee_id INT)
RETURNS VOID AS $$
DECLARE
    current_salary DECIMAL;
    bonus DECIMAL;
BEGIN
    -- Get current salary of the employee
    SELECT salary INTO current_salary FROM employees WHERE id = employee_id;

    -- Calculate the bonus
    bonus := calculate_bonus(current_salary);

    -- Update the salary with the bonus
    UPDATE employees SET salary = current_salary + bonus WHERE id = employee_id;
END;
$$ LANGUAGE plpgsql;

-- Task 7: Complex Calculation Procedure with Nested Subblocks
CREATE OR REPLACE FUNCTION complex_calculation(input_text VARCHAR, num1 INT, num2 INT)
RETURNS VARCHAR AS $$
DECLARE
    -- Subblock 1: String manipulation
    manipulated_text VARCHAR;

    -- Subblock 2: Numeric computation
    numeric_result INT;

    -- Final result
    final_result VARCHAR;
BEGIN
    -- Subblock 1: String manipulation
    manipulated_text := UPPER(input_text);  -- Converts input text to uppercase

    -- Subblock 2: Numeric computation
    numeric_result := num1 + num2;  -- Sums the two numeric values

    -- Main block: Combine the results from both subblocks
    final_result := manipulated_text || ' | Computed Sum: ' || numeric_result;

    -- Return the final combined result
    RETURN final_result;
END;
$$ LANGUAGE plpgsql;

