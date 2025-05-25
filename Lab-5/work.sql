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




select t1.id,count(distinct t2.id)
from teaches t1,takes t2
where t1.course_id=t2.course_id and 
      t1.semester=t2.semester and t1.year=t2.year and
      t1.semester='Fall' and t1.year=2017 
group by t1.id
having count(distinct t2.id)>5


delete from inst_dump
where id in(
     select t1.id
     from teaches t1,takes t2
      where t1.course_id=t2.course_id and 
      t1.semester=t2.semester and t1.year=t2.year and
      t1.semester='Fall' and t1.year=2017 
      group by t1.id
     having count(distinct t2.id)>5
    
)

update dept_copy
set budget = case
            when budget=50000 then 0
            when budget=120000 then 10000
            else 5000
            end
               





