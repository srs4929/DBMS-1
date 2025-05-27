-- a)Find the ids and names of all student who were taught by an instructor named Einstein;
--make sure there are no duplicates in the result and sort the data by names in reverse lexagraphical word

select distinct s.id,s.name
from student s,takes tk,teaches ts,instructor i
where s.id=tk.id 
    and ts.id=i.id
    and tk.course_id=ts.course_id
    and tk.semester=ts.semester
    and tk.year=ts.year
    and tk.sec_id=ts.sec_id
    and i.name='Einstein'
order by s.name desc
--b)Find all instructors earning highest salary
--method-1
select name,salary
from instructor
where salary=(select max(salary) from instructor)
--method-2
select name,salary
from instructor 
where salary>=all(select salary from instructor)

--d)Increase the salary of each instructor in the Comp.Sci department by 10%
   
update instructor
set salary= salary*1.1
            where dept_name='Comp. Sci.'
--e) Delete all course that have never been offered

--method1
delete from course
where course_id not in (select course_id from section)
--method 2
delete from course
where not exists
(
    select 1 from
    course,section 
    where course.course_id=section.course_id
    
)
   
-- Insert every student whose tot_cred attribute is greater than 100 as an instructor in the same dept with a salary of 30000
insert into instructor
select id,name,dept_name,30000
from student
where tot_cred>100

--Find the id and name of each student who has taken at least one 'Comp. Sci.' course
--method-1
select distinct s.id,s.name --not sure
from student s,course c,takes t
where s.id=t.id
and c.title='Comp. Sci'
and c.course_id=t.course_id
--method 2
select distinct id,name
from student 
where id in(select id from takes,course 
           where takes.course_id=course.course_id
           and course.title='Comp. Sci')
