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



