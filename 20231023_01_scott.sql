SELECT USER
FROM DUAL;


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session��(��) ����Ǿ����ϴ�.

--�� ���� ��¥ �� �ð����κ��� 
-- ������ 2024-03-19 18:00 �б��� 
-- ���� �Ⱓ�� ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� ����

--       ���� �ð�              ������             ��       �ð�      ��       �� 
--2023-10-20 17:09:10   2024-03-19 18:00:00       140��      0        49       50

SELECT SYSDATE "����ð�"
     , TO_DATE('2024-03-19 18:00:00') "������"
     , TRUNC(TO_DATE('2024-03-19 18:00:00') - SYSDATE) "��"
     , TRUNC((TO_DATE('2024-03-19 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)/24*60) "�ð�"
     , TRUNC((TO_DATE('2024-03-19 18:00:00') - SYSDATE)/(24*60*60)) "��"
     
FROM DUAL;

-- 1�� 2�ð� 3�� 4�� 
SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--> 93784

-- "93784"�� �ٽ� ��, �ð�, ��, �ʷ� ȯ���ϸ�

SELECT  TRUNC(TRUNC(TRUNC(93784/60)/60)/24) ��
        , MOD(TRUNC(TRUNC(93784/60)/60),24) �ð�
        , MOD(TRUNC(93784/60),60) ��
        , MOD(93784,60) ��
FROM DUAL;
-- 1	2	3	4

-- �����ϱ��� ���� �Ⱓ Ȯ�� (���� : ��)
SELECT ���� �ϼ�  * (24*60*60)
FROM DUAL;

SELECT (TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;

SELECT TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE
FROM DUAL;

SELECT (TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)
FROM DUAL;
-- 12817386.99999999999999999999999999999999


SELECT SYSDATE ����ð�
     , TO_DATE('2024-03-19 18:00:00') ������
     , TRUNC(TRUNC(TRUNC((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60)/24) ��
     , MOD(TRUNC(TRUNC((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))/60),24) �ð�
     , MOD(TRUNC((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60),60) ��
     , TRUNC(MOD((TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60),60)) ��
FROM DUAL;
-- 2023-10-23 09:42:58	2024-03-19 18:00:00	8900	17	17	2


-- �� ���� �¾ ��¥ �� �ð����κ��� ������� �󸶸�ŭ�� �ð��� ��� �ִ��� 
-- ������ ���� ���·� ��ȸ�� �� �ֵ��� ������ 

--       ���� �ð�            �������             ��       �ð�      ��       �� 
-- 2023-10-20 17:09:10   1999-02-11 02:00:00       ???��      ?        ?       ??

SELECT SYSDATE ����ð�
     , TO_DATE ('1999-02-11 02:00:00') �������
     , SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS')
 --    , MOD(TRUNC(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS')/60),60) ��
     , TRUNC(MOD(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS'),60)) ��

FROM DUAL;


/*
SELECT  TRUNC(TRUNC(TRUNC(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS')/60)/60)/24) ��
        , MOD(TRUNC(TRUNC(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS')/60)/60),24) �ð�
        , MOD(TRUNC(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS')/60),60) ��
        , MOD(SYSDATE - TO_DATE('1999-02-11 02:00:00', 'YYYY-MM-DD HH24:MI:SS'),60) ��
FROM DUAL;

SYSDATE - TO_DATE('2024-03-19 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
*/

-- ��¥ ���� ���� ���� ���� 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
-- Session��(��) ����Ǿ����ϴ�.

-- �� ��¥ �����͸� ������� �ݿø�, ���� ���� ������ ���� �� �� ���� 

-- �� ��¥ �ݿø� 
SELECT SYSDATE COL1 -- 2023-10-23 -> �⺻ ���� ��¥ 
     , ROUND(SYSDATE, 'YEAR') COL2 -- 2024-01-01 -> �������� ��ȿ�� ������(��ݱ� / �Ϲݱ� ����)
     , ROUND(SYSDATE, 'MONTH') COL3 -- 2023-11-01 -> ������ ��ȿ�� ������(15�� ����)
     , ROUND(SYSDATE, 'DD') COL4 -- 2023-10-23 -> �ϱ��� ��ȿ�� ������(���� ����)
     , ROUND(SYSDATE, 'DAY') COL5 -- 2023-10-22 -> �ϱ��� ��ȿ�� ������ (������ ���� ����)
FROM DUAL;

-- �� ��¥ ����  
SELECT SYSDATE COL1 -- 2023-10-23 -> �⺻ ���� ��¥ 
     , TRUNC(SYSDATE, 'YEAR') COL2 -- 2024-01-01 -> �������� ��ȿ�� ������(��ݱ� / �Ϲݱ� ����)
     , TRUNC(SYSDATE, 'MONTH') COL3 -- 2023-10-01 -> ������ ��ȿ�� ������(15�� ����)
     , TRUNC(SYSDATE, 'DD') COL4 -- 2023-10-23 -> �ϱ��� ��ȿ�� ������(���� ����)
     , TRUNC(SYSDATE, 'DAY') COL5 -- 2023-10-22 -> �� �� �ֿ� �ش��ϴ� �Ͽ��� (������ ���� ����)
FROM DUAL;

-- �� ��¥ �ݿø�


-----------------------------------------------------------------------------------------------------

-- �� ��ȯ �Լ� �� 
-- TO_CHAR() : ���ڳ� ��¥ �����͸� ���� Ÿ������ ���ѽ����ִ� �Լ�
-- TO_DATE() : ���� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ� 
-- TO_NUMBER() : ���� �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ� 

-- �� ��¥�� -> ������ 
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') COL1 -- 2023-10-23
     , TO_CHAR(SYSDATE, 'YYYY') COL2 -- 2023
     , TO_CHAR(SYSDATE, 'YEAR') COL3 -- TWENTY TWENTY-THREE
     , TO_CHAR(SYSDATE, 'MM') COL4 -- 10
     , TO_CHAR(SYSDATE, 'MONTH') COL5 -- 10��
     , TO_CHAR(SYSDATE, 'MON') COL6 -- 10��
     , TO_CHAR(SYSDATE, 'DD') COL7   -- 23
     , TO_CHAR(SYSDATE, 'MM-DD') COL8 -- 10-23
     , TO_CHAR(SYSDATE, 'DAY') COL9 -- ������
     , TO_CHAR(SYSDATE, 'DY') COL10 -- ��
     , TO_CHAR(SYSDATE, 'HH24') COL11 -- 10
     , TO_CHAR(SYSDATE, 'HH') COL12 -- 10
     , TO_CHAR(SYSDATE, 'HH AM')  COL13 -- 10 ����
     , TO_CHAR(SYSDATE, 'HH PM') COL14 -- 10 ����
     , TO_CHAR(SYSDATE, 'MI') COL15 -- 31
     , TO_CHAR(SYSDATE, 'SS') COL16 -- 29
     , TO_CHAR(SYSDATE, 'SSSSS') COL17 -- 37909
     , TO_CHAR(SYSDATE, 'Q') COL18 -- 4(�б�)
FROM DUAL;

SELECT 10 COL1
     , '10' COL2
FROM DUAL;
-- 10	10

-- �� ��¥�� ��ȭ ������ ���� ���� ��� 
-- ���� ���� ���� ������ ���� �� �� ���� 

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\'; 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- �� ������ -> ������ 

SELECT 7 COL1
     , TO_CHAR(7) COL2
     , '7'
FROM DUAL;
-- 7	7	7
--��ȸ ����� ���� �������� ���� �������� Ȯ�� 

SELECT '4' COL1
     , TO_NUMBER(4) COL2
     , 4 COL3
     , TO_CHAR('4') COL4
     , TO_NUMBER(04) COL5
FROM DUAL;
-- 4	4	4	4	4
--> ��ȸ ����� ���� �������� ������������ Ȯ���ϱ�

-- ���� ��¥���� ���� �⵵(2023)�� ���� ���·� ��ȸ(��ȯ)
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) COL1
FROM DUAL;
-- 2023

-- �� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') COL1 -- 2023 -> ����
     , TO_CHAR(SYSDATE, 'MM') COL2 -- 10 -> ����
     , TO_CHAR(SYSDATE, 'DD') COL3 -- 23 -> ����
     , EXTRACT(YEAR FROM SYSDATE) COL4 -- 2023 -> ����
     , EXTRACT(MONTH FROM SYSDATE) COL5 -- 10 -> ����
     , EXTRACT(DAY FROM SYSDATE) COL6 -- 23 -> ����
FROM DUAL;
--> 2023	10	23	2023	10	23
-- ��, ��, ��, �̿��� �ٸ� �׸��� �Ұ�

-- TO_CHAR() Ȱ�� -> ������ ���� ǥ�� ����� ��ȯ 

SELECT 60000 COL1
     , TO_CHAR(60000, '99,999') COL2
     , TO_CHAR(60000, '$99,999') COL3
     , TO_CHAR(60000, 'L99,999') COL4
     , LTRIM(TO_CHAR(60000, 'L99,999')) COL5
FROM DUAL;
-- 60000	 60,000	 $60,000	        ��60,000	��60,000

-- �� ��¥ ���� ���� ���� ���� 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ �� 

SELECT  SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))
FROM DUAL;

-- ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ?
-- TO_YMINTERVAL(), TO_DSINTERVAL()
SELECT SYSDATE ����ð�
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "���� ���" 
FROM DUAL;
-- 2023-10-23 11:25:22	2024-12-26 15:30:28

-------------------------------------------------------------------------------------

-- �� CASE ����(���ǹ�, �б⹮)
/*
CASE
WHEN
THEN
ELES
END
*/

SELECT CASE 5+2 WHEN 4 THEN '5+2=4' ELSE '5+2�� �����' END
FROM DUAL;
-- 5+2�� �����

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2�� �����' END
FROM DUAL;
-- 5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2'
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'                
                ELSE '�����'
        END
FROM DUAL;
- 1+1 =2

SELECT CASE 2+2 WHEN 2 THEN '2+2=2'
                WHEN 3 THEN '2+2=3'
                WHEN 4 THEN '2+2=4'                
                ELSE '�����'
        END
FROM DUAL;
-- 2+2=4

SELECT CASE 3+3 WHEN 2 THEN '3+3=2'
                WHEN 3 THEN '3+3=3'
                WHEN 4 THEN '3+3=4'                
                ELSE '�����'
        END
FROM DUAL;
-- �����

SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-1=3 THEN '6-1=3'
            WHEN 7+0=0 THEN '7+0=0'
            ELSE '����'
       END
FROM DUAL;
-- ����

SELECT CASE WHEN 5+2=7 THEN '5+2=7'
            WHEN 6-1=3 THEN '6-1=3'
            WHEN 7+0=0 THEN '7+0=0'
            ELSE '����'
       END
FROM DUAL;
-- 5+2=7

--�� DECODE()
SELECT DECODE(5-2, 1, '5-2=1',2,'5-2=2',3,'5-2=3','5-2 �����') Ȯ��
FROM DUAL;
-- 5-2=3

--�� CASE WHEN THEN ELSE END(���ǹ�, �б⹮) Ȱ��

SELECT CASE WHEN 5<2 THEN '5<2' 
            WHEN 5>2 THEN '5>2'
            ELSE '5�� 2�� �� �Ұ�'
        END "���Ȯ��"
FROM DUAL;
-- 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '�ϼ�����'
            ELSE '��������'
       END "��� Ȯ��"
FROM DUAL;
-- ��������

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '������'
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '��������'  
        END "��� Ȯ��"
FROM DUAL;


SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '������'
            WHEN 5<2 AND 2=3 THEN '��������'
            ELSE '��������'  
        END "��� Ȯ��"
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--Session��(��) ����Ǿ����ϴ�.

SELECT *
FROM TBL_SAWON;
/*
1003	�ڳ���	    9902082234567	2006-08-10	4000
1004	������	    9708112234567	2010-05-06	5000
1005	������	    0502034234567	2015-10-19	1000
1006	������	    0609304234567	2012-06-17	1000
1007	�μ���	    6510102234567	1999-08-22	2000
1008	������	    6909101234567	1998-01-10	2000
1009	���̰�	    0505053234567	2011-05-06	1500
1010	������	6611112234567	2000-01-16	1300
1011	������	    9501061234567	2009-09-19	4000
1012	���켱	    0606064234567	2011-11-11	2000
1013	����	    6511111234567	1999-11-11	2000
1014	������	    9904171234567	2009-11-11	2000
1015	���ù�	    0202023234567	2010-10-10	2300
*/

-- TBL_SAWON ���̺��� Ȱ���Ͽ� ������ ���� �׸��� ��ȸ�� �� �ֵ��� ������ ����
-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, ����������, �ٹ��ϼ�, ���� �ϼ� 
-- �޿�, ���ʽ� �� ���糪�̴� ������ ���� ���� �ѱ����� ������ ���� ������ ����
-- ����, ���� �������� �ش� ������ ���̰� �ѱ� ���̷� 60���� �Ǵ� ���� �� ������ �Ի� ��, �Ϸ� ������ ���� 
-- �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� ����� �� ����� ���� �޿� ����
-- 30% ����, 2000�� �̻� �ٹ��� ����� �� ����� ���� �޿� ���� 50% ���� �� �� �ֵ��� ó����

--EXTRACT(YEAR FROM SUBSTR(JUBUN,1,2))
--TRUNC(TRUNC(TRUNC(93784/60)/60)/24) ��
--      ,CASE WHEN SUBSTR(JUBUN,7,1) = '1' OR SUBSTR(JUBUN,7,1) = '2' THEN TO_NUMBER(SYSDATE,'YYYY') - TO_NUMBER(TO_CHAR(19)+SUBSER(JUBUN,1,2))


SELECT SANO �����ȣ, SANAME ����̸�,JUBUN �ֹε�Ϲ�ȣ,HIREDATE �Ի���,SAL �޿�
       ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'
        ELSE '��'
    END "����" 
      ,SUBSTR(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)),3,4)+1 ����
      ,SYSDATE + (61 - (SUBSTR(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)),3,4)+1))*366 ������
--      ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2') THEN TO_CHAR(SYSDATE,'YYYY') - TO_NUMBER(19 ||SUBSTR(JUBUN,1,2))+1
--            WHEN SUBSTR(JUBUN,7,1) IN ('3','4') THEN TO_CHAR(SYSDATE,'YYYY') - TO_NUMBER(20 ||SUBSTR(JUBUN,1,2))+1
--            WHEN SUBSTR(7,1) = '3' OR SUBSTR(7,1) = '4' THEN TO_NUMBER(SYSDATE,'YY') - SUBSTR(7,1)
--            ELSE '����'
--        END "����"
      ,TRUNC(SYSDATE - HIREDATE) �ٹ��ϼ�
      ,(59 - (SUBSTR(EXTRACT(YEAR FROM SYSDATE) - TO_NUMBER(SUBSTR(JUBUN,1,2)),3,4)+1))*365 �����ϼ�
      ,CASE WHEN TRUNC(SYSDATE - HIREDATE) < 2000 AND TRUNC(SYSDATE - HIREDATE) >= 1000 THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000 THEN SAL*0.5
        END "���ʽ�"
FROM TBL_SAWON;

SELECT SANO "�����ȣ", SANAME "�����",JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'  
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
            ELSE '����Ȯ�κҰ�'
     END "����"
     -- ���糪�� = ����͵� - �¾�⵵ + 1
     ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
          THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
          WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
          THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
          ELSE -1
     END "���� ����"
     --�Ի���
     ,HIREDATE "�Ի���"
     ,SAL "�޿���"
FROM TBL_SAWON;

SELECT EMPNO, ENAME,SAL, SAL*12+NVL(COMM,0), COMM, "����"
FROM EMP;
-- �����߻�
-- ORA-00904: "����": invalid identifier

SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
FROM EMP;

SELECT �����ȣ, �����, �޿�, ����, ����, ����*2 "�����ι�"
FROM (

SELECT EMPNO �����ȣ, ENAME �����, SAL �޿�, COMM ����, SAL*12+NVL(COMM,0) "����"
FROM EMP

);


CREATE VIEW VIEW_EMP
AS
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
FROM EMP;
-- ORA-01031: insufficient privileges

--�� SYS�� �����Ͽ� SCOTT ������ CREATE VIEW ������ �ο��� �� �ٽ� ���� 

CREATE VIEW VIEW_EMP
AS
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����"
FROM EMP;
-- View VIEW_EMP��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_EMP;

CREATE OR REPLACE VIEW VIEW_EMP -- REPLACE(�����) ����
AS
SELECT EMPNO �����ȣ , ENAME �����, SAL �޿�, COMM ����, SAL*12+NVL(COMM,0) "����"
FROM EMP;
-- View VIEW_EMP��(��) �����Ǿ����ϴ�.

SELECT �����ȣ, �����, ����
FROM VIEW_EMP;

-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, ����������, �ٹ��ϼ�, ���� �ϼ� 
-- �޿�, ���ʽ� �� ���糪�̴� ������ ���� ���� �ѱ����� ������ ���� ������ ����

SELECT T.�����ȣ,T.�����,T.�ֹι�ȣ,T.����,T.���糪��,T.�Ի���
    -- ����������
    -- ���������⵵ -> �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
    -- ���� ���̰� 57�� 3�� �� 2023 -> 2026
    -- ���� ���̰� 28�� 32�� �� 2023 -> 2055
    -- ADD_MONTHS(SYSDATE, �������*12)
    --                     �ѤѤѤ�
    --                     60-���糪��
    -- ADD_MONTHS(SYSDATE, (60- ���糪��)*12) -> Ư������ 
    -- TO_CHAR('Ư����¥','YYYY') -> �������� �⵵�� ����
    -- TO_CHAR('�Ի���', 'MM-DD') -> �Ի� ���ϸ� ����
    -- TO_CHAR('Ư����¥', 'YYYY') || '-' || TO_CHAR('�Ի���', 'MM-DD') -> ����������
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD') ����������
     -- �ٹ� �ϼ� 
     -- ���糯¥ - �Ի���
     ,TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    ,T.�޿�
    --���ʽ�
    -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� -> �޿� * 0.3
    -- �ٹ��ϼ��� 2000�� �̻� -> �޿� * 0.5
    -- ������ (�ٹ��ϼ��� 1000�� �̸�) -> 0
  ---------------------------------------------------------
  -- �ٹ��ϼ��� 2000�� �̻��϶� -> �޿� * 0.3
  -- �ٹ��ϼ��� 1000�� �̻��϶� -> �޿� * 0.5
  -- ������ (1000�� �̸�) -> 0
  , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� *0.5
        ELSE T.�޿� * 0.3
    END "���ʽ�"
  
  
FROM 
(
    SELECT SANO "�����ȣ", SANAME "�����",JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'  
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
          END "����"
         ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
          END "���糪��"
         ,HIREDATE "�Ի���"
         ,SAL "�޿�"
    FROM TBL_SAWON
) T;

----------------------------------------------------------------------------------------

SELECT T.�����ȣ,T.�����,T.�ֹι�ȣ,T.����,T.���糪��,T.�Ի���
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD') ����������
     ,TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    ,T.�޿�
  , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� *0.5
        ELSE T.�޿� * 0.3
    END "���ʽ�"
FROM (
    SELECT SANO "�����ȣ", SANAME "�����",JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'  
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
          END "����"
         ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
          END "���糪��"
         ,HIREDATE "�Ի���"
         ,SAL "�޿�"
    FROM TBL_SAWON
) T;

/*
1001	������	    9710171234567	��	27	2005-01-03	2056-01-03	6867	11759	3000	1500
1002	�ڰ���	    9511182234567	��	29	1999-11-23	2054-11-23	8735	11353	4000	2000
1003	�ڳ���	    9902082234567	��	25	2006-08-10	2058-08-10	6283	12709	4000	2000
1004	������	    9708112234567	��	27	2010-05-06	2056-05-06	4918	11883	5000	2500
1005	������	    0502034234567	��	19	2015-10-19	2064-10-19	2926	14971	1000	500
1006	������	    0609304234567	��	18	2012-06-17	2065-06-17	4145	15212	1000	500
1007	�μ���	    6510102234567	��	59	1999-08-22	2024-08-22	8828	303	    2000	1000
1008	������	    6909101234567	��	55	1998-01-10	2028-01-10	9417	1539	2000	1000
1009	���̰�	    0505053234567	��	19	2011-05-06	2064-05-06	4553	14805	1500	750
1010	������	6611112234567	��	58	2000-01-16	2025-01-16	8681	450	    1300	650
1011	������	    9501061234567	��	29	2009-09-19	2054-09-19	5147	11288	4000	2000
1012	���켱	    0606064234567	��	18	2011-11-11	2065-11-11	4364	15359	2000	1000
1013	����	    6511111234567	��	59	1999-11-11	2024-11-11	8747	384	    2000	1000
1014	������	    9904171234567	��	25	2009-11-11	2058-11-11	5094	12802	2000	1000
1015	���ù�	    0202023234567	��	22	2010-10-10	2061-10-10	4761	13866	2300	1150
*/

-- ������ ó���� ������ �������..
-- Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�..
-- Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 �߻��� �� ����
-- (��, �߰����� ��ȸ ������ �߻��ϰų�, ������ �Ļ��Ǵ� ���)
-- �̿� ���� ���.. �ش� �������� �ٽ� �����ؾ� �ϴ� ���ŷο��� ���� �� �ֵ��� ��(VIEW)�� ����� ������ �� �� ����

CREATE OR REPLACE VIEW VIEW_SAWON
AS
SELECT T.�����ȣ,T.�����,T.�ֹι�ȣ,T.����,T.���糪��,T.�Ի���
     , TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD') ����������
     ,TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
     , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE, (60- T.���糪��)*12), 'YYYY') 
        || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    ,T.�޿�
  , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� *0.5
        ELSE T.�޿� * 0.3
    END "���ʽ�"
FROM (
    SELECT SANO "�����ȣ", SANAME "�����",JUBUN "�ֹι�ȣ"
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '��'  
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '��'
                ELSE '����Ȯ�κҰ�'
          END "����"
         ,CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
          END "���糪��"
         ,HIREDATE "�Ի���"
         ,SAL "�޿�"
    FROM TBL_SAWON
) T;
-- View VIEW_SAWON��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_SAWON;

/*
1001	������	9710171234567	��	27	2005-01-03	2056-01-03	6867	11759	3000	1500
1002	�ڰ���	9511182234567	��	29	1999-11-23	2054-11-23	8735	11353	4000	2000
1003	�ڳ���	9902082234567	��	25	2006-08-10	2058-08-10	6283	12709	4000	2000
1004	������	9708112234567	��	27	2010-05-06	2056-05-06	4918	11883	5000	2500
1005	������	0502034234567	��	19	2015-10-19	2064-10-19	2926	14971	1000	500
1006	������	0609304234567	��	18	2012-06-17	2065-06-17	4145	15212	1000	500
1007	�μ���	6510102234567	��	59	1999-08-22	2024-08-22	8828	303	2000	1000
1008	������	6909101234567	��	55	1998-01-10	2028-01-10	9417	1539	2000	1000
1009	���̰�	0505053234567	��	19	2011-05-06	2064-05-06	4553	14805	1500	750
1010	������	6611112234567	��	58	2000-01-16	2025-01-16	8681	450	1300	650
1011	������	9501061234567	��	29	2009-09-19	2054-09-19	5147	11288	4000	2000
1012	���켱	0606064234567	��	18	2011-11-11	2065-11-11	4364	15359	2000	1000
1013	����	6511111234567	��	59	1999-11-11	2024-11-11	8747	384	2000	1000
1014	������	9904171234567	��	25	2009-11-11	2058-11-11	5094	12802	2000	1000
1015	���ù�	0202023234567	��	22	2010-10-10	2061-10-10	4761	13866	2300	1150
*/

SELECT *
FROM VIEW_SAWON
WHERE �ٹ��ϼ� >= 5000;
/*
1001	������	9710171234567	��	27	2005-01-03	2056-01-03	6867	11759	3000	1500
1002	�ڰ���	9511182234567	��	29	1999-11-23	2054-11-23	8735	11353	4000	2000
1003	�ڳ���	9902082234567	��	25	2006-08-10	2058-08-10	6283	12709	4000	2000
1007	�μ���	6510102234567	��	59	1999-08-22	2024-08-22	8828	303	2000	1000
1008	������	6909101234567	��	55	1998-01-10	2028-01-10	9417	1539	2000	1000
1010	������	6611112234567	��	58	2000-01-16	2025-01-16	8681	450	1300	650
1011	������	9501061234567	��	29	2009-09-19	2054-09-19	5147	11288	4000	2000
1013	����	6511111234567	��	59	1999-11-11	2024-11-11	8747	384	2000	1000
1014	������	9904171234567	��	25	2009-11-11	2058-11-11	5094	12802	2000	1000
*/

SELECT *
FROM VIEW_SAWON
WHERE ���ʽ� >= 2000;
/*
1002	�ڰ���	9511182234567	��	29	1999-11-23	2054-11-23	8735	11353	4000	2000
1003	�ڳ���	9902082234567	��	25	2006-08-10	2058-08-10	6283	12709	4000	2000
1004	������	9708112234567	��	27	2010-05-06	2056-05-06	4918	11883	5000	2500
1011	������	9501061234567	��	29	2009-09-19	2054-09-19	5147	11288	4000	2000
*/

-- ���������� Ȱ���Ͽ� 
-- TBL_SAWON ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �� 
-- ����� ���� ���糪�� �޿� ���̺��ʽ� 
-- VIEW_SAWON�� �̿��ϴ°��� �ƴ�
-- ���̺��ʽ��� ���� ���̰� 40�� �̻��̸� �޿��� 70%
-- 30�� �̻� 40�� �̸��̸� �޿��� 50%
-- 20�� �̻� 30�� �̸����� �޿��� 30%�� ��

-- ���� �̷��� �ϼ��� ��ȸ ������ ���� 
-- VIEW_SAWON2��� �̸��� ��(VIEW)�� ������ �� �ֵ��� �� 

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