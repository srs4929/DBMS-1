
select dept_name,avg(salary)
from instructor
group by dept_name
having avg(salary)>42000

with deptnew(dept_name,avg_salary) as
(
    select dept_name,avg(salary)
    from instructor 
    group by dept_name
)
select dept_name,avg_salary
from deptnew where avg_salary>42000
