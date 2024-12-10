create database lab10;

create table books (
    book_id serial primary key,
    title varchar,
    author varchar,
    price decimal(10, 2),
    quantity int
);

create table orders (
    order_id serial primary key,
    book_id int references books(book_id),
    customer_id int,
    order_date date,
    quantity int
);

create table customers (
    customer_id serial primary key,
    name varchar,
    email varchar
);

insert into books (book_id, title, author, price, quantity) values
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

insert into customers (customer_id, name, email) values
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

--1
begin;
insert into orders (book_id, customer_id, order_date, quantity)
values (1, 101, current_date, 2);
update books
set quantity = quantity - 2
where book_id = 1;
commit;

begin;
select * from books;
commit;

--2
rollback;

begin;
insert into orders (order_id, book_id, customer_id, order_date, quantity)
values (1002, 3, 102, current_date, 10);
select quantity from books where book_id = 3;
rollback;

begin;
select * from orders;
commit;

--3
--S1
begin;
set transaction isolation level read committed;
update books
set price = 38.00
where book_id = 2;


commit;

--S2
begin;
set transaction isolation level read committed;
select price from books where book_id = 2;


select price from books where book_id = 2;
commit;

--4
begin;
update customers
set email = 'john_new@example.com'
where customer_id = 101;
commit;

select email from customers where customer_id = 101;