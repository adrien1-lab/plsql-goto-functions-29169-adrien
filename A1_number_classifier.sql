-- A1: Number classifier using GOTO
SET SERVEROUTPUT ON;

DECLARE
    v_num NUMBER := 7;   -- change to test negative and zero
BEGIN
    IF v_num > 0 THEN
        GOTO positive_number;
    ELSIF v_num < 0 THEN
        GOTO negative_number;
    ELSE
        GOTO zero_number;
    END IF;

    <<positive_number>>
    DBMS_OUTPUT.PUT_LINE('Number is positive.');
    GOTO finished;

    <<negative_number>>
    DBMS_OUTPUT.PUT_LINE('Number is negative.');
    GOTO finished;

    <<zero_number>>
    DBMS_OUTPUT.PUT_LINE('Number is zero.');

    <<finished>>
    NULL;
END;
/
