-- �� TRIGGER(Ʈ���� ����) Ʈ���ŷ� �α� ��� ���� ���� (�̷� ������� �����)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    -- �̺�Ʈ ���� ����(���ǹ��� ���� �б�)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT ������ ����Ǿ����ϴ�.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE ������ ����Ǿ����ϴ�.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE ������ ����Ǿ����ϴ�.');
    END IF;
    
    --COMMIT;
    -- �� TRIGGER �������� COMMIT/ ROLLBACK ���� ��� �Ұ�
END;

-- ���� ���̺� �߰�, ����, ���� �α� ���̺� ���� Ʈ���� ���� 
CREATE OR REPLACE TRIGGER TRG_PROFESSORS_LOG
AFTER 
INSERT OR UPDATE OR DELETE ON PROFESSORS
FOR EACH ROW
BEGIN
    IF (INSERTING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:NEW.PRO_NAME, '����ID�� �߰��Ǿ����ϴ�.');
    ELSIF (UPDATING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:NEW.PRO_NAME, '���������� ����Ǿ����ϴ�.');
    ELSIF (DELETING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:OLD.PRO_NAME, '����ID�� �����Ǿ����ϴ�.');
    END IF;
END;

-- �������̺� ������ ���� �� ���� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_PROFESSORS_UPDATE
        AFTER 
        UPDATE OR DELETE ON PROFESSORS
        FOR EACH ROW
BEGIN
        IF (UPDATING)
            THEN UPDATE OPENING_SUBJECTS
                 SET PRO_ID = :NEW.PRO_ID
                 WHERE PRO_ID = :OLD.PRO_ID;
                 
        ELSIF (DELETING) THEN
        
        DELETE FROM SCORE
        WHERE OPEN_SUB_CODE IN (SELECT OPEN_SUB_CODE
                                FROM OPENING_SUBJECTS 
                                WHERE PRO_ID = :OLD.PRO_ID);

        DELETE FROM OPENING_SUBJECTS
        WHERE PRO_ID = :OLD.PRO_ID;
        END IF;
END;

-- ������ ���̺� �α��� 
CREATE OR REPLACE PROCEDURE PRC_ADMIN_LOGIN
( 
  V_ID  IN ADMINS.ADMIN_ID%TYPE
, V_PW  IN ADMINS.ADMIN_PW%TYPE
)
IS
  V2_ID ADMINS.ADMIN_ID%TYPE;
  V2_PW ADMINS.ADMIN_PW%TYPE;
  V_PLAG VARCHAR2(40);
  
BEGIN
  SELECT ADMIN_ID, ADMIN_PW INTO V2_ID, V2_PW
  FROM ADMINS
  WHERE ADMIN_ID = V_ID AND ADMIN_PW = V_PW;

  IF (V2_ID = V_ID AND V2_PW = V_PW) THEN
    V_PLAG := '�α��� ����';
  ELSE
    V_PLAG := '�α��� ����';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(V_PLAG);

EXCEPTION
  --WHEN NO_DATA_FOUND THEN
    WHEN OTHERS THEN
    V_PLAG := '����ڸ� ã�� �� ����';
    DBMS_OUTPUT.PUT_LINE(V_PLAG);
    
    COMMIT;
    
END;

-- ���� ������ ���̺� ���� �� ������ ���� ����
CREATE OR REPLACE TRIGGER TRG_ADMIN_AUTH_UPDATE
AFTER 
INSERT OR UPDATE OR DELETE ON ADMIN_AUTHORITY
FOR EACH ROW
BEGIN
    
    IF UPDATING 
        THEN UPDATE ADMINS
        SET AUTHO_NUM = :NEW.AUTHO_NUM
        WHERE AUTHO_NUM = :OLD.AUTHO_NUM;
        
    ELSIF DELETING
           THEN  DELETE 
           FROM ADMINS
           WHERE AUTHO_NUM = :OLD.AUTHO_NUM;
    END IF;

END;

--------------------------------------------------------------------------------

SELECT *
FROM ADMIN_AUTHORITY;

SELECT *
FROM ADMINS;

