-- A4: Same classification as A1, rewritten with structured IF/ELSIF/ELSE
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER := 7;
BEGIN
    IF v_num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Number is positive.');
    ELSIF v_num < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Number is negative.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Number is zero.');
    END IF;
END;
/
