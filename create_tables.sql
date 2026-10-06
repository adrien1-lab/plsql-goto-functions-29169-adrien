-- ============================================================
-- Assignment III: PL/SQL GOTO Statements and Functions
-- Student: Niyonkuru Adrien
-- Student ID: 29169
-- File: create_tables.sql
-- ============================================================

-- Enable output
SET SERVEROUTPUT ON;

-- ============================================================
-- 1. DROP EXISTING TABLES
-- ============================================================

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- ============================================================
-- 2. CREATE DEPARTMENTS TABLE
-- ============================================================

CREATE TABLE departments (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL
);

-- ============================================================
-- 3. CREATE EMPLOYEES TABLE
-- ============================================================

CREATE TABLE employees (
    employee_id   NUMBER PRIMARY KEY,
    first_name    VARCHAR2(50) NOT NULL,
    last_name     VARCHAR2(50) NOT NULL,
    department_id NUMBER,
    salary        NUMBER(10,2) NOT NULL,
    hire_date     DATE NOT NULL,

    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    CONSTRAINT chk_employee_salary
        CHECK (salary >= 0)
);

-- ============================================================
-- 4. INSERT DEPARTMENTS
-- ============================================================

INSERT INTO departments
    (department_id, department_name)
VALUES
    (10, 'Information Technology');

INSERT INTO departments
    (department_id, department_name)
VALUES
    (20, 'Human Resources');

INSERT INTO departments
    (department_id, department_name)
VALUES
    (30, 'Finance');

INSERT INTO departments
    (department_id, department_name)
VALUES
    (40, 'Marketing');

-- ============================================================
-- 5. INSERT EMPLOYEES
-- ============================================================

INSERT INTO employees
    (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (101, 'Alice', 'Uwase', 10, 120000, DATE '2021-03-15');

INSERT INTO employees
    (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (102, 'Brian', 'Niyonzima', 20, 85000, DATE '2022-06-10');

INSERT INTO employees
    (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (103, 'Claudine', 'Mukamana', 30, 95000, DATE '2020-01-20');

INSERT INTO employees
    (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (104, 'David', 'Habimana', 10, 150000, DATE '2019-09-05');

INSERT INTO employees
    (employee_id, first_name, last_name, department_id, salary, hire_date)
VALUES
    (105, 'Esther', 'Ingabire', 40, 70000, DATE '2023-02-01');

-- ============================================================
-- 6. SAVE CHANGES
-- ============================================================

COMMIT;

-- ============================================================
-- 7. VERIFY DATA
-- ============================================================

SELECT *
FROM departments
ORDER BY department_id;

SELECT *
FROM employees
ORDER BY employee_id;
