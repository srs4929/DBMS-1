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
    primary key(emp_id),
    constraint salary_chk check (salary>=8250 and salary<=78000),
    constraint division_chk check(division in('Dhaka','Chittagong', 'Rangpur', 'Barishal', 'Khulna', 'Sylhet', 'Rajshahi')),
    constraint blood_chk check(blood_group in('A+','A-','B+','B-','O+','O-','AB+')),
    constraint cell_chk check(substr(cell_no,1,3)in('017','015','016','019'))
    
)
