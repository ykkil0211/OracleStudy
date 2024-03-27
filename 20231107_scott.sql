select user
from dual;

-------------------------------------------------------------------------------
SELECT *
FROM TBL_상품;

/*
H001	바밤바	 600	30
H002	죠스바	 500	30
H003	보석바	 500	20      35 -> 15 -> 20
H004	누가바	 600	70
H005	쌍쌍바	 700	 0
H006	수박바	 500	 0
H007	알껌바	 500	 0
C001	빵빠레	1600	20
C002	월드콘	1500	20
C003	메타콘	1500	20
C004	구구콘	1600	20
C005	슈퍼콘	1700	 0
E001	빵또아	2600	 0
E002	투게더	2500	 0
E003	팥빙수	2500	 0
E004	셀렉션	2600	 0
E005	설레임	2700	 0
*/
SELECT *
FROM TBL_출고;
/*
1	H001	2023-11-06	10	600
2	H001	2023-11-06	10	600
3	C001	2023-11-06	20	1500
4	C001	2023-11-06	20	1500
5	C001	2023-11-06	10	1500
6	H001	2023-11-06	10	500
7	H001	2023-11-06	10	500
8	H001	2023-11-06	10	500
9	H002	2023-11-06	20	500
10	H003	2023-11-06	15	500  <- 보석바
*/

SELECT *
FROM TBL_입고;

-- 생성한 프로시저가 제대로 작동하는지의 여부 확인 -> 프로시저 호출 
EXEC PRC_출고_UPDATE(10,40);
-- 에러발생
-- ORA-20002: 재고 부족

EXEC PRC_출고_UPDATE(10,25);
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- 프로시저 호출 이후 테이블 조회 

SELECT *
FROM TBL_출고;
/*
1	H001	2023-11-06	10	600
2	H001	2023-11-06	10	600
3	C001	2023-11-06	20	1500
4	C001	2023-11-06	20	1500
5	C001	2023-11-06	10	1500
6	H001	2023-11-06	10	500
7	H001	2023-11-06	10	500
8	H001	2023-11-06	10	500
9	H002	2023-11-06	20	500
10	H003	2023-11-06	15	500
*/

SELECT *
FROM TBL_상품;

SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_출고;

EXEC PRE_입고_UPDATE(2,10);

EXEC PRC_입고_DELETE(11);

EXEC PRC_출고_DELETE(10);

-- ■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업에 대한 이벤트 기록 

-- ㅇ 실습을 위한 준비 -> 테이블 생성(TBL_TEST1)
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);

-- Table TBL_TEST1이(가) 생성되었습니다.


-- ㅇ 실습을 위한 준비 -> 테이블 생성(TBL_EVENTLOG)
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
-- Table TBL_EVENTLOG이(가) 생성되었습니다.

-- ㅇ 날짜 관련 세션 설정 변경 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--Session이(가) 변경되었습니다.

-- 확인 
SELECT *
FROM TBL_TEST1;
-- 조회결과 없음 

SELECT *
FROM TBL_EVENTLOG;
--조회결과 없음 

-- 생성한 TRIGGER 작동 여부 확인
-- -> TBL_TEST1 테이블을 대상으로 INSERT, UPDATE, DELETE 수행 

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '이윤수', '010-1111-1111');
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '강혜성', '010-2222-2222');
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '문정환', '010-3333-3333');
-- 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '박가영', TEL = '010-4444-4444'
WHERE ID = 1;
--1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID IN(2,3);
-- 2개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST1;

DELETE
FROM TBL_TEST1
WHERE ID = 1;
-- 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST1;
-- 조회 결과 없음 

SELECT *
FROM TBL_EVENTLOG;
/*
INSERT 쿼리가 실행되었습니다.	2023-11-07 16:14:36
INSERT 쿼리가 실행되었습니다.	2023-11-07 16:15:30
INSERT 쿼리가 실행되었습니다.	2023-11-07 16:17:17
UPDATE 쿼리가 실행되었습니다.	2023-11-07 16:18:35
DELETE 쿼리가 실행되었습니다.	2023-11-07 16:19:29
DELETE 쿼리가 실행되었습니다.	2023-11-07 16:20:16
*/

-- ■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■ -- 
-- ※ DML 작업 수행 전에 작업에 대한 가능여부 확인

SELECT SYSDATE 
FROM DUAL;
-- 2023-11-07 18:47:03

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1,'김다슬','010-1111-1111');
-- 에러발생
-- ORA-20003: 작업 시간은 09:00 ~ 18:00 까지만 가능합니다.

SELECT SYSDATE 
FROM DUAL;
--2023-11-07 16:49:09

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1,'김다슬','010-1111-1111');
-- 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_TEST1;
-- 1	김다슬	010-1111-1111

COMMIT;
-- 커밋 완료.

UPDATE TBL_TEST1
SET NAME ='오수경', TEL = '010-2222-2222'
WHERE ID = 1;
-- 1 행 이(가) 업데이트되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2,'김경태','010-3333-3333');
-- 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_TEST1;
/*
2	김경태	010-3333-3333
1	오수경	010-2222-2222
*/

UPDATE TBL_TEST1
SET NAME ='박범구', TEL = '010-4444-4444'
WHERE ID = 1;
-- 에러발생
-- 오류 보고 -
-- ORA-20003: 작업 시간은 09:00 ~ 18:00 까지만 가능합니다.


