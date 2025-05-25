--process-1
select dept_name,avg(salary)
from instructor
group by dept_name
having avg(salary)>42000
--process 2
with deptnew(dept_name,avg_salary) as
(
    select dept_name,avg(salary)
    from instructor 
    group by dept_name
)
select dept_name,avg_salary
from deptnew where avg_salary>42000

--process 3
select dept_name,avg_salary
from (select dept_name, avg(salary) as avg_salary from instructor group by dept_name)
where avg_salary>42000
