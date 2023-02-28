-- Exercise 1

CREATE TABLE orders
	(orderId INT,
	date DATE,
	customerId INT,
	customerName VARCHAR(15),
	city VARCHAR(15),
	itemId INT,
	itemName VARCHAR(15),
	quantity INT,
	price REAL,
	PRIMARY KEY (orderId, customerId, itemId)
	);

INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '3786', 'Net', '3', '35.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '4011', 'Racket', '6', '65.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '9132', 'Pack-3', '8', '4.75');
INSERT INTO orders VALUES ('2302', '2012-02-25', '107', 'Herman', 'Madrid', '5794', 'Pack-6', '4', '5.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '4011', 'Racket', '2', '65.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '3141', 'Cover', '2', '10.00');

-- 1NF

CREATE TABLE orders
 (orderId INT,
 date DATE,
 customerId INT,
 customerName VARCHAR(15),
 city VARCHAR(15),
 itemId INT,
 itemName VARCHAR(15),
 quantity INT,
 price REAL,
 PRIMARY KEY (orderId, customerId, itemId)
 );

INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '3786', 'Net', '3', '35.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '4011', 'Racket', '6', '65.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '9132', 'Pack-3', '8', '4.75');
INSERT INTO orders VALUES ('2302', '2012-02-25', '107', 'Herman', 'Madrid', '5794', 'Pack-6', '4', '5.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '4011', 'Racket', '2', '65.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '3141', 'Cover', '2', '10.00');

-- Queries: 
--1 Calculate the total number of items per order and the total amount to pay for the order
SELECT orderId, SUM(quantity) AS total_items, SUM(quantity * price) AS total_amount
FROM orders
GROUP BY orderId;

-- 2- Obtain the customer whose purchase in terms of money has been greater than the others
SELECT customerId, customerName, SUM(quantity * price) AS total_spent
FROM orders
GROUP BY customerId, customerName
ORDER BY total_spent DESC
LIMIT 1;

--NF2 and NF3 they have the same tables with same queries solutions:

CREATE TABLE order_item (
 orderId INT,
 itemId INT,
 quantity INT,
 PRIMARY KEY (orderId, itemID)
);

INSERT INTO order_item VALUES ('2301', '3786', '3');
INSERT INTO order_item VALUES ('2301', '4011', '6');
INSERT INTO order_item VALUES ('2301', '9132', '8');
INSERT INTO order_item VALUES ('2302', '5794', '4');
INSERT INTO order_item VALUES ('2303', '4011', '2');
INSERT INTO order_item VALUES ('2303', '3141', '2');
 
CREATE TABLE item_price(
 itemId INT,
 itemName VARCHAR(15),
 price REAL,
 PRIMARY KEY (itemID)
);

INSERT INTO item_price VALUES ('3786', 'Net', '35.00');
INSERT INTO item_price VALUES ('4011', 'Racket', '65.00');
INSERT INTO item_price VALUES ('9132', 'Pack-3', '4.75');
INSERT INTO item_price VALUES ('5794', 'Pack-6', '5.00');
INSERT INTO item_price VALUES ('3141', 'Cover', '10.00');
 
CREATE TABLE customer_city (
 customerId INT,
 customerName VARCHAR(15),
 city VARCHAR(15),
 PRIMARY KEY (customerId)
);

INSERT INTO customer_city VALUES ('101', 'Martin', 'Prague');
INSERT INTO customer_city VALUES ('107', 'Herman', 'Madrid');
INSERT INTO customer_city VALUES ('110', 'Pedro', 'Moscow');
 
CREATE TABLE order_customer (
 orderId INT,
 customerId INT,
 date DATE,
 PRIMARY KEY(orderId)
);

INSERT INTO order_customer VALUES ('2301', '101', '2011-02-23');
INSERT INTO order_customer VALUES ('2302', '107', '2011-02-25');
INSERT INTO order_customer VALUES ('2303', '110', '2011-02-27');

