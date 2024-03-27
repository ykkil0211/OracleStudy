SELECT USER
FROM DUAL;
-- SCOTT

-- �˾Ƹ�����...
DROP TABLE TBL_JUMUN PURGE;

DELETE TBL_JUMUN
WHERE DEPTNO = 50;

-- UNION / UNION ALL
-- �ǽ� ���̺� ����(���̺�� : TBL_JUBUN)
CREATE TABLE TBL_JUMUN -- �ֹ� ���̺� ���� 
(  JUNO     NUMBER          -- �ֹ���ȣ
 , JECODE   VARCHAR2(30)    -- ��ǰ �ڵ� 
 , JUSU     NUMBER          -- �ֹ�����
 , JUDAY    DATE DEFAULT SYSDATE   
);
-- Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
-- ���� �ֹ��� �߻��Ǿ��� ��� �ֹ� ���뿡 ����
-- �����Ͱ� �Էµ� �� �ֵ��� ó���ϴ� ���̺� 

-- �ǽ� ���� �� ��ǰ �ڵ�(JUCODE)����
-- ���ǻ� ��ǰ�� �ڵ带 �����Ѵٰ� �����ϰ� ��ǰ�� ������ �Է��Ѵ� 

INSERT INTO TBL_JUMUN
VALUES(1, '����ƽ', 20, TO_DATE('2001-11-01 09:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(2, '������', 10, TO_DATE('2001-11-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(3, '��ǹ�', 30, TO_DATE('2001-11-01 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(4, '��īĨ', 20, TO_DATE('2001-11-02 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(5, '��īĨ', 30, TO_DATE('2001-11-01 09:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(6, '������', 20, TO_DATE('2001-11-04 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(7, 'Ȩ����', 10, TO_DATE('2001-11-05 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(8, 'Ȩ����', 10, TO_DATE('2001-11-05 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(9, '������', 20, TO_DATE('2001-11-07 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(10, '��ǹ�', 10, TO_DATE('2001-11-08 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(11, '������', 20, TO_DATE('2001-11-09 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(12, '���ڱ�', 10, TO_DATE('2001-11-10 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(13, '������', 20, TO_DATE('2001-11-11 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(14, 'Ȩ����', 20, TO_DATE('2001-11-12 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(15, '��īĨ', 10, TO_DATE('2001-11-13 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(16, '��īĨ', 20, TO_DATE('2001-11-16 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(17, '������', 20, TO_DATE('2001-11-17 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(18, '������', 30, TO_DATE('2001-11-18 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(19, '������', 20, TO_DATE('2001-11-19 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(20, '����Ĩ', 30, TO_DATE('2001-11-20 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

SELECT *
FROM TBL_JUMUN;

-- �� Ŀ��
COMMIT;

-- �� ��¥�� ���� ���� ���� ���� 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session��(��) ����Ǿ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_JUMUN;
/*
1	����ƽ	20	2001-11-01 09:10:10
2	������	10	2001-11-01 10:10:10
3	��ǹ�	30	2001-11-01 11:10:10
4	��īĨ	20	2001-11-02 11:10:10
5	��īĨ	30	2001-11-01 09:10:10
6	������	20	2001-11-04 11:10:10
7	Ȩ����	10	2001-11-05 11:10:10
8	Ȩ����	10	2001-11-05 11:10:10
9	������	20	2001-11-07 11:10:10
10	��ǹ�	10	2001-11-08 11:10:10
11	������	20	2001-11-09 11:10:10
12	���ڱ�	10	2001-11-10 11:10:10
13	������	20	2001-11-11 11:10:10
14	Ȩ����	20	2001-11-12 11:10:10
15	��īĨ	10	2001-11-13 11:10:10
16	��īĨ	20	2001-11-16 11:10:10
17	������	20	2001-11-17 11:10:10
18	������	30	2001-11-18 11:10:10
19	������	20	2001-11-19 11:10:10
20	����Ĩ	30	2001-11-20 11:10:10
*/

-- �߰� ������ �Է� -> 2001����� ���۵� �ֹ��� ����(2023)���� ��� �߻�
INSERT INTO TBL_JUMUN VALUES(98764, '����Ĩ', 10 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98765, '������', 30 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98766, '������', 20 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98767, '���̽�', 40 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98768, 'Ȩ����', 10 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98769, '���ڱ�', 20 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98770, '������', 10 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98771, '���Ͻ�', 20 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98772, '������', 30 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98773, '������', 20 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98774, '������', 50 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_JUMUN VALUES(98775, '������', 10 , SYSDATE);
-- 1 �� ��(��) ���ԵǾ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_JUMUN;
/*
1	����ƽ	20	2001-11-01 09:10:10
2	������	10	2001-11-01 10:10:10
3	��ǹ�	30	2001-11-01 11:10:10
4	��īĨ	20	2001-11-02 11:10:10
5	��īĨ	30	2001-11-01 09:10:10
6	������	20	2001-11-04 11:10:10
7	Ȩ����	10	2001-11-05 11:10:10
8	Ȩ����	10	2001-11-05 11:10:10
9	������	20	2001-11-07 11:10:10
10	��ǹ�	10	2001-11-08 11:10:10
11	������	20	2001-11-09 11:10:10
12	���ڱ�	10	2001-11-10 11:10:10
13	������	20	2001-11-11 11:10:10
14	Ȩ����	20	2001-11-12 11:10:10
15	��īĨ	10	2001-11-13 11:10:10
16	��īĨ	20	2001-11-16 11:10:10
17	������	20	2001-11-17 11:10:10
18	������	30	2001-11-18 11:10:10
19	������	20	2001-11-19 11:10:10
20	����Ĩ	30	2001-11-20 11:10:10
                :
                :
98764	����Ĩ	10	2023-10-26 12:46:08
98765	������	30	2023-10-26 12:46:58
98766	������	20	2023-10-26 12:47:16
98767	���̽�	40	2023-10-26 12:47:46
98768	Ȩ����	10	2023-10-26 12:48:18
98769	���ڱ�	20	2023-10-26 12:48:36
98770	������	10	2023-10-26 12:48:58
98771	���Ͻ�	20	2023-10-26 12:49:18
98772	������	30	2023-10-26 12:49:39
98773	������	20	2023-10-26 12:50:06
98774	������	50	2023-10-26 12:50:22
98775	������	10	2023-10-26 12:50:52
*/

-- �� �����̰� ���� ���θ� � �� 
-- TBL_JUMUN ���̺��� ���ſ��� ��Ȳ
-- ���ø����̼ǰ��� �������� ���� �ֹ� ������
-- �����δ� �ٸ� ���̺� ����� �� �ֵ��� ���ٴ��� ���� ���� �Ұ����� 
-- ������ ��� �����͸� ������� ����� �͵� �Ұ����� ��Ȳ
-- -> ���������.. ������� ������ �ֹ� ������ �� ���� �߻��� 
-- �ֹ� ������ �����ϰ� ������ �����͸� �ٸ� ���̺�(TBL_JUMUNBACKUP)�� �����͸� �̰��Ͽ� ����� ������ ��ȹ 

CREATE TABLE TBL_JUMUNBACKUP
AS 
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') < TO_CHAR(SYSDATE,'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUNBACKUP;
/*
1	����ƽ	20	2001-11-01 09:10:10
2	������	10	2001-11-01 10:10:10
3	��ǹ�	30	2001-11-01 11:10:10
4	��īĨ	20	2001-11-02 11:10:10
5	��īĨ	30	2001-11-01 09:10:10
6	������	20	2001-11-04 11:10:10
7	Ȩ����	10	2001-11-05 11:10:10
8	Ȩ����	10	2001-11-05 11:10:10
9	������	20	2001-11-07 11:10:10
10	��ǹ�	10	2001-11-08 11:10:10
11	������	20	2001-11-09 11:10:10
12	���ڱ�	10	2001-11-10 11:10:10
13	������	20	2001-11-11 11:10:10
14	Ȩ����	20	2001-11-12 11:10:10
15	��īĨ	10	2001-11-13 11:10:10
16	��īĨ	20	2001-11-16 11:10:10
17	������	20	2001-11-17 11:10:10
18	������	30	2001-11-18 11:10:10
19	������	20	2001-11-19 11:10:10
20	����Ĩ	30	2001-11-20 11:10:10
*/

--------------------------------------------------------------------------------
CREATE TABLE TBL_JUMUNBACKUP
AS 
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
-- TABLE TBL_JUNUNBACKUP��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_JUMUNBACKUP;
--> TBL_JUMUN ���̺��� �����͵� �� ���� �ֹ� ���� �̿��� �����ʹ� 
-- ��� TBL_JUMUNBACKUP ���̺� ����� ��� ��ģ ����

-- TBL_JUMUN ���̺��� �����͵� �� 
-- ����� ��ģ �����͵� �� ���� �߻��� �ֹ� ������ �ƴ� �����͵� ���� 

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
-- 20�� �� ��(��) �����Ǿ����ϴ�.

-- Ȯ�� 
SELECT *
FROM TBL_JUMUN;
/*
98764	����Ĩ	10	2023-10-26 12:46:08
98765	������	30	2023-10-26 12:46:58
98766	������	20	2023-10-26 12:47:16
98767	���̽�	40	2023-10-26 12:47:46
98768	Ȩ����	10	2023-10-26 12:48:18
98769	���ڱ�	20	2023-10-26 12:48:36
98770	������	10	2023-10-26 12:48:58
98771	���Ͻ�	20	2023-10-26 12:49:18
98772	������	30	2023-10-26 12:49:39
98773	������	20	2023-10-26 12:50:06
98774	������	50	2023-10-26 12:50:22
98775	������	10	2023-10-26 12:50:52
*/

-- Ŀ��
COMMIT;
-- Ŀ�� �Ϸ� 

-- ���� ��ǰ �߼��� �̷������ ���� ���� �ֹ� �����͸� �����ϰ� 
-- ������ ��� �ֹ� �����͵��� ������ ��Ȳ�̹Ƿ� 
-- ���̺��� ��(���ڵ�)�� ������ �پ��� �ſ� �������� ������ 

-- �׷���, ���ݱ��� �ֹ����� ������ ���� ������ ��ǰ�� �� �ֹ������� 
-- ��Ÿ����� �� ��Ȳ�� �߻��ϰ� �Ǿ��� 
-- �׷��ٸ�, TBL_JUMUNBACKUP ���̺��� ���ڵ�(��)�� TBL_JUMUN ���̺��� ���ڵ�(��)�� 
-- ��� ���� �ϳ��� ���̺��� ��ȸ �ϴ°Ͱ� ���� ����� Ȯ���� �� �ֵ��� ��ȭ�� �̷������ ��

-- �÷��� �÷��� ���踦 ����Ͽ� ���̺��� �����ϰ��� �ϴ� ��� 
-- JOIN�� ��������� ���ڵ�� ���ڵ带 �����ϰ��� �� �� UNION / NUION ALL�� ����ϰ� ���� 

SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

-------------------------------------------

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

-- UNION�� �׻� ������� ù ��° �÷��� �������� 
-- �������� ������ ������ 
-- �ݸ�, UNION ALL�� ���յ� ����(���������� ���̺��� ����� ����)��� 
-- ��ȸ�� ����� �ִ� �״�� ��ȯ��( -> ���� ����)
-- �̷� ���� UNION�� ��ȭ�� �� ŭ ( -> ���ҽ� �Ҹ� �� ŭ)
-- ����, UNION�� ������� ���� �ߺ��� ���ڵ�(��)�� ������ ���
-- �ߺ��� �����ϰ� 1�� �ุ ��ȸ�� ����� ��ȯ�ϰ� �� 

-- �� ���ݱ��� �ֹ����� �����͸� ���� 
-- ��ǰ�� �� �ֹ����� ��ȸ �� �� �ִ� ������ ������ 

SELECT T.JECODE, SUM(T.JUSU)
FROM
(
    SELECT *
    FROM TBL_JUMUN 
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP 
)T GROUP BY JECODE
ORDER BY 2;

-- �� INTERSECT / MINUS(������/������)

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� 
-- ��ǰ�ڵ�� �ֹ������� ���� �Ȱ��� �ุ �����ؼ� ��ȸ�ϰ��� �� 
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE, JUSU
FROM TBL_JUMUN;
/*
������	30
������	20
Ȩ����	10
*/
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
/*
���ڱ�	10
����Ĩ	30
������	20
������	20
������	10
������	20
��ǹ�	10
��ǹ�	30
������	20
����ƽ	20
��īĨ	10
��īĨ	20
��īĨ	30
Ȩ����	20
*/

-- TBL_JUMUNBACKUP ���̺�� TBL_JUMUN ���̺��� ������� 
-- ��ǰ�ڵ�� �ֹ����� ���� �Ȱ��� ���� ������ 
-- �ֹ���ȣ, ��ǰ�ڵ�, �ֹ���, �ֹ����� �׸����� ��ȸ 

SELECT T.*
FROM(
SELECT JECODE, JUSU,JUNO,JUDAY
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE, JUSU,JUNO,JUDAY
FROM TBL_JUMUN
)T;

-- ��� 1
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1 WHERE (T1.JECODE,T1.JUSU) IN ( SELECT JECODE, JUSU
                                     FROM TBL_JUMUN
                                     INTERSECT
                                     SELECT JECODE, JUSU
                                     FROM TBL_JUMUNBACKUP);
                
-- ��� 2           
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1 JOIN (  SELECT JECODE, JUSU
             FROM TBL_JUMUN
             INTERSECT
             SELECT JECODE, JUSU
             FROM TBL_JUMUNBACKUP) T2 ON T1.JECODE = T2.JECODE AND T1.JUSU = T2.JUSU;
             
----------------------------------------------------------------------------------------

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	WARD	1250
30	SALES	TURNER	1500
30	SALES	ALLEN	1600
30	SALES	JAMES	950
30	SALES	BLAKE	2850
30	SALES	MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
-- ���� �߻�
-- ORA-00905: missing keyword

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D USING (DEPTNO);

/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	WARD	1250
30	SALES	TURNER	1500
30	SALES	ALLEN	1600
30	SALES	JAMES	950
30	SALES	BLAKE	2850
30	SALES	MARTIN	1250
*/

-------------------------------------------------------------------------------

-- �� TBL_EMP ���̺��� �޿��� ���� ���� ����� �����ȣ, �����, ������
-- �޿� �׸��� ��ȸ�� 

SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT T.�����ȣ,T.�̸�, T.������, T.����
FROM (
    SELECT EMPNO �����ȣ, JOB ������, SAL ����,ENAME �̸�
        ,RANK() OVER (ORDER BY SAL DESC) ����
    FROM TBL_EMP
)T WHERE T.���� = 1;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM TBL_EMP);
--> 7839	KING	PRESIDENT	5000

-- ANY 

-- =ALL
SELECT SAL
FROM TBL_EMP;
--> 
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
1500
2000
1700
2500
1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = ANY(800,1600,1250,2975,1250,2850,2450,3000,5000
            ,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL 
                 FROM TBL_EMP);
-- ��� ���̵��� ������ ã�ڴٴ� �ǹ� 
S
-- �� TBL_EMP ���̺��� 20�� �μ��� �ٹ��ϴ� ����� �� �޿��� ���� ���� �����
-- �����ȣ, �����, ������, �޿� �׸��� ��ȸ�ϴ� �������� �ۼ� 

SELECT EMPNO, DEPTNO ,ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL >= ALL (SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20);
                  
SELECT EMPNO, DEPTNO ,ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL = (SELECT MAX(SAL)
                           FROM TBL_EMP
                           WHERE DEPTNO = 20);
                  
SELECT *
FROM TBL_EMP
WHERE DEPTNO = 20;