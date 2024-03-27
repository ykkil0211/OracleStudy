-- ㅇ TRIGGER(트리거 생성) 트리거로 로그 기록 남게 설정 (이런 방식으로 만들것)
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER 
    INSERT OR UPDATE OR DELETE ON TBL_TEST1
BEGIN
    -- 이벤트 종류 구분(조건문을 통한 분기)
    IF (INSERTING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT 쿼리가 실행되었습니다.');
    ELSIF (UPDATING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE 쿼리가 실행되었습니다.');
    ELSIF (DELETING)
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE 쿼리가 실행되었습니다.');
    END IF;
    
    --COMMIT;
    -- ※ TRIGGER 내에서는 COMMIT/ ROLLBACK 구문 사용 불가
END;

-- 교수 테이블 추가, 변경, 삭제 로그 테이블에 관한 트리거 생성 
CREATE OR REPLACE TRIGGER TRG_PROFESSORS_LOG
AFTER 
INSERT OR UPDATE OR DELETE ON PROFESSORS
FOR EACH ROW
BEGIN
    IF (INSERTING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:NEW.PRO_NAME, '교수ID가 추가되었습니다.');
    ELSIF (UPDATING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:NEW.PRO_NAME, '교수정보가 변경되었습니다.');
    ELSIF (DELETING) THEN
        INSERT INTO PROFESSORS_LOG(PRO_NAME, MEMO)
        VALUES(:OLD.PRO_NAME, '교수ID가 삭제되었습니다.');
    END IF;
END;

-- 교수테이블 데이터 수정 및 삭제 트리거 생성
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

-- 관리자 테이블 로그인 
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
    V_PLAG := '로그인 성공';
  ELSE
    V_PLAG := '로그인 실패';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(V_PLAG);

EXCEPTION
  --WHEN NO_DATA_FOUND THEN
    WHEN OTHERS THEN
    V_PLAG := '사용자를 찾을 수 없음';
    DBMS_OUTPUT.PUT_LINE(V_PLAG);
    
    COMMIT;
    
END;

-- 최종 관리자 테이블 삭제 시 관리자 정보 삭제
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

-- 관리자가 교수 테이블 사전 등록 하는법 
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
        -- 바로 INSERT 문에서 SUBSTR(P_SSN, 8, 7) 사용
        INSERT INTO PROFESSORS(PRO_ID, PRO_SSN, PRO_NAME, PRO_PW)
        VALUES(P_ID, P_SSN, P_NAME, SUBSTR(P_SSN, 8, 7));
    ELSE
        V_PLAG2 := '비밀번호가 틀립니다.';
    END IF;

    DBMS_OUTPUT.PUT_LINE(V_PLAG2);
    
    EXCEPTION
  --WHEN NO_DATA_FOUND THEN
    WHEN OTHERS THEN
    V_PLAG2 := '이미 존재하고 있습니다.';
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
                    THEN RAISE_APPLICATION_ERROR(-20023, '이미 종료된 과정이라 수정 불가합니다.');
                END IF;
            
                UPDATE COURSE_APPLICATION
                SET OPEN_COU_CODE = :NEW.OPEN_COU_CODE
                WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE;      
            
                UPDATE OPENING_SUBJECTS
                SET OPEN_COU_CODE = :NEW.OPEN_COU_CODE
                WHERE OPEN_COU_CODE = :OLD.OPEN_COU_CODE;
                    
        ELSIF (DELETING)
            
            THEN
            
        --[과정 삭제 가능 조건]===============================
        --① 과정 시작일이 SYSDATE 보다 미래여야 한다.
        --==▶ 즉, 과정이 시작되지 않아야만 한다.
        --===================================================
          
            IF NOT (SYSDATE < :OLD.COU_START_DATE)
                THEN RAISE_APPLICATION_ERROR(-20023, '이미 시작된 과정이므로 삭제가 불가능합니다.');
                
            END IF;
            
            -- 개설과목 전체 삭제 
            
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
                RAISE_APPLICATION_ERROR(-20001, '날짜 때문에 삭제 할 수 없습니다.');
        END IF;
    
END;
