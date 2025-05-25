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

--Question : Find the names of each instructor ,along with their salary and
    --avg salary in thie department

--process-1

with newtable(dept_name,avg_salary) as
(
    select dept_name,avg(salary)
    from instructor
    group by dept_name
)
select name,salary,avg_salary
from instructor,newtable
where instructor.dept_name=newtable.dept_name

--process-2
select name,salary,avg_salary
from (select dept_name,avg(salary) as avg_salary from instructor group by dept_name) natural join instructor
--process-3
select name,salary,(select avg(salary) as avg_salary from instructor s1 where s1.dept_name=s2.dept_name) as avg_salary
from instructor s2



--process-1
select name
from instructor natural join department
where salary*10>budget
--process-2
select name
from instructor,department
where salary*10>budget and instructor.dept_name=department.dept_name
--process-3
select name
from instructor
where salary * 10 >
(select budget from department
where department.dept_name = instructor.dept_name)

--process-1
select dept_name,count(*) as count_instructor
from instructor
group by dept_name

--process-2
select dept_name,
(select count(*) from instructor 
    where department.dept_name=instructor.dept_name) as num_instructor
from department
--process-3
select dept_name,count(*) as num_instructor
from department natural join instructor --check the mistake pls





