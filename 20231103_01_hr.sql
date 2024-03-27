SELECT USER
FROM DUAL;
-- HR

-- ��(VIEW) --

-- 1.��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ� �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ�
-- �����͵鸸�� ��Ȯ���� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ� 
-- �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ ����

-- ������ ���̺��̶� �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶� �ϳ� �̻��� ���̺���
-- �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̶�� �ǹ��̸�, �� ������ �����س��� SQL �����̶�� �� �� ����

--2. ���� �� ���� 
-- CREATE [OR REPLACE] VIEW ���̸�
-- [ALIAS[,ALIAS, ... ])]
-- AS
-- ��������(SUBQUERY)
--[WITH CRECK OPTION]
--[WITH READ ONLY]

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID;

-- �� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID;
-- View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

-- ��(VIEW) ��ȸ 
SELECT *
FROM VIEW_EMPLOYEES;

-- �� ��(VIEW)�� ���� Ȯ��
DESC VIEW_EMPLOYEES;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/

-- �� ��(VIEW) �ҽ� Ȯ�� CHECK ~!

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES'
/*
VIEW_EMPLOYEES	
"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
 AND D.LOCATION_ID = L.LOCATION_ID
 AND L.COUNTRY_ID = C.COUNTRY_ID
 AND C.REGION_ID = R.REGION_ID"
*/