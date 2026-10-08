-- B4: Department name lookup. Returns a friendly value instead of raising an error.
CREATE OR REPLACE FUNCTION fn_dept_name (
    p_department_id IN NUMBER
)
RETURN VARCHAR2
IS
    v_name departments.department_name%TYPE;
BEGIN
    SELECT department_name
    INTO v_name
    FROM departments
    WHERE department_id = p_department_id;

    RETURN v_name;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Unknown Department';
END;
/
