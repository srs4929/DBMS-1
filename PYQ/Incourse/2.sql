create table employee
(
    id varchar(4),
    person_name varchar(10),
    street varchar(20),
    city varchar(20),
    constraint pk_id primary key (id)
)

create table works
(
    id varchar(10),
    branch_name varchar(20),
    salary number(10,0),
    constraint wo_id foreign key (id) references employee(id),
    foreign key (branch_name) references company(branch_name),
    constraint sal check(salary>=0)
    
)

create table company
(
    branch_name varchar(10),
    city varchar(10),
    primary key (branch_name)
)

create table manages
(
    id varchar(10),
    manager_id varchar(15),
    foreign key (id) references employee(id) 
)

--a) Modify the database so that employee whose id is '12345' now works in a branch located in 'Newtown'
update works
set branch_name='Newtown'
where id='12345'
--b) Give each manager of "First bank corporation" a 10 percent raise unless the salary becomes greater than Tk.10,0000 unless give a 3 percent raise
update works
set salary = case
                when salary * 1.1 < 100000 then salary * 1.1
                else salary * 1.03
             end
where id in  (
    select manager_id
    from  manages
    where manager_id in (
        select id
        from  works
        where branch_name = 'First bank Corporation'
    )
);
