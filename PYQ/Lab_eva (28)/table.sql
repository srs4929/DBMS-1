create table employee(
    emp_id int,
    first_name varchar(20),
    last_name varchar(20),
    division varchar(20),
    cell_no varchar(11) unique,
    blood_group varchar(4),
    salary number(10,0),
    marital_status varchar(9),
    employee_type varchar(10),
    dob date,
    primary key(emp_id),
    constraint salary_chk check (salary>=8250 and salary<=78000),
    constraint division_chk check(division in('Dhaka','Chittagong', 'Rangpur', 'Barishal', 'Khulna', 'Sylhet', 'Rajshahi')),
    constraint blood_chk check(blood_group in('A+','A-','B+','B-','O+','O-','AB+')),
    constraint cell_chk check(substr(cell_no,1,3)in('017','015','016','019'))
    
)

create table workplace(
    wp_id int,
    wp_name varchar(20) not null,
    wp_type varchar(20) not null,
    location varchar(50),
    primary key (wp_id)
 ) 

create table employee_work (
    emp_id int,
    wp_id int,
    join_date date,
    increment_rate number(10,2),
    designation varchar(20),
    primary key(emp_id,wp_id),
    foreign key (emp_id) references employee(emp_id),
    foreign key (wp_id) references  workplace(wp_id)
)

create table car
(
    car_id int,
    emp_id int,
    car_name varchar(15),
    brand varchar(15),
    reg_year varchar(7),
    primary key(car_id),
    foreign key (emp_id) references employee(emp_id)
)