-- �����ڰ� ���� ���̺� ���� ��� �ϴ¹� 
CREATE OR REPLACE PROCEDURE PRC_PROFESSORS_REGISTRATION
( 
  V_ID   IN ADMINS.ADMIN_ID%TYPE
, V_PW   IN ADMINS.ADMIN_PW%TYPE
, P_NAME IN PROFESSORS.PRO_NAME%TYPE
, P_ID   IN PROFESSORS.PRO_ID%TYPE
, P_SSN  IN PROFESSORS.PRO_SSN%TYPE
)
IS
    V2_ID ADMINS.ADMIN_ID%TYPE;
    V2_PW ADMINS.ADMIN_PW%TYPE;
    
    V_PRO_DATE PROFESSORS.PRO_REG_DATE%TYPE;
    V_SUB_DATE OPENING_SUBJECTS.SUB_START_DATE%TYPE;
    
    V_PLAG NUMBER := 0;
    V_PLAG2 VARCHAR2(40);
BEGIN
    SELECT ADMIN_ID, ADMIN_PW INTO V2_ID, V2_PW
    FROM ADMINS
    WHERE ADMIN_ID = V_ID AND ADMIN_PW = V_PW;

    IF (V2_ID = V_ID AND V2_PW = V_PW) THEN
        V_PLAG := 1;
    ELSE
        V_PLAG := 0;
    END IF;

    IF V_PLAG = 1 AND PRO_REG_DATE < SUB_START_DATE THEN
        -- �ٷ� INSERT ������ SUBSTR(P_SSN, 8, 7) ���
        INSERT INTO PROFESSORS(PRO_ID, PRO_SSN, PRO_NAME, PRO_PW)
        VALUES(P_ID, P_SSN, P_NAME, SUBSTR(P_SSN, 8, 7));
    ELSE
        V_PLAG2 := '��й�ȣ�� Ʋ���ϴ�.';
    END IF;

    DBMS_OUTPUT.PUT_LINE(V_PLAG2);
    
    EXCEPTION
  --WHEN NO_DATA_FOUND THEN
    WHEN OTHERS THEN
    V_PLAG2 := '�̹� �����ϰ� �ֽ��ϴ�.';
    DBMS_OUTPUT.PUT_LINE(V_PLAG2);
    
    COMMIT;
END;

--------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_OPEN_COU_UPDATE_DELETE
    AFTER
    UPDATE OR DELETE ON OPENING_COURSES
    FOR EACH ROW
    
BEGIN
        IF (UPDATING)
            THEN
            
                IF (SYSDATE > :OLD.COU_END_DATE)
                    THEN RAISE_APPLICATION_ERROR(-20023, '�̹� ����� �����̶� ���� �Ұ��մϴ�.');
                END IF;
            
                UPDATE COURSE_APPLICATION
                SET OPEN_COU_CODE = :NEW.OPEN_COU_CODE
                WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE;      
            
                UPDATE OPENING_SUBJECTS
                SET OPEN_COU_CODE = :NEW.OPEN_COU_CODE
                WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE;
                    
        ELSIF (DELETING)
            
            THEN
            
        --[���� ���� ���� ����]===============================
        --�� ���� �������� SYSDATE ���� �̷����� �Ѵ�.
        --==�� ��, ������ ���۵��� �ʾƾ߸� �Ѵ�.
        --===================================================
          
            IF NOT (SYSDATE < :OLD.COU_START_DATE)
                THEN RAISE_APPLICATION_ERROR(-20023, '�̹� ���۵� �����̹Ƿ� ������ �Ұ����մϴ�.');
                
            END IF;
            
            -- �������� ��ü ���� 
            
                DELETE 
                FROM RETIRE_OUT_STUDENTS
                WHERE COU_APP_NUM IN (SELECT COU_APP_NUM
                                      FROM COURSE_APPLICATION
                                      WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE);
                                      
                DELETE 
                FROM SCORE
                WHERE COU_APP_NUM IN (SELECT COU_APP_NUM
                                      FROM COURSE_APPLICATION
                                      WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE);      
                DELETE 
                FROM COURSE_APPLICATION
                WHERE OPEN_COU_CODE =:OLD.OPEN_COU_CODE;         
                
                DELETE
                FROM OPENING_SUBJECTS
                WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE;

            ELSE
                RAISE_APPLICATION_ERROR(-20001, '��¥ ������ ���� �� �� �����ϴ�.');
        END IF;
    
END;
