SELECT USER 
FROM DUAL;

-- ���������� Ȱ���Ͽ� 
-- TBL_SAWON ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �� 
-- ����� ���� ���糪�� �޿� ���̺��ʽ� 
-- VIEW_SAWON�� �̿��ϴ°��� �ƴ�
-- ���̺��ʽ��� ���� ���̰� 40�� �̻��̸� �޿��� 70%
-- 30�� �̻� 40�� �̸��̸� �޿��� 50%
-- 20�� �̻� 30�� �̸����� �޿��� 30%�� ��

-- ���� �̷��� �ϼ��� ��ȸ ������ ���� 
-- VIEW_SAWON2��� �̸��� ��(VIEW)�� ������ �� �ֵ��� �� 


SELECT T.*
        , CASE WHEN T.���糪�� >= 40 THEN T.�޿� * 0.7
               WHEN T.���糪�� >= 30 THEN T.�޿� * 0.5
               WHEN T.���糪�� >= 20 THEN T.�޿� * 0.3
               ELSE 0
            END ���̺��ʽ�
FROM
(
SELECT SANAME "�����"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
               WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
               ELSE '����Ȯ�κҰ�'
        END "����"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
            END "���糪��"
        , SAL �޿�
FROM TBL_SAWON
) T;

/*
������	����	27	3000	900
�ڰ���	����	29	4000	1200
�ڳ���	����	25	4000	1200
������	����	27	5000	1500
������	����	19	1000	0
������	����	18	1000	0
�μ���	����	59	2000	1400
������	����	55	2000	1400
���̰�	����	19	1500	0
������	����	58	1300	910
������	����	29	4000	1200
���켱	����	18	2000	0
����	����	59	2000	1400
������	����	25	2000	600
���ù�	����	22	2300	690
*/

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.�����, T.����, T.�޿�, T.����
    , CASE WHEN T.���� >= 40 THEN T.�޿�*0.7
           WHEN T.���� <= 39 AND T.����>= 30 THEN T.�޿�*0.5
           WHEN T.���� <= 29 AND T.����>= 20 THEN T.�޿�*0.3
           ELSE 0
        END "���̺��ʽ�"
FROM (
    SELECT SANAME �����
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'  
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
          END "����"
        , SAL �޿�
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
          END "����"
    FROM TBL_SAWON
)T;
-- View VIEW_SAWON2��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON2;
/*
������	��	3000	27	900
�ڰ���	��	4000	29	1200
�ڳ���	��	4000	25	1200
������	��	5000	27	1500
������	��	1000	19	0
������	��	1000	18	0
�μ���	��	2000	59	1400
������	��	2000	55	1400
���̰�	��	1500	19	0
������	��	1300	58	910
������	��	4000	29	1200
���켱	��	2000	18	0
����	��	2000	59	1400
������	��	2000	25	600
���ù�	��	2300	22	690
*/
-----------------------------------------------------------------------------

-- �� RANK() -> ���(����)�� ��ȯ�ϴ� �Լ�

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���", SAL "�޿�"
        , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
/*
7839	KING	10	5000	1
7902	FORD	20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	4
7698	BLAKE	30	2850	5
7782	CLARK	10	2450	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	13
7369	SMITH	20	800	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���", SAL "�޿�"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
        , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;

/*
7839	KING	10	5000	1	1
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7698	BLAKE	30	2850	1	5
7782	CLARK	10	2450	2	6
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7934	MILLER	10	1300	3	9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	950	6	13
7369	SMITH	20	800	5	14
*/

SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���", SAL "�޿�"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
        , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP ORDER BY DEPTNO;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	6
7934	MILLER	10	1300	3	9
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	5	14
7698	BLAKE	30	2850	1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	950	6	13
*/

-- �� DENSE_RANK() -> ������ ��ȯ�ϴ� �Լ� 
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���", SAL "�޿�"
        ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
        ,DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP ORDER BY DEPTNO;

/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���", SAL "�޿�"
        ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
        ,DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP ORDER BY 3, 4 DESC;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/

-- �� EMP ���̺��� ��� �����͸�
-- �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ

