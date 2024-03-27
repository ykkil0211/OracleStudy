select user
from dual;
-- scott

-- FUNCTION(�Լ�)
--1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ���� �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���
-- ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų� ���� ������ �Լ��� ���� �� ����(-> ����� ���� �Լ�)
-- �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų� ���� ���ν���ó�� EXECUTE ���� ���� ���� �� �� ���� 

--2. ���� �� ���� 

/*
CREATE [OR REPLACE] FUNCTION �Լ��� 
[(�Ű�������1 �ڷ��� 
, �Ű�������2 �ڷ���
)]
RETURN ������Ÿ��

IS
    �ֿ� ���� ����
BEGIN
    -- ���๮;
    ... 
    RETURN(��);
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;

-- ����� ���� �Լ�(������ �Լ�)��
-- IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
-- �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN���� �����ؾ� �ϰ�,
-- FUNCTION�� �ݵ�� ���� ���� ��ȯ�� 

-- �� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- -----------------------
-- �Ű����� ����(����) -> '771212-1022432' --> 'YYMMDD - NNNNNNN'
-- �Լ��� : FN_GENDER()
                     �� �ֹε�Ϲ�ȣ -> "751010-1122233"
*/

CREATE OR REPLACE FUNCTION FN_GENDER(V_SSN VARCHAR2) -- �Ű����� : �ڸ���(����) ���� ���� 
RETURN VARCHAR2                                      -- ��ȯ�ڷ��� : �ڸ���(����) ���� ���� 
IS
    -- ����� -> �ֿ� ���� ���� (�� �ʱ�ȭ)
    V_RESULT   VARCHAR2(20);
BEGIN
    -- ����� -> ���� �� ó�� (�׸��� ����� ��ȯ)
    IF (SUBSTR(V_SSN, 8,1) IN ('1','3'))
        THEN V_RESULT := '����';
    ELSIF(SUBSTR(V_SSN, 8,1) IN ('2','4'))
        THEN V_RESULT := '����';
    ELSE 
        V_RESULT := '����Ȯ�� �Ұ�';
    END IF;
    
    -- ����� ��ȯ CHECK
    RETURN V_RESULT;
END;
-- Function FN_GENDER��(��) �����ϵǾ����ϴ�.

-- ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� -> (A,B)
-- A�� B���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ���
-- ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ���Ͽ� �ۼ� 
-- �Լ��� : FN_POW()
/*
SELECT FN_POW(10,3)
--> 1000
*/
CREATE OR REPLACE FUNCTION FN_POW(A NUMBER, B NUMBER)
RETURN NUMBER
IS
     V_NUM NUMBER;      -- ���� ����
     V_RESULT NUMBER := 1;    -- ��ȯ ����� ���� ->  1�� �ʱ�ȭ 
BEGIN

    -- �ݺ��� ����
    FOR V_NUM IN 1 .. B LOOP
        V_RESULT := V_RESULT * A; -- V_RESULT*= A;
    END LOOP;
    
    -- ���� ����� ��ȯ
    RETURN V_RESULT;
    
    RETURN  V_RESULT;
END;

SELECT FN_POW(10,3)
FROM DUAL;

--PBL_INSA ���̺��� �޿� ��� ���� �Լ� ���� 
-- �޿��� "(�⺻��*12)+����" ������� ������ ����
-- �Լ��� : FN_PAY(�⺻��, ����)

CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER, SUDANG NUMBER)
RETURN NUMBER
IS
    -- �ֿ� ���� ���� 
    V_RESULT NUMBER := 1;
BEGIN
    -- ���� �� ó��
    V_RESULT := (NVL(BASICPAY,0) *12) + NVL(SUDANG,0);
    
    -- ���� ����� ��ȯ
    RETURN V_RESULT;
END;

-- TBL_INSA ���̺��� �Ի����� �������� ��������� �ٹ������ ��ȯ�ϴ� �Լ��� ����
-- ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ��� 
-- �Լ��� : FN_WORKYEAR(�Ի���)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    V_RESULT VARCHAR2(30);
BEGIN
    
    V_RESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, IBSADATE)/12)||' '||
                TRUNC(MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, IBSADATE)/12),12));

    RETURN V_RESULT;
END;

-- Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.

SELECT FN_WORKYEAR(IBSADATE)
FROM TBL_INSA;

--------------------------------------------------------------------------------
-- ���� 

--1. INSERT, UPDATE, DELETE, (MERGE)
--> DML(Data Manipulation Language)
-- COMMIT/ ROLLBACK�� �ʿ��� 

--2. CREATE, DROP, ALTER, (TRUNCATE)
--> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� commit�� 

--3. GRANT, REVOKE 
--> DCL(Date Control Language)
-- �����ϸ� �ڵ����� commit�� 

--4. COMMIT, ROLLBACK
--> TCL(Transaction Control Language)

-- ���� pl/sql�� -> DML��, TCL���� ��� ����
-- ���� pl/sql�� -> DML��, DDL��, DCL��, TCL�� ��� ���� 

------------------------------------------------------------------------------

-- 1. PL/SQL���� ���� ��ǥ���� ������ ������ ���ν����� 
-- �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧�� �̸� �ۼ��Ͽ� �����ͺ��̽� ����
-- ������ �ξ��ٰ� �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ��� ó�����ִ� ���� 

