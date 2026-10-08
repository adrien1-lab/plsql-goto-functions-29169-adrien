-- 00_setup: create and seed tables
-- (On a very first run, ignore "table or view does not exist" errors.)

DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;

CREATE TABLE departments (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(50) NOT NULL
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    department_id NUMBER,
    salary NUMBER(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT fk_emp_dept
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO departments VALUES (10, 'IT');
INSERT INTO departments VALUES (20, 'Finance');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Networking');

INSERT INTO employees VALUES (101, 'Adrien', 'Niyonkuru', 10, 500000, DATE '2022-01-15');
INSERT INTO employees VALUES (102, 'Alice',  'Uwase',      20, 650000, DATE '2020-06-10');
INSERT INTO employees VALUES (103, 'Brian',  'Niyonzima',  30, 450000, DATE '2023-03-20');
INSERT INTO employees VALUES (104, 'David',  'Habimana',   40, 800000, DATE '2019-09-05');
INSERT INTO employees VALUES (105, 'Esther', 'Ingabire',   10, 950000, DATE '2018-11-12');

COMMIT;
