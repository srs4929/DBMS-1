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

