SELECT USER 
FROM DUAL;
-- SCOTT

-- HAVING

-- �� EMP ���̺��� �μ���ȣ�� 20, 30�� �μ��� ������� 
-- �μ� �� �޿��� 10000���� ���� ��츸 �μ��� �� �޿��� ��ȸ 
SELECT DEPTNO,SUM(SAL)
FROM EMP
WHERE �μ���ȣ�� 20,30
GROUP BY �μ���ȣ;

SELECT DEPTNO,SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO;
/*
30	9400
20	10875
*/

SELECT DEPTNO,SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30) AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--> ���� �߻� 
-- ORA-00934: group function is not allowed here

SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000; -- �׷쿡 ���� ����
-- 30	9400

-- 1�� ���� 
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
    AND DEPTNO IN (20,30);
-- 30	9400

SELECT *
FROM EMP;

-- 2�� ���� 
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20,30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000; 

SELECT *
FROM EMP
WHERE DEPTNO IN (20,30);

-- �� �ΰ��� 1�������� 2�������� ������� ������ 
-- ������ ���ϸ� �ٸ� �����̸� 2�� ������ �޸𸮸� ���� �����ϴ� ������
-- ���� 1�� ������ ���� �̻����� �����̱��� (������ ��)

-------------------------------------------------------------------------------
-- ��ø �׷��Լ� / �弮�Լ� 

-- �׷��Լ��� 2 LEVEL ���� ��ø�ؼ� ����� �� ���� 

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL)) COL1
FROM EMP
GROUP BY DEPTNO;
-- 10875

-- RANK() / DENSE_RANK()
-- ORACLE 9I���� ����... (MSSQL 2005���� ����?)

--> ���� ���������� RANK() �� DENSE_RANK()�� ����� �� ���� ������ 
-- �� �Լ��� Ȱ������ �ʴ� �ٸ� ����� ã�ƾ� �� 
-- ���� ���.. �޿� ������ ���ϰ��� �Ѵٸ�
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� �� 
-- ������ ���ڿ� "+1"�� �߰��� ������ �ָ� 
-- �� ���� �� �ش� ����� ����� �� 

select ename, sal
from emp;

select count(*) + 1
from emp
where sal > 880;        -- SMITH�� �޿�
-- 14

select count(*) + 1
from emp
where sal > 1600;
--  7                            -- ALLEN�� �޿� ���

-- ���� ��� ���� (��� ���� ����)
-- ���� ������ �ִ� ���̺��� �ø��� ���� ������ ������(WHERE�� ��  HAVING��)DP 
-- ���Ǵ� ��� �츮�� �� �������� ���� ��� ����(��� ���� ����)��� �θ�

SELECT ENAME "�����", SAL "�޿�", (1) "�޿����"
FROM EMP;
/*
SMITH	800	1
ALLEN	1600	1
WARD	1250	1
JONES	2975	1
MARTIN	1250	1
BLAKE	2850	1
CLARK	2450	1
SCOTT	3000	1
KING	5000	1
TURNER	1500	1
ADAMS	1100	1
JAMES	950	1
FORD	3000	1
MILLER	1300	1
*/
SELECT E.ENAME "�����", E.SAL "�޿�", (SELECT COUNT(*) +1
                                       FROM EMP
                                       WHERE SAL > 800) "�޿����"
FROM EMP E;
/*
SMITH	800	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	950	14
FORD	3000	14
MILLER	1300	14
*/

SELECT E.ENAME "�����", E.SAL "�޿�", (SELECT COUNT(*) +1
                                       FROM EMP
                                       WHERE SAL > E.SAL) "�޿����"
FROM EMP E;
/*
SMITH	800	14
ALLEN	1600	7
WARD	1250	10
JONES	2975	4
MARTIN	1250	10
BLAKE	2850	5
CLARK	2450	6
SCOTT	3000	2
KING	5000	1
TURNER	1500	8
ADAMS	1100	12
JAMES	950	13
FORD	3000	2
MILLER	1300	9
*/
SELECT E.ENAME "�����", E.SAL "�޿�", (SELECT COUNT(*) +1
                                       FROM EMP
                                       WHERE SAL > E.SAL) "�޿����"
