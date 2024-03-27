-- sys 접속 비밀번호 변경(! 제외하게끔)
--ALTER USER SYS IDENTIFIED BY "java006$";
 
SELECT USER
FROM DUAL;
--==>> SYS
 
 
 
-- (현재 sys로 연결된 상태)
 
--■■■ 암호화 및 복호화 01 ■■■--
 
--1. 오라클 암호화 기능을 사용하기 위해서는
--   DBMS_OBFUSCATION_TOOLKIT 패키지를 이용할 수 있다.
--   (관련 패키지를 활용하지 않고, 암호화 복호화 알고리즘을 직접 구현할 수도 있다.)
 
--2. DBMS_OBFUSCATION_TOOLKIT 패키지는
--   기본적(default)으로는 사용할 수 없느 상태로 설정되어 있으므로
--   추가로 이 패키지를 사용할 수 있는 상태로 설치하는 과정이 필요하다.
--   이를 위해... 『dbmsobtk.sql』과 『prvtobtk.plb』파일을 찾아 실행해야 한다.
/*
암호화를 하지 않는다면...
DB에 접근하는 것은 DBA만 접근하는 것이 아니라 누구나 접근할 수있음
 
관리자도 못보게 하는것 -> 공인인증서 수준(양쪽의 키 값이 맞아야 함)
 
오라클에서는 쉽게 암호화 복호화 패키지를 제공함.-> 찾아서 설치해야함
*/
 
-- book   -------   2151511   -------   book
-- book   -------   cppl      -------   book
 
 
-- ** DBMS_OBFUSCATION_TOOLKIT 패키지 를 설치하기 위해 필요한 리소스
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\dbmsobtk.sql
--==>>
-- @ 붙임.
/*
Library DBMS_OBFUSCATION_LIB이(가) 컴파일되었습니다.
Library CRYPTO_TOOLKIT_LIBRARY이(가) 컴파일되었습니다.
Package DBMS_CRYPTO이(가) 컴파일되었습니다.
SYNONYM DBMS_CRYPTO이(가) 생성되었습니다.
Package DBMS_OBFUSCATION_TOOLKIT이(가) 컴파일되었습니다.
SYNONYM DBMS_OBFUSCATION_TOOLKIT이(가) 생성되었습니다.
Grant을(를) 성공했습니다.
Package DBMS_SQLHASH이(가) 컴파일되었습니다.
SYNONYM DBMS_SQLHASH이(가) 생성되었습니다.
*/
 
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\prvtobtk.plb
--==>>
/*
Package DBMS_CRYPTO_FFI이(가) 컴파일되었습니다.
Package Body DBMS_CRYPTO_FFI이(가) 컴파일되었습니다.
Package Body DBMS_CRYPTO이(가) 컴파일되었습니다.
Package DBMS_OBFUSCATION_TOOLKIT_FFI이(가) 컴파일되었습니다.
Package Body DBMS_OBFUSCATION_TOOLKIT_FFI이(가) 컴파일되었습니다.
Package Body DBMS_OBFUSCATION_TOOLKIT이(가) 컴파일되었습니다.
Package Body DBMS_SQLHASH이(가) 컴파일되었습니다.
*/
 
-- 3. 이 패키지는 4개의 프로시저로 이루어져 있다.
--    VARCHAR2 타입을 Encrypt/Decrypt 할 수 있는 2개의 프로시저
--    RAW 타입을 Encrypt/Decrypt 할 수 있는 2개의 프로시저
--    (※ 다른 타입은 지원히지 않기 때문에
--        NUMBER 나 DATE 와 같은 경우는 TO_CHAR() 이용)
 
-- ※ RAW, LONG RAW, ROWID 타입
--    그래픽 이미지나 디지털 사운드 등을 저장
--    HEXA-DECIMAL(16진수) 형태로 RETURN,
--    이 중 RAW 는 VARCHAR2 와 유사하다.
--    LONG RAW 는 LONG 과 유사하지만 다음과 같은 제약사항이 있다.
--    ·저장과 추출만 가능하고 DATA 를 가공할수 없다.
--    ·LONG RAW 는 LONG 과 같은 제약사항을 갖는다.
 
-- ** VARCHAR2 암호화 복호화를 작업할것. 
-- ** DB자체에 그래픽 이미지나 디지털 사운드를 저장하는 경우는 거의 없음
 
 
-- ○ 해당 패키지를 사용할 수있도록 권한 부여(SYS 가 SCOTT 에게...)
GRANT EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO SCOTT;
--==>> Grant을(를) 성공했습니다.
--> SCOTT 계정으로 DBMS_OBFUSCATION_TOOLKIT 패키지의
--  프로시저를 사용할 수 있는 권한 부여
 
-- ○ 해당 패키지를 사용할 수있도록 권한 부여(SYS 가 PUBLIC 에게...)
GRANT EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO PUBLIC;
--==>> Grant을(를) 성공했습니다.
--> 운영자 계정으로 DBMS_OBFUSCATION_TOOLKIT 패키지의
--  프로시저를 사용할 수 있는 권한 부여