DELETE 
FROM TBL_TEST1
WHERE ID = 2;
-- 에러발생
-- ORA-20003: 작업 시간은 09:00 ~ 18:00 까지만 가능합니다.


-- ■■■ BEFORE ROW TRIGGER 상황 실습 ■■■ -- 
-- ※참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델 

-- 실습 환경 구성을 위한 테이블 생성 → TBL_TEST2
CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
-- Table TBL_TEST2이(가) 생성되었습니다.

-- 실습 환경 구성을 위한 테이블 생성 → TBL_TEST3
CREATE TABLE TBL_TEST3
( SID  NUMBER
, CODE NUMBER
, SU   NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
            REFERENCES TBL_TEST2(CODE)
);
-- Table TBL_TEST3이(가) 생성되었습니다.

-- ○ 실습 관련 데이터 입력 
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '텔레비전');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '건조기');
-- 1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_TEST2;
/*
1	텔레비전
2	냉장고
3	세탁기
4	건조기
*/

COMMIT;
-- 커밋 완료

-- ○ 실습 관련 데이터 입력 
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(1 ,1, 30);   -- 텔레비전
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(2 ,1, 50);   -- 텔레비전
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(3 ,1, 60);   -- 텔레비전

INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(4 ,2, 20);   -- 냉장고
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(5 ,2, 20);   -- 냉장고
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(6 ,3, 40);   -- 세탁기

INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(7 ,1, 30);   -- 텔레비전
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(8 ,4, 30);   -- 건조기
INSERT INTO TBL_TEST3(SID,CODE, SU) VALUES(9 ,3, 10);   -- 세탁기
-- 1 행 이(가) 삽입되었습니다. * 9

SELECT *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	2	20
5	2	20
6	3	40
7	1	30
8	4	30
9	3	10
*/

COMMIT;
-- 커밋 완료

--○ 부모 테이블(TBL_TEST2)의 데이터 삭제 시도
SELECT *
FROM TBL_TEST2
WHERE CODE=1;
--1	텔레비전

DELETE
FROM TBL_TEST2
WHERE CODE=1;
-- 에러발생
-- ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found

-- ○ TRIGGER 생성 이후 확인
DELETE
FROM TBL_TEST2
WHERE CODE=1;
-- 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
/*
2	냉장고
3	세탁기
4	건조기
*/

SELECT *
FROM TBL_TEST3;
/*
4	2	20
5	2	20
6	3	40
8	4	30
9	3	10
*/

DELETE
FROM TBL_TEST2
WHERE CODE=2;
-- 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
/*
3	세탁기
4	건조기
*/

SELECT *
FROM TBL_TEST3;
/*
6	3	40
8	4	30
9	3	10
*/

-- ■■■ AFTER ROW TRIGGER 상황 실습 ■■■ -- 
-- ※ 참조 테이블 관련 트랜잭션 처리

-- ※ 실습을 위한 준비 
UPDATE TBL_상품
SET 재고수량 = 0;
-- 17개 행 이(가) 업데이트되었습니다.

-- TRUNCATE 사용시 ROLLBACK 안됨 
TRUNCATE TABLE TBL_입고;
-- Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
-- Table TBL_출고이(가) 잘렸습니다.

SELECT *
FROM TBL_상품;

ROLLBACK;
--롤백 완료;

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	0
H002	죠스바	 500	0
H003	보석바	 500	0
H004	누가바	 600	0
H005	쌍쌍바	 700	0
H006	수박바	 500	0
H007	알껌바	 500	0
C001	빵빠레	1600	0
C002	월드콘	1500	0
C003	메타콘	1500	0
C004	구구콘	1600	0
C005	슈퍼콘	1700	0
E001	빵또아	2600	0
E002	투게더	2500	0
E003	팥빙수	2500	0
E004	셀렉션	2600	0
E005	설레임	2700	0
*/

SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_출고;


-- ○ TRIGGER(트리거) 생성 이후 실습 테스트 
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1,'H001', SYSDATE, 40,1000);
1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
-- 1	 H001	 2023-11-08	 40	 1000

COMMIT;
-- 커밋완료

SELECT *
FROM TBL_상품;
/*
H001	바밤바	 600	40
H002	죠스바	 500	 0
H003	보석바	 500	 0
H004	누가바	 600	 0
H005	쌍쌍바	 700	 0
H006	수박바	 500	 0
H007	알껌바	 500	 0  
C001	빵빠레	1600	 0 
C002	월드콘	1500	 0
C003	메타콘	1500	 0
C004	구구콘	1600	 0
C005	슈퍼콘	1700	 0
E001	빵또아	2600	 0
E002	투게더	2500	 0
E003	팥빙수	2500	 0
E004	셀렉션	2600	 0
E005	설레임	2700	 0
*/

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(2,'H001', SYSDATE, 20,1000);
-- 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
/*
1	H001	2023-11-08	40	1000
2	H001	2023-11-08	20	1000
*/

COMMIT;

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	60
H002	죠스바	500	0
H003	보석바	500	0
H004	누가바	600	0
H005	쌍쌍바	700	0
H006	수박바	500	0
H007	알껌바	500	0
C001	빵빠레	1600	0
C002	월드콘	1500	0
C003	메타콘	1500	0
        :
        :
*/

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1,'H001', SYSDATE, 20,1000);

SELECT *
FROM TBL_입고;
SELECT *
FROM TBL_상품;

UPDATE TBL_상품
SET 재고수량 = 40
WHERE 상품코드 = 'H001';

DELETE 
FROM TBL_입고 
WHERE 입고번호 = 1;