FROM EMP E
ORDER BY 3;
/*
KING	5000	1
FORD	3000	2
SCOTT	3000	2
JONES	2975	4
BLAKE	2850	5
CLARK	2450	6
ALLEN	1600	7
TURNER	1500	8
MILLER	1300	9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	950	13
SMITH	800	14
*/

-- EMP ���̺��� ������� �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ
-- ��, RANK() �Լ��� ������� �ʰ� ������������ Ȱ���� �� �ֵ��� ��

SELECT E.ENAME "�����",E.DEPTNO �μ���ȣ ,E.SAL "�޿�", (SELECT COUNT(*) +1
                                                          FROM EMP
                                                          WHERE SAL > E.SAL) "�޿����"
                                                          
                                                          ,(SELECT COUNT(*) +1
                                                           FROM EMP
                                                           WHERE SAL > E.SAL AND DEPTNO = E.DEPTNO) "�μ������"
FROM EMP E
ORDER BY 3,5;
/*
KING	10	5000	1	1
CLARK	10	2450	6	2
MILLER	10	1300	9	3
SCOTT	20	3000	2	1
FORD	20	3000	2	1
JONES	20	2975	4	3
ADAMS	20	1100	12	4
SMITH	20	800	14	5
BLAKE	30	2850	5	1
ALLEN	30	1600	7	2
TURNER	30	1500	8	3
MARTIN	30	1250	10	4
WARD	30	1250	10	4
JAMES	30	950	13	6
*/

SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;
-- 14

SELECT COUNT (*) + 1 
FROM EMP
WHERE SAL > 800
    AND DEPTNO = 20;
-- 5 -> SMITH�� �޿� ��� 

SELECT ENAME �����, SAL �޿�, DEPTNO �μ���ȣ 
    ,(SELECT COUNT(*) + 1
      FROM EMP
      WHERE SAL > E.SAL
        AND DEPTNO = E.DEPTNO) �μ����޿����
    ,(SELECT COUNT(*) + 1
      FROM EMP
      WHERE SAL > E.SAL) ��ü�޿����
FROM EMP E
ORDER BY 3,5;
/*
KING	5000	10	1	1
CLARK	2450	10	2	6
MILLER	1300	10	3	9
SCOTT	3000	20	1	2
FORD	3000	20	1	2
JONES	2975	20	3	4
ADAMS	1100	20	4	12
SMITH	800	    20	5	14
BLAKE	2850	30	1	5
ALLEN	1600	30	2	7
TURNER	1500	30	3	8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	950	    30	6	13
*/

SELECT *
FROM EMP;

-- EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� ������ �ۼ�
/*
                                                - �� �μ� ������ �Ի����ں��� ������ �޿��� ��
�����      �μ���ȣ       �Ի���        �޿�      �μ����Ի纰�޿�����
SMITH           20       1980-12-17       800              800
JONES           20       1981-04-02      2975             3775
FORD            20       1981-12-03      3000             6775
*/

SELECT ENAME �����, DEPTNO �μ���ȣ, HIREDATE �Ի���, SAL �޿�
        ,(SELECT SUM(SAL)
          FROM EMP
          WHERE DEPTNO = E.DEPTNO AND HIREDATE <= E.HIREDATE) �μ����Ի纰�޿�����
FROM EMP E
ORDER BY 2,3;
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	800	    800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	950	    9400
*/

SELECT E1.ENAME �����, E1.DEPTNO �μ���ȣ, E1.HIREDATE �Ի���, E1.SAL �޿�
        ,(1) �μ����Ի纰�޿�����
FROM EMP E1
ORDER BY 2,3;

SELECT E1.ENAME �����, E1.DEPTNO �μ���ȣ, E1.HIREDATE �Ի���, E1.SAL �޿�
        ,(SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO AND (E2.HIREDATE = E1.HIREDATE) OR E2.HIREDATE <= E1.HIREDATE) �μ����Ի纰�޿�����
