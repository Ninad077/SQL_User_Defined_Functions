-- User Defined Functions

-- Add two numbers
Delimiter //
create function Add_nos(a int, b int)
returns int          -- Specifying the datatype of the o/p          
deterministic        -- A function that gives the same o/p every time it is called.
					--  Not deterministic is a function that gives different o/p every time it is called. (E.g Random function Rand())
begin
	declare ans int; -- declaring the o/p variable
    SET ans= a+b;    -- Storing the answer in o/p variable
    return ans;      --  returing the value of o/p variable
end //
Delimiter ;

-- Calling a function
select Add_nos(5,3);

-- Create a table EMP
create table EMP(
Emp_id int primary key,
Emp_name varchar(50),
Salary int
);

 -- Insert into EMP values and calculate the Net salary for employee where net_calulated_salary = SAL+HRA+TA+OTHER-PF;
 -- where (0.10*salary) as PF,
-- (0.11*salary) as HRA,
-- (0.04*salary) as TA,
-- (0.3*salary) as OTHER
-- (1, "meera",20000),
-- (2, "Raj",25000),
-- (3, "rahul",28000),
-- (4, "seema",30000);

select salary, (0.10*salary) as PF,
(0.11*salary) as HRA,
(0.04*salary) as TA,
(0.3*salary) as OTHER
from EMP;

DELIMITER //
CREATE FUNCTION NET_SALARY(SAL int)
RETURNS float
DETERMINISTIC
BEGIN
	DECLARE net_calulated_salary float;
    DECLARE PF Float;
    DECLARE HRA FLoat;
    DECLARE TA FLoat;
    DECLARE OTHER FLoat;
    
    SET PF = 0.10*sal ; 
	SET HRA = 0.11*sal;
	SET TA = 0.04*sal;
	SET OTHER = 0.3*sal;
    SET net_calulated_salary = SAL+HRA+TA+OTHER-PF;
    return net_calulated_salary;
END//
DELIMITER ;

SELECT NET_SALARY(Salary); -- Taking Salary column from Emp table
SELECT emp_id,emp_name,salary,NET_SALARY(Salary) as NET_SALARY
from employee;

-- Make a user defined function avg_per_customer() that takes creditlimit of customers as input and returns it's average
DELIMITER //
CREATE FUNCTION avg_per_customer() 
RETURNS float
DETERMINISTIC
Begin
	declare avg_cust float;	
	declare total_credit float;
	declare total_cust int;
		select count(customerNumber) into total_cust from customers;
		select sum(creditLimit) into total_credit from customers;
        set avg_cust = total_credit/total_cust;
    return avg_cust;
end //
DELIMITER ;

select  avg_per_customer();