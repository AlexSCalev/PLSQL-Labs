
-- Home work 1 create function in plsql how show week odd or even 
CREATE OR REPLACE FUNCTION get_Odd_Even_Week(user_date DATE DEFAULT SYSDATE ) RETURN VARCHAR2 
IS 
ret_value VARCHAR2(10);
first_sept DATE DEFAULT TO_DATE('1/9/2019','dd/mm/yyyy');
between_week FLOAT;
BEGIN
between_week:=(user_date-first_sept)/7;
IF MOD(TRUNC(between_week,0),2)=0 THEN
IF MOD(between_week,1) = 0 THEN 
DBMS_OUTPUT.PUT_LINE('Odd');
ELSE
DBMS_OUTPUT.PUT_LINE('Even');
END IF;
ELSE
IF MOD(between_week,1) = 0 THEN 
DBMS_OUTPUT.PUT_LINE('Even');
ELSE
DBMS_OUTPUT.PUT_LINE('Odd');
END IF;
END IF; 
RETURN 'FALSE';
END;
