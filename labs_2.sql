
DROP PACKAGE show_dates;

CREATE PACKAGE show_dates AS 
PROCEDURE get_all_dep;
PROCEDURE get_employees_in_dep;
PROCEDURE add_new_dep;
PROCEDURE add_kek(dep_id DEPARTMENTS.DEPARTMENT_ID%TYPE,dep_name DEPARTMENTS.DEPARTMENT_NAME%TYPE,
dep_mang DEPARTMENTS.MANAGER_ID%TYPE, dep_loc DEPARTMENTS.LOCATION_ID%TYPE );
END show_dates;

CREATE PACKAGE BODY show_dates AS

PROCEDURE html_start IS
BEGIN
HTP.HTMLOPEN; 
HTP.HEADOPEN;
HTP.META('Content-Type', NULL, 'text/html;charset=utf-8');
HTP.TITLE('LB TWO -- PLSQL');
HTP.HEADCLOSE;
HTP.BODYOPEN;
END html_start;

PROCEDURE html_end IS
BEGIN 
HTP.BODYCLOSE;
HTP.HTMLCLOSE;
END html_end;

PROCEDURE get_all_dep IS
dep_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
dep_id DEPARTMENTS.DEPARTMENT_ID%TYPE;
CURSOR cur_dep IS 
SELECT DEPARTMENT_ID,DEPARTMENT_NAME FROM DEPARTMENTS;
BEGIN
html_start;
OPEN cur_dep;
HTP.P('<table style="border:2px solid black">');
LOOP
FETCH cur_dep into dep_id ,dep_name;
EXIT WHEN cur_dep%NOTFOUND;
HTP.P('<tr>'||'<td style="border:2px solid black" >'||dep_id||'</td>'||'<td style="border:2px solid black">'||dep_name||'</td>'||'</tr>');
END LOOP;
HTP.P('</table>');
CLOSE cur_dep;
html_end;
END get_all_dep;


PROCEDURE get_all_EMP(dep_id DEPARTMENTS.DEPARTMENT_ID%TYPE,date_str OUT CLOB)
IS
emp_first EMPLOYEES.FIRST_NAME%TYPE;
emp_last EMPLOYEES.LAST_NAME%TYPE;
CURSOR emp_cur IS 
SELECT FIRST_NAME,LAST_NAME from employees 
WHERE DEPARTMENT_ID=dep_id;
BEGIN
OPEN emp_cur;
LOOP
FETCH emp_cur into emp_first,emp_last;
EXIT WHEN emp_cur%NOTFOUND;
date_str:=date_str||' '||emp_first||' '||emp_last||' , ';
END LOOP;
CLOSE emp_cur;
END get_all_EMP;


PROCEDURE get_employees_in_dep IS
get_dep_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
CURSOR dep_cur IS 
select DEPARTMENT_NAME from DEPARTMENTS;
counter INTEGER DEFAULT 0;
CURSOR emp_cur IS 
SELECT FIRST_NAME,LAST_NAME from employees;

emp_name EMPLOYEES.FIRST_NAME%type;
emp_last EMPLOYEES.LAST_NAME%TYPE;

save_date_for_js CLOB;
BEGIN 
html_start;
OPEN dep_cur;
LOOP
FETCH dep_cur into get_dep_name;
EXIT WHEN dep_cur%NOTFOUND;
counter:=counter+10;
get_all_EMP(counter,save_date_for_js);
HTP.P('<input onclick="oneClickAd('||counter||')" id="'||counter||'" type="button" value="'||get_dep_name||'" name="'||save_date_for_js||'" >');
HTP.P('<br>');
HTP.P('
<script>
let oneClickAd = function(idElement) {
let element=document.getElementById(idElement);
alert(element.name);
};
</script>');
END LOOP;
CLOSE dep_cur;
html_end;
END get_employees_in_dep;

PROCEDURE add_kek(dep_id DEPARTMENTS.DEPARTMENT_ID%TYPE,dep_name DEPARTMENTS.DEPARTMENT_NAME%TYPE,
dep_mang DEPARTMENTS.MANAGER_ID%TYPE, dep_loc DEPARTMENTS.LOCATION_ID%TYPE )
IS
BEGIN
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID,LOCATION_ID)
VALUES (dep_id, dep_name , dep_mang , dep_loc);
HTP.P('DONE date save');
get_employees_in_dep;
END;

PROCEDURE add_new_dep IS 
BEGIN 
html_start;
HTP.P('
<form action="show_dates.add_kek" method="POST">
<input type="text" name="dep_id" />
<input type="text" name="dep_name" />
<input type="text" name="dep_mang" />
<input type="text" name="dep_loc" />
<input type="submit"/>
</form>
');
html_end;
END add_new_dep;
 
END show_dates;