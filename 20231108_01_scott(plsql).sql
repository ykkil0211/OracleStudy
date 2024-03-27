select user
from dual;

-- �� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
-- TBL_��ǰ ���̺��� �ش� ��ǰ�� ���� ������ ���� Ʈ���� �ۼ� 
-- Ʈ���Ÿ� : TRG_CHULGO
-- ���� ���ϸ� : ����Ŭ_Ʈ����_������.sql
-- ��� ���� ���� ���� ó���� �� 

CREATE OR REPLACE TRIGGER TRG_CHULGO
            AFTER 
            INSERT OR UPDATE OR DELETE ON TBL_���
            FOR EACH ROW
DECLARE

    USER_DEFINE_ERROR   EXCEPTION;
    V_������  TBL_��ǰ.������%TYPE;

BEGIN    

            
        IF (INSERTING)
            THEN UPDATE TBL_��ǰ 
                SET ������ = ������ - :NEW.������
                WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
                
            SELECT ������ INTO V_������
            FROM TBL_��ǰ
            WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
                
            IF (V_������ < 0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;                
                
                
        ELSIF (UPDATING)
            THEN UPDATE TBL_��ǰ 
                 SET ������ = ������ + :OLD.������ - :NEW.������
                 WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
                 
            SELECT ������ INTO V_������
            FROM TBL_��ǰ
            WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
                
            IF (V_������ < 0)
                THEN RAISE USER_DEFINE_ERROR;
            END IF;        
        
        ELSIF (DELETING) 
            THEN UPDATE TBL_��ǰ
                 SET ������ = ������ + :OLD.������
                 WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
        
        END IF;
        
        EXCEPTION
            WHEN USER_DEFINE_ERROR
                THEN RAISE_APPLICATION_ERROR(-20002, '��� ����~!!!');

END;

SELECT *
FROM TBL_��ǰ;

----------------------------------------------------------------------------------
-- �� 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü, ���� ���α׷�(PROCEDURE, FUCTION ��)��
-- �������� ����� ��
-- ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��EBMS_OUTPUT����

--2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ��� 
-- �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ� 
-- ��ü ���α׷��� ���ȭ �� �� �ִٴ� ������ ����

--3. ��Ű���� ����(PAKAGE SPECIFICATION)�� ��ü��(PACKAGE BODY)�� �����Ǿ� ������
-- �� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM�� ����ǰ� 
-- ��ü �κп��� �̵��� ���� ������ ������
-- �׸���, ȣ���� �뿡�� ����Ű����,. ���ν������� ���� ������ ������ �̿��ؾ� ��

--4. ���� �� ����(����)
/*
CREATE [OR REPLAVE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
        :
END ��Ű����;
*/

--5. ���� �� ���� (��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű���� 
IS
    FUNCTION �Լ��� [(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
        ��������
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;
END ��Ű����;
*/

-- ��Ű�� ��� �ǽ� 

-- �� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
--   PROCEDURE ���ν�����(�Ű�����); 
    
END INSA_PACK;
-- Package INSA_PACK��(��) �����ϵǾ����ϴ�.

-- �� ��ü�� �ۼ�
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
        
    BEGIN
        IF (SUBSTR(V_SSN, 8 ,1) IN ('1','3'))
            THEN V_RESULT :='����';
        ELSIF  (SUBSTR(V_SSN, 8 ,1) IN ('2','4'))
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
        
        RETURN V_RESULT;
    END;
    
END INSA_PACK;
-- Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.
