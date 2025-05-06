select* from inst_dup -- dummy table where some values are null
select count(*) from inst_dup -- total number of rows output:12
select count(salary) from inst_dup -- total number of salary . Some values are null . So it will show 9
select count(salary) from inst_dup where salary is  null -- Output: 0 . Salary is nul in these places. So count 0
select count(*) from inst_dup where salary is  null -- Output 3 . Go to the row where salary is null then count the rows
