SELECT USER
FROM DUAL;
-- SCOTT

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

-- ��� 1 
CREATE OR REPLACE PROCEDURE PRG_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0; -- �н����� ��ġ:1 / �н��������ġ :2
BEGIN
    
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = 'moon';
    
    IF (V_PW = V_PW2)       -- �н����� ��ġ
        THEN V_FLAG := 1;
    ELSE                    -- �н����� ����ġ
        V_FLAG := 2;
    END IF;
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_FLAG=1;  
    
    COMMIT;

END;
-- Procedure PRG_STUDENT_UPDATE��(��) �����ϵǾ����ϴ�.
CREATE OR REPLACE PROCEDURE PRG_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0; -- �н����� ��ġ:1 / �н��������ġ :2
BEGIN
        UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
                FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
                ON T1.ID = T2.ID) T
        SET T.TEL = V_TEL, T.ADDR = V_ADDR
        WHERE T.ID =V_ID AND T.PW = V_PW ;
END;
-- Procedure PRG_STUDENT_UPDATE��(��) �����ϵǾ����ϴ�.

--TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ���
          
--NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG���� ������ �÷� ��
-- NUM(�����ȣ) �׸��� ������ ������ �Է� �� �ش� �׸��� ���� ���� �ο��� ���� ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� 
-- �ڵ����� �Է� ó���� �� �ִ� ���ν����� ������
-- ���ν����� : PRC_INSA_INSERT()
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970812-2234567', SYSDATE, '����', '010-2509-1783', '���ߺ�','�븮',20000000,2000000);
-> ���� ���� ���ν��� ȣ�� �� ���� 

