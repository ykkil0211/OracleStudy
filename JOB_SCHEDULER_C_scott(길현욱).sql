SELECT USER 
FROM DUAL;
--==>> SCOTT;

-- FINAL PROJECT 일부 테이블 샘플링 

-- 1. 일반 회원 테이블 
CREATE TABLE MEMBERS (
    MEMBER_CODE     NUMBER
  , MEM_ID          VARCHAR2(50)
  , MEM_PW          VARCHAR2(50)
  , MEM_NICKNAME    VARCHAR2(50)
  , JOIN_DATE       DATE    DEFAULT SYSDATE
);

INSERT INTO MEMBERS VALUES(1, 'ID1', 'PW1', 'NN1', SYSDATE);
INSERT INTO MEMBERS VALUES(2, 'ID2', 'PW2', 'NN2', SYSDATE);
INSERT INTO MEMBERS VALUES(3, 'ID3', 'PW3', 'NN3', SYSDATE);
INSERT INTO MEMBERS VALUES(4, 'ID4', 'PW4', 'NN4', SYSDATE);
INSERT INTO MEMBERS VALUES(5, 'ID5', 'PW5', 'NN5', SYSDATE);
INSERT INTO MEMBERS VALUES(6, 'ID6', 'PW6', 'NN6', SYSDATE);
INSERT INTO MEMBERS VALUES(7, 'ID7', 'PW7', 'NN7', SYSDATE);


ALTER TABLE MEMBERS ADD PRIMARY KEY(MEMBER_CODE);

-- 2. 개설 신청 테이블 
CREATE TABLE APP_OPENING
( APP_OPENCODE      NUMBER
, APP_TITLE         VARCHAR(100) NOT NULL
, APP_MINCONTENT    VARCHAR(100)
, APP_STARTDATE     DATE
, APP_ENDDATE       DATE
, APP_CONTENT       VARCHAR(1000)
, APP_OPENDATE      DATE DEFAULT SYSDATE
, MEMBER_NUMBER     NUMBER
, VIEW_NUMBER       NUMBER
, MEMBER_CODE       NUMBER
, CONSTRAINT FK_MEMBER_CODE FOREIGN KEY(MEMBER_CODE)
                    REFERENCES MEMBERS(MEMBER_CODE)
);

ALTER TABLE APP_OPENING ADD PRIMARY KEY(APP_OPENCODE);

INSERT INTO APP_OPENING
VALUES(1,'가나다','첫번째', SYSDATE, SYSDATE+1 ,'첫번째다다',SYSDATE, 5, 5, 1);
INSERT INTO APP_OPENING
VALUES(2,'가가가','두번째', SYSDATE, SYSDATE+2 ,'두번째다다',SYSDATE, 5, 5, 2);
INSERT INTO APP_OPENING
VALUES(3,'나나나','세번째', SYSDATE, SYSDATE+3 ,'세번째다다',SYSDATE, 5, 5, 3);
INSERT INTO APP_OPENING
VALUES(4,'다다다','네번째', SYSDATE, SYSDATE+4 ,'네번째다다',SYSDATE, 5, 5, 4);

UPDATE APP_OPENING
SET APP_STARTDATE = TO_DATE('2024-03-03','YYYY-MM-DD');

COMMIT;

-- 3. 『팀원별 직무 구성 테이블』
CREATE TABLE ROLE_COMPOSITION
( RC_CODE       NUMBER
, RC_NUMBER     NUMBER
, APP_OPENCODE  NUMBER
, MR_CODE       NUMBER
, CONSTRAINT R_COMPOSITION_RC_CODE_PK PRIMARY KEY(RC_CODE)
, CONSTRAINT R_COMPOSITION_APP_OPENCODE_FK FOREIGN KEY (APP_OPENCODE)
                                           REFERENCES APP_OPENING(APP_OPENCODE)
, CONSTRAINT R_COMPOSITION_MR_CODE_FK FOREIGN KEY (MR_CODE)
                                      REFERENCES MEMBER_ROLE(MR_CODE)
);

INSERT INTO ROLE_COMPOSITION(RC_CODE, RC_NUMBER, APP_OPENCODE, MR_CODE)
VALUES(1, 3, 1, 1);
INSERT INTO ROLE_COMPOSITION(RC_CODE, RC_NUMBER, APP_OPENCODE, MR_CODE)
VALUES(2, 2, 1, 2);
INSERT INTO ROLE_COMPOSITION(RC_CODE, RC_NUMBER, APP_OPENCODE, MR_CODE)
VALUES(3, 4, 2, 1);
INSERT INTO ROLE_COMPOSITION(RC_CODE, RC_NUMBER, APP_OPENCODE, MR_CODE)
VALUES(4, 1, 2, 2);



