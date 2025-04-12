--creating table
--branch table
--T10 style
create table branch(          
   branch_name varchar(15)  primary key,
   branch_city varchar(15) not null,
   assets number check(assets>=10000)  -- checking assets value. If the value less than 10000 is given will show error
);
-- creating customer table
--T20 style
create table customer
(
   customer_id varchar(5) ,
   customer_name varchar2(15) ,
   customer_street varchar2(12) ,
   customer_city varchar2(12)  not null,
   cell varchar2(11) unique,
   dob date not null,
   primary key(customer_id)  
);

--creating account table
--One day style
--If we do not give constraints by default it give constraints then we can not determine error. So we should give constraints to identify error
create table account
(
  account_no char(5),
  branch_name varchar2(10),
  balance number(10,2) not null,
  constraints pk_ac_no primary key(account_no) ,
  constraints fk_br_name foreign key(branch_name) references branch (branch_name) , -- branch_name is coming from another table. Since it is primary key of another table it is known as foreign key
  constraints bal check(balance>=0),
  constraints ch_ac_no check(account_no like'A-%')  
);
