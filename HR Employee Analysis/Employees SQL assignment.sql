use employees;
show tables;

#	List all employees:
select * from employees;

#   List all departments:
select * from departments; 

#	List all employees with their current titles:
Select first_name, last_name, title from employees
join titles;

#	Total Number of Employees:
select count(*) from employees;

#	Average Salary by Department:
SELECT 
    d.dept_name AS department_name,
    AVG(s.salary) AS avg_salary
FROM 
    departments d
JOIN 
    dept_emp de ON d.dept_no = de.dept_no
JOIN 
    salaries s ON de.emp_no = s.emp_no
WHERE 
    s.to_date = '9999-01-01'  -- Only consider current salaries
GROUP BY 
    d.dept_name;

#	Top 10 Highest Paid Employees:
SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    s.salary,
    t.title,
    d.dept_name
FROM 
    employees e
JOIN 
    salaries s ON e.emp_no = s.emp_no
JOIN 
    titles t ON e.emp_no = t.emp_no
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    departments d ON de.dept_no = d.dept_no
WHERE 
    s.to_date = '9999-01-01'  -- Only consider current salaries
ORDER BY 
    s.salary DESC
LIMIT 10;


# 	Employee Count by Department:
SELECT 
    d.dept_name AS department_name,
    COUNT(de.emp_no) AS employee_count
FROM 
    departments d
JOIN 
    dept_emp de ON d.dept_no = de.dept_no
JOIN 
    employees e ON de.emp_no = e.emp_no
GROUP BY 
    d.dept_name;
    
  #  Salary Trend Over Time:
    SELECT 
    YEAR(s.from_date) AS year,
    AVG(s.salary) AS avg_salary
FROM 
    salaries s
GROUP BY 
    YEAR(s.from_date)
ORDER BY 
    year;
    
#	Gender Distribution by Department:
SELECT 
    d.dept_name AS department_name,
    e.gender,
    COUNT(e.emp_no) AS gender_count
FROM 
    departments d
JOIN 
    dept_emp de ON d.dept_no = de.dept_no
JOIN 
    employees e ON de.emp_no = e.emp_no
GROUP BY 
    d.dept_name, e.gender;