-- 6. 멤버지원 테이블
CREATE TABLE MEMBER_APPLY
( MA_CODE       NUMBER PRIMARY KEY
, MA_CONTENT    VARCHAR2(1000)
, MA_DATE       DATE
, MAD_DATE      DATE
, MEMBER_CODE   NUMBER REFERENCES MEMBERS(MEMBER_CODE)
, RC_CODE       NUMBER REFERENCES ROLE_COMPOSITION(RC_CODE)       
, AR_CODE       NUMBER REFERENCES A_RESULT(AR_CODE)
);

INSERT INTO MEMBER_APPLY (MA_CODE, MA_CONTENT, MA_DATE, MEMBER_CODE, RC_CODE, AR_CODE) VALUES(1, '열심히 할게용!!', SYSDATE, 1, 1, 1);
INSERT INTO MEMBER_APPLY (MA_CODE, MA_CONTENT, MA_DATE, MEMBER_CODE, RC_CODE, AR_CODE) VALUES(2, '뽑지마라', SYSDATE, 2, 1, 1);
INSERT INTO MEMBER_APPLY (MA_CODE, MA_CONTENT, MA_DATE, MEMBER_CODE, RC_CODE, AR_CODE) VALUES(3, '너 내 동료가 돼라', SYSDATE, 3, 1, 1);
INSERT INTO MEMBER_APPLY (MA_CODE, MA_CONTENT, MA_DATE, MEMBER_CODE, RC_CODE, AR_CODE) VALUES(4, '테스트~!!!', SYSDATE, 4, 2, 1);
INSERT INTO MEMBER_APPLY (MA_CODE, MA_CONTENT, MA_DATE, MEMBER_CODE, RC_CODE, AR_CODE) VALUES(5, '같이 해봐요', SYSDATE, 5, 2, 1);



-- 4. 직무 테이블 생성 
CREATE TABLE MEMBER_ROLE
( MR_CODE NUMBER
, ROLE VARCHAR2(50)
, CONSTRAINT MR_CODE_PK PRIMARY KEY(MR_CODE)
);

INSERT INTO MEMBER_ROLE (MR_CODE, ROLE) VALUES (1, '팀장');
INSERT INTO MEMBER_ROLE (MR_CODE, ROLE) VALUES (2, '프론트');
INSERT INTO MEMBER_ROLE (MR_CODE, ROLE) VALUES (3, '백엔드');


-- 5. 지원 결과 테이블 생성 
CREATE TABLE A_RESULT
( AR_CODE NUMBER
, A_RESULT VARCHAR2(50)
, CONSTRAINT AR_CODE_PK PRIMARY KEY(AR_CODE)
);


INSERT INTO A_RESULT (AR_CODE, A_RESULT) VALUES (1, '성공');
INSERT INTO A_RESULT (AR_CODE, A_RESULT) VALUES (2, '실패');
INSERT INTO A_RESULT (AR_CODE, A_RESULT) VALUES (3, '보류');


-- 7. 프로젝트 테이블
CREATE TABLE C_PROJECT
( CP_CODE                  NUMBER
, CP_DATE                   DATE
, APP_OPENCODE        NUMBER
, CONSTRAINT C_CODE_PK PRIMARY KEY(CP_CODE)
, CONSTRAINT APP_OPENCODE_FK FOREIGN KEY(APP_OPENCODE) REFERENCES APP_OPENING(APP_OPENCODE)
);

INSERT INTO C_PROJECT (CP_CODE, CP_DATE, APP_OPENCODE) VALUES(1, SYSDATE, 1);
INSERT INTO C_PROJECT (CP_CODE, CP_DATE, APP_OPENCODE) VALUES(2, SYSDATE, 2);


-- 필요한 프로시저 구성 

-- 합격자 
SELECT *
FROM APP_OPENING A JOIN ROLE_COMPOSITION R
ON A.APP_OPENCODE = R.APP_OPENCODE
JOIN MEMBER_APPLY M
ON R.RC_CODE = M.RC_CODE
WHERE M.AR_CODE=1 AND A.APP_OPENCODE=1;


--○ 실습 프로시저 생성(PRC_TEST)
CREATE OR REPLACE PROCEDURE PRC_PROJECT
IS
    V_COUNT NUMBER; -- 인원수  
    V_APP_ENDDATE APP_OPENING.APP_ENDDATE%TYPE; -- 종료일 
    V_MEMBER_NUMBER APP_OPENING.MEMBER_NUMBER%TYPE;
    V_AR_CODE MEMBER_APPLY.AR_CODE%TYPE;
    V_APP_OPENCODE APP_OPENING.APP_OPENCODE%TYPE;
    V_CP_CODE NUMBER;
    
    -- 커서 선언 
    CURSOR CURSOR_OPEN
    IS
    SELECT APP_OPENCODE
    FROM APP_OPENING
    WHERE TO_CHAR(APP_STARTDATE-1,'YYYY-MM-DD') = TO_CHAR(SYSDATE,'YYYY-MM-DD');

