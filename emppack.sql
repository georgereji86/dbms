--TABLE DESIGN
CREATE TABLE Employees (
    Eid INT PRIMARY KEY,               
    Ename VARCHAR(50),
    Eaddress VARCHAR(100),
    Esalary DECIMAL(10, 2)
);

-- PACKAGE CREATION

CREATE OR REPLACE PACKAGE Employee_Package AS
    PROCEDURE Add_Employee(p_Eid IN INT, p_Ename IN VARCHAR2, p_Eaddress IN VARCHAR2, p_Esalary IN DECIMAL);
    PROCEDURE Delete_Employee(p_Eid IN INT);
    PROCEDURE List_Employees;
    FUNCTION Get_Salary(p_Eid IN INT) RETURN DECIMAL;
END Employee_Package;
/

-- PACKAGE BODY

CREATE OR REPLACE PACKAGE BODY Employee_Package AS

    -- Add an employee
    PROCEDURE Add_Employee(p_Eid IN INT, p_Ename IN VARCHAR2, p_Eaddress IN VARCHAR2, p_Esalary IN DECIMAL) AS
    BEGIN
        INSERT INTO Employees (Eid, Ename, Eaddress, Esalary)
        VALUES (p_Eid, p_Ename, p_Eaddress, p_Esalary);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee ' || p_Ename || ' added successfully with ID ' || p_Eid || '.');
    END Add_Employee;

    -- Delete an employee
    PROCEDURE Delete_Employee(p_Eid IN INT) AS
    BEGIN
        DELETE FROM Employees WHERE Eid = p_Eid;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee with ID ' || p_Eid || ' deleted successfully.');
    END Delete_Employee;

    -- List all employees
    PROCEDURE List_Employees AS
        CURSOR emp_cursor IS
            SELECT Eid, Ename, Eaddress, Esalary FROM Employees;
        v_emp emp_cursor%ROWTYPE;
    BEGIN
        OPEN emp_cursor;
        LOOP
            FETCH emp_cursor INTO v_emp;
            EXIT WHEN emp_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || v_emp.Eid || ', Name: ' || v_emp.Ename || ', Address: ' || v_emp.Eaddress || ', Salary: ' || v_emp.Esalary);
        END LOOP;
        CLOSE emp_cursor;
    END List_Employees;

    -- Get salary of an employee
    FUNCTION Get_Salary(p_Eid IN INT) RETURN DECIMAL AS
        v_salary DECIMAL(10, 2);
    BEGIN
        SELECT Esalary INTO v_salary FROM Employees WHERE Eid = p_Eid;
        RETURN v_salary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee with ID ' || p_Eid || ' not found.');
            RETURN NULL;
    END Get_Salary;

END Employee_Package;
/