-- Queries: 
--1 Calculate the total number of items per order and the total amount to pay for the order
SELECT oi.orderId, SUM(oi.quantity) AS total_items, SUM(ip.price * oi.quantity) AS total_amount
FROM order_item oi
JOIN item_price ip ON oi.itemId = ip.itemId
GROUP BY oi.orderId;


-- 2- Obtain the customer whose purchase in terms of money has been greater than the others
SELECT cc.customerId, cc.customerName, SUM(ip.price * oi.quantity) AS total_spent
FROM order_customer oc
JOIN customer_city cc ON oc.customerId = cc.customerId
JOIN order_item oi ON oc.orderId = oi.orderId
JOIN item_price ip ON oi.itemId = ip.itemId
GROUP BY cc.customerId, cc.customerName
ORDER BY total_spent DESC
LIMIT 1;
---------------------------------------------------------------------
-- Exercise 2

CREATE TABLE loan_books
(
    school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    class VARCHAR(5),
    section VARCHAR(10),
    book VARCHAR(90),
    publisher VARCHAR(50),
    loanDate DATE,
    PRIMARY KEY (???)
);
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01', 'Preschool, N56', 'Taylor & Francis Publishing', '2010-05-05');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-05');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01', 'Early Childhood Education N9', 'Prentice Hall', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-05-05');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-12-18');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');


-- 1NF
CREATE TABLE loan_books
(
    loan_id INT PRIMARY KEY,
    school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    class VARCHAR(5),
    section VARCHAR(10),
    title VARCHAR(90),
    publisher VARCHAR(90),
    loan_date DATE
);

