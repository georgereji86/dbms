SET SERVEROUTPUT ON;

DECLARE
    v_salary DECIMAL(10, 2);
    v_emp_id_for_salary INT := &employee_id_for_salary;  -- Prompt for EmployeesID to get salary
    v_emp_id_for_deletion INT := &employee_id_for_deletion;  -- Prompt for EmployeesID to delete
BEGIN
    -- Add employees
    Employee_Package.Add_Employee(101, 'Alice Johnson', '101 Maple St', 55000);
    Employee_Package.Add_Employee(102, 'Bob Smith', '202 Oak St', 60000);
    Employee_Package.Add_Employee(103, 'Charlie Brown', '303 Pine St', 50000);
    Employee_Package.Add_Employee(104, 'Emma Watson', '403 Rose St', 53000);
    
    -- List all employees
    Employee_Package.List_Employees;
    
    -- Get salary of an employee
    v_salary := Employee_Package.Get_Salary(v_emp_id_for_salary);  -- Get salary for user-specified EmployeeID
    IF v_salary IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Salary of EmployeesID ' || v_emp_id_for_salary || ': ' || v_salary);
    END IF;
    
    -- Delete an employee
    Employee_Package.Delete_Employee(v_emp_id_for_deletion);  -- Delete employee with user-specified ID
    
    -- List employees again
    Employee_Package.List_Employees;
END;
/
