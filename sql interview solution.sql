-- ===================================================================
-- BASIC LEVEL
-- ===================================================================

-- Show all employees.
select * from employees;

-- Show employee names and salaries.
select emp_name,salary
 from employees;

-- Find employees working in IT department.
select * 
 from employees
  where department='IT';

-- Find employees with salary greater than 60000.
select * 
 from employees
  where salary >60000;

-- Show employees ordered by salary descending.
select * 
 from employees
 order by salary desc;

-- Count total employees.
select count(emp_id) as count_total
 from employees;

-- Find maximum and minimum salary.
select max(salary) as max_sal,
       min(salary) as min_sal
 from employees;

-- Find average salary in IT department.
select avg(salary) as avg_sal_IT_dep
from employees
where department ='IT';

-- Show distinct departments.
select distinct(department)
from employees;
 
-- Find employees hired after 2020.
select * 
 from employees
  where hire_date>'2020-12-31';

-- ===================================================================
-- 🟡 INTERMEDIATE LEVEL
-- ===================================================================

-- Count number of employees in each department.
select department,
       count(department) as total_emp_dep
from employees
 group by department;       

-- Find department with highest average salary.
select department,
        avg(salary) as avg_salary
from employees
 group by department
  order by avg(salary) desc
  limit 1;
                   
-- Find second highest salary.
select salary as sec_max_sal
from employees
order by salary desc
limit 1 offset 1;

-- using_subquery
select max(salary) as sec_max_sal
from employees
where salary<(
               select max(salary)
                from employees);

-- Find employees earning more than department average.
select *
from employees e
where salary>(
              select avg(salary)
               from employees
               where department=e.department);

-- Find duplicate salaries.
select salary
from employees
group by salary
having count(*)>1;

-- Find employees without manager.
select *
 from employees
  where manager_id is null;

-- Find employees who have same salary.
select * 
from employees 
where salary in (select salary
                 from employees
                 group by salary
                 having count(*)>1);

-- Get total sales amount per customer.
select c.customer_name,
       o.customer_id,
       sum(o.amount) as total_sales
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id;

-- Get customers who never placed orders.
select *
 from customers
 where customer_id not in (
                            select customer_id
                            from orders);

-- Find top 3 highest paid employees.
select *
 from employees
 order by salary desc
 limit 3;

-- ===================================================================
-- 🟠 JOIN Based Questions
-- ===================================================================

-- Show customer name with their orders.
select c.customer_name,o.*
from customers c 
join orders o 
on c.customer_id= o.customer_id;

-- Show customers who placed completed orders only.
select c.customer_name,o.*
from customers c 
join orders o 
on c.customer_id= o.customer_id
where status='Completed';

-- Find total amount spent by each customer.
select c.customer_name,
       o.customer_id,
       sum(o.amount) as total_spent
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id;

-- Find customer with highest total purchase.
select c.customer_name,
       o.customer_id,
       sum(o.amount) as total_spent
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id
order by  sum(o.amount) desc
limit 1;

-- Show customers who have no orders.
select *
 from customers
 where customer_id not in (
                            select customer_id
                              from orders);
                              
-- Show employees and their manager names (Self Join).
select e.*,b.emp_name as manger
from employees e
left join employees b 
on e.manager_id=b.emp_id;

-- Find employees who earn more than their manager.
select e.*
from employees e
left join employees b 
on e.manager_id=b.emp_id
where e.salary>b.salary;

-- Find customers who placed more than 2 orders.
select c.customer_name,
       o.customer_id,
       count(o.order_id) as total_orders
from customers c
join orders o 
on c.customer_id=o.customer_id
group by c.customer_name,o.customer_id
having count(o.order_id) > 1;

-- ===================================================================

-- 🔴 ADVANCED LEVEL
-- ===================================================================

-- Find running total of orders by date.
select *,
sum(amount) over(partition by order_date order by order_date) as running_total
from orders;

-- Find rank of employees based on salary (use RANK).
select *,
rank() over(order by salary desc) sal_rnk
from employees;

-- Find 3rd highest salary using window function.
select salary
from (
	 select *,
     rank() over(order by salary desc) rnk
     from employees) as rnk
where rnk=3;     

-- Find department-wise top earner.
select department,salary
from (
	 select *,
     rank() over(partition by department order by salary desc) rnk
     from employees) as rnk
where rnk=1; 

-- Find month-wise total sales.
select
    extract(year from order_date) as SalesYear,
    extract(month from order_date) as SalesMonth,
    sum(amount) as TotalSales
from
    orders
group by SalesYear, SalesMonth
order by SalesYear,SalesMonth;

-- Find customers who ordered in consecutive months.
WITH order_months AS (
    SELECT DISTINCT
        customer_id,
        STR_TO_DATE(DATE_FORMAT(order_date, '%Y-%m-01'), '%Y-%m-%d') AS month_date
    FROM orders
),
lag_data AS (
    SELECT 
        customer_id,
        month_date,
        LAG(month_date) OVER (PARTITION BY customer_id ORDER BY month_date) AS prev_month
    FROM order_months
)
SELECT DISTINCT customer_id
FROM lag_data
WHERE TIMESTAMPDIFF(MONTH, prev_month, month_date) = 1;  

-- Find employees hired in last 2 years.
SELECT *
FROM employees
WHERE hire_date = CURDATE() - INTERVAL 2 YEAR;

-- Find gaps in order IDs.
SELECT o1.order_id + 1 AS missing_id
FROM orders o1
LEFT JOIN orders o2
ON o1.order_id + 1 = o2.order_id
WHERE o2.order_id IS NULL
AND o1.order_id < (SELECT MAX(order_id) FROM orders)
ORDER BY o1.order_id;

-- Pivot department salary summary.
SELECT 
    SUM(CASE WHEN department = 'IT' THEN salary ELSE 0 END) AS IT_Total,
    SUM(CASE WHEN department = 'HR' THEN salary ELSE 0 END) AS HR_Total,
    SUM(CASE WHEN department = 'Finance' THEN salary ELSE 0 END) AS Finance_Total
FROM employees;

-- Find employees whose salary increased compared to previous hire (window logic).

SELECT *
FROM (
    SELECT emp_id,
           emp_name,
           hire_date,
           salary,
           LAG(salary) OVER (ORDER BY hire_date) AS prev_salary
    FROM employees
) t
WHERE salary > prev_salary;

-- Write stored procedure to get employee details by department.

DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(50))
BEGIN
    SELECT *
    FROM employees
    WHERE department = dept_name;
END //

DELIMITER ;