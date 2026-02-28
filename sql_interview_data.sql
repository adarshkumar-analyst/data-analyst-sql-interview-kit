CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT,
    hire_date DATE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount INT,
    status VARCHAR(20)
);





INSERT INTO employees VALUES
(1, 'Amit', 'IT', 60000, NULL, '2018-01-15'),
(2, 'Karan', 'HR', 45000, 5, '2019-03-10'),
(3, 'Riya', 'IT', 75000, 1, '2020-07-23'),
(4, 'Sneha', 'Finance', 50000, 6, '2021-06-01'),
(5, 'Raj', 'HR', 80000, NULL, '2015-02-18'),
(6, 'Vikas', 'Finance', 90000, NULL, '2014-11-11'),
(7, 'Neha', 'IT', 72000, 1, '2022-08-19'),
(8, 'Arjun', 'IT', 60000, 1, '2023-01-05'),
(9, 'Pooja', 'Finance', 65000, 6, '2017-09-14'),
(10, 'Manish', 'HR', 48000, 5, '2020-12-20'),
(11, 'Anjali', 'IT', 82000, 1, '2016-05-25'),
(12, 'Rohit', 'Finance', 55000, 6, '2019-04-30'),
(13, 'Simran', 'IT', 70000, 1, '2021-03-11'),
(14, 'Deepak', 'HR', 52000, 5, '2022-10-17'),
(15, 'Tanya', 'Finance', 88000, 6, '2018-07-07');





INSERT INTO customers VALUES
(101, 'Rahul', 'Delhi'),
(102, 'Priya', 'Mumbai'),
(103, 'Ankit', 'Delhi'),
(104, 'Sara', 'Bangalore'),
(105, 'Meena', 'Mumbai'),
(106, 'Kunal', 'Chennai'),
(107, 'Isha', 'Hyderabad'),
(108, 'Varun', 'Pune'),
(109, 'Nidhi', 'Kolkata'),
(110, 'Aditya', 'Jaipur');





INSERT INTO orders VALUES
(1001, 101, '2024-01-10', 5000, 'Completed'),
(1002, 102, '2024-01-11', 7000, 'Pending'),
(1003, 101, '2024-02-15', 3000, 'Completed'),
(1004, 103, '2024-02-20', 4500, 'Completed'),
(1006, 104, '2024-03-05', 8000, 'Cancelled'),  -- Gap at 1005
(1007, 101, '2024-03-10', 6500, 'Completed'),
(1008, 105, '2024-04-12', 9000, 'Completed'),
(1010, 106, '2024-05-01', 7500, 'Completed'),  -- Gap at 1009
(1011, 101, '2024-05-18', 4000, 'Completed'),
(1012, 107, '2024-06-22', 10000, 'Completed'),
(1013, 108, '2024-07-02', 6200, 'Pending'),
(1014, 109, '2024-07-15', 3000, 'Completed'),
(1015, 110, '2024-08-19', 8500, 'Completed');