1061 ������ 970812-2234567 2023-11-06 ���� 010-2509-1783 ���ߺ� �븮 2000000 2000000
�� �ű� �����Ͱ� �ű� �Էµ� ��Ȳ 
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME            IN TBL_INSA.NAME%TYPE 
, V_SSN             IN TBL_INSA.SSN%TYPE
, V_IBSADATE        IN TBL_INSA.IBSADATE%TYPE
, V_CITY            IN TBL_INSA.CITY%TYPE
, V_TEL             IN TBL_INSA.TEL%TYPE
, V_BUSEO           IN TBL_INSA.BUSEO%TYPE
, V_JIKWI           IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY        IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG          IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM TBL_INSA.NUM%TYPE;
BEGIN
    -- ���� �ο��� �����ȣ�� ������ ��ȣ 
    SELECT MAX(NVL(NUM,1)) INTO V_NUM
    FROM TBL_INSA;

    -- ������ �Է� ������ �ۼ� 
    INSERT INTO TBL_INSA(NUM,NAME,SSN,IBSADATE,CITY,TEL,BUSEO,JIKWI,BASICPAY,SUDANG)
        VALUES ((V_NUM+1), V_NAME, V_SSN, V_IBSADATE, V_CITY,V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
        
END;
-- Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

-- 20231106_02_SCOTT.sql ������ Ȱ���Ͽ� TBL_��ǰ, TBL_�԰� ���̺��� �������
-- TBL_�԰� ���̺� ������ �Է� �� (��, �̺� �̺�Ʈ �߻� ��) 
-- TBL_��ǰ ���̺��� �ش� ��ǰ�� ���� �������� �Բ� ������ �� �ִ� ����� ���� ���ν����� �ۼ� 
-- �� �� �������� �԰� ��ȣ�� �ڵ� ���� ó���� (������ ��� ����)
-- TBL_�԰� ���̺� ���� �÷��� �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ��̸� 
-- ���ν��� ȣ���� ���� ������ �Ķ���ʹ� ��ǰ�ڵ�, �԰����, �԰�ܰ���
-- ���ν����� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�  IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����  IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�  IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    
    SELECT NVL(MAX(�԰��ȣ),0) + 1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
        VALUES(V_�԰��ȣ, V_��ǰ�ڵ�,SYSDATE, V_�԰����, V_�԰�ܰ�);
        
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    COMMIT;
    
END;

---------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PRC_�԰�_INSERT
( V_��ǰ�ڵ�  IN TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����  IN TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�  IN TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    -- �����
    -- ������ ������ �� ��Ƴ���
    -- �Ʒ��� �������� �����ϱ� ���� �ʿ��� ���� �߰� ����
    V_�԰��ȣ TBL_�԰�.�԰��ȣ%TYPE;
BEGIN
    -- �����
    -- SELECT ������ ���� -> �԰��ȣ Ȯ��
    SELECT NVL(MAX(�԰��ȣ),0) INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    -- INSERT ������ ����
    INSERT INTO TBL_�԰�(�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES((V_�԰��ȣ+1), V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
        
    -- UPDATE ������ ���� 
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó�� 
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;  
    
    --Ŀ��
    COMMIT;
    
END;

-------------------------------------------------------------------------------

-- ���� ���ν��� �������� ����ó�� ���� --

-- �� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� �ۼ� 
-- ��, �� ���ν����� ���� �����͸� �Է��� ��� 
-- CITY(����) �׸� '����', '���', '����'�� �Է��� �����ϵ��� ������ 
-- �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��Ϸ��� ��� 
-- (��, ��ȿ���� ���� ������ �Է��� �õ��Ϸ��� ���)
-- ���ܿ� ���� ó���� �Ϸ��� �� 
-- ���ν����� : PRC_MEMBER_INSERT()

/*
���� ��)
EXEC PRC_MEMBER_INSERT('�ڹ���','010-1111-1111','����');
-- ������ �Է� o
EXEC PRC_MEMBER_INSERT('�����','010-2222-2222','�λ�');
-- ������ �Է� X

*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT 
( V_NAME        IN TBL_MEMBER.NAME%TYPE
, V_TEL         IN TBL_MEMBER.TEL%TYPE
, V_CITY        IN TBL_MEMBER.CITY%TYPE
)
IS
    --���� ������ ������ ������ ���� �ʿ��� ���� ���� 
    V_NUM TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ���������� �ƴ����� ���θ�
    -- ���� ���� Ȯ���� �� �ֵ��� �ڵ� ���� 
    IF (V_CITY NOT IN ('����','���','����'))
        -- ���� �߻� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ������ ������ �� ��Ƴ��� 
    
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;
    
    -- ������ ���� -> INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- ���� ó�� ���� ������ Ŀ�� ���� ��� 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'����,���,������ �Է��� �����մϴ�.'); -- 20000�� ���ķ� ����� ���� ���� ó�� ���� 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
            
    -- Ŀ��
    COMMIT;
    
END;

-- Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.

-- �� TBL_��� ���̺� ������ �Է� �� (��, ��� �̺�Ʈ �߻� ��)
-- TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��� 
-- ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ� ����
-- ����, �������� ���������� ���� ��� 
-- ��� �׼��� ����� �� �ֵ��� ó��(��� �̷������ �ʵ���) -> ����ó�� Ȱ��
-- ���ν����� : PRC_���_INSERT()
/*
���� ��)
EXEC PRC_���_INSERT('H001',10,600);

-> �� ���������� ��ǰ ���̺��� �ٹ�� �������� 70

EXEC PRC_���_INSERT('H001', 80, 600);

--�����߻�
-- (20002, ��� ����)
*/

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_���.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE 
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    V_����ȣ TBL_���.����ȣ%TYPE;
    
    V_������ TBL_��ǰ.������%TYPE;
    
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    IF (V_������ < V_������)
        -- ���� �߻� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(����ȣ),0) INTO V_����ȣ
    FROM TBL_���;
    
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
        
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó�� ���� ������ Ŀ�� ���� ��� 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'��� ����'); -- 20000�� ���ķ� ����� ���� ���� ó�� ���� 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    COMMIT;

END;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN TBL_���.��ǰ�ڵ�%TYPE
, V_������    IN TBL_���.������%TYPE 
, V_���ܰ�    IN TBL_���.���ܰ�%TYPE
)
IS
    -- �ֿ� ���� ����
    V_����ȣ TBL_���.����ȣ%TYPE;
    V_������ TBL_��ǰ.������%TYPE;
    
    -- ����� ���� ���� ����
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    -- ������ ���� ������ ���� ���θ� Ȯ���ϴ� ��������
    -- ������ �ľ� -> ���� ��� Ȯ���ϴ� ������ ����Ǿ�� ��
    -- �׷��� ���ν��� ȣ�� �� �Ѱܹ޴� �������� �񱳰� �����ϱ� ����
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ��� ���������� �������� �������� ���� ���� Ȯ��
    -- ������ �ľ��� ���������� ���� ���ν������� �Ѱܹ��� �������� ������ ����ó�� �߻� 
    
    IF (V_������ > V_������)
        -- ���� �߻� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ����ȣ ���� -> ������ ������ ������ �� ��Ƴ���
    SELECT NVL(MAX(����ȣ),0) + 1 INTO V_����ȣ
    FROM TBL_���;
    
    -- ������ ���� -> INSERT(TBL_���)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ������ ���� -> UPDATE(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ������ ���� -- INSERT(TBL_���)
    INSERT INTO TBL_���(����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
        VALUES((V_����ȣ+1), V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    -- ���� ó�� 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'��� ����'); -- 20000�� ���ķ� ����� ���� ���� ó�� ���� 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    COMMIT;
    
END;

---------------------------------------------------------------------------------------------------------

-- �� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν���
-- ���ν����� : PRC_���_UPDATE()
/*
���� ��)
EREC PRC_���_UPDATE(����ȣ,�������); ����    
*/

CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ        IN TBL_���.����ȣ%TYPE
, V_�������        IN TBL_���.������%TYPE
)
IS
    V_������ TBL_���.������%TYPE;
    V_��ǰ�ڵ� TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������ TBL_��ǰ.������%TYPE;


    USER_DEFINE_ERROR EXCEPTION;

BEGIN

    IF (V_������ + V_������) < V_�������
        -- ���� �߻� 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    SELECT ������ INTO V_������
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;

    
    UPDATE TBL_���
    SET ������ = V_������� 
    WHERE ����ȣ = V_����ȣ;
    
    UPDATE TBL_��ǰ
    SET ������ = ������ +  V_������ - V_�������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'��� ����'); -- 20000�� ���ķ� ����� ���� ���� ó�� ���� 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
            
    COMMIT;
        
END;