FROM EMP E1
ORDER BY 2,3;
/*
CLARK	10	1981-06-09	2450	11925
KING	10	1981-11-17	5000	19675
MILLER	10	1982-01-23	1300	24925
SMITH	20	1980-12-17	800	    800
JONES	20	1981-04-02	2975	6625
FORD	20	1981-12-03	3000	23625
SCOTT	20	1987-07-13	3000	29025
ADAMS	20	1987-07-13	1100	29025
ALLEN	30	1981-02-20	1600	2400
WARD	30	1981-02-22	1250	3650
BLAKE	30	1981-05-01	2850	9475
TURNER	30	1981-09-08	1500	13425
MARTIN	30	1981-09-28	1250	14675
JAMES	30	1981-12-03	950	    23625
*/

/*
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
*/

-- EMP ���̺� ������� �Ի��� ����� ���� ���� ������ ���� 
-- �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� ������

SELECT T.�Ի���, COUNT(*) �ο���
FROM(
    SELECT TO_CHAR(HIREDATE,'YYYY-MM') �Ի���
    FROM EMP
)T GROUP BY T.�Ի���
HAVING COUNT(T.�Ի���) >= 2
ORDER BY 1;
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/

SELECT T2. �Ի���, MAX(T2.�ο���) �ִ��ο�
FROM(
    SELECT TO_CHAR(HIREDATE,'YYYY-MM') �Ի���, COUNT(*) �ο���
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
)T2 GROUP BY T2.�Ի���
HAVING T2.�ο��� <= MAX(T2.�ο���);

--------------------------------------------------------------------------

SELECT TO_CHAR(HIREDATE,'YYYY-MM') �Ի���, COUNT(*) �ο���
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 2;
/*
1981-12	2
1981-09	2
1981-02	2
1987-07	2
*/
SELECT TO_CHAR(HIREDATE,'YYYY-MM') �Ի���, COUNT(*) �ο���
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (�Ի�⵵�� ���� �ִ� �ο�);

-- �� �Ի��� ���� �ִ� �ο� 
SELECT COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
/*
1
2
1
2
2
1
1
1
2
1
*/

SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');

SELECT TO_CHAR(HIREDATE,'YYYY-MM') �Ի���, COUNT(*) �ο���
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'));
/*
1981-12	2
1981-09	2
1981-02	2
1987-07	2
*/

