# PL/SQL GOTO Statements and Functions — INSY 8311

**Student:** Adrien Niyonkuru  
**Student ID:** 29169  
**Instructor:** Eric Maniraguha  
**Database environment:** Oracle Database 21c / SQL*Plus  
**Pluggable database (PDB):** `AD_PDB_29169`  

---

## 1. Assignment Overview

This assignment covers:

- PL/SQL `GOTO` statements
- Stored functions
- Exception handling
- Functions used in SQL statements
- GitHub repository organization and documentation
- Testing and reflection

## 2. Database Setup

The setup script creates two tables: `departments` and `employees`.

### 2.1 Table structure

**`departments`**

| Column | Description |
|---|---|
| `department_id` | Primary key |
| `department_name` | Department name; required |

**`employees`**

| Column | Description |
|---|---|
| `employee_id` | Primary key |
| `first_name` | Employee's first name |
| `last_name` | Employee's last name |
| `department_id` | Foreign key referencing `departments.department_id` |
| `salary` | Employee's salary |
| `hire_date` | Employee's hire date |

### 2.2 Sample data

| Employee ID | Employee | Department | Salary | Hire date |
|---:|---|---|---:|---|
| 101 | Adrien Niyonkuru | IT | 500,000 | 2022-01-15 |
| 102 | Alice Uwase | Finance | 650,000 | 2020-06-10 |
| 103 | Brian Niyonzima | HR | 450,000 | 2023-03-20 |
| 104 | David Habimana | Networking | 800,000 | 2019-09-05 |
| 105 | Esther Ingabire | IT | 950,000 | 2018-11-12 |

### 2.3 Database preparation

In SQL*Plus, check the current container and switch to the assignment PDB if required and authorized:

```sql
SHOW CON_NAME;
ALTER SESSION SET CONTAINER = AD_PDB_29169;
SET SERVEROUTPUT ON;
```

Run `00_setup/create_tables.sql` to create the tables and insert the sample data. **Warning:** the supplied setup script drops existing `employees` and `departments` tables before recreating them.

## 3. Part A — GOTO Statements

### A1. Number classifier

This exercise classifies a number as positive, negative, or zero using labels and `GOTO` statements. The example value is `7`, so the expected message is:

```text
Number is positive.
```

### A2. Salary review

This exercise retrieves an employee's salary using `employees.salary%TYPE` and checks it against a review threshold of 500,000.

For employee ID `103`, whose sample salary is 450,000, the expected message is:

```text
Salary requires review: 450000
```

### A3. Illegal GOTO statement

A `GOTO` statement cannot branch into an inner control structure in an illegal way. The working notes record Oracle error `PLS-00375` for the invalid example. The provided script comments out the deliberately invalid block and includes a legal example for execution.

### A4. Rewrite without GOTO

This exercise performs the number classification using `IF`, `ELSIF`, and `ELSE`. It demonstrates structured control flow without jumping between labels.

## 4. Part B — Stored Functions

### B1. `FN_ANNUAL_SALARY`

**Purpose:** Return an employee's annual salary by multiplying the monthly salary by 12.

- Input: employee ID
- Return value: monthly salary multiplied by 12
- Exception handling: returns `NULL` if the employee ID is not found

Expected annual salary results for the supplied sample data:

| Employee ID | Monthly salary | Annual salary |
|---:|---:|---:|
| 101 | 500,000 | 6,000,000 |
| 102 | 650,000 | 7,800,000 |
| 103 | 450,000 | 5,400,000 |
| 104 | 800,000 | 9,600,000 |
| 105 | 950,000 | 11,400,000 |

### B2. `FN_YEARS_OF_SERVICE`

**Purpose:** Calculate the number of completed years since an employee's hire date.

The function uses `MONTHS_BETWEEN(SYSDATE, hire_date) / 12`, then applies `TRUNC` to return completed years. Results depend on the date when the function is run.

### B3. `FN_CALCULATE_TAX`

**Purpose:** Calculate tax based on the progressive brackets recorded in the working notes.

| Monthly salary portion | Rate |
|---|---:|
| First 60,000 | 0% |
| Portion from 60,000 to 250,000 | 20% |
| Portion above 250,000 | 30% |

The function rejects a `NULL` or negative salary by raising application error `-20001`.

**Important:** The tax brackets above are assumptions copied from the working notes. Confirm them against the lecturer's official assignment instructions before submitting.

### B4. `FN_DEPT_NAME`

**Purpose:** Return a department's name from its department ID.

If no matching department exists, the function returns:

```text
Unknown Department
```

## 5. Part C — Payroll Validation

### C1. `FN_VALIDATE_PAYROLL`

This function combines the functions from Part B to validate an employee's payroll record.

It checks that:

1. The employee exists.
2. The salary is greater than zero.
3. The department exists.
4. Annual tax is less than annual salary.

The function returns a `VALID` summary containing the employee's name, monthly salary, annual salary, years of service, monthly tax, and department, or an `INVALID` message explaining the issue.

## 6. Testing

The `03_tests/` directory contains SQL scripts for testing:

- Annual salary calculations
- Years of service
- Tax calculations
- Department name lookup
- Missing employee handling
- Payroll validation

Run the scripts in Oracle Database 21c and check the actual output in your SQL*Plus session. Capture genuine screenshots of the results for the repository if screenshots are required by the lecturer.

## 7. Repository Structure

```text
plsql-goto-functions-29169-adrien/
├── README.md
├── .gitignore
├── 00_setup/
│   └── create_tables.sql
├── 01_goto/
│   ├── A1_number_classifier.sql
│   ├── A2_salary_review.sql
│   ├── A3_illegal_goto_example.sql
│   └── A4_without_goto.sql
├── 02_functions/
│   ├── B1_fn_annual_salary.sql
│   ├── B2_fn_years_of_service.sql
│   ├── B3_fn_calculate_tax.sql
│   ├── B4_fn_dept_name.sql
│   └── C1_fn_validate_payroll.sql
├── 03_tests/
│   ├── test_functions.sql
│   └── test_validate_payroll.sql
├── docs/
│   └── REFLECTION.md
└── screenshots/
    └── Add genuine SQL*Plus screenshots here
```


## 8. Reflection

**Personal i learnt something in this assignment and all are listed belllow.**

While working on this assignment, I practiced using PL/SQL blocks, labels, and `GOTO` statements to control program flow. I learned that a `GOTO` statement must branch to a label in a legal scope, and that jumping into an inner control structure can produce the `PLS-00375` error. I also compared this approach with `IF / ELSIF / ELSE`, which can be easier to read for simple classification tasks.

I practiced creating stored functions that retrieve employee data and return calculated values, including annual salary, years of service, tax, and department name. Exception handling helped me decide what a function should return when a requested employee or department is not found. I also practiced calling stored functions from SQL queries to test their results.

One debugging issue recorded in my notes was calling a function with the wrong name, which caused an invalid-identifier error. Checking the function name in the database helped identify the problem.

