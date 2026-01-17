-- =========================================
-- Employee Analytics Project
-- Database: employee_analytics
-- =========================================

-- Select the project database
USE employee_analytics;

-- -----------------------------------------
-- Create employees table
-- -----------------------------------------
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    dept_id INT,
    salary INT
);

-- Insert data into employees table
INSERT INTO employees VALUES
(1, 'A', 10, 50000),
(2, 'B', 20, 40000),
(3, 'C', 10, 60000),
(4, 'D', 30, 30000),
(5, 'E', 20, 45000);

-- View employees data
SELECT * FROM employees;

-- -----------------------------------------
-- Create departments table
-- -----------------------------------------
CREATE TABLE departments (
    dept_id INT,
    dept_name VARCHAR(50)
);

-- Insert data into departments table
INSERT INTO departments VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');

-- View departments data
SELECT * FROM departments;

-- -----------------------------------------
-- Join employees with departments
-- -----------------------------------------
SELECT e.emp_id,
       e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id;

-- -----------------------------------------
-- Count employees in each department
-- -----------------------------------------
SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- -----------------------------------------
-- Average salary per department
-- -----------------------------------------
SELECT d.dept_name,
       AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- -----------------------------------------
-- Departments having more than one employee
-- -----------------------------------------
SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 1;

-- -----------------------------------------
-- Departments with average salary > 45000
-- -----------------------------------------
SELECT d.dept_name,
       AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 45000;

-- -----------------------------------------
-- Employees earning more than department average
-- (Correlated subquery)
-- -----------------------------------------
SELECT e.emp_name,
       e.salary,
       d.dept_name
FROM employees e
JOIN departments d
ON e.dept_id = d.dept_id
WHERE e.salary >
(
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
);