INSERT INTO loan_books VALUES (1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES (2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01', 'Preschool, N56', 'Taylor & Francis Publishing', '2010-05-05');
INSERT INTO loan_books VALUES (3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-05');
INSERT INTO loan_books VALUES (4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01', 'Early Childhood Education N9', 'Prentice Hall', '2010-05-06');
INSERT INTO loan_books VALUES (5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');
INSERT INTO loan_books VALUES (6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES (7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-05-05');
INSERT INTO loan_books VALUES (8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-12-18');
INSERT INTO loan_books VALUES (9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');


-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT school, publisher, COUNT(*) as num_loans
FROM loan_books
GROUP BY school, publisher;


-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it
SELECT school, title, teacher, loan_date, DATEDIFF(NOW(), loan_date) AS days_on_loan
FROM loan_books
WHERE (school, loan_date) IN (
  SELECT school, MAX(loan_date)
  FROM loan_books
  GROUP BY school
)
ORDER BY days_on_loan DESC;

--NF2 
CREATE TABLE loans
(
loan_id INT PRIMARY KEY,
school VARCHAR(50),
teacher VARCHAR(30),
course VARCHAR(40),
room VARCHAR(10),
class VARCHAR(5),
section VARCHAR(10),
loan_date DATE
);

CREATE TABLE books
(
book_id INT PRIMARY KEY,
title VARCHAR(90),
publisher VARCHAR(90)
);

CREATE TABLE loan_books
(
loan_id INT,
book_id INT,
PRIMARY KEY (loan_id, book_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO loans VALUES (1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01', '2010-09-09');
INSERT INTO loans VALUES (2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01', '2010-05-05');
INSERT INTO loans VALUES (3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01', '2010-05-05');
INSERT INTO loans VALUES (4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01', '2010-05-06');
INSERT INTO loans VALUES (5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01', '2010-05-06');
INSERT INTO loans VALUES (6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01', '2010-09-09');
INSERT INTO loans VALUES (7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01', '2010-05-05');
INSERT INTO loans VALUES (8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01', '2010-12-18');
INSERT INTO loans VALUES (9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01', '2010-05-06');

INSERT INTO books VALUES (1, 'Learning and teaching in early childhood education', 'BOA Editions');
INSERT INTO books VALUES (2, 'Preschool, N56', 'Taylor & Francis Publishing');
INSERT INTO books VALUES (3, 'Early Childhood Education N9', 'Prentice Hall');
INSERT INTO books VALUES (4, 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

INSERT INTO loan_books VALUES (1, 1);
INSERT INTO loan_books VALUES (2, 2);
INSERT INTO loan_books VALUES (3, 1);
INSERT INTO loan_books VALUES (4, 3);
INSERT INTO loan_books VALUES (5, 1);
INSERT INTO loan_books VALUES (6, 1);
INSERT INTO loan_books VALUES (7, 4);
INSERT INTO loan_books VALUES (8, 4);
INSERT INTO loan_books VALUES (9, 1);

-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT loans.school, books.publisher, COUNT(*) AS num_loans
FROM loans
JOIN loan_books ON loans.loan_id = loan_books.loan_id
JOIN books ON loan_books.book_id = books.book_id
GROUP BY loans.school, books.publisher;

-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it
SELECT loans.school, books.title, loans.teacher, MAX(loans.loan_date) AS loan_date
FROM loans
JOIN loan_books ON loans.loan_id = loan_books.loan_id
JOIN books ON loan_books.book_id = books.book_id
GROUP BY loans.school, books.title
HAVING loan_date = MAX(loans.loan_date);

--3NF

CREATE TABLE loans
(
loan_id INT PRIMARY KEY,
loan_date DATE
);

CREATE TABLE loan_details
(
loan_id INT,
school VARCHAR(50),
teacher VARCHAR(30),
course VARCHAR(40),
room VARCHAR(10),
class VARCHAR(5),
section VARCHAR(10),
PRIMARY KEY (loan_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE books
(
book_id INT PRIMARY KEY,
title VARCHAR(90),
publisher VARCHAR(90)
);

CREATE TABLE loan_books
(
loan_id INT,
book_id INT,
PRIMARY KEY (loan_id, book_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

INSERT INTO loans VALUES (1, '2010-09-09');
INSERT INTO loans VALUES (2, '2010-05-05');
INSERT INTO loans VALUES (3, '2010-05-05');
INSERT INTO loans VALUES (4, '2010-05-06');
INSERT INTO loans VALUES (5, '2010-05-06');
INSERT INTO loans VALUES (6, '2010-09-09');
INSERT INTO loans VALUES (7, '2010-05-05');
INSERT INTO loans VALUES (8, '2010-12-18');
INSERT INTO loans VALUES (9, '2010-05-06');

INSERT INTO loan_details VALUES (1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01');
INSERT INTO loan_details VALUES (9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01');

INSERT INTO books VALUES (1, 'Learning and teaching in early childhood education', 'BOA Editions');
INSERT INTO books VALUES (2, 'Preschool, N56', 'Taylor & Francis Publishing');
INSERT INTO books VALUES (3, 'Early Childhood Education N9', 'Prentice Hall');
INSERT INTO books VALUES (4, 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

INSERT INTO loan_books VALUES (1, 1);
INSERT INTO loan_books VALUES (2, 2);
INSERT INTO loan_books VALUES (3, 1);
INSERT INTO loan_books VALUES (4, 3);
INSERT INTO loan_books VALUES (5, 1);
INSERT INTO loan_books VALUES (6, 1);
INSERT INTO loan_books VALUES (7, 4);
INSERT INTO loan_books VALUES (8, 4);
INSERT INTO loan_books VALUES (9, 1);
-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT ld.school, b.publisher, COUNT(*) AS num_books_loaned
FROM loans l
JOIN loan_details ld ON l.loan_id = ld.loan_id
JOIN loan_books lb ON l.loan_id = lb.loan_id
JOIN books b ON lb.book_id = b.book_id
GROUP BY ld.school, b.publisher;


-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it

SELECT ld.school, lb.book_id, b.title, ld.teacher, DATEDIFF(CURRENT_DATE, l.loan_date) AS days_on_loan
FROM loans l
JOIN loan_details ld ON l.loan_id = ld.loan_id
JOIN loan_books lb ON l.loan_id = lb.loan_id
JOIN books b ON lb.book_id = b.book_id
WHERE (ld.school, lb.book_id, l.loan_date) IN (
  SELECT ld.school, lb.book_id, MIN(l.loan_date)
  FROM loans l
  JOIN loan_details ld ON l.loan_id = ld.loan_id
  JOIN loan_books lb ON l.loan_id = lb.loan_id
  GROUP BY ld.school, lb.book_id
)
ORDER BY ld.school;
-- BCNF
CREATE TABLE loans
(
    loan_id INT PRIMARY KEY,
    loan_date DATE
);

CREATE TABLE loan_details
(
    loan_id INT,
    school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    class VARCHAR(5),
    section VARCHAR(10),
    PRIMARY KEY (loan_id),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE publishers
(
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(90)
);

CREATE TABLE books
(
    book_id INT PRIMARY KEY,
    title VARCHAR(90),
    publisher_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

CREATE TABLE loan_books
(
    loan_id INT,
    book_id INT,
    PRIMARY KEY (loan_id, book_id),
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO loans VALUES (1, '2010-09-09');
INSERT INTO loans VALUES (2, '2010-05-05');
INSERT INTO loans VALUES (3, '2010-05-05');
INSERT INTO loans VALUES (4, '2010-05-06');
INSERT INTO loans VALUES (5, '2010-05-06');
INSERT INTO loans VALUES (6, '2010-09-09');
INSERT INTO loans VALUES (7, '2010-05-05');
INSERT INTO loans VALUES (8, '2010-12-18');
INSERT INTO loans VALUES (9, '2010-05-06');

INSERT INTO loan_details VALUES (1, 'Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (2, 'Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (3, 'Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (4, 'Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (5, 'Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (6, 'Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (7, 'Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (8, 'Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01');
INSERT INTO loan_details VALUES (9, 'Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01');

INSERT INTO publishers VALUES (1, 'BOA Editions');
INSERT INTO publishers VALUES (2, 'Taylor & Francis Publishing');
INSERT INTO publishers VALUES (3, 'Prentice Hall');
INSERT INTO publishers VALUES (4, 'McGraw Hill');

INSERT INTO books VALUES (1, 'Learning and teaching in early childhood education', 1);
INSERT INTO books VALUES (2, 'Preschool, N56', 2);
INSERT INTO books VALUES (3, 'Early Childhood Education N9', 3);
INSERT INTO books VALUES (4, 'Know how to educate: guide for Parents and Teachers', 4);

INSERT INTO loan_books VALUES (1, 1);
INSERT INTO loan_books VALUES (2, 2);
INSERT INTO loan_books VALUES (3, 1);
INSERT INTO loan_books VALUES (4, 3);
INSERT INTO loan_books VALUES (5, 1);
INSERT INTO loan_books VALUES (6, 1);
INSERT INTO loan_books VALUES (7, 4);
INSERT INTO loan_books VALUES (8, 4);
INSERT INTO loan_books VALUES (9, 1);

-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT ld.school, b.publisher_id, COUNT(*) AS num_loans
FROM loan_books lb
JOIN loan_details ld ON lb.loan_id = ld.loan_id
JOIN books b ON lb.book_id = b.book_id
GROUP BY ld.school, b.publisher_id
ORDER BY ld.school, b.publisher_id;



-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it

SELECT ld.school, lb.book_id, b.title, ld.teacher, DATEDIFF(CURRENT_DATE, lo.loan_date) AS days_on_loan
FROM loan_details ld
JOIN loan_books lb ON ld.loan_id = lb.loan_id
JOIN books b ON lb.book_id = b.book_id
JOIN loans lo ON ld.loan_id = lo.loan_id
WHERE (ld.school, lb.book_id, lo.loan_date) IN (
SELECT ld.school, lb.book_id, MIN(lo.loan_date)
FROM loan_details ld
JOIN loan_books lb ON ld.loan_id = lb.loan_id
JOIN loans lo ON ld.loan_id = lo.loan_id
GROUP BY ld.school, lb.book_id
)
ORDER BY ld.school;

-- 4NF
CREATE TABLE loans
(
loan_id INT PRIMARY KEY,
loan_date DATE
);

CREATE TABLE loan_details
(
loan_id INT,
teacher VARCHAR(30),
course VARCHAR(40),
room VARCHAR(10),
class VARCHAR(5),
section VARCHAR(10),
PRIMARY KEY (loan_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE books
(
book_id INT PRIMARY KEY,
title VARCHAR(90),
publisher VARCHAR(90)
);

CREATE TABLE loan_books
(
loan_id INT,
book_id INT,
PRIMARY KEY (loan_id, book_id),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id),
FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE loans_by_school
(
loan_id INT,
school VARCHAR(50),
PRIMARY KEY (loan_id, school),
FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);
INSERT INTO loans VALUES (1, '2010-09-09');
INSERT INTO loans VALUES (2, '2010-05-05');
INSERT INTO loans VALUES (3, '2010-05-05');
INSERT INTO loans VALUES (4, '2010-05-06');
INSERT INTO loans VALUES (5, '2010-05-06');
INSERT INTO loans VALUES (6, '2010-09-09');
INSERT INTO loans VALUES (7, '2010-05-05');
INSERT INTO loans VALUES (8, '2010-12-18');
INSERT INTO loans VALUES (9, '2010-05-06');

INSERT INTO loan_details VALUES (1, 'Chad Russell', 'Logical Thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (2, 'Chad Russell', 'Writing', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (3, 'Chad Russell', 'Numerical thinking', '1.A01', '1', 'A01');
INSERT INTO loan_details VALUES (4, 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (5, 'E.F.Codd', 'Numerical thinking', '1.B01', '1', 'B01');
INSERT INTO loan_details VALUES (6, 'Jones Smith', 'Writing', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (7, 'Jones Smith', 'English', '1.A01', '2', 'A01');
INSERT INTO loan_details VALUES (8, 'Adam Baker', 'Logical Thinking', '2.B01', '1', 'B01');
INSERT INTO loan_details VALUES (9, 'Adam Baker', 'Numerical Thinking', '2.B01', '1', 'B01');

INSERT INTO books VALUES (1, 'Learning and teaching in early childhood education', 'BOA Editions');
INSERT INTO books VALUES (2, 'Preschool, N56', 'Taylor & Francis Publishing');
INSERT INTO books VALUES (3, 'Early Childhood Education N9', 'Prentice Hall');
INSERT INTO books VALUES (4, 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill');

INSERT INTO loan_books VALUES (1, 1);
INSERT INTO loan_books VALUES (2, 2);
INSERT INTO loan_books VALUES (3, 1);
INSERT INTO loan_books VALUES (4, 3);
INSERT INTO loan_books VALUES (5, 1);
INSERT INTO loan_books VALUES (6, 1);
INSERT INTO loan_books VALUES (7, 4);
INSERT INTO loan_books VALUES (8, 4);
INSERT INTO loan_books VALUES (9, 1);

INSERT INTO loans_by_school VALUES (1, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (2, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (3, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (4, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (5, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (6, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (7, 'Horizon Education Institute');
INSERT INTO loans_by_school VALUES (8, 'Bright Institution');
INSERT INTO loans_by_school VALUES (9, 'Bright Institution');

-- Queries 
-- 1-Obtain for each of the schools, the number of books that have been loaned to each publishers
SELECT l.school, b.publisher, COUNT(*) AS num_books_loaned
FROM loans_by_school l
JOIN loan_details ld ON l.loan_id = ld.loan_id
JOIN loan_books lb ON l.loan_id = lb.loan_id
JOIN books b ON lb.book_id = b.book_id
GROUP BY l.school, b.publisher;


-- 2- For each school, find the book that has been on loan the longest and the teacher in charge of it

SELECT l.school, lb.book_id, b.title, ld.teacher, DATEDIFF(CURRENT_DATE, lo.loan_date) AS days_on_loan
FROM loans_by_school l
JOIN loan_details ld ON l.loan_id = ld.loan_id
JOIN loan_books lb ON l.loan_id = lb.loan_id
JOIN books b ON lb.book_id = b.book_id
JOIN loans lo ON l.loan_id = lo.loan_id
WHERE (l.school, lb.book_id, lo.loan_date) IN (
SELECT l.school, lb.book_id, MIN(lo.loan_date)
FROM loans_by_school l
JOIN loan_books lb ON l.loan_id = lb.loan_id
JOIN loans lo ON l.loan_id = lo.loan_id
GROUP BY l.school, lb.book_id
)
ORDER BY l.school;


