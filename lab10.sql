/* Task 1*/

-- a

-- create table of accounts
CREATE TABLE accounts (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  credit INT,
  currency VARCHAR(10),
);

INSERT INTO accounts (id, name, credit, currency)
VALUES (1, 'Account 1', 1000, 'RUB'),
       (2, 'Account 2', 1000, 'RUB'),
       (3, 'Account 3', 1000, 'RUB');


BEGIN;
SAVEPOINT sp1;

UPDATE accounts SET credit = credit + 500 WHERE id = 1;
UPDATE accounts SET credit = credit - 500 WHERE id = 3;


SAVEPOINT sp2;

UPDATE accounts SET credit = credit - 700 WHERE id = 2;
UPDATE accounts SET credit = credit + 700 WHERE id = 1;

SAVEPOINT sp3;

UPDATE accounts SET credit = credit + 100 WHERE id = 2;
UPDATE accounts SET credit = credit - 100 WHERE id = 3;


ROLLBACK TO sp2;

ROLLBACK TO sp1;

COMMIT;

--1 B

-- create table of accounts
CREATE TABLE accounts (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  credit INT,
  currency VARCHAR(10),
  bank_name VARCHAR(50)
);

-- insert 3 accounts with 1000 RUB each
INSERT INTO accounts (id, name, credit, currency, bank_name)
VALUES (1, 'Account 1', 1000, 'RUB', 'SberBank'),
       (2, 'Account 2', 1000, 'RUB', 'Tinkoff'),
       (3, 'Account 3', 1000, 'RUB', 'SberBank'),
       (4, 'Fees Account', 0, 'RUB', 'ِAny');



BEGIN;

UPDATE accounts SET credit = credit + 500 WHERE id = 1;
UPDATE accounts SET credit = credit - 500 WHERE id = 3;


UPDATE accounts SET credit = credit - 730 WHERE id = 2;
UPDATE accounts SET credit = credit + 700 WHERE id = 1;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;


UPDATE accounts SET credit = credit + 100 WHERE id = 2;
UPDATE accounts SET credit = credit - 130 WHERE id = 3;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;


COMMIT;


ROLLBACK;


-- 1 C


-- create table of accounts
CREATE TABLE accounts (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  credit INT,
  currency VARCHAR(10),
  bank_name VARCHAR(50)
);

-- insert 3 accounts with 1000 RUB each
INSERT INTO accounts (id, name, credit, currency, bank_name)
VALUES (1, 'Account 1', 1000, 'RUB', 'SberBank'),
       (2, 'Account 2', 1000, 'RUB', 'Tinkoff'),
       (3, 'Account 3', 1000, 'RUB', 'SberBank'),
       (4, 'Fees Account', 0, 'RUB', 'any');

-- create table for ledger
CREATE TABLE ledger (
  id INT PRIMARY KEY,
  from_account INT,
  to_account INT,
  fee INT,
  amount INT,
  transaction_date_time DATETIME
);

BEGIN;
SAVEPOINT sp1;

UPDATE accounts SET credit = credit + 500 WHERE id = 1;
UPDATE accounts SET credit = credit - 500 WHERE id = 3;
INSERT INTO ledger (id, from_account, to_account, fee, amount, transaction_date_time)
VALUES (1, 1, 3, 0, 500, NOW());

SAVEPOINT sp2;

UPDATE accounts SET credit = credit - 730 WHERE id = 2;
UPDATE accounts SET credit = credit + 700 WHERE id = 1;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO ledger (id, from_account, to_account, fee, amount, transaction_date_time)
VALUES (2, 2, 1, 30, 670, NOW());

SAVEPOINT sp3;

UPDATE accounts SET credit = credit + 100 WHERE id = 2;
UPDATE accounts SET credit = credit - 130 WHERE id = 3;
UPDATE accounts SET credit = credit + 30 WHERE id = 4;
INSERT INTO ledger (id, from_account, to_account, fee, amount, transaction_date_time)
VALUES (3, 2, 3, 30, 100, NOW());

COMMIT;

ROLLBACK;


-- Task 2 :


