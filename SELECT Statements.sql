SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    d.location
FROM employees e, departments d 
WHERE e.department_id = d.department_id;
-- OR
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    d.location
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
-- below will display only 2 records/ rows.
SELECT * FROM employees LIMIT 2;

SELECT DISTINCT department_id FROM employees;
-- Returns unique department IDs from employees (avoids duplicates).

-- If you want the department name, you’d join with the departments table:
SELECT DISTINCT d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
-- SALARY AFTER RAISE BELOW
SELECT first_name, last_name, salary * 1.1 AS 'Salary After Raise'
FROM employees;
-- Shows each employee’s name.
-- Increases their salary by 10% (* 1.1).
-- Uses AS to rename the column as Salary After Raise.

SELECT 
    CONCAT(first_name, ' ', last_name) AS 'Full Name',
    YEAR(hire_date) AS 'Hire Year',
    ROUND(salary, 1) AS 'Rounded Salary'
FROM employees;
-- CONCAT → merges first and last name into one field.
-- YEAR(hire_date) → extracts only the year from the hire date.
-- ROUND(salary, 1) → rounds salary to 1 decimal place.

SELECT AVG(salary) FROM employees;

SELECT * 
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Union of Employees from Two Departments
SELECT first_name, last_name 
FROM employees 
WHERE department_id = 2   -- IT
UNION
SELECT first_name, last_name 
FROM employees 
WHERE department_id = 1;  -- HR
-- UNION combines results from both queries.
-- Ensures no duplicates (use UNION ALL if you want duplicates).


-- department = 'IT' and 'HR' are used, but since we set up a normalized design, you’d actually join departments:
SELECT e.first_name, e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT'

UNION

SELECT e.first_name, e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'HR';


SELECT COUNT(*), department 
FROM employees 
GROUP BY department;
-- 1) Average salary per department
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
-- 2) Highest paid employee per department
SELECT d.department_name, MAX(e.salary) AS max_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
-- Depertmants ordered by number of employees
SELECT d.department_name, COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_employees DESC;

-- SELECT can also used to perform arithmatic operations like:
SELECT NOW() AS 'time';
SELECT 5 * 2;
SELECT LENGTH('hello');
SELECT CURDATE();         -- Current date (YYYY-MM-DD)
SELECT YEAR(NOW());       -- Current year
SELECT MONTHNAME(NOW());  -- Current month name (e.g. 'September')
SELECT UPPER('hello');             -- HELLO
SELECT LOWER('WORLD');             -- world
SELECT CONCAT('Data', ' ', 'SQL'); -- Data SQL
SELECT SUBSTRING('Database', 1, 4);-- Data
SELECT ROUND(123.456, 2); -- 123.46
SELECT FLOOR(9.99);       -- 9
SELECT CEIL(9.01);        -- 10
SELECT POW(2, 3);         -- 8
