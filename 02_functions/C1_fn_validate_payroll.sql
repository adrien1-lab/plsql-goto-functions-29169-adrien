-- C1: Payroll validator — chains B1 (annual), B2 (years), B3 (tax), B4 (dept name)
CREATE OR REPLACE FUNCTION fn_validate_payroll (
    p_employee_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_first   employees.first_name%TYPE;
    v_last    employees.last_name%TYPE;
    v_salary  employees.salary%TYPE;
    v_dept_id employees.department_id%TYPE;
    v_dept    VARCHAR2(50);
    v_annual  NUMBER;
    v_years   NUMBER;
    v_tax     NUMBER;
BEGIN
    SELECT first_name, last_name, salary, department_id
    INTO v_first, v_last, v_salary, v_dept_id
    FROM employees
    WHERE employee_id = p_employee_id;

    -- Rule 1: salary must be positive
    IF v_salary <= 0 THEN
        RETURN 'INVALID: employee ' || p_employee_id || ' has no valid salary.';
    END IF;

    -- Rule 2: department must exist (uses B4)
    v_dept := fn_dept_name(v_dept_id);
    IF v_dept = 'Unknown Department' THEN
        RETURN 'INVALID: employee ' || p_employee_id || ' has no valid department.';
    END IF;

    -- Rule 3: annual tax cannot exceed annual salary
    v_annual := fn_annual_salary(p_employee_id);   -- B1
    v_years  := fn_years_of_service(p_employee_id);-- B2
    v_tax    := fn_calculate_tax(v_salary);        -- B3

    IF v_tax * 12 >= v_annual THEN
        RETURN 'INVALID: employee ' || p_employee_id || ' tax exceeds salary.';
    END IF;

    RETURN 'VALID: ' || v_first || ' ' || v_last
        || ' | Monthly: ' || v_salary
        || ' | Annual: '  || v_annual
        || ' | Years: '   || v_years
        || ' | Tax: '     || v_tax
        || ' | Dept: '    || v_dept;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'INVALID: employee ' || p_employee_id || ' does not exist.';
END;
/
