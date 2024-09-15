CREATE database lab1;

CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50)
);

ALTER TABLE users
ADD COLUMN isadmin INTEGER;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN
USING isadmin::boolean;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT false;

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INTEGER,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);

--DROP table tasks;
--DROP database lab1;