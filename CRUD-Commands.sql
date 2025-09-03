-- CREATE TABLE employees SQL statement.
create table employees(
    employee_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    hire_date date default (current_date),
    email varchar(100) unique,
    phone_number varchar(100) unique,
    salary decimal(10,2) check (salary > 0.0),
    employment_status enum('active', 'on leave', 'terminated') default 'active'
);
-- A few notes/corrections:
-- 1) ✅ DEFAULT (current_date) is the right function for today’s date in MySQL.
-- 2) ⚠️ The CHECK constraint is supported in MySQL 8.0.16+, but in earlier versions it’s parsed but ignored.
-- 3)  used enum correctly — default is 'active'.
-- 4) Table design looks good for a basic employee system.

-- Compared to the first version, this one has extra audit fields for tracking record creation and updates. Here’s the cleaned-up SQL:
create table employees (
    employee_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    hire_date date default (current_date),
    email varchar(100) unique,
    phone_number varchar(100) unique,
    salary decimal(10,2) check (salary > 0.0),
    employment_status enum('active', 'on leave', 'terminated') default 'active',
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
);
-- Key Additions:
-- created_at → automatically stores the time the record is inserted.
-- updated_at → automatically updates whenever the record changes.
-- This is a very common best practice in database design 👌 because it helps track when records were created or modified.
-- INSERT COMMAND WITH FEW VALUES
insert into employees (first_name, last_name, email, phone_number, salary, employment_status)
values 
('Alice', 'Johnson', 'alice.johnson@example.com', '0871111111', 50000.00, 'active'),
('Bob', 'Smith', 'bob.smith@example.com', '0872222222', 42000.50, 'on leave'),
('Charlie', 'Brown', 'charlie.brown@example.com', '0873333333', 55000.75, 'terminated'),
('Diana', 'Williams', 'diana.williams@example.com', '0874444444', 60000.00, 'active');

-- Then Run
select * from employees;

-- Now Its time to create Second Table which is Department Table
create table departments (
    department_id int primary key auto_increment,
    department_name varchar(100) not null,
    location varchar(100),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp
);
-- INSERT few Data Values in it
insert into departments (department_name, location)
values
('Human Resources', 'Dublin'),
('Finance', 'Cork'),
('IT', 'Galway'),
('Marketing', 'Limerick');
-- see the table
select * from departments;

-- Let’s extend the design so that each employee belongs to a department.
-- We can use several method . The below method is when you create the table add constraints in the table, 
-- but if you have already created both tables then there are alternate method which I will also show below.
-- METHOD 1 , While CREATING TABLES
create table employees (
    employee_id int primary key auto_increment,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    hire_date date default (current_date),
    email varchar(100) unique,
    phone_number varchar(100) unique,
    salary decimal(10,2) check (salary > 0.0),
    employment_status enum('active', 'on leave', 'terminated') default 'active',
    department_id int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp on update current_timestamp,
    
    constraint fk_department
        foreign key (department_id)
        references departments(department_id)
        on delete set null
        on update cascade
);
-- METHOD 2
-- Add a foreign key (if not done during creation)
ALTER TABLE employees
ADD COLUMN department_id INT;
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);
-- OR
ALTER TABLE employees
MODIFY COLUMN department_id INT NOT NULL;
ALTER TABLE employees
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);
-- END both METHODS
-- department_id → connects each employee to a department.
-- foreign key → ensures data integrity: an employee’s department must exist in the departments table.
-- on delete set null → if a department is deleted, employees will not be deleted but their department_id will become NULL.
-- on update cascade → if a department’s department_id changes, it updates automatically in employees.
-- Insert employees assigned to departments
insert into employees (first_name, last_name, email, phone_number, salary, employment_status, department_id)
values
('Alice', 'Johnson', 'alice.johnson@example.com', '0871111111', 50000.00, 'active', 1),
('Bob', 'Smith', 'bob.smith@example.com', '0872222222', 42000.50, 'on leave', 2),
('Charlie', 'Brown', 'charlie.brown@example.com', '0873333333', 55000.75, 'terminated', 3),
('Diana', 'Williams', 'diana.williams@example.com', '0874444444', 60000.00, 'active', 4);

-- ALTER COMMAND
-- ALTER TABLE BY ADDING COLUMN to EMPLOYEES
ALTER TABLE employees
ADD COLUMN description text;
-- Explanation
    -- ALTER TABLE → used to change the structure of an existing table.
    -- ADD COLUMN description text → adds a new column named description of type TEXT.
    -- TEXT is useful for long strings (e.g., employee notes, additional info).
-- Modify column type/size
ALTER TABLE employees
MODIFY COLUMN phone_number varchar(20);
-- Rename a column
ALTER TABLE employees
RENAME COLUMN description employee_notes text;
-- DROP delete column
ALTER TABLE employees
DROP COLUMN description;

ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100) NOT NULL;

ALTER TABLE employees
ADD COLUMN emergency_contact VARCHAR(100) NOT NULL
CHECK (emergency_contact REGEXP '^[A-Za-z ]+: [0-9+-]+$');


