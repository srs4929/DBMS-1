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

--Find courses offered in Fall 2009 but not in Spring 2010
--method1: minus
select course_id from section
where (semester='Fall' and year=2017)
minus
select course_id from section
where(semester='Spring'and year=2018 )
--method2:
select distinct course_id from section 
where (semester='Fall' and year=2017) and
course_id not in (select course_id from section where semester='Spring' and year=2018)

--Find the total number of (distinct) students who have taken course
--sections taught by the instructor with ID 10101
--method-1
select count(distinct id) from takes
where
(course_id,sec_id,semester,year)
in
(select course_id,sec_id,semester,year from teaches where teaches.id=10101)
--method2
select count(distinct takes.id) from 
takes,teaches
where takes.course_id=teaches.course_id
and takes.sec_id=teaches.sec_id
and takes.semester=teaches.semester
and takes.year=teaches.year
and teaches.id=10101

--Find names of instructors with salary greater than that of some (at
--least one) instructor in the Biology department.
--method1:
select distinct T.name,T.salary
from instructor T, instructor S
where T.salary>S.salary and S.dept_name='Biology'
--method2:
select distinct name,salary
from instructor
where salary>some(select salary from instructor where dept_name='Biology')
--Find the names of all instructors whose salary is greater than the
--salary of all instructors in the Biology department.

--method-1
select distinct name,salary
from instructor
where salary>all(select salary from instructor where dept_name='Biology') --it finds instructors who earn more than the highest-paid Biology instructor

--method2

SELECT DISTINCT name, salary
FROM instructor
WHERE salary > (
    SELECT MAX(salary)
    FROM instructor
    WHERE dept_name = 'Biology'
);

--Find the departments that have the highest average salary.
select dept_name,avg(salary)
from instructor
group by dept_name
having avg(salary)>=all(select avg(salary) from instructor group by dept_name) -- compares with all the avg salary and give the highest
--exists

SELECT course_id
FROM section S
WHERE semester = 'Fall' AND year = 2017
  AND EXISTS (
    SELECT 1
    FROM section T
    WHERE semester = 'Spring' AND year = 2018
      AND S.course_id = T.course_id
);
--the outer one find out all the courses that is in Fall sem and year 2017
--the inner one select the spring and 2018
--and exists find out the common
--work as intersect

--Find all students who have taken all courses offered in the Biology dept.

--method-1
select distinct S.ID, S.name -- all the students
from student S
where not exists
(
    (select course_id from course where dept_name='Biology') -- all the courses from Bio dept
    minus
    (select T.course_id from takes T where S.ID = T.ID) --all the course id where Student ID matches Takes ID
)

--method 2
SELECT S.ID, S.name
FROM student S
WHERE NOT EXISTS (
    SELECT * FROM course C 
    WHERE C.dept_name = 'Biology'
    AND NOT EXISTS (
        SELECT * FROM takes T
        WHERE T.ID = S.ID AND T.course_id = C.course_id
    )
); --from gpt

--unique- returns true if there is no duplicate element

--Find all the courses that were offered exactly once in year in 2018

--method-1
select T.course_id --take one course id from course T and checks if it offered exactly once from section
from course T
where 1=(select count(R.course_id) from section R where T.course_id=R.course_id and R.year=2018)
--method-2
select course_id
from section
where year=2018
group by course_id
having count(*)=1

--Find the average instructors’ salaries of those departments where the average
--salary is greater than $42,000.

--method-1

select dept_name,avg(salary)
from instructor
group by dept_name    
having avg(salary)>=42000

--method 2

select dept_name,avg_salary
from (select dept_name,avg(salary) as avg_salary from instructor
    group by dept_name)
where avg_salary>=42000
    
--Find the names of each instructor, along with their salary and the
--average salary in their department

select i1.name, i1.salary, dept_avg.avg_salary
from instructor i1,
LATERAL (
    SELECT AVG(i2.salary) AS avg_salary
    FROM instructor i2
    WHERE i1.dept_name = i2.dept_name
) AS dept_avg;

--with use

-- step1: Get total salary per department
with dept_total (dept_name, value) as (
  select dept_name, SUM(salary)
  from  instructor
  group by dept_name
),

-- Step 2: Get average of total salaries across departments
dept_total_avg(value) as (
  select avg(value)
  from dept_total
)

-- Final query: Find departments where total salary >= average total
select dept_name
from dept_total, dept_total_avg
where dept_total.value >= dept_total_avg.value;

-- Scalar subquery
--Lists all departments along with the number of instructors in each department

--method-1
select d.dept_name, --takes all the dept name
(
    select count(*) -- from the instructor where it matches the dept_name count it
    from instructor i
    where d.dept_name=i.dept_name
) as num_instructor
from department d

--method-2

SELECT department.dept_name, COUNT(*)
FROM instructor
JOIN department ON instructor.dept_name = department.dept_name
GROUP BY department.dept_name; --gpt

--delete

delete instructor
where dept_name='Music' -- the instructor whose dept name is MUSIC will be deleted

--update if we want to modify a partcular column

--increases the salary by 5% for instructors whose current salary is greater than or equal to 70,000.
--method-1   
update instructor
set salary=salary*1.05
where salary>=70000

--method-2 (delete and insert method)

DELETE FROM instructor -- first deleting all the rows that meet the condition
WHERE salary >= 70000;

INSERT INTO instructor (ID, name, dept_name, salary)
SELECT ID, name, dept_name, salary * 1.05
FROM instructor_backup -- copy table of instructor . Take the values from there and insert into instructor table with updated value
WHERE salary >= 70000;

--update with case when multiple cases are included


update instructor
set salary=case
when salary<=700000 then salary*1.07
when salary<=100000 then salary*1.05
else salary*1.03
end

--Scaler with upadate
--Write an SQL query to update the tot_cred field in the student table.
--The value should be the sum of credits for all courses a student has taken, excluding those with a grade of 'F' or NULL.

--student: Contains student information (e.g., student ID).

--takes: Contains records of which courses each student has taken, along with their grades.

--course: Contains details about each course, including the number of credits.
update student S
set tot_cred=(select sum(course.credits) from takes natural join course where S.id=takes.id and
    takes.grade<>'F'and takes.grade is not null)

--first take student table to update
--then from course table sum the total cred where s.id matches with takes.id and takes.grade is not null and f
--takes and course natural join and make a table

