-- ���� �� ���� 
/*
CREATE [OR REPLACE] PROCUDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [--�ֿ� ���� ����]
BEGIN
    -- ���� ����;
    ...
    
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/
-- FUNCTION�� ������ �� "RETURN ��ȯ �ڷ���" �κ��� �������� ������
-- "RETURN"�� ��ü�� �������� �ʰ�, ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ����,��
-- IN(�Է�), OUT(���), INOUT(�����)���� ���е�

--3. ����(ȣ��)
/*
EXE[CUTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

-- �� ���ν��� �ǽ��� ���� ���̺� ������..
-- "20231103_02_scott.sql" ���� ���� 

-- ���ν��� ���� 
-- ���ν����� : PRC_STUDENT_INSERT(���̵�, �н�����,. �̸�, ��ȭ, �ּ�)

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( ���̵�
, �н�����
, �̸�
, ��ȭ��ȣ
, �ּ�
)
IS
BEGIN
END;

CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.ID%TYPE
, V_TEL     IN TBL_STUDENTS.ID%TYPE
, V_ADDR    IN TBL_STUDENTS.ID%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է� -> INSERT
    INSERT INTO TBL_IDPW(ID,PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է� -> INSERT
    INSERT INTO TBL_STUDENTS(ID,NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
END;
-- Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.

-- ���ν��� �ǽ��� ���� ���̺� ������ 
-- "20231103_02_scott.sql" ���� ���� 

-- �� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ� ���������� �ٸ� �߰��׸� ���� ó���� 
-- �Բ� �̷���� �� �ֵ��� �ϴ� ���ν����� �ۼ��� 
-- ���ν����� : PRC_SUNGJUK_INSERT()

/*
���� �ν�)
���� TBL_SUNGJUK ���̺��� 
HAKBUN, NAME,KOR ,ENG,MAT,TOT ,AVG ,GRADE
(�й�, �̸�, ��������, ��������, ��������, ����, ���, ���) �÷����� ����
�� ���̺��� ������� Ư�� �׸�(�й�, �̸�, �����Ӽ�, ��������, ��������)�� �Է��ϸ�
�߰� �׸�(����, ���, ���)�� �˾Ƽ� ó���� �� �ֵ��� ���ν����� �����ϴ� ���� 

���� ��)
EXEC PRC_SUNGJUK_INSERT(1,'��ٽ�',90,80,70);

-> �̿� ���� ���ν��� ȣ��� ó���� ��� 

�й� �̸� �������� �������� ��������  ����    ���   ���  
1.  ��ٽ�  90       80        70      240     80     B

*/

/*
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS 
     V_TOT          TBL_SUNGJUK.TOT%TYPE;
    ,V_AVG          TBL_SUNGJUK.AVG%TYPE;
    ,V_GRADE        TBL_SUNGJUK.GRADE%TYPE; 
BEGIN 
    
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := TRUNC(V_TOT/3);
    
    INSERT INTO TBL_STUDENTS(HAKBUN,NAME, KOR, ENG,MAT,TOT,AVG,GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
    
    IF V_AVG > 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG > 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG > 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG > 60
        THEN V_GRADE := 'D';
    ELSE 
        V_GRADE := 'F';
    END IF;
        
END;
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN      IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME        IN TBL_SUNGJUK.NAME%TYPE
, V_KOR         IN TBL_SUNGJUK.KOR%TYPE
, V_ENG         IN TBL_SUNGJUK.ENG%TYPE
, V_MAT         IN TBL_SUNGJUK.MAT%TYPE
)
IS 
     -- ����� 
     -- INSERT �������� �����ϱ� ���� �ʿ��� �߰� ���� ����
     V_TOT          TBL_SUNGJUK.TOT%TYPE;
     V_AVG          TBL_SUNGJUK.AVG%TYPE;
     V_GRADE        TBL_SUNGJUK.GRADE%TYPE; 
BEGIN 
    -- �����
    -- INSERT �������� �����ϱ� ���� �ʿ��� �߰� ���� ����
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
        
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
        
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
        
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
        
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    COMMIT;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN,NAME, KOR, ENG,MAT,TOT,AVG,GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG,V_MAT,V_TOT,V_AVG,V_GRADE);
        
END;
-- Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.

EXEC PRC_SUNGJUK_INSERT(1, '��ٽ�',90,80,70);
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

EXEC PRC_SUNGJUK_INSERT(2, '������',80,60,50);
-- -- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


-- �� TBL_SUNGJUK ���̺��� Ư�� �л��� ����(����, ��������, ��������, ��������) ������ ���� �� 
--  ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� ������ 
-- ���ν����� : PRC_SUNGJUK_UPDATE()
/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2,50,50,50);

1	��ٽ�	90	80	70	240	80	B
2	������	50	50	50	150	50	F

*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE     
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
     V_TOT          TBL_SUNGJUK.TOT%TYPE;
     V_AVG          TBL_SUNGJUK.AVG%TYPE;
     V_GRADE        TBL_SUNGJUK.GRADE%TYPE; 
BEGIN

    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT/3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
        
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
        
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
        
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
        
    ELSE 
        V_GRADE := 'F';
    END IF;
    
    COMMIT;

    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT, TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
END;

-- �� ���ν��� ���� ���� ���� 
EXEC PRC_SUNGJUK_UPDATE(1,90,90,90);

-- �� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
-- ���ν����� �ۼ��� 
-- �� ID�� PW�� ��ġ�ϴ� ��쿡�� ������ ���� �� �� �ְԱ� ó���� 
-- ���ν����� : PRG_STUDENT_UPDATE()
/*
EXEC PRC_STUDENT_UPDATE('moon','java006','010-9999-9999','������ Ⱦ��');
--> ������ ���� X 

EXEC PRC_STUDENT_UPDATE('moon','java006','010-9999-9999','������ Ⱦ��');
--> ������ ���� ��
*/

CREATE OR REPLACE PROCEDURE PRG_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
        
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_PW = (SELECT PW
                                FROM TBL_IDPW
                                WHERE ID = V_ID);                       
END;

COMMIT;