SELECT T1.�Ի���, T1.�ο���
FROM
(
    SELECT TO_CHAR(HIREDATE, 'YYYY-MM') �Ի���
            , COUNT(*) �ο���
    FROM EMP
    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
) T1
WHERE T1.�ο��� = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM'))                
ORDER BY 1;
/*
1981-12	2
1981-09	2
1981-02	2
1987-07	2
*/
-------------------------------------------------------------------------------
-- ROW_NUMBER --
SELECT ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP;
/*
SMITH	800	1980-12-17
ALLEN	1600	1981-02-20
WARD	1250	1981-02-22
JONES	2975	1981-04-02
MARTIN	1250	1981-09-28
BLAKE	2850	1981-05-01
CLARK	2450	1981-06-09
SCOTT	3000	1987-07-13
KING	5000	1981-11-17
TURNER	1500	1981-09-08
ADAMS	1100	1987-07-13
JAMES	950	1981-12-03
FORD	3000	1981-12-03
MILLER	1300	1982-01-23
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) ����
        , ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP;
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	950	    1981-12-03
14	SMITH	800	    1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) ����
        , ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP
ORDER BY ENAME;
/*
12	ADAMS	1100	1987-07-13
7	ALLEN	1600	1981-02-20
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
2	FORD	3000	1981-12-03
13	JAMES	950	1981-12-03
4	JONES	2975	1981-04-02
1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
9	MILLER	1300	1982-01-23
3	SCOTT	3000	1987-07-13
14	SMITH	800	1980-12-17
8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) ����
        , ENAME �����, SAL �޿�, HIREDATE �Ի���
FROM EMP
ORDER BY ENAME;
/*
1	ADAMS	1100	1987-07-13
2	ALLEN	1600	1981-02-20
3	BLAKE	2850	1981-05-01
4	CLARK	2450	1981-06-09
5	FORD	3000	1981-12-03
6	JAMES	950	1981-12-03
7	JONES	2975	1981-04-02
8	KING	5000	1981-11-17
9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/

-- �� �Խ����� �Խù� ��ȣ�� SEQUNCE �� IDENTITY�� ����ϰ� �Ǹ�
-- �Խù��� �������� ��� ������ ��ù��� �ڸ��� ���� ��ȣ�� ���� �Խù���
-- ��ϵǴ� ��Ȳ�� �߻��ϰ� ��
-- �̴� ���ȼ� �����̳� �ٶ������� ���� ������ �� �ֱ� ������
-- ������ �������� ����� ������ SEQUENCE�� IDENTITY�� ���������,
-- �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������ 
-- ������� �ʴ°��� �ٶ� ���� 

-- �� SEQUENCE (������ : �ֹι�ȣ)
-- �������� �ǹ� : 1. (�Ϸ���) �������� ��ǵ� 2. (��Ǥ��ൿ ����) ����

-- ������ ���� 
CREATE SEQUENCE SEQ_BOARD -- �⺻���� ������ ���� ���� 
START WITH 1 -- ���۰� ���� �ɼ�
INCREMENT BY 1 -- ������ ���� �ɼ�
NOMAXVALUE -- �ִ밪 �����ɼ�
NOCACHE; -- ĳ�� ������ ���� �ɼ�
--Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.

-- �� �ǽ� ���̺� ���� (���̺�� : TBL_BOARD)
CREATE TABLE TBL_BOARD -- TBL_BOARD ���̺� ���� ���� -> �Խ��� ���̺� 
( NO        NUMBER                  -- �Խù� ��ȣ        X
, TITLE     VARCHAR2(50)            -- �Խù� ����        O
, CONTENTS  VARCHAR2(1000)          -- �Խù� ����        O
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���      ��
, PW        VARCHAR2(20)            -- �Խù� �н�����    ��
,CREATED    DATE DEFAULT SYSDATE    -- �Խù� �ۼ���      X
);
-- Table TBL_BOARD��(��) �����Ǿ����ϴ�.

-- ������ �Է� -> �Խ��ǿ� �Խù� �ۼ� 

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'����� ��','10�и� ����','����ȯ','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'������ ��','10�и� ����','���ѿ�','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'����� ����','10�и� ����','���ѿ�','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'��~����','�Ϸ��Ϸ簡 ��վ��','������','JAVA006$',DEFAULT);
--1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'����ʹ�','������ �ʹ��ʹ� ���� �;��','���ȯ','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'����Ŀ�','������ �Ծ��µ� ����Ŀ�','�����','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'���� �����ֳ׿�','�� �ð� ���̳� �����ֳ׿�','������','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'�׸��ϰ�ʹ�','�׳� �Ѿ��....','��ȣ��','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'��~ �����','��������������','������','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'�ұټұ�','�ý÷��ý÷�','������','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'���ڶ��','���� ���� ���ڶ��','�赿��','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'���ڶ��','���� ���� ���ڶ��','�赿��','JAVA006$',DEFAULT);

-- �� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
1	����� ��	10�и� ����	����ȯ	    JAVA006$	2023-10-25
2	������ ��	10�и� ����	    ���ѿ�	    JAVA006$	2023-10-25
3	��~����	�Ϸ��Ϸ簡 ��վ��	������	    JAVA006$	2023-10-25
4	����ʹ�	������ �ʹ��ʹ� ���� �;��	���ȯ	JAVA006$	2023-10-25
5	����Ŀ�	������ �Ծ��µ� ����Ŀ�	�����	JAVA006$	2023-10-25
6	���� �����ֳ׿�	�� �ð� ���̳� �����ֳ׿�	������	JAVA006$	2023-10-25
7	�׸��ϰ�ʹ�	�׳� �Ѿ��....	��ȣ��	JAVA006$	2023-10-25
8	��~ �����	��������������	������	JAVA006$	2023-10-25
9	�ұټұ�	�ý÷��ý÷�	������	JAVA006$	2023-10-25
10	���ڶ��	���� ���� ���ڶ��	�赿��	JAVA006$	2023-10-25
*/

-- �� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session��(��) ����Ǿ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
1	����� ��	10�и� ����	����ȯ	JAVA006$	2023-10-25 15:24:44
2	������ ��	10�и� ����	���ѿ�	JAVA006$	2023-10-25 15:28:10
3	��~����	�Ϸ��Ϸ簡 ��վ��	������	JAVA006$	2023-10-25 15:31:21
4	����ʹ�	������ �ʹ��ʹ� ���� �;��	���ȯ	JAVA006$	2023-10-25 15:31:56
5	����Ŀ�	������ �Ծ��µ� ����Ŀ�	�����	JAVA006$	2023-10-25 15:32:23
6	���� �����ֳ׿�	�� �ð� ���̳� �����ֳ׿�	������	JAVA006$	2023-10-25 15:35:16
7	�׸��ϰ�ʹ�	�׳� �Ѿ��....	��ȣ��	JAVA006$	2023-10-25 15:37:35
8	��~ �����	��������������	������	JAVA006$	2023-10-25 15:38:14
9	�ұټұ�	�ý÷��ý÷�	������	JAVA006$	2023-10-25 15:38:42
10	���ڶ��	���� ���� ���ڶ��	�赿��	JAVA006$	2023-10-25 15:39:22
*/

-- �� Ŀ��
COMMIT;
-- Ŀ�� �Ϸ�

--�Խù� ����
DELETE
FROM TBL_BOARD
WHERE NO = 1;
--1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 6;
-- 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 8;
-- 1 �� ��(��) �����Ǿ����ϴ�.

DELETE 
FROM TBL_BOARD
WHERE NO = 10;
-- 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_BOARD;
/*
2	������ ��	10�и� ����	���ѿ�	JAVA006$	2023-10-25 15:28:10
3	��~����	�Ϸ��Ϸ簡 ��վ��	������	JAVA006$	2023-10-25 15:31:21
4	����ʹ�	������ �ʹ��ʹ� ���� �;��	���ȯ	JAVA006$	2023-10-25 15:31:56
5	����Ŀ�	������ �Ծ��µ� ����Ŀ�	�����	JAVA006$	2023-10-25 15:32:23
7	�׸��ϰ�ʹ�	�׳� �Ѿ��....	��ȣ��	JAVA006$	2023-10-25 15:37:35
9	�ұټұ�	�ý÷��ý÷�	������	JAVA006$	2023-10-25 15:38:42
*/

-- �� �Խù� �ۼ� 
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL,'�����սô�','���� ���� ������ �ʾƿ�','���ϼ�','JAVA006$',DEFAULT);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

-- �Խù� ����
DELETE 
FROM TBL_BOARD
WHERE NO = 7;
-- 1 �� ��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_BOARD;
/*
2	������ ��	10�и� ����	���ѿ�	JAVA006$	2023-10-25 15:28:10
3	��~����	�Ϸ��Ϸ簡 ��վ��	������	JAVA006$	2023-10-25 15:31:21
4	����ʹ�	������ �ʹ��ʹ� ���� �;��	���ȯ	JAVA006$	2023-10-25 15:31:56
5	����Ŀ�	������ �Ծ��µ� ����Ŀ�	�����	JAVA006$	2023-10-25 15:32:23
9	�ұټұ�	�ý÷��ý÷�	������	JAVA006$	2023-10-25 15:38:42
11	�����սô�	���� ���� ������ �ʾƿ�	���ϼ�	JAVA006$	2023-10-25 16:06:23
*/

-- Ŀ��
COMMIT;
-- Ŀ�� �Ϸ�.

-- �� �Խ����� �Խù� ����Ʈ ��ȸ 

