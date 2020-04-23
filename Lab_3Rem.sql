DROP PACKAGE emp_proc;

CREATE PACKAGE emp_proc
IS
PROCEDURE show_all_emp;
PROCEDURE add_new_emp;
PROCEDURE add_emp_action(
    emp_id EMPLOYEES.EMPLOYEE_ID%TYPE,
    emp_first EMPLOYEES.FIRST_NAME%TYPE,
    emp_last EMPLOYEES.LAST_NAME%TYPE,
    emp_email EMPLOYEES.EMAIL%TYPE,
    emp_pNumber EMPLOYEES.PHONE_NUMBER%TYPE,
    emp_hireDate EMPLOYEES.HIRE_DATE%TYPE,
    emp_jobId EMPLOYEES.JOB_ID%TYPE,
    emp_salary EMPLOYEES.SALARY%TYPE,
    emp_Commision EMPLOYEES.COMMISSION_PCT%TYPE,
    emp_ManagerId EMPLOYEES.MANAGER_ID%TYPE,
    emp_DepartmanentID EMPLOYEES.DEPARTMENT_ID%TYPE
);
END emp_proc;

CREATE PACKAGE BODY emp_proc IS
PROCEDURE html_start IS
BEGIN
HTP.HTMLOPEN; 
HTP.HEADOPEN;
HTP.META('Content-Type', NULL, 'text/html;charset=utf-8');
HTP.TITLE('LB three -- PLSQL');
HTP.HEADCLOSE;
HTP.BODYOPEN;
END html_start;

PROCEDURE html_end IS
BEGIN 
HTP.BODYCLOSE;
HTP.HTMLCLOSE;
END html_end;

PROCEDURE add_emp_action (
    emp_id EMPLOYEES.EMPLOYEE_ID%TYPE,
    emp_first EMPLOYEES.FIRST_NAME%TYPE,
    emp_last EMPLOYEES.LAST_NAME%TYPE,
    emp_email EMPLOYEES.EMAIL%TYPE,
    emp_pNumber EMPLOYEES.PHONE_NUMBER%TYPE,
    emp_hireDate EMPLOYEES.HIRE_DATE%TYPE,
    emp_jobId EMPLOYEES.JOB_ID%TYPE,
    emp_salary EMPLOYEES.SALARY%TYPE,
    emp_Commision EMPLOYEES.COMMISSION_PCT%TYPE,
    emp_ManagerId EMPLOYEES.MANAGER_ID%TYPE,
    emp_DepartmanentID EMPLOYEES.DEPARTMENT_ID%TYPE
) IS
BEGIN
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
VALUES (emp_id, emp_first, emp_last,emp_email,emp_pNumber,emp_hireDate,emp_jobId,emp_salary,emp_Commision,emp_ManagerId,emp_DepartmanentID); 
html_start;
HTP.P('DONE');
html_end;
END add_emp_action;

PROCEDURE show_all_emp IS
CURSOR cur_emp IS 
SELECT * FROM EMPLOYEES;
emp_rec EMPLOYEES%ROWTYPE;
BEGIN
html_start;
OPEN cur_emp;
HTP.P('<table align="center" style="border:2px solid black">');
HTP.P('<tr>');
HTP.P('<td style="border:2px solid black">EMPLOYEE_ID</td>');
HTP.P('<td style="border:2px solid black">FIRST_NAME</td>');
HTP.P('<td style="border:2px solid black">LAST_NAME</td>');
HTP.P('<td style="border:2px solid black">EMAIL</td>');
HTP.P('<td style="border:2px solid black">PHONE_NUMBER</td>');
HTP.P('<td style="border:2px solid black">HIRE_DATE</td>');
HTP.P('<td style="border:2px solid black">JOB_ID</td>');
HTP.P('<td style="border:2px solid black">SALARY</td>');
HTP.P('<td style="border:2px solid black">COMMISSION_PCT</td>');
HTP.P('<td style="border:2px solid black">MANAGER_ID</td>');
HTP.P('<td style="border:2px solid black">DEPARTMENT_ID</td>');
HTP.P('</tr>');
LOOP
FETCH cur_emp into emp_rec;
EXIT WHEN cur_emp%notfound;
HTP.P('<tr>');
HTP.P('<td style="border:2px solid black">'||emp_rec.EMPLOYEE_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.FIRST_NAME||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.LAST_NAME||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.EMAIL||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.PHONE_NUMBER||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.HIRE_DATE||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.JOB_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.SALARY||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.COMMISSION_PCT||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.MANAGER_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.DEPARTMENT_ID||'</td>');
HTP.P('</tr>');
END LOOP;
HTP.P('</table>');
CLOSE cur_emp;
html_end;
END show_all_emp;

