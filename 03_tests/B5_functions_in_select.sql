-- B5: stored functions called directly inside SQL
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS employee,
       e.salary,
       fn_annual_salary(e.employee_id)    AS annual_salary,
       fn_years_of_service(e.employee_id) AS years_of_service,
       fn_calculate_tax(e.salary)         AS tax,
       fn_dept_name(e.department_id)      AS department
FROM employees e
ORDER BY e.employee_id;
