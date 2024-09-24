CREATE DATABASE lab2;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(255),
    region_id INT,
    population INT
);

INSERT INTO countries (country_name, region_id, population)
VALUES ('Russia', 1, 144500000);

INSERT INTO countries (country_name)
VALUES ('USA');

INSERT INTO countries (country_name, region_id, population)
VALUES ('Canada', NULL, 37000000);


INSERT INTO countries (country_name, region_id, population)
VALUES
    ('Germany', 3, 83000000),
    ('France', 2, 67000000),
    ('Japan', 5, 126000000);

ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries (region_id, population)
VALUES (4, 19000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new (LIKE countries INCLUDING ALL);

INSERT INTO countries_new SELECT * FROM countries;

UPDATE countries
SET region_id = 1
WHERE region_id IS NULL;

SELECT country_name,
       population * 1.1 AS "New Population"
FROM countries;

DELETE FROM countries
WHERE population < 100000000
RETURNING *;

DELETE FROM countries
RETURNING *;




