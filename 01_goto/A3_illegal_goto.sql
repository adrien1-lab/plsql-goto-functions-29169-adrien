-- A3: Illegal GOTO demonstration and fix
SET SERVEROUTPUT ON;

-- ILLEGAL VERSION (uncomment to reproduce the error screenshot)
-- Error: PLS-00375: illegal GOTO statement; this GOTO cannot branch to label 'INSIDE_BLOCK'
-- Reason: GOTO cannot jump INTO the body of an IF statement.
--
-- BEGIN
--     GOTO inside_block;
--     IF 1 = 1 THEN
--         <<inside_block>>
--         DBMS_OUTPUT.PUT_LINE('This should not execute.');
--     END IF;
-- END;
-- /

-- FIXED VERSION: branch to a label at the same block level
BEGIN
    GOTO valid_label;

    <<valid_label>>
    DBMS_OUTPUT.PUT_LINE('GOTO executed successfully.');
END;
/