SELECT NO �۹�ȣ, TITLE ����, NAME �ۼ���, CREATED �ۼ���
FROM TBL_BOARD;
/*
2	������ ��	���ѿ�	2023-10-25 15:28:10
3	��~����	    ������	2023-10-25 15:31:21
4	����ʹ�	���ȯ	2023-10-25 15:31:56
5	����Ŀ�	�����	2023-10-25 15:32:23
9	�ұټұ�	������	2023-10-25 15:38:42
11	�����սô�	���ϼ�	2023-10-25 16:06:23
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) �۹�ȣ
        , TITLE ����, NAME �ۼ���, CREATED �ۼ���
FROM TBL_BOARD;

/*
1	������ ��	���ѿ�	2023-10-25 15:28:10
2	��~����	������	2023-10-25 15:31:21
3	����ʹ�	���ȯ	2023-10-25 15:31:56
4	����Ŀ�	�����	2023-10-25 15:32:23
5	�ұټұ�	������	2023-10-25 15:38:42
6	�����սô�	���ϼ�	2023-10-25 16:06:23
*/

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) �۹�ȣ
        , TITLE ����, NAME �ۼ���, CREATED �ۼ���
FROM TBL_BOARD
ORDER BY 4 DESC;
/*
6	�����սô�	���ϼ�	2023-10-25 16:06:23
5	�ұټұ�	������	2023-10-25 15:38:42
4	����Ŀ�	�����	2023-10-25 15:32:23
3	����ʹ�	���ȯ	2023-10-25 15:31:56
2	��~����	������	2023-10-25 15:31:21
1	������ ��	���ѿ�	2023-10-25 15:28:10
*/

-------------------------------------------------------------------------------

-- �� JOIN(����) �� -- 
-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
-- ���п��� ���ϴ� ��ī��Ʈ ��(CATERSIOAN PRODUCT)
-- �� ���̺��� ������ ��� ����� ��

-- EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �����͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO; 
/*
7782	CLARK	MANAGER	7839	1981-06-09 00:00:00	2450		10	10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		1981-11-17 00:00:00	5000		10	10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975		20	20	RESEARCH	DALLAS
7902	FORD	ANALYST	7566	1981-12-03 00:00:00	3000		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	7566	1987-07-13 00:00:00	3000		20	20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	1981-02-22 00:00:00	1250	500	30	30	SALES	CHICAGO
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30	30	SALES	CHICAGO
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30	30	SALES	CHICAGO
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
7698	BLAKE	MANAGER	7839	1981-05-01 00:00:00	2850		30	30	SALES	CHICAGO
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	1400	30	30	SALES	CHICAGO
*/

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
/*
7782	CLARK	MANAGER	7839	1981-06-09 00:00:00	2450		10	10	ACCOUNTING	NEW YORK
7839	KING	PRESIDENT		1981-11-17 00:00:00	5000		10	10	ACCOUNTING	NEW YORK
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975		20	20	RESEARCH	DALLAS
7902	FORD	ANALYST	7566	1981-12-03 00:00:00	3000		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7788	SCOTT	ANALYST	7566	1987-07-13 00:00:00	3000		20	20	RESEARCH	DALLAS
7521	WARD	SALESMAN	7698	1981-02-22 00:00:00	1250	500	30	30	SALES	CHICAGO
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30	30	SALES	CHICAGO
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30	30	SALES	CHICAGO
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
7698	BLAKE	MANAGER	7839	1981-05-01 00:00:00	2850		30	30	SALES	CHICAGO
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	1400	30	30	SALES	CHICAGO
*/

-- NON EQUI JOIN : ���� �ȿ� ������ �����͵鳢�� �����Ű�� ���� ���
SELECT *
FROM EMP, SALGRADE
WHERE EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	1	700	1200
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	1	700	1200
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	1	700	1200
7521	WARD	SALESMAN	7698	1981-02-22 00:00:00	1250	500	30	2	1201	1400
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	1400	30	2	1201	1400
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	2	1201	1400
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30	3	1401	2000
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30	3	1401	2000
7782	CLARK	MANAGER	7839	1981-06-09 00:00:00	2450		10	4	2001	3000
7698	BLAKE	MANAGER	7839	1981-05-01 00:00:00	2850		30	4	2001	3000
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975		20	4	2001	3000
7788	SCOTT	ANALYST	7566	1987-07-13 00:00:00	3000		20	4	2001	3000
7902	FORD	ANALYST	7566	1981-12-03 00:00:00	3000		20	4	2001	3000
7839	KING	PRESIDENT		1981-11-17 00:00:00	5000		10	5	3001	9999
*/

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	1	700	1200
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	1	700	1200
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	1	700	1200
7521	WARD	SALESMAN	7698	1981-02-22 00:00:00	1250	500	30	2	1201	1400
7654	MARTIN	SALESMAN	7698	1981-09-28 00:00:00	1250	1400	30	2	1201	1400
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	2	1201	1400
7844	TURNER	SALESMAN	7698	1981-09-08 00:00:00	1500	0	30	3	1401	2000
7499	ALLEN	SALESMAN	7698	1981-02-20 00:00:00	1600	300	30	3	1401	2000
7782	CLARK	MANAGER	7839	1981-06-09 00:00:00	2450		10	4	2001	3000
7698	BLAKE	MANAGER	7839	1981-05-01 00:00:00	2850		30	4	2001	3000
7566	JONES	MANAGER	7839	1981-04-02 00:00:00	2975		20	4	2001	3000
7788	SCOTT	ANALYST	7566	1987-07-13 00:00:00	3000		20	4	2001	3000
7902	FORD	ANALYST	7566	1981-12-03 00:00:00	3000		20	4	2001	3000
7839	KING	PRESIDENT		1981-11-17 00:00:00	5000		10	5	3001	9999
*/

