-- Find the ids and names of all student who were taught by an instructor named Einstein;
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
   
