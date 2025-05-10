create table employee
(
    id varchar(4),
    person_name varchar(10),
    street varchar(7),
    city varchar(8),
    constraint pk_id primary key (id)
)

create table works
(
    id varchar(2),
    branch_name varchar(5),
    salary number(10,0),
    constraint wo_id foreign key (id) references employee(id),
    foreign key (branch_name) references company(branch_name),
    constraint sal check(salary>=0)
    
)

create table company
(
    branch_name varchar(5),
    city varchar(5),
    primary key (branch_name)
)

create table manages
(
    id varchar(4),
    manager_id varchar(5),
    foreign key (id) references employee(id) 
)