BEGIN
    OPEN CURSOR_OPEN;
    
    LOOP
    FETCH CURSOR_OPEN INTO V_APP_OPENCODE;
    EXIT WHEN CURSOR_OPEN%NOTFOUND;
    
    SELECT COUNT(*) INTO V_COUNT
    FROM APP_OPENING A 
    JOIN ROLE_COMPOSITION R
        ON A.APP_OPENCODE = R.APP_OPENCODE
    JOIN MEMBER_APPLY M
        ON R.RC_CODE = M.RC_CODE
    WHERE M.AR_CODE = 1 AND A.APP_OPENCODE = V_APP_OPENCODE;
    
    SELECT MEMBER_NUMBER INTO V_MEMBER_NUMBER
    FROM APP_OPENING
    WHERE APP_OPENCODE=1;
    
    SELECT NVL(MAX(CP_CODE),0)+1 INTO V_CP_CODE
    FROM C_PROJECT;
    
    IF (V_COUNT = V_MEMBER_NUMBER)
    THEN
        INSERT INTO C_PROJECT VALUES(V_CP_CODE, SYSDATE, V_APP_OPENCODE);
    END IF;
    
    COMMIT;
    
    END LOOP;
    CLOSE CURSOR_OPEN; -- 커서 종료
END;
--==>> Procedure PRC_PROJECT이(가) 컴파일되었습니다.

BEGIN 
    DBMS_SCHEDULER.CREATE_PROGRAM
    ( PROGRAM_NAME => 'PRC_FINAL_PROGRAM'
    -- 『PROGRAM_NAME』 : 프로그램 이름 
    , PROGRAM_ACTION => 'PRC_PROJECT'
    -- 『PROJRAM_ACTION』 : 실제 액션이 발생하는 STORED_PROCEDURE
    --                     미리 등록되어 있어야 하며,
    --                     SHELL과 같은 외부 프로그램을 구동할 수도 있음
    , PROGRAM_TYPE => 'STORED_PROCEDURE'
    -- 『PROGRAM_TYPE』 : 'STORED_PROCEDURE' 라고 명시
    , COMMENTS => 'PRC_FINAL_PROGRAM'
    -- 『COMMENTS』 : 코멘트, 부가 설명
    , ENABLED => TRUE
    -- 『ENABLED』 : 사용 기능 설정
    );
END;

-- 자동화 업무 수행 
BEGIN
    DBMS_SCHEDULER.CREATE_SCHEDULE
    ( SCHEDULE_NAME => 'SCHEDULE_FINAL'
    -- 『SCHEDULE_NAME』 : 스케줄의 이름
    , START_DATE => TO_DATE('2024-02-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS')
    -- 『START_DATE』 : 스케줄러 작동의 시작 시각
    , END_DATE => NULL
    -- 『END_DATE』 : 스케줄러의 작동의 종료 시작 (NULL 구성 시 종료하지 않음)
    , REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=1'
    -- 『REPEAT_INTERVAL』 : 스케줄러의 작동 주기 
    --                      FREQ를 분단위(FREQ='MINUTELY')로 하고, 30분 마다 (INTERVAL=30) 들게하는 식
    --                      (※ FREQ : Frequncy, 빈도)
    , COMMENTS => 'Every 1 day'
    -- 『COMMENTS』 : 코멘트, 부가 설명
    );
END;

BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    ( JOB_NAME => 'TEST_FINAL'
    -- 『JOB_NAME』 : 작업의 이름
    , PROGRAM_NAME => 'PRC_FINAL_PROGRAM'
    -- 『PROGRAM_NAME』 : 구동될 프로그램의 이름 
    --                   위에서 등록한 프로그램의 이름을 명시함 
    , SCHEDULE_NAME => 'SCHEDULE_FINAL'
    -- 『SCHEDULE_NAME』 : 어떤 스케줄러가 돌면서 이 작업을 수행할 것인가에 해당하는 부분으로 
    --                    위에서 등록한 스케줄러의 이름을 명시함
    --, JOB_CLASS → JOB을 CLASS 다누이로 묶어서 관리할 수 있는 속성
    --              스케줄러를 통해 수행되는 작업이 많다면, 관리를 위해 추가할 수 있음
    , ENABLED => TRUE
    -- 『ENABLED』 : 사용 가능 설정 
    );
END;

-- 테스트 및 확인 
SELECT *
FROM C_PROJECT;

EXEC PRC_PROJECT;