SELECT ENAME "�����" , DEPTNO "�μ���ȣ", SAL*12+ NVL(COMM,0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY  SAL*12+ NVL(COMM,0) DESC) "�μ�����������"
     ,DENSE_RANK() OVER(ORDER BY SAL*12+ NVL(COMM,0) DESC) "��ü��������"
FROM EMP ORDER BY DEPTNO;

------------------------------------------------------------------------------------------

SELECT T.�����, T.�μ���ȣ, T.����
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY  T.���� DESC) "�μ�����������"
     ,DENSE_RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM (
    SELECT ENAME "�����"
         , DEPTNO "�μ���ȣ"
         , SAL*12+ NVL(COMM,0) "����"
    FROM EMP
)T ORDER BY 2,4;

/*
KING	10	60000	1	1
CLARK	10	29400	2	5
MILLER	10	15600	3	9
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	3
ADAMS	20	13200	4	11
SMITH	20	9600	5	13
BLAKE	30	34200	1	4
ALLEN	30	19500	2	6
TURNER	30	18000	3	7
MARTIN	30	16400	4	8
WARD	30	15500	5	10
JAMES	30	11400	6	12
*/

-- �� EMP ���̺��� ��ü���������� 1����� 5�����..
-- �����, �μ���ȣ, ���� ��ü�������� �׸����� ��ȸ 

SELECT T.*
FROM (
    SELECT ENAME �����, DEPTNO �μ���ȣ, SAL*12 + NVL(COMM,0) ����
    , DENSE_RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) ��ü��������
    FROM EMP
    
)T 
WHERE ��ü�������� < 6;

SELECT T.*
FROM (
    SELECT ENAME �����, DEPTNO �μ���ȣ, SAL*12 + NVL(COMM,0) ����
    , DENSE_RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) ��ü��������
    FROM EMP
)T 
WHERE ��ü�������� <= 5;
--�����߻�(���� ������ �ȸ���� ���� ��쿡 ������ ��)

-- �� ������ RANK() OVER() �Լ��� WHERE ���������� ����� ����̸�
-- �� �Լ��� WHERE ���������� ����� �� ���� ������ �߻��ϴ� ������
-- �� ���, �츮�� INLINE VIEW�� Ȱ���Ͽ� Ǯ���ؾ� �� 

/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	3
BLAKE	30	34200	4
CLARK	10	29400	5
*/

-- EMP ���̺��� �� �μ����� ���� ����� 1����� 2�� ������ ��ȸ 
-- �����, �μ���ȣ, �μ����������, ��ü������� �׸��� 
-- ��ȸ�� �� �ֵ��� ������ ����

SELECT T.*
FROM (
    SELECT ENAME �����, DEPTNO �μ���ȣ, SAL*12 + NVL(COMM,0) ����
        , RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) ��ü��������
        , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12 + NVL(COMM,0) DESC) �μ�����������
    FROM EMP
)T
WHERE �μ����������� <=2;

/*
KING	10	60000	1	1
CLARK	10	29400	6	2
FORD	20	36000	2	1
SCOTT	20	36000	2	1
BLAKE	30	34200	5	1
ALLEN	30	19500	7	2
*/

-- ���� 
-- LN() �ڿ� �α� ������
SELECT LN(95) COL1
FROM DUAL;
-- 4.55387689160054083460978676511404117675 

-- �� �߰�
-- TRIM()
SELECT TRIM('            TEST                  ') COL1
     , LTRIM('           TEST                         ') COL2
     , RTRIM('                 TEST                   ') COL3
FROM DUAL;
/*
TEST	TEST                         	                 TEST
*/

--- �׷� �Լ� ---
-- SUM ��, AVG() ���, COUNT() ī��Ʈ, MAX() �ִ밪, MIN() �ּҰ�
-- , VARIENCE() �л�, STDDEV() ǥ������

-- �׷� �Լ��� ���� ū Ư¡ 
-- ó���ؾ� �� �����͵� �� NULL�� �����Ѵٸ�(���ԵǾ� �ִٸ�)
-- �� NULL�� ������ ���·� ������ �����Ѵٴ� �� 
-- ��, NULL�� ������ ��󿡼� ������

