SELECT USER
FROM DUAL;
--==>> SCOTT


-- 스케줄러 정상 작동여부 확인을 위한
-- 테이블 및 프로시저 생성


--○ 실습 테이블 생성(TBL_TEST)
CREATE TABLE TBL_TEST
( NOW_COL   VARCHAR2(30)
);
--==>> Table TBL_TEST이(가) 생성되었습니다.


--○ 실습 프로시저 생성(PRC_TEST)
CREATE OR REPLACE PROCEDURE PRC_TEST
( P_NOW_COL IN VARCHAR2
)
IS
BEGIN
    INSERT INTO TBL_TEST(NOW_COL) VALUES(P_NOW_COL);
    COMMIT;
END;
--==> Procedure PRC_TEST이(가) 컴파일되었습니다.

--○ 날짜 시간 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 테스트(확인)
SELECT TRUNC(SYSDATE)+ 12/24
FROM DUAL;
--==>> 2024-02-19 12:00:00


--○ 스케줄러 잡 등록

BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    ( JOB_NAME => 'JOB_PRC_TEST'
    -- 잡 이름은 등록된 잡 이름들 중 유니크하기만 하면 되고,
    -- 스케줄러에서 잡을 삭제할 떄 잡 이름을 파라미터로 입력하여 삭제하게 된다.
    
    , START_DATE => TRUNC(SYSDATE)+ 12/24
    , REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=1;'
    -- START_DATE 와 REPEAT_INTERVAL 은 스케줄러에 등록한 잡이
    -- 일정 시간마다 반복되도록 하는 옵션으로 서로 연관 관계가 있다.
    -- START_DATE  는 잡이 최초로 실행되는 시간을 지정하게 되며,
    -- REPEAT_INTERVAL 은 반복되는 형식을 지정하게 된다.
    -- 만약, 위에서 START_DATE 에 TRUNC(SYSDATE+1) + 12/24 와 같이 지정했다면
    -- TRUNC(SYSDATE+1) 은 내일을 의미한다.
    -- 즉, 『SELECT TRUNC(SYSDATE+1) FROM DUAL』 과 같이 쿼리문을 실행하면
    -- 내일 일자가 조회되는 것을 확인할 수 있다.
    -- 『12/24』 는 정오를 의미하는 값이 된다.
    , END_DATE => SYSDATE + 5
    -- END_DATE 는 잡의 만료 시간을 의미한다.
    -- 영구적인 반복 실행을 설정하려면 NULL 을 지정하게 된다.
    -- 시간과 관계없이 일주일만 실행되기를 바란다면
    -- 『TRUNC(SYSDATE+7)』과 같이 등록하게 된다.
    --, JOB_CLASS => 'DEFAULT_JOB_CLASS'
    , JOB_TYPE => 'PLSQL_BLOCK'
    
    , JOB_ACTION => 'BEGIN PRC_TEST(TO_CHAR(SYSDATE, ''YYYY-MM-DD HH24:MI:SS'')); END;'
    -- 실제로 실행 되어야 하는 쿼리문
    , COMMENTS => 'JOB 등록 실습'
    );
    
    DBMS_SCHEDULER.ENABLE('JOB_PRC_TEST');
END;
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 스케줄러 잡 등록 내역 확인

SELECT *
FROM USER_SCHEDULER_JOBS
WHERE JOB_NAME='JOB_PRC_TEST';
--==>>
/*
JOB_PRC_TEST		REGULAR	SCOTT					PLSQL_BLOCK	BEGIN PRC_TEST(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')); END;	0			CALENDAR	24/02/19 12:00:00.000000000 +09:00	FREQ=DAILY; INTERVAL=1								24/02/24 11:11:18.000000000 +09:00	DEFAULT_JOB_CLASS	TRUE	TRUE	FALSE	SCHEDULED	3	0		0		0			24/02/19 12:00:00.000000000 +09:00			OFF	FALSE	TRUE		FALSE	1	NLS_LANGUAGE='KOREAN' NLS_TERRITORY='KOREA' NLS_CURRENCY='￦' NLS_ISO_CURRENCY='KOREA' NLS_NUMERIC_CHARACTERS='.,' NLS_CALENDAR='GREGORIAN' NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS' NLS_DATE_LANGUAGE='KOREAN' NLS_SORT='BINARY' NLS_TIME_FORMAT='HH24:MI:SSXFF' NLS_TIMESTAMP_FORMAT='RR/MM/DD HH24:MI:SSXFF' NLS_TIME_TZ_FORMAT='HH24:MI:SSXFF TZR' NLS_TIMESTAMP_TZ_FORMAT='RR/MM/DD HH24:MI:SSXFF TZR' NLS_DUAL_CURRENCY='￦' NLS_COMP='BINARY' NLS_LENGTH_SEMANTICS='BYTE' NLS_NCHAR_CONV_EXCP='FALSE'		1						FALSE	FALSE	JOB 등록 실습	133168
*/



--○ 지정한 시간에 스케줄러 잡이 정상적으로 실행되었는지 확인
SELECT *
FROM USER_SCHEDULER_JOB_LOG
WHERE JOB_NAME='JOB_PRC_TEST';
--( 11:24 기준 )
--==>> 조회 결과 없음
--( 12:01 rlwns)
--==>> 8861	24/02/19 12:00:00.038000000 +09:00	SCOTT	JOB_PRC_TEST		DEFAULT_JOB_CLASS	RUN	FAILED								


SELECT *
FROM USER_SCHEDULER_JOB_RUN_DETAILS
WHERE JOB_NAME = 'JOB_PRC_TEST';
--( 11:25 기준 )
--==>> 조회 결과 없음
--( 12:02 기준 )
--==>> 8861	24/02/19 12:00:00.038000000 +09:00	SCOTT	JOB_PRC_TEST		FAILED	6550	24/02/19 12:00:00.000000000 +09:00	24/02/19 12:00:00.022000000 +09:00	+00 00:00:00.000000	1	74,129	10752	+00 00:00:00.000000					"ORA-06550: line 1, column 756:
/*
PLS-00905: object SCOTT.PRC_TEST is invalid
ORA-06550: line 1, column 756:
PL/SQL: Statement ignored
"
*/

-- *) 뒤에 DETAILS 가 붙어있는 것들은, 실행을 실패했을 때
-- 에러 내용을 확인할 수 있는 DICTIONARY 이다.


--※ ALL...DETAILS, DBA...DETAILS, USER...DETAILS 와 같이
--  『DETAILS』가 붙은 스케줄러 잡 로그 딕셔너리 뷰는
--   실행 실패 관련 에러 내용을 조회할 수 있다.


SELECT *
FROM TBL_TEST;
--==>> ( 11:28 기준 )
--==>> 조회 결과 없음
/*
2024-02-19 13:00:00
*/

--※ 잡 삭제 구문
DBMS_SCHEDULER.DROP_JOB('JOB_PRC_TEST');

--※ 프로시저 삭제 구문
DROP PROCEDURE PRC_TEST;

--※ 테이블 삭제 구문
DROP TABLE TBL_TEST;

INSERT INTO C_PROJECT(CP_CODE, CP_DATE, APP_OPENCODE) 
VALUES ( (SELECT ('CP' || (NVL(MAX(CP_CODE), 0) + 1)) FROM C_PROJECT) , SYSDATE, 4 );