-- EQUI JOIN �� (+)�� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP;

SELECT *
FROM TBL_DEPT;

INSERT INTO TBL_DEPT VALUES(50, '���ߺ�', '����');
-- 1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;
-- Ŀ�� �Ϸ� 

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ 
-- ��, �μ���ȣ�� ���� ���� �����(5) ��� ���� 
-- ����, �Ҽ� ����� ���� ���� �μ�(2) ��� ���� 

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
-- �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ 
-- �Ҽ� ����� ���� ���� �μ�(2) ���� --------(+)
-- �μ���ȣ�� ���� ���� �����(5) ��� ��ȸ 

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
-- �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ 
-- �μ���ȣ�� ���� ���� �����(5) ���� -------(+)
-- �Ҽ� ����� ���� ���� �μ�(2) ��� ��ȸ

-- �� "(+)"�� ���� �� ���̺��� �����͸� ��� �޸𸮿� ������ �� -- �⺻ 
-- "(+)"�� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�  -- �߰�
-- JOIN�� �̷����
-- �̿� ���� ������ 
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
-- �̷� ������ JOIN�� �������� ���� 


-- 2. SQL 1999 CODE -> JOIN Ű���� ���� -> JOIN(����)�� ���� ���
--                  -> "ON" Ű���� ����  -> ���� ������ WHERE ��� ON


-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT 
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
-- INNER JOIN���� INNER�� ���� ���� 

-- OUTTER JOIN
SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;
-- OUTER JOIN���� OUTER�� ���� ���� 

SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- ���� 
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND E.JOB = 'CLERK';
--> �̿� ���� ������� �������� �����ص� ��ȸ ����� ��� ���������� ������ ���� 

/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
*/
-----------------------------------------------------------------------------
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK';
-- ������ �̿� ���� �����Ͽ� ��ȸ�ϴ°��� ������ 
/*
7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20	20	RESEARCH	DALLAS
7876	ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
7900	JAMES	CLERK	7698	1981-12-03 00:00:00	950		30	30	SALES	CHICAGO
7934	MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
*/

-- �� EMP ���̺�� DEPT ���̺��� ������� 
-- ������ MANAGER �� CLERK�� ����鸸 �μ���ȣ, �μ���, ������, �޿� �׸��� ��ȸ��
SELECT E.DEPTNO �μ���ȣ,E.ENAME �̸�, E.JOB ������, D.DNAME �μ���, E.SAL �޿�
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'CLERK' OR E.JOB = 'MANAGER'
ORDER BY 1;
/*
10	CLARK	MANAGER	ACCOUNTING	2450
10	MILLER	CLERK	ACCOUNTING	1300
20	ADAMS	CLERK	RESEARCH	1100
20	JONES	MANAGER	RESEARCH	2975
20	SMITH	CLERK	RESEARCH	800
30	BLAKE	MANAGER	SALES	2850
30	JAMES	CLERK	SALES	950
*/

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
-- �����߻� 
-- ORA-00918: column ambiguously defined
-- �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ���������

SELECT E.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;