-- Sample SQL script to demonstrate Oracle DB functionality
-- Run this with: sqlplus system/OraclePassword123@oracle-db:1521/XEPDB1 @scripts/sample.sql

-- Connect to the pluggable database
ALTER SESSION SET CONTAINER = XEPDB1;

-- Create a sample schema/user
CREATE USER sample_user IDENTIFIED BY SamplePass123
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;

-- Grant necessary privileges
GRANT CONNECT, RESOURCE TO sample_user;
GRANT CREATE SESSION TO sample_user;
GRANT CREATE TABLE TO sample_user;
GRANT CREATE VIEW TO sample_user;
GRANT CREATE SEQUENCE TO sample_user;

-- Create a sample table
CREATE TABLE sample_user.employees (
    employee_id NUMBER(6) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    hire_date DATE DEFAULT SYSDATE,
    salary NUMBER(8,2),
    department_id NUMBER(4)
);

-- Create a sequence for employee IDs
CREATE SEQUENCE sample_user.emp_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Insert sample data
INSERT INTO sample_user.employees (employee_id, first_name, last_name, email, salary, department_id)
VALUES (sample_user.emp_seq.NEXTVAL, 'John', 'Doe', 'john.doe@example.com', 50000, 10);

INSERT INTO sample_user.employees (employee_id, first_name, last_name, email, salary, department_id)
VALUES (sample_user.emp_seq.NEXTVAL, 'Jane', 'Smith', 'jane.smith@example.com', 60000, 20);

INSERT INTO sample_user.employees (employee_id, first_name, last_name, email, salary, department_id)
VALUES (sample_user.emp_seq.NEXTVAL, 'Bob', 'Johnson', 'bob.johnson@example.com', 55000, 10);

COMMIT;

-- Verify the data
SELECT * FROM sample_user.employees;

-- Display summary
SELECT 
    'Sample database setup complete!' AS status,
    COUNT(*) AS employee_count
FROM sample_user.employees;
