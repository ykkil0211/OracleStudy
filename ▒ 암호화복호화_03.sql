SELECT USER
FROM DUAL;
--==>> SCOTT
 
 
-- (현재 SCOTT 으로 연결된 상태)
 
--■■■ 암호화 및 복호화 03 ■■■--
CREATE TABLE TBL_PACKAGETEST
( ID    NUMBER
, KEY   VARCHAR2(40)
, PW    VARCHAR2(40)
);
--==>> Table TBL_PACKAGETEST이(가) 생성되었습니다.
 
 
--○ 데이터 입력(비 암호화)
INSERT INTO TBL_PACKAGETEST(ID,PW) VALUES(1, 'abcd1234');   
-- key 값 부여하지 않고(암호화X) 실행하는 구문
--==>> 1 행 이(가) 삽입되었습니다.
 
--○ 확인
SELECT *
FROM TBL_PACKAGETEST;
--==>> 1	(null)	abcd1234
 
--○ 롤백
ROLLBACK;
--==>> 롤백 완료.
 
--○ 다시 데이터 입력(암호화)
--INSERT INTO TBL_PACKAGETEST(ID,KEY,PW) VALUES(1, 'abcd1234', 'abcd1234');
INSERT INTO TBL_PACKAGETEST(ID,KEY,PW) 
VALUES(1, 'abcd1234', CRYPTPACK.ENCRYPT('abcd1234','abcd1234'));
-- ====================================================== 
-- ** 암호화함수: 【CRYPTPACK.ENCRYPT('패스워드' , '키')】
-- ======================================================
-- 'abcd1234' (패스워드)를
-- 'abcd1234' (키)로 암호화 처리
--==>> 1 행 이(가) 삽입되었습니다.
 
--○ 확인 (→ 복호화 과정을 수행하지 않고 일반적인 조회를 수행)
SELECT *
FROM TBL_PACKAGETEST;
--==>> 1	abcd1234	c":5?
 
--○ 데이터 조회 (복호화 → 암호화 과정에서 설정한 KEY 가 아닌 잘못된 KEY를 통해 복호화)
SELECT ID, CRYPTPACK.DECRYPT(PW,'1111') "결과확인"
FROM TBL_PACKAGETEST;
-- ======================================================
-- ** 복호화함수: 【CRYPTPACK.DECRYPT('패스워드' , '키')】
-- ** 암호화한 '키'를 넣지 않으면 원래의 암호를 찾을 수 없음
-- ======================================================
--==>> 1	?f+??
 
SELECT ID, CRYPTPACK.DECRYPT(PW,'abcd') "결과확인"
FROM TBL_PACKAGETEST;
--==>> 1	G?"!?
 
SELECT ID, CRYPTPACK.DECRYPT(PW,'abcd1234') "결과확인"
FROM TBL_PACKAGETEST;
--==>> 1	abcd1234
-- ** 패스워드를 주민번호 뒷번호로 암호화? 주민번호 뒷번호를 패스워드로 암호화?
 
-- ** 파이널 프로젝트에서 연결을 다시 할 필요는 없음(02) 사용할 계정에 권한만 부여하고,
-- ** 03만 실행하기