-- �� SUM() ��
-- EMP ���̺��� ������� ��ü ������� �޿� �� ���� ��ȸ�� 
SELECT SAL
FROM EMP;
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL) -- ��� �޿��� ��
FROM EMP;
-- 29025

SELECT COMM
FROM EMP;
/*

300
500

1400




0




*/
SELECT SUM(COMM) -- NULL + 300 + 500 + NULL + ... + NULL => �̰� �ƴ�(���� ��󿡼� �����ϰ� �� ���� ����)
FROM EMP;
-- 2200

-- �� COUNT() ��(���ڵ�)�� ���� ��ȸ -> �����Ͱ� �� ������.. Ȯ�� 
SELECT COUNT(ENAME)
FROM EMP;
-- 14

SELECT COUNT(COMM)
FROM EMP;
-- 4

SELECT COUNT(*)
FROM EMP;
-- 14

-- �� AVG() ��� ��ȯ
SELECT AVG(SAL) COL1
      , SUM(SAL) / COUNT(SAL) COL2
      , 29025 / 14 COL3
FROM EMP;
-- 2073.214285714285714285714285714285714286	
-- 2073.214285714285714285714285714285714286
-- 2073.214285714285714285714285714285714286

SELECT AVG(COMM) COL1
     , SUM(COMM) / COUNT(COMM) COL2
     , 2200 / 4 COL3
     , 2200 / 14
FROM EMP;
-- 550
-- 550
-- 550	
-- 157.142857142857142857142857142857142857

-- �����Ͱ� NULL�� �÷��� ���ڵ�� ���� ��󿡼� ���ܵǱ� ������
-- �����Ͽ� ���� ó���ؾ��� 

SELECT SUM(COMM) / COUNT(*) COL1
FROM EMP;
-- 157.142857142857142857142857142857142857

-- VARIANCE() / STDDEV()
-- �л�� ǥ������
-- ǥ�������� ������ �л�, �л��� �������� ǥ������

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--> 1398313.87362637362637362637362637362637
--> 1182.503223516271699458653359613061928508

SELECT POWER(STDDEV(SAL),2) COL1
    , VARIANCE(SAL) COL2
FROM EMP;
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) COL1
    , STDDEV(SAL) COL2
FROM EMP;

/*
1182.503223516271699458653359613061928508
1182.503223516271699458653359613061928508
*/

-- MAX(), MIN()
-- �ִ밪 / �ּҰ�
SELECT MAX(SAL) COL1
    , MIN(SAL)
FROM EMP;
-- 5000
-- 800

--����
SELECT ENAME, SUM(SAL)
FROM EMP;
-- �����߻�
-- ORA-00937: not a single-group group function

SELECT ENAME
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP;
-- �����߻�
-- ORA-00937: not a single-group group function

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
/*
10	8750
20	10875
30	9400
*/

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;

/*
10	2450 ��
10	5000 ��10
10	1300 ��
20	2975 ��
20	3000 ��
20	1100 ��20
20	800  ��
20	3000 ��
30	1250 ��
30	1500 ��
30	1600 ��30
30	950  ��
30	2850 ��
30	1250 ��
*/

-- ���� ���̺� ����
DROP TABLE TBL_EMP;
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- �ǽ� ���̺� �ٽ� ����(����)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
-- Table TBL_EMP��(��) �����Ǿ����ϴ�.

DESC TBL_EMP;
/*

�̸�       ��? ����           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    

*/

