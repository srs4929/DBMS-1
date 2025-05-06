select* from inst_dup -- dummy table where some values are null
select count(*) from inst_dup -- total number of rows output:12
select count(salary) from inst_dup -- total number of salary . Some values are null . So it will show 9
select count(salary) from inst_dup where salary is  null -- Output: 0 . Salary is nul in these places. So count 0
select count(*) from inst_dup where salary is  null -- Output 3 . Go to the row where salary is null then count the rows

-- group by : groups rows that have the same values into summary rows. for example the all the cs dept then avg salary.
select dept_name,avg(salary)
from instructor
group by dept_name

--example 2
select avg(salary) from instructor -- it is average of all the salary from instructor table

-- find the course that is offered in fall 2017 and spring 2018

--method1:
select distinct course_id from section 
where (semester='Fall' and year=2017) and
course_id in (select course_id from section where semester='Spring' and year=2018)
--method2 : intersect

select course_id from section
where (semester='Fall' and year=2017)
intersect
select course_id from section
where(semester='Spring'and year=2018 )

