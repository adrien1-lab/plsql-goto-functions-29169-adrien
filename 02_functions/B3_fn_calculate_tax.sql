-- B3: Tax calculator.
-- ⚠ Brackets are an assumption (Rwanda PAYE-style):
--   0% up to 60,000 | 20% on 60,001-250,000 | 30% above 250,000
-- Replace with the brackets from your detailed task sheet if different.
-- Takes a salary (not an employee id) so it is a reusable, testable calculator.
CREATE OR REPLACE FUNCTION fn_calculate_tax (
    p_salary IN NUMBER
)
RETURN NUMBER
IS
    v_tax NUMBER := 0;
BEGIN
    IF p_salary IS NULL OR p_salary <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary must be a positive number.');
    END IF;

    IF p_salary <= 60000 THEN
        v_tax := 0;                              -- 0% band
    ELSIF p_salary <= 250000 THEN
        v_tax := (p_salary - 60000) * 0.20;      -- 20% band
    ELSE
        v_tax := 38000                           -- 20% of the 190,000 middle band
               + (p_salary - 250000) * 0.30;     -- 30% band
    END IF;

    RETURN v_tax;
END;
/