-- �� �ǽ� ������ �߰� �Է�
INSERT INTO TBL_EMP VALUES
(8001, '������', 'CLERK', 7566, SYSDATE, 1500,10, NULL);
--1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '���ϼ�', 'CLERK', 7566, SYSDATE, 2000,10, NULL);
--1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '�����', 'SALESMAN', 7698, SYSDATE, 1700,NULL, NULL);
--1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '������', 'SALESMAN', 7698, SYSDATE, 2500 ,NULL, NULL);
--1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '�ڳ���', 'SALESMAN', 7698, SYSDATE, 1000,NULL, NULL);
--1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_EMP;
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
8001	������	CLERK	    7566	2023-10-24	1500	        10	
8002	���ϼ�	CLERK	    7566	2023-10-24	2000	        10	
8003	�����	SALESMAN	7698	2023-10-24	1700		
8004	������	SALESMAN	7698	2023-10-24	2500		
8005	�ڳ���	SALESMAN	7698	2023-10-24	1000		
*/

-- Ŀ��
COMMIT;
-- Ŀ�� �Ϸ� 

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
/*
20	800	
	1700	
	1000	
10	1300	
20	2975	
30	2850	
10	2450	
20	3000	
10	5000	
	2500	
20	1100	
30	950	
20	3000	
30	1250	1400
30	1250	500
30	1600	300
	1500	10
	2000	10
30	1500	0
*/

-- ����Ŭ������ NULL�� ���� ū ������ ������
-- (ORACLE 9I������ NULL�� ���� ���� ������ �����߾���)
-- MSSQL�� NULL�� ���� ���� ������ ����

-- �� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
-- �μ���ȣ, �޿��� �׸� ��ȸ 
SELECT DEPTNO �μ���ȣ, SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
/*
10	8750
20	10875
30	9400
	8700
*/

SELECT DEPTNO �μ���ȣ, SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700    -- �μ���ȣ�� NULL�� ������� �޿���
	37725   -- ���μ� �������� �޿��� 
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);

/*
10	         8750
20	        10875
30	         9400
���μ�	29025
*/

-- EMP ���̺��� ������� ���� ���� ��ȸ�ǵ��� ������ �ۼ�

SELECT 
    CASE WHEN T.�μ���ȣ IS NULL THEN '���μ�'
        ELSE TO_CHAR(T.�μ���ȣ)
    END DEPTNO
    , T.�޿���
FROM 
(
    SELECT DEPTNO "�μ���ȣ", SUM(SAL) �޿���
    FROM TBL_EMP
    WHERE DEPTNO IS NOT NULL
    GROUP BY ROLLUP(DEPTNO)
)T;

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO),'���μ�') �μ���ȣ, SUM(SAL) �޿���
FROM EMP
GROUP BY ROLLUP(DEPTNO);
-- ORA-01722: invalid number
-- ����Ÿ���� �ƴ϶� ���� �߻�
/*
10	8750
20	10875
30	9400
���μ�	29025
*/

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO),'���μ�') �μ���ȣ, SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
���μ�	8700
���μ�	37725
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700
	37725
*/

-- GROUPING()
SELECT GROUPING(DEPTNO), DEPTNO �μ���ȣ, SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY DEPTNO;
/*
0	30	9400
0		8700
0	20	10875
0	10	8750
*/

SELECT GROUPING(DEPTNO), DEPTNO �μ���ȣ, SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
0	10	8750
0	20	10875
0	30	9400
0		8700
1		37725
*/

-- ������ ��ȸ�� �ش� ������ 
/*
10	8750
20	10875
30	9400
����	8700
���μ�	37725
�̿� ���� ��ȸ�ǵ��� �������� �ۼ��ϱ� 
*/

-- NVL2(DEPTNO,TO_CHAR(DEPTNO),'���μ�')

-- ��Ʈ
SELECT CASE WHEN GROUPING(DEPTNO) = 0 AND DEPTNO IS NULL THEN '����'
            WHEN GROUPING(DEPTNO) = 1 AND DEPTNO IS NULL THEN '���μ�'
            ELSE TO_CHAR(DEPTNO) 
         END "�μ���ȣ"
                             
        , SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����') 
                             ELSE '���μ�'
                        END "�μ���ȣ"
        , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����')
                             ELSE '���μ�'
                        END "�μ���ȣ"
        , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700
���μ�	37725
*/

-- �� TBL_SAWON ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� ������ ����
/*
    ����      �޿���
    ��         XXX
    ��        XXXXXX
�����      XXXXXX
*/

