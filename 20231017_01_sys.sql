
--1줄 주석문 처리(단일행 주석문 처리)

/*
여러행
(다중행)
주석문
처리
*/

-- ㅇ 현재 오라클 서버에 접속한 자신의 계정 조회

show user
--USER이(가) "SYS"입니다.
-- -> sqlplus 상태일때 사용하는 명령어

SELECT USER
FROM dual;
-- > SYS

select user
from dual;
-- > SYS

select 1 + 2
from dual;
-- > 3

select 1 + 2
fromdual;
-- 00923. 00000 - "FROM keyword not found where expected"

select 오라클수업
-- 에러 발생
-- (00923. 00000 -  "FROM keyword not found where expected")

select 오라클 수업
from dual;
--> 에러 발생
--> 00923. 00000 -  "FROM keyword not found where expected"

select "오라클 수업"
from dual;
--> 에러발생
--> 00904. 00000 -  "%s: invalid identifier"


select '오라클 수업'
from dual;
-- 오라클 수업

select '한 발 한 발 힘겨운 오라클 수업'
from dual;
--> 한 발 한 발 힘겨운 오라클 수업

select 3.14 + 3.14
from dual;
--> 6.28

select 10 * 5
from dual;
--> 50

select 10 * 0.5
from dual;
--> 5

select 4/2
from dual;
--> 2

select 10/2.5
from dual;
--> 4

select 10/2.4
from dual;
--> 4.16666666666666666666666666666666666667

select 4.0/2
from dual;
--> 2

select 5/2
from dual;
--> 2.5

select 100 -78
from dual
--> 22

select '김동민'+ '정한올'
from dual;
--> 오류 오라클은 문자열끼리 문자열을 결합할 수 없음
--> 00933. 00000 -  "SQL command not properly ended"

-- ㅇ 현재 오라클 서버에 존재하는 사용자 계정 상태 조회

select USERNAME, ACCOUNT_STATUS
from DBA_USERS;



/*
SYS                         	OPEN
SYSTEM	                    OPEN
ANONYMOUS	                OPEN
HR	                        OPEN
APEX_PUBLIC_USER            	LOCKED
FLOWS_FILES	                LOCKED
APEX_040000	                LOCKED
OUTLN	                    EXPIRED & LOCKED
DIP	                        EXPIRED & LOCKED
ORACLE_OCM	                EXPIRED & LOCKED
XS$NULL	                    EXPIRED & LOCKED
MDSYS	                    EXPIRED & LOCKED
CTXSYS	                    EXPIRED & LOCKED
DBSNMP	                    EXPIRED & LOCKED
XDB	                        EXPIRED & LOCKED
APPQOSSYS	                EXPIRED & LOCKED
*/

select *
from DBA_USERS;

/*
SYS	0		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP
SYSTEM	5		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP
ANONYMOUS	35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
HR	43		OPEN		24/04/14	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
FLOWS_FILES	44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APEX_040000	47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
OUTLN	9		EXPIRED & LOCKED	23/10/16	23/10/16	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
DIP	14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
ORACLE_OCM	21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
XS$NULL	2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
MDSYS	42		EXPIRED & LOCKED	14/05/29	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
CTXSYS	32		EXPIRED & LOCKED	23/10/16	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
DBSNMP	29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
XDB	34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APPQOSSYS	30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
*/

select username, created
from dba_users;

/*
SYS	                2014-05-29
SYSTEM	            2014-05-29
ANONYMOUS	        2014-05-29
HR	                2014-05-29
APEX_PUBLIC_USER    2014-05-29
FLOWS_FILES	        2014-05-29
APEX_040000	        2014-05-29
OUTLN	            2014-05-29
DIP	                2014-05-29
ORACLE_OCM	        2014-05-29
XS$NULL	            2014-05-29
MDSYS	            2014-05-29
CTXSYS	            2014-05-29
DBSNMP	            2014-05-29
XDB	                2014-05-29
APPQOSSYS	        2014-05-29
*/

alter session set nls_date_format = 'yyyy-mm-dd';

--> "DBA_"로 시작하는 Oracle Data Dictionary View는 오로지 관리자 권한으로 접속했을 경우에만 조회가 가능함

-- ㅇ "hr" 사용자 계정을 잠금 상태로 설정 

alter user hr account lock;
-- User HR이(가) 변경되었습니다.

select username, account_status
from dba_users;

--> HR	LOCKED

-- ㅇ "hr" 사용자 계정을 다시 잠금 해제 상태로 설정

ALTER USER HR ACCOUNT UNLOCK;
-- User HR이(가) 변경되었습니다.

-------------------------------------------------------------------------------
-- ㅇ TABLESPACE 생성 

-- TABLESPACE란?
-- 세그먼트(데이블, 인덱스, ....)를 담아두는 오라클의 논리적인 저장구조를 의미 
-- 오라클의 논리적인 저장구조를 의미

CREATE TABLESPACE TBS_EDUA -- 생성하겠음. 테이블스페이스를 TBS_EDUA라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF' -- 물리적 데이터 파일 경로 및 이름
SIZE 4M                     -- 사이즈(용량)
EXTENT MANAGEMENT LOCAL -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO; -- 세그먼트 공간 관리도 오라클 서버가 자동으로 관리

-- 테이블스페이스 생성 구문을 실행하기 전에
-- 해당 경로의 물리적인 디렉터리 생성이 필요함 
-- (C:\TESTDATA)

-- ㅇ 생성된 테이블스페이스 조회
SELECT *
FROM DBA_TABLESPACES;

-- ㅇ 파일 용량 정보 조회(물리적인 파일 이름 조회)

SELECT *
FROM DBA_DATA_FILES;
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	4	USERS	104857600	12800	AVAILABLE	4	YES	11811160064	1441792	1280	103809024	12672	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	2	SYSAUX	692060160	84480	AVAILABLE	2	YES	34359721984	4194302	1280	691011584	84352	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	3	UNDOTBS1	398458880	48640	AVAILABLE	3	YES	524288000	64000	640	397410304	48512	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	1	SYSTEM	377487360	46080	AVAILABLE	1	YES	629145600	76800	1280	376438784	45952	SYSTEM
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/

-- ㅇ오라클 사용자 계정 생성 
CREATE USER ghw IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
-- User GHW이(가) 생성되었습니다.

--> ghw 라는 사용자 계정을 생성했음. (만들거임, 만들어줘)
-- 이 사용자 계정의 패스워드는 java006$로 할거임 
-- 이 계정을 통해 생성하는 오라클 세그먼트는 기본적으로 TBS_EDUA라는 테이블 스페이스에 생성할 수 있도록 설정 

--  생성된 오라클 사용자 계정(각자 본인의 이름 이니셜 계정)을 통해 접속 시도
-- 접속 불가(실패)
-- "CREATE SESSION" 권한이 없기 때문에 접속 불가

-- ㅇ 생성된 오라클 사용자 계정(각자 본인의 이름 이니셜 계정)에 
-- 오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여

GRANT CREATE SESSION TO GHW;
-- Grant을(를) 성공했습니다.

-- ㅇ 각자 생성한 오라클 사용자 게정의 시스템 관련 관한 조회 

SELECT *
FROM DBA_SYS_PRIVS;
-- GHW	CREATE SESSION	NO

GRANT CREATE TABLE TO GHW;

-- ㅇ 각자 생성한 오라클 사용자 게정에 
-- 테이블 스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량) 지정 

ALTER USER GHW
QUOTA UNLIMITED ON TBS_EDUA;
--> User GHW이(가) 변경되었습니다.