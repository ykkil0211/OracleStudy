SELECT USER
FROM DUAL;
--> GHW

-- ㅇ 테이블 생성(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10) 
, NAME       VARCHAR2(30)   
);
--> 에러발생 
-- ORA-01031: insufficient privileges

--> 현재 각자의 이름 계정은 CREATE SESSION 권한만 갖고 있으며 
-- 테이블 생성 권한은 갖고 있지 않은 상태
-- 그러므로 관리자로부터 테이블을 생성할 수 있는 권한을 부여받아야 함 

-------------------------------------------------------------------------------
-- ㅇ 각자 생성한 오라클 사용자 게정에 
-- 테이블 생성이 가능하도록 CREATE TABLE 권한 부여

-- ㅇ SYS로부터 테이블 생성 권한(CREATE TABLE)을 부여받은 후 
-- 다시 테이블 생성(TBL_ORAUSERTEST)

CREATE TABLE TBL_ORAUSERTEST
(   NO      NUMBER(10)
,   NAME    VARCHAR2(30)
);

--> 에러발생 
-- ORA-01950: no privileges on tablespace 'TBS_EDUA'
--> 테이블 생성 권한까지 부여받은 상황이지만
-- 각자의 이름 계정의 기본 테이블 스페이스(DEFAULT TABLESPACE)는 
-- TBS_EDUA 이며, 이 공간에 대한 할당량을 부여받지 못한 상태
-- 그러므로 이 테이블 스페이스를 사용할 권한이 없다라는 에러 메세지를 오라클이 알려주고 있는 상황임

-- ㅇ SYS로부터 테이블스페이스(TBS_EDUA)에 대한 할당량을 부여받은 후 
-- 다시 테이블 생성(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)
);
--> Table TBL_ORAUSERTEST이(가) 생성되었습니다.

-- ㅇ 생성된 테이블 조회
SELECT *
FROM TBL_ORAUSERTEST;
--> 테이블의 구조만 확인할 수 있는 상태로 조회
-- 단 조회된 데이터는 없음  

--ㅇ 자신에게 부여된 할당량 조회

SELECT *
FROM USER_TS_QUOTAS;
-- TBS_EDUA	65536	-1	8	-1	NO
-- -1은 무제한을 의미 

-- ㅇ 생성된 테이블(TBL_ORAUSERTEST)이 어떤 테이블스페이스에 저장되어 있는지 조회

SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;

-- TBL_ORAUSERTEST	TBS_EDUA