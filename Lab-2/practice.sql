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

--creating loan table
create table loan
(loan_no char(5),
branch_name varchar2(15),
amount number(10,2) not null,
constraint pk_loan_no primary key (loan_no),
constraint fk_br_nm foreign key (branch_name) references branch(branch_name),
constraint ch_amount check (amount >= 0),
constraint ch_lo_no check (loan_no like 'L-%'));

--creating depositor table
create table depositor
(
   customer_id varchar2(5) ,
   account_no char(5) ,
   constraint pk_ci_an primary key(customer_id,account_no) , -- here for identifying primary key we need two key and both of the key is primary key of another table
   constraint fk_ci foreign key (customer_id)  references customer(customer_id),
   constraint fk_ac_no foreign key (account_no)  references account(account_no)
);

-- creating borrower table
create table borrower
(
   customer_id varchar2(5),
   loan_no char(5),
   constraint pk_cui_lo primary key(customer_id,loan_no) ,
   constraint fk_cui foreign key(customer_id) references customer(customer_id),
   constraint fk_lo foreign key (loan_no)  references loan(loan_no)
);

--describe table
describe borrower -- it will show table details
-- Output:
-- NAME         NULL?     TYPE
-- ------------ --------- ----------
-- CUSTOMER_ID  NOT NULL  VARCHAR2(5)
-- LOAN_NO      NOT NULL  CHAR(5)

--Since customer_id and loan_no both are primary key they can not be null .