SELECT *
FROM TBL_SAWON;

SELECT NVL(T.����,'����ο�') ����, SUM(�޿�)
FROM (
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
                ELSE 'Ȯ�κҰ�'
            END "����"
        ,SAL �޿�
    FROM TBL_SAWON
)T 
GROUP BY ROLLUP(T.����);

SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����       
                             ELSE '�����'
                        END ����
        ,SUM(T.�޿�) �޿���
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '����'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '����'
            ELSE 'Ȯ�κҰ�'
        END "����"
          , SAL �޿�
FROM TBL_SAWON
)T GROUP BY ROLLUP(T.����);
/*
����	    16800
����	    20300
����ο�	37100
*/

--TBL_SAWON ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� ������ �ۼ�
/*
���ɴ�     �ο���
------------------
 10         XX
 20         XX
 50         XX
*/

-- SELECT T.����, COUNT(T.����) �ο���
SELECT NVL(T2.���ɴ�,'��ü����') ���� , COUNT(T2.���ɴ�) �ο���
FROM (
    SELECT CASE SUBSTR(T.����,1,1) WHEN '1' THEN '10��'
                                   WHEN '2' THEN '20��'
                                   WHEN '3' THEN '30��'
                                   WHEN '4' THEN '40��'
                                   WHEN '5' THEN '50��'
                                   ELSE '�����Ұ�'
                            END ���ɴ�
    FROM (      
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                  END "����"
        FROM TBL_SAWON
    ) T 
)T2 
GROUP BY ROLLUP(T2.���ɴ�);

SELECT NVL(T.����,'���ɴ�') COUNT(T.����)
FROM (
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
            ELSE -1
        END "����"
    FROM TBL_SAWON
)T GROUP BY ROLLUP(T.����);

-- ��� 1
SELECT NVL(T2.���ɴ�,'��ü����') ���� , COUNT(T2.���ɴ�) �ο���
FROM (
    SELECT CASE SUBSTR(T.����,1,1) WHEN '1' THEN '10��'
                                   WHEN '2' THEN '20��'
                                   WHEN '3' THEN '30��'
                                   WHEN '4' THEN '40��'
                                   WHEN '5' THEN '50��'
                                   ELSE '�����Ұ�'
                            END ���ɴ�
    FROM (      
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                  END "����"
        FROM TBL_SAWON
    ) T 
)T2 
GROUP BY ROLLUP(T2.���ɴ�);
/*
10��	4
20��	7
50��	4
��ü����	15
*/

-- 2��° ���
-- ���ɴ�
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�) 
                                ELSE '��ü' END "���ɴ�"
                                ,COUNT(*) �ο���
FROM(
SELECT TRUNC (CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)  -1) 
        END -1) "���ɴ�"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);

/*
10��	4
20��	7
50��	4
��ü����	15
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1,2;
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	    1300    -- 10�� �μ� CLERK ������ �޿���
10	MANAGER	    2450    -- 10�� �μ� MANAGER ������ �޿���
10	PRESIDENT	5000    -- 10�� �μ� PRESIDENT ������ �޿���
10		        8750    -- 10�� �μ� ��� ������ �޿���
20	ANALYST	    6000    -- 20�� �μ� ANALYST ������ �޿���
20	CLERK	    1900    -- 20�� �μ� CLERK ������ �޿���
20	MANAGER	    2975    -- 20�� �μ� MANAGER ������ �޿���
20		       10875    -- 20�� �μ� ��� ������ �޿���
30	CLERK	     950    -- 30�� �μ� CLERK ������ �޿���
30	MANAGER	    2850    -- 30�� �μ��� MANAGER ������ �޿���
30	SALESMAN	5600    -- 30�� �μ��� SALESMAN ������ �޿���
30		        9400    -- 30�� �μ��� ��� ������ �޿���
               29025    -- ��� �μ� ��� ������ �޿���
*/