PROCEDURE add_new_emp IS
BEGIN
html_start;
HTP.P('<form style="display:flex;flex-direction:column;border:2px solid black;" action="emp_proc.add_emp_action" method="POST">');
HTP.P('Employee_id: <input type="text" name="emp_id" />');
HTP.P('First_Name: <input type="text" name="emp_first" />');
HTP.P('Last_Name: <input type="text" name="emp_last" />');
HTP.P('Email: <input type="text" name="emp_email" />');
HTP.P('Phone Number: <input id="emp_pNumber" type="text" name="emp_pNumber" />');
HTP.P('Hire Date: <input id="emp_hireDate" type="text" name="emp_hireDate" />');
HTP.P('Job Id: <input id="emp_jobId" type="text" name="emp_jobId" />');
HTP.P('Salary: <input id="emp_salary" type="text" name="emp_salary" />');
HTP.P('Commision Pct: <input id="emp_Commision" type="text" name="emp_Commision" />');
HTP.P('Manager Id: <input id="emp_ManagerId" type="text" name="emp_ManagerId" />');
HTP.P('Department Id: <input id="emp_DepartmanentID" type="text" name="emp_DepartmanentID" />');
HTP.P('<input type="submit">');
HTP.P('</form>');
html_end;
END add_new_emp;

END emp_proc;


CREATE PACKAGE BODY emp_proc AS

PROCEDURE html_start IS
BEGIN
HTP.HTMLOPEN; 
HTP.HEADOPEN;
HTP.META('Content-Type', NULL, 'text/html;charset=utf-8');
HTP.TITLE('LB three -- PLSQL');
HTP.HEADCLOSE;
HTP.BODYOPEN;
END html_start;

PROCEDURE html_end IS
BEGIN 
HTP.BODYCLOSE;
HTP.HTMLCLOSE;
END html_end;

PROCEDURE show_all_emp IS
CURSOR cur_emp IS 
SELECT * FROM EMPLOYEES;
emp_rec EMPLOYEES%ROWTYPE;
BEGIN
html_start;
OPEN cur_emp;
HTP.P('<table align="center" style="border:2px solid black">');
HTP.P('<tr>');
HTP.P('<td style="border:2px solid black">EMPLOYEE_ID</td>');
HTP.P('<td style="border:2px solid black">FIRST_NAME</td>');
HTP.P('<td style="border:2px solid black">LAST_NAME</td>');
HTP.P('<td style="border:2px solid black">EMAIL</td>');
HTP.P('<td style="border:2px solid black">PHONE_NUMBER</td>');
HTP.P('<td style="border:2px solid black">HIRE_DATE</td>');
HTP.P('<td style="border:2px solid black">JOB_ID</td>');
HTP.P('<td style="border:2px solid black">SALARY</td>');
HTP.P('<td style="border:2px solid black">COMMISSION_PCT</td>');
HTP.P('<td style="border:2px solid black">MANAGER_ID</td>');
HTP.P('<td style="border:2px solid black">DEPARTMENT_ID</td>');
HTP.P('</tr>');
LOOP
FETCH cur_emp into emp_rec;
EXIT WHEN cur_emp%notfound;
HTP.P('<tr>');
HTP.P('<td style="border:2px solid black">'||emp_rec.EMPLOYEE_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.FIRST_NAME||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.LAST_NAME||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.EMAIL||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.PHONE_NUMBER||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.HIRE_DATE||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.JOB_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.SALARY||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.COMMISSION_PCT||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.MANAGER_ID||'</td>');
HTP.P('<td style="border:2px solid black">'||emp_rec.DEPARTMENT_ID||'</td>');
HTP.P('</tr>');
END LOOP;
HTP.P('</table>');
CLOSE cur_emp;
html_end;
END show_all_emp;

PROCEDURE add_new_emp IS
BEGIN
html_start;
HTP.P('<form style="display:flex;flex-direction:column;border:2px solid black;" action="emp_proc.add_exmaple" method="POST">');
HTP.P('Employee_id: <input type="text" name="emp_id" />');
HTP.P('First_Name: <input type="text" name="emp_first" />');
HTP.P('Last_Name: <input type="text" name="emp_last" />');
HTP.P('Email: <input type="text" name="emp_email" />');
HTP.P('Phone Number: <input id="emp_pNumber" type="text" name="emp_pNumber" />');
HTP.P('Hire Date: <input id="emp_hireDate" type="text" name="emp_hireDate" />');
HTP.P('Job Id: <input id="emp_jobId" type="text" name="emp_jobId" />');
HTP.P('Salary: <input id="emp_salary" type="text" name="emp_salary" />');
HTP.P('Commision Pct: <input id="emp_Commision" type="text" name="emp_Commision" />');
HTP.P('Manager Id: <input id="emp_ManagerId" type="text" name="emp_ManagerId" />');
HTP.P('Department Id: <input id="emp_DepartmanentID" type="text" name="emp_DepartmanentID" />');
HTP.P('<input type="submit">');
HTP.P('</form>');
html_end;
END add_new_emp;

END emp_proc;