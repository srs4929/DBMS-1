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