-- CUBE() -> ROLLUP() ���� �� �ڼ��� ����� ��ȯ����
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
10		        8750
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
20		       10875
30	CLERK	    950
30	MANAGER	    2850
30	SALESMAN	5600
30		        9400
	ANALYST	    6000    -- ��� �μ� ANALYST ������ �޿��� -- �߰�
	CLERK	    4150    -- ��� �μ� CLERK ������ �޿��� -- �߰�
	MANAGER	    8275    -- ��� �μ� MANAGER ������ �޿��� -- �߰�
	PRESIDENT	5000    -- ��� �μ� PRESIDENT ������ �޿��� -- �߰�
	SALESMAN	5600    -- ��� �μ� SALESMAN ������ �޿��� -- �߰�
               29025
*/

-- �� ROLLUP() �� CUBE()�� 
-- �׷��� �����ִ� ����� �ٸ�(����) 

--EX
-- ROLLUP(A,B,C)
-- -> (A,B,C) / (A,B) / (A) / ()
-- CUBE(A,B,C)
-- -> (A,B,C) / (A,B) / (A,C) / (B,C) / (A) / (B) / (C) / ()

--> ���� ����(ROLLUP())�� ���� ����� �ټ� ���ڶ� ���� �ְ� 
--> �Ʒ� ����(CUBE())�� ���� ����� �ټ� ����ĥ ���� �ֱ� ������
-- ������ ���� ����� ������ �� ���� ����ϰ� ��
-- ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 
-- "GROUPING SETS"�� �̿��Ͽ��� ���������� �����ִ� ���

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����') 
                             ELSE '��ü�μ�'
            END �μ���ȣ
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '��ü����' 
            END ����
    ,SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750

20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875

30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400

����	CLERK	3500
����	SALESMAN	5200
����	��ü����	8700

��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����') 
                             ELSE '��ü�μ�'
            END �μ���ȣ
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '��ü����' 
            END ����
    ,SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;

/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750

20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875

30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400

����	CLERK	3500
����	SALESMAN	5200
����	��ü����	8700

��ü�μ�	ANALYST	6000
��ü�μ�	CLERK	7650
��ü�μ�	MANAGER	8275
��ü�μ�	PRESIDENT	5000
��ü�μ�	SALESMAN	10800

��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����') 
                             ELSE '��ü�μ�'
            END �μ���ȣ
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '��ü����' 
            END ����
    ,SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB),())
ORDER BY 1,2;
/* CUBE�� ����
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400
����	CLERK	3500
����	SALESMAN	5200
����	��ü����	8700
��ü�μ�	ANALYST	6000
��ü�μ�	CLERK	7650
��ü�μ�	MANAGER	8275
��ü�μ�	PRESIDENT	5000
��ü�μ�	SALESMAN	10800
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'����') 
                             ELSE '��ü�μ�'
            END �μ���ȣ
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '��ü����' 
            END ����
    ,SUM(SAL) �޿���
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO),())
ORDER BY 1,2;
/* ROLLUP�� ����
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	��ü����	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	��ü����	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	��ü����	9400
����	CLERK	3500
����	SALESMAN	5200
����	��ü����	8700
��ü�μ�	��ü����	37725
*/

--------------------------------------------------------------------------------
--�� TBL_EMP ���̺��� ������� �Ի�⵵�� �ο����� ��ȸ

SELECT NVL(TO_CHAR(T.�Ի���),'��ü�⵵') �Ի���, COUNT(*) �ο���
FROM (
    SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի���"
    FROM TBL_EMP
)T GROUP BY ROLLUP(T.�Ի���);
/*
1980	1
1981	10
1982	1
1987	2
2023	5
��ü�⵵	19
*/
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի���", COUNT(*) �ο���
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY')
ORDER BY 1;
-- �����߻�
-- ORA-00979: not a GROUP BY expression

SELECT TO_CHAR(HIREDATE,'YYYY') "�Ի���", COUNT(*) �ο���
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
-- �����߻�
-- ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE,'YYYY')
            ELSE '��ü' 
        END �Ի�⵵
       ,COUNT(*) �ο���
FROM TBL_EMP
GROUP BY CUBE (TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;

/*
1980	1
1981	10
1982	1
1987	2
2023	5
��ü	19
*/