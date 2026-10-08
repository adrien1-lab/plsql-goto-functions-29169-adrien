SET SERVEROUTPUT ON;

BEGIN
    -- all real employees
    FOR r IN (SELECT employee_id FROM employees ORDER BY employee_id) LOOP
        DBMS_OUTPUT.PUT_LINE(fn_validate_payroll(r.employee_id));
    END LOOP;

    -- nonexistent employee
    DBMS_OUTPUT.PUT_LINE(fn_validate_payroll(999));

    -- temporarily break a salary to exercise the INVALID path, then restore
    UPDATE employees SET salary = -100 WHERE employee_id = 105;
    DBMS_OUTPUT.PUT_LINE(fn_validate_payroll(105));
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Data restored with ROLLBACK.');
END;
/