create table residence (
    res_id int,      
    emp_id int,                        
    building_name VARCHAR(50),
    room_no VARCHAR(10),
    --hall_accommodation BOOLEAN,
    primary key(res_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

create table child(
    child_name varchar(20),
    emp_id int,
    dob date,
    edu_levl varchar(20),
    institution varchar(50),
    primary key(child_name,emp_id,dob),
    foreign key (emp_id) references employee(emp_id)
)

--value insertion 
INSERT INTO employee VALUES (101, 'Rezaul', 'Karim', 'Dhaka', '01712345678', 'A+', 60000, 'Married', 'Teacher', DATE '1975-06-15');
INSERT INTO employee VALUES (102, 'Anika', 'Sultana', 'Chittagong', '01623456789', 'B+', 48000, 'Single', 'Officer', DATE '1985-11-20');
INSERT INTO employee VALUES (103, 'Sabbir', 'Ahmed', 'Rajshahi', '01534567890', 'O+', 30000, 'Married', '3rd_class', DATE '1990-03-12');
INSERT INTO employee VALUES (104, 'Fatema', 'Begum', 'Khulna', '01998765432', 'AB+', 25000, 'Divorced', '4th_class', DATE '1988-09-05');
INSERT INTO employee VALUES (105, 'Tariq', 'Hasan', 'Sylhet', '01787654321', 'A-', 75000, 'Married', 'Teacher', DATE '1980-01-10');
INSERT INTO employee VALUES (105, 'Tariq', 'Hasan', 'Sylhet', '01787654321', 'A-', 75000, 'Married', 'Teacher', DATE '1980-01-10');

INSERT INTO workplace VALUES (1, 'CSE', 'Department', 'Curzon Hall');
INSERT INTO workplace VALUES (2, 'EEE', 'Department', 'Science Annex');
INSERT INTO workplace VALUES (3, 'FH Hall Office', 'Hall Office', 'Fazlul Huq Hall');
INSERT INTO workplace VALUES (4, 'Registrar Office', 'Office', 'Admin Building');
INSERT INTO workplace VALUES (5, 'Proctor Office', 'Office', 'Main Campus');

INSERT INTO employee_work VALUES (101, 1, DATE '2010-01-01', 5.00, 'Professor');
INSERT INTO employee_work VALUES (102, 2, DATE '2015-06-01', 4.50, 'Officer');
INSERT INTO employee_work VALUES (103, 3, DATE '2017-03-15', 3.00, 'Technician');
INSERT INTO employee_work VALUES (104, 3, DATE '2018-09-01', 2.50, 'Support Staff');
INSERT INTO employee_work VALUES (105, 4, DATE '2012-02-20', 4.00, 'Lecturer');
INSERT INTO employee_work (emp_id, wp_id, join_date, increment_rate, designation)
VALUES (106, 10, TO_DATE('2010-07-01', 'YYYY-MM-DD'), 5.00, 'Professor');

INSERT INTO car VALUES (1, 101, 'Axio', 'Toyota', '2015');
INSERT INTO car VALUES (2, 102, 'Corolla', 'Toyota', '2018');
INSERT INTO car VALUES (3, 105, 'Premio', 'Toyota', '2017');

INSERT INTO residence VALUES (1, 101, 'Shaheed Abul Khair Bhaban', 'B12');
INSERT INTO residence VALUES (2, 102, 'Shaheed Abul Khair Bhaban', 'A05');
INSERT INTO residence VALUES (3, 103, 'TSC Quarter', 'C07');
INSERT INTO residence VALUES (4, 104, 'Shaheed Sergeant Zahurul Haq Hall', 'G21');
INSERT INTO residence VALUES (5, 105, 'Shaheed Abul Khair Bhaban', 'D15');

INSERT INTO child VALUES ('Imran', 101, DATE '2005-06-10', 'Secondary', 'University Laboratory School');
INSERT INTO child VALUES ('Nabila', 103, DATE '2010-04-20', 'Primary', 'University Laboratory School');
INSERT INTO child VALUES ('Samiha', 105, DATE '2003-12-25', 'Higher Secondary', 'Dhaka College');
INSERT INTO child VALUES ('Rafi', 105, DATE '2007-01-15', 'Primary', 'Udayan School');
INSERT INTO child VALUES ('Samaha', 105, DATE '2003-01-15', 'Higher Secondary', 'Dhaka University');

--Find the names of the employees along with division and date of birth who
--belong to ‘CSE’, ‘EEE’ or ‘FH Hall Office’ offices and have at least 25
--characters as their names

select first_name,last_name,division,dob
from employee,(employee_work natural join workplace)
where employee.emp_id=employee_work.emp_id
and workplace.wp_name in('CSE','EEE','FH Hall Office')
and length(employee.first_name||employee.last_name)>=25

--Find the information of the children with their parents who study in
--different department/institutes of the Dhaka university    
select*
from employee,child
where employee.emp_id=child.emp_id
and child.institution='Dhaka University'



--) Delete the residence information of the employees who have ‘125’ in the 4
--th, 5th and 6th digits in their mobile numbers.

INSERT INTO employee 
VALUES (
  107, 'Shafiq', 'Hossain', 'Barishal', '01712567890', 
  'O+', 42000, 'Single', 'Officer', DATE '1987-07-25'
);
INSERT INTO residence 
VALUES (
  6, 107, 'New Staff Quarter', 'E05'
);


delete from residence
where emp_id=(select emp_id from employee 
              where substr(cell_no,4,3)='125')

--Find the number of employees and total salary for each workplace
--(department, offices or hall offices) where average salary of such workplace
--is greater than the minimum total salary among all the offices (use with
--clause). 
with minsal(minisalary) as --vhul hoise ig
(
    select min(total_salary) as minall
    from
    (
      select sum(salary) as total_salary
      from employee natural join employee_work,workplace
      where employee_work.wp_id=workplace.wp_id
      and workplace.wp_type='Office'
      group by wp_name
    )
)
select count(emp_id),sum(salary),wp_name
from employee natural join employee_work,workplace
where employee_work.wp_id=workplace.wp_id    
group by wp_name    
having avg(salary)> (select minisalary from minsal);

--Find the employees who do not have any children
--method1
select  e.emp_id,e.first_name,e.last_name
from employee e
where emp_id in(select emp_id
              from employee
              minus
              select emp_id
              from child
              )
--method2
select e.emp_id,e.first_name,e.last_name
from employee e
where not exists
(
    select 1
    from child c
    where c.emp_id=e.emp_id
)




