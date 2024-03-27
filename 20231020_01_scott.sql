--ㅇ 데이터 수정(UPDATE -> TBL_DEPT)
UPDATE TBL_DEPT
SET DNAME = '연구부', LOC = '경기'
WHERE DEPTNO = 50;

SELECT *
FROM TBL_DEPT;
--==> 
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	개발부	서울
*/

ROLLBACK;
-- 롤백 완료.

--ㅇ 롤백 이후 다시 확인 
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	개발부	서울
*/

--ㅇ 데이터 수정
UPDATE TBL_DEPT
SET DNAME = ' 연구부', LOC = '인천'
WHERE DEPTNO = 50;
--> 1행이(가) 업데이트되었습니다.

--ㅇ 확인
SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	 연구부	인천
*/

COMMIT;

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	 연구부	인천
*/

ROLLBACK;

SELECT *
FROM TBL_DEPT;
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
50	 연구부	인천
*/

--ㅇ 데이터 삭제(DELETE -> TBL_DEPT)
DELETE TBL_DEPT
WHERE DEPTNO = 50;

SELECT *
FROM TBL_DEPT
WHERE DEPTNO = 50;

DELETE 
FROM TBL_DEPT
WHERE DEPTNO = 50;

ROLLBACK;

SELECT *
FROM TBL_DEPT;

/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	CHICAGO
40	OPERATIONS	BOSTON
*/

COMMIT;
-----------------------------------------------------------

--ㅇ ORDER BY절 
SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP;

SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY DEPTNO ASC; -- DEPTNO -> 정렬기준 : 부서번호 
                     -- ASC -> 정렬 유형 : 오름차순
/*
CLARK	10	MANAGER	2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
JONES	20	MANAGER	2975	35700
FORD	20	ANALYST	3000	36000
ADAMS	20	CLERK	1100	13200
SMITH	20	CLERK	800	9600
SCOTT	20	ANALYST	3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/

SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY DEPTNO; -- ASC -- 정렬 유형 : 오름차순 -> 생략가능 

SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY DEPTNO DESC; -- DEPTNO -> 정렬기준 : 부서번호 
                     -- DESC -> 정렬 유형 : 내림차순
/*
BLAKE	30	MANAGER	2850	34200
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
MARTIN	30	SALESMAN	1250	16400
WARD	30	SALESMAN	1250	15500
JAMES	30	CLERK	950	11400
SCOTT	20	ANALYST	3000	36000
JONES	20	MANAGER	2975	35700
SMITH	20	CLERK	800	9600
ADAMS	20	CLERK	1100	13200
FORD	20	ANALYST	3000	36000
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
CLARK	10	MANAGER	2450	29400
*/

SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY 연봉 DESC;
/*
KING	10	PRESIDENT	5000	60000
FORD	20	ANALYST	3000	36000
SCOTT	20	ANALYST	3000	36000
JONES	20	MANAGER	2975	35700
BLAKE	30	MANAGER	2850	34200
CLARK	10	MANAGER	2450	29400
ALLEN	30	SALESMAN	1600	19500
TURNER	30	SALESMAN	1500	18000
MARTIN	30	SALESMAN	1250	16400
MILLER	10	CLERK	1300	15600
WARD	30	SALESMAN	1250	15500
ADAMS	20	CLERK	1100	13200
JAMES	30	CLERK	950	11400
SMITH	20	CLERK	800	9600
*/

SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY 2; -- 부서번호 오름차순

/*
-- EMP 테이블이 갖고 있는 테이블의 고유한 컬럼 순서(2 -> ENMAE)가 아니라 
-- SELECT 처리되는 두번째 컬럼(2 -> DEPTNO, 부서번호)을 기준으로 정렬
-- ASC는 생략된 상태 -> 오름차순 정렬
-- 오라클에서의 기본 인덱서는 자바와 달리 1부터 시작
-- 최종적으로.. 현재 "ORDER BY 2" 구문은 -> "ORDER BY DEPTNO ASC"임
*/
/*
CLARK	10	MANAGER	2450	29400
KING	10	PRESIDENT	5000	60000
MILLER	10	CLERK	1300	15600
JONES	20	MANAGER	2975	35700
FORD	20	ANALYST	3000	36000
ADAMS	20	CLERK	1100	13200
SMITH	20	CLERK	800	9600
SCOTT	20	ANALYST	3000	36000
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
JAMES	30	CLERK	950	11400
BLAKE	30	MANAGER	2850	34200
MARTIN	30	SALESMAN	1250	16400
*/


SELECT ENAME 사원명, DEPTNO 부서번호, JOB 직종, SAL 급여
        , SAL*12 + NVL(COMM,0) 연봉
FROM EMP
ORDER BY 2,4; -- 부서번호 급여 오름차순 정렬
--                  1차   2차 
/*
MILLER	10	CLERK	1300	15600
CLARK	10	MANAGER	2450	29400
KING	10	PRESIDENT	5000	60000
SMITH	20	CLERK	800	9600
ADAMS	20	CLERK	1100	13200
JONES	20	MANAGER	2975	35700
SCOTT	20	ANALYST	3000	36000
FORD	20	ANALYST	3000	36000
JAMES	30	CLERK	950	11400
MARTIN	30	SALESMAN	1250	16400
WARD	30	SALESMAN	1250	15500
TURNER	30	SALESMAN	1500	18000
ALLEN	30	SALESMAN	1600	19500
BLAKE	30	MANAGER	2850	34200
*/

SELECT ENAME, DEPTNO, JOB, SAL
FROM EMP
ORDER BY 2,3,4 DESC;
--1. 2 --> DEPTNO(부서번호) 기준 오름차순 정렬
--2. 3 --> JOB(직종명) 기준 오름차순 정렬 
--3. 4 DESC -> SAL(급여) 기준 내림차순(DES) 정렬 
-- (3차 정렬 수행) 
/*
MILLER	10	CLERK	1300
CLARK	10	MANAGER	2450
KING	10	PRESIDENT	5000
SCOTT	20	ANALYST	3000
FORD	20	ANALYST	3000
ADAMS	20	CLERK	1100
SMITH	20	CLERK	800
JONES	20	MANAGER	2975
JAMES	30	CLERK	950
BLAKE	30	MANAGER	2850
ALLEN	30	SALESMAN	1600
TURNER	30	SALESMAN	1500
MARTIN	30	SALESMAN	1250
WARD	30	SALESMAN	1250
*/

-- CONCAT()
SELECT ENAME || JOB COL1
    , CONCAT(ENAME, JOB) COL2
FROM EMP;
/*
SMITHCLERK	SMITHCLERK
ALLENSALESMAN	ALLENSALESMAN
WARDSALESMAN	WARDSALESMAN
JONESMANAGER	JONESMANAGER
MARTINSALESMAN	MARTINSALESMAN
BLAKEMANAGER	BLAKEMANAGER
CLARKMANAGER	CLARKMANAGER
SCOTTANALYST	SCOTTANALYST
KINGPRESIDENT	KINGPRESIDENT
TURNERSALESMAN	TURNERSALESMAN
ADAMSCLERK	ADAMSCLERK
JAMESCLERK	JAMESCLERK
FORDANALYST	FORDANALYST
MILLERCLERK	MILLERCLERK
*/

-- 문자열 기반으로 데이터 결합을 수행하는 함수 CONCAT()
-- 오로지 2개의 문자열만 결합시킬 수 있음 
SELECT '서로' || '배려하며' || '지내자' COL1
        , CONCAT('서로','배려하며','지내자') COL2
FROM DUAL;
-- 에러 발생 
-- ORA-00909: invalid number of arguments

-- 사원명, 직종명, 부서번호
SELECT CONCAT(ENAME, CONCAT(JOB, DEPTNO)) COL2
FROM EMP;
/*
SMITHCLERK20
ALLENSALESMAN30
WARDSALESMAN30
JONESMANAGER20
MARTINSALESMAN30
BLAKEMANAGER30
CLARKMANAGER10
SCOTTANALYST20
KINGPRESIDENT10
TURNERSALESMAN30
ADAMSCLERK20
JAMESCLERK30
FORDANALYST20
MILLERCLERK10
*/

-- 내부적인 형 변환이 일어나며 결합을 수행하게 됨
-- CONCAT()은 문자열과 문자열을 결합시켜주는 함수이지만
-- 내부적으로 숫자나 날짜를 문자로 변환해주는 과정이 포함되어 있음 

--ㅇ SUBSTR() 
/*
obj.substring()
---
문자열 - 문자열.substring(n,m);
                        -----
                        문자열의 n부터 m-1까지...(인덱스는 0부터)
*/
--ㅇ SUBSTR() 개수를 기반으로 / SUBSTRB() 바이트 기반 
SELECT ENAME "CAL1"
        , SUBSTR(ENAME, 1,2) "COL2"
FROM EMP;
-- 문자열을 추출하는 기능을 가진 함수
-- 첫 번째 파라미터 값은 대상 문자열(추출의 대상, TARGET)
-- 두 번째 파라미터 값은 추출을 시작하는 위치(인덱스, START) -> 인덱스는 1부터 시작...
-- 세 번째 파라미터 값은 추출할 문자열의 개수(개수, COUNT) -> 생략 시... 문자열 길이 끝까지
/*
SMITH	SM
ALLEN	AL
WARD	WA
JONES	JO
MARTIN	MA
BLAKE	BL
CLARK	CL
SCOTT	SC
KING	KI
TURNER	TU
ADAMS	AD
JAMES	JA
FORD	FO
MILLER	MI
*/

SELECT ENAME COL1
        ,SUBSTR(ENAME, 3,2) COL2
        ,SUBSTR(ENAME, 3,5) COL3
        ,SUBSTR(ENAME, 3) COL4
        ,SUBSTR(ENAME, 6, 1) COL5
FROM EMP;
/*
SMITH	IT	ITH	    ITH	
ALLEN	LE	LEN	    LEN	
WARD	RD	RD	RD	
JONES	NE	NES	    NES	
MARTIN	RT	RTIN    	RTIN    	N
BLAKE	AK	AKE	    AKE	
CLARK	AR	ARK	    ARK	
SCOTT	OT	OTT	    OTT	
KING	NG	NG	NG	
TURNER	RN	RNER	    RNER	    R
ADAMS	AM	AMS	    AMS	
JAMES	ME	MES	    MES	
FORD	RD	RD	RD	
MILLER	LL	LLER	    LLER    	R
*/

--ㅇ TBL_SAWON 테이블에서 성별이 남성인 사원만
-- 사원번호, 사원명, 주민번호, 급여 항목을 조회
-- 단, SUBSTR() 함수를 활용하여 처리할 수 있도록 함 

SELECT *
FROM TBL_SAWON;

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) ='1' OR SUBSTR(JUBUN,7,1) ='3';
/*
1001	강혜성	9710171234567	3000
1008	선동열	6909101234567	2000
1009	이이경	0505053234567	    1500
1011	이윤수	9501061234567	4000
1013	남진	    6511111234567	2000
1014	이주형	9904171234567	2000
1015	남궁민	0202023234567   	2300
*/

SELECT SANO, SANAME, JUBUN, SAL
FROM TBL_SAWON
WHERE SUBSTR(JUBUN,7,1) IN ('1','3');
/*
1001	강혜성	9710171234567	3000
1008	선동열	6909101234567	2000
1009	이이경	0505053234567	    1500
1011	이윤수	9501061234567	4000
1013	남진  	6511111234567	2000
1014	이주형	9904171234567	2000
1015	남궁민	0202023234567	    2300
*/

-- LENGTH() 글자수 / LENGTHB() 바이트 수 
SELECT ENAME "COL1"
        , LENGTH(ENAME) "COL2"
        ,LENGTHB(ENAME) "COL3"
FROM EMP;
/*
SMITH	5	5
ALLEN	5	5
WARD	    4	4
JONES	5	5
MARTIN	6	6
BLAKE	5	5
CLARK	5	5
SCOTT	5	5
KING	    4	4
TURNER	6	6
ADAMS	5	5
JAMES	5	5
FORD    	4	4
MILLER	6	6
*/

--ㅇ INSTR()
SELECT 'ORACLE ORAHOME BIORA' "COL1"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA',1,1) "COL2"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA',1,2) "COL3"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA',2,1) "COL4"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA',2) "COL5"
    , INSTR('ORACLE ORAHOME BIORA', 'ORA',2,3) "COL6"
FROM DUAL;

--  ORACLE ORAHOME BIORA	1	8	8	8	0
-- 첫 번째 파라미터 값에 해당하는 문자열에서..(대상 문자열, TARGET)
-- 두 번째 파라미터 값을 통해 넘겨준 문자열이 등장하는 위치를 찾기
-- 세 번재 파라미터 값은 찾기 시작하는(스캔을 시작하는) 위치
-- 네 번째 파라미터 값은 몇 번째 등장하는 값을 찾을 것인지에 대한 설정 -> (1일 경우 생략 가능)

SELECT '나의 오라클 집으로오라 합니다.' "COL1"
    , INSTR('나의 오라클 집으로오라 합니다.', '오라',1) "COL2"
    , INSTR('나의 오라클 집으로오라 합니다.', '오라',2)"COL3"
    , INSTR('나의 오라클 집으로오라 합니다.', '오라',10) "COL4"
    , INSTR('나의 오라클 집으로오라 합니다.', '오라',11)" COL5"
FROM DUAL;

--REVERSE()
SELECT 'ORACLE' "COL1"
    , REVERSE('ORACLE') "COL2"
    , REVERSE('오라클') "COL3"
FROM DUAL;
-- ORACLE	ELCARO	???

--ㅇ 실습 테이블 생성(TBL_FILES)
CREATE TABLE TBL_FILES
( FILENO    NUMBER(3)
, FILENAME VARCHAR2(100)
);
-- Table TBL_FILES이(가) 생성되었습니다.

--ㅇ 데이터 입력(TBL_FILES)
INSERT INTO TBL_FILES VALUES (1, 'C:\AAA\BBB\CCC\SALES.DOC');
INSERT INTO TBL_FILES VALUES (2, 'C:\AAA\PANMAE.XXLS');
INSERT INTO TBL_FILES VALUES (3, 'D:\RESEARCH.PPT');
INSERT INTO TBL_FILES VALUES (4, 'C:\DOCUMENTS\STUDY.DOC');
INSERT INTO TBL_FILES VALUES (5, 'C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT');
INSERT INTO TBL_FILES VALUES (6, 'C:\SHARE\F\TEST\FLOWER.PNG');
INSERT INTO TBL_FILES VALUES (7, 'E:\STUDY\ORACLE\20231020_01_SCOTT.SQL');

SELECT *
FROM TBL_FILES;

/*
C:\AAA\BBB\CCC\SALES.DOC
D:\RESEARCH.PPT
C:\DOCUMENTS\STUDY.DOC
C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT
C:\SHARE\F\TEST\FLOWER.PNG
E:\STUDY\ORACLE\20231020_01_SCOTT.SQL
C:\AAA\PANMAE.XXLS
*/

--ㅇ 커밋 
COMMIT;
-- 커밋완료 

SELECT FILENO "파일번호"
    , FILENAME "파일명"
FROM TBL_FILES;

/*
1	SALES.DOC
2	PANMAE.XXLS
3	PPT
4	DOC
5	SQL.TXT
6	FLOWER.PNG
7	20231020_01_SCOTT.SQL
*/

--ㅇ TBL_FILES 테이블을 조회하여 다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성
--SUBSTR(ENAME, 1,2) "COL2"
-- INSTR('ORACLE ORAHOME BIORA', 'ORA',1,1)
SELECT FILENO
        ,SUBSTR(FILENAME,INSTR(FILENAME, '\',-1,1)+1)
FROM TBL_FILES;


SELECT FILENO "파일번호"
    ,REVERSE(FILENAME) "거꾸로된 파일명"
FROM TBL_FILES;


SELECT FILENO "파일번호"
     , FILENAME "경로포함파일명"
     , REVERSE(FILENAME) "거꾸로된경로및파일명"
     , SUBSTR(REVERSE(FILENAME), 1,INSTR(REVERSE(FILENAME),'\',1) -1) "거꾸로된 파일명"
FROM TBL_FILES;
/*
1	C:\AAA\BBB\CCC\SALES.DOC	COD.SELAS\CCC\BBB\AAA\:C	COD.SELAS
3	D:\RESEARCH.PPT	TPP.HCRAESER\:D	TPP.HCRAESER
4	C:\DOCUMENTS\STUDY.DOC	COD.YDUTS\STNEMUCOD\:C	COD.YDUTS
5	C:\DOCUMENTS\TEMP\HOMEWORK\SQL.TXT	TXT.LQS\KROWEMOH\PMET\STNEMUCOD\:C	TXT.LQS
6	C:\SHARE\F\TEST\FLOWER.PNG	GNP.REWOLF\TSET\F\ERAHS\:C	GNP.REWOLF
7	E:\STUDY\ORACLE\20231020_01_SCOTT.SQL	LQS.TTOCS_10_02013202\ELCARO\YDUTS\:E	LQS.TTOCS_10_02013202
2	C:\AAA\PANMAE.XXLS	SLXX.EAMNAP\AAA\:C	SLXX.EAMNAP
*/

SELECT FILENO "파일번호"
--     , FILENAME "경로포함파일명"
--     , REVERSE(FILENAME) "거꾸로된경로및파일명"
     , REVERSE(SUBSTR(REVERSE(FILENAME), 1,INSTR(REVERSE(FILENAME),'\',1) -1)) "거꾸로된 파일명"
FROM TBL_FILES;
/*
1	SALES.DOC
3	RESEARCH.PPT
4	STUDY.DOC
5	SQL.TXT
6	FLOWER.PNG
7	20231020_01_SCOTT.SQL
2	PANMAE.XXLS
*/

--ㅇ LPAD()
--> Byte를 확보하여 왼쪽부터 문자로 채우는 기능을 가진 함수 
SELECT 'ORACLE' "COL1"
    ,LPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
-- 1. 10Byte를 확보함 -- 두 번째 파라미터 값에 의해 
-- 2. 확보한 공간에 'ORACLE'문자열을 담음 -> 첫 번째 파라미터 값에 의해 
-- 3. 남이있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채움
-- 4. 이렇게 구성된 최종 결과값을 반환함
--ORACLE	****ORACLE

--ㅇ RPAD()
--> Byte를 확보하여 오른쪽부터 문자로 채우는 기능을 가진 함수
SELECT 'ORACLE' "COL1"
    ,RPAD('ORACLE', 10, '*') "COL2"
FROM DUAL;
-- 1. 10Byte를 확보함 -- 두 번째 파라미터 값에 의해 
-- 2. 확보한 공간에 'ORACLE'문자열을 담음 -> 첫 번째 파라미터 값에 의해 
-- 3. 남이있는 Byte 공간을 왼쪽부터 세 번째 파라미터 값으로 채움
-- 4. 이렇게 구성된 최종 결과값을 반환함
--ORACLE	ORACLE****

--ㅇ LTRIM()
SELECT 'ORAORAORAORACLEORACLE' "CLO1"
        ,LTRIM('ORAORAORAORACLEORACLE','ORA') "COL2"
        ,LTRIM('AAAAAAAAAORACLEORACLE','ORA') "COL3"
        ,LTRIM('ORAORAoRAORACLEORACLE','ORA') "COL4"         -- 대소문자 구분 함
        ,LTRIM('ORAORA ORAORACLEORACLE','ORA') "COL5"
        ,LTRIM('               ORACLE',' ') "COL6"
        ,LTRIM('               ORACLE') "COL7" -- 두 번째 파라미터 생략
FROM DUAL;
/*ORAORAORAORACLEORACLE	
CLEORACLE	
CLEORACLE	
oRAORACLEORACLE	 
 ORAORACLEORACLE	
ORACLE	
ORACLE
*/

-- 첫 번째 파라미터 값에 해당하는 문자열을 대상으로 왼쪽부터 연속으로 등장하는
-- 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우 이를 제거한 결과값을 반환함 
-- 단 완성형은 처리되지 않음

SELECT LTRIM('김이신이김김이이신김김김이김이김박이김신','김신이')
FROM DUAL;
-- 박이김신

--ㅇ RIRIM()
-- 첫 번째 파라미터 값에 해당하는 문자열을 대상으로 오른쪽부터 연속으로 등장하는
-- 두 번째 파라미터 값에서 지정한 글자와 같은 글자가 등장할 경우 이를 제거한 결과값을 반환함 
-- 단 완성형은 처리되지 않음

--ㅇ TRANSLATE()
-- 1 : 1로 바꿔줌 

SELECT TRANSLATE('MY ORACLE SERVER'
                , 'ABCDEFGHIJKLMNOPURSTUVWXYZ'
                , 'abcdefghijklmnopurstuvwxyz') "COL1"
FROM DUAL;
-- my oracle server

SELECT TRANSLATE('010-9322-9643'
                 , '0123456789'
                 ,'공일이삼사오육칠팔구') "COL1"
FROM dual;
-- 공일공-구삼이이-구육사삼

-- REPLACE()
SELECT REPLACE ('MY ORACLE SERVER ORAHOME', 'ORA','오라') "COL1"
FROM DUAL;
-- MY 오라CLE SERVER 오라HOME

-----------------------------------------------------------------------
-- ㅇ ROUND() 반올림을 처리해 주는 함수

SELECT 48.678 "COL1"    
        , ROUND(48.678,2) "COL2" -- 48.68소수점 이하 둘째자리까지 표현 -> 두번째 파라미터
        , ROUND(48.674,2) "COL3" -- 48.67
        , ROUND(48.674,1) "COL4" -- 48.7
        , ROUND(48.684,0) "COL5" -- 49
        , ROUND(48.684) "COL6" -- 49    -- 두번째 파라미터 값이 0일때 생략 가능 
        , ROUND(48.684,-1) "COL7" -- 50
        , ROUND(48.684,-2) "COL8" -- 0
        , ROUND(48.684,-3) "COL9" -- 0
FROM DUAL;

-- ㅇ TRUNC() 절삭을 처리해주는 함수
SELECT 48.678 "COL1"    
        , TRUNC(48.678,2) "COL2" -- 48.68소수점 이하 둘째자리까지 표현 -> 두번째 파라미터
        , TRUNC(48.674,2) "COL3" -- 48.67
        , TRUNC(48.674,1) "COL4" -- 48.7
        , TRUNC(48.684,0) "COL5" -- 48
        , TRUNC(48.684) "COL6" -- 48    -- 두번째 파라미터 값이 0일때 생략 가능 
        , TRUNC(48.684,-1) "COL7" -- 40
        , TRUNC(48.684,-2) "COL8" -- 0
        , TRUNC(48.684,-3) "COL9" -- 0
FROM DUAL;

--MOD() 나머지를 반환하는 함수 -%

SELECT MOD(5,2) "COL1"
FROM DUAL;
-- 1

-- ㅇ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5,3)
FROM DUAL;

--ㅇ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "COL1"
FROM DUAL;
--> 루트 2에 대한 결과값 반환
-- 1.41421356237309504880168872420969807857

--ㅇ LOG() 로그 함수 
-- (오라클은 상용로그와 자연로그도 존재함, MSSQL도 사용로그, 자연로그 모두 지원함)
SELECT LOG(10,100) "COL1"
        ,LOG(10,20) "COL2"
FROM DUAL;
-- 1.30102999566398119521373889472449302677	2

-- LN() 자연 로그
SELECT LN(95) COL1
FROM DUAL;
-- 4.55387689160054083460978676511404117675 

-- 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
-- 0.8414709848078965066525023216302989996233	0.5403023058681397174009366074429766037354	1.55740772465490223050697480745836017308
-- 각각 싸인, 코싸인, 탄젠트

--ㅇ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
-- 0.52359877559829887307710723054658381405	1.04719755119659774615421446109316762805	0.4636476090008061162142562314612144020295

--ㅇ SIGN() 서명, 부호, 특징
--> 연산 결과값이 양수면 1, 0이면 0 음수이면 -1을 반환함
SELECT SIGN(5-2) "COL1"
        ,SIGN(5-5) "COL2"
        ,SIGN(5-7) "COL3"
FROM DUAL;
-- 1	0	-1
--> 매출이나 수지와 관련된 적자 및 흑자의 개념을 나타낼때 사용 

--ㅇ ASCII(), CHR() <-> 서로 대응(상응)되는 함수
SELECT ASCII('A') COL1
        , CHR(65) "COL2"
FROM DUAL;
--65	A
-- ASCILL() : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환함
-- CHR() : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환

-----------------------------------------------------------------
--ㅇ 날짜 관련 세션 설정 변경 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session이(가) 변경되었습니다.

-- 날짜 연산의 기본 단위는 일수(DAY)임 -- CHECK~!
SELECT SYSDATE "COL1"
        ,SYSDATE + 1 "COL2"
        ,SYSDATE - 2 "COL3"
        ,SYSDATE +30 "COL4"
FROM DUAL;
-- 2023-10-20 15:34:52

SELECT SYSDATE "COL1"
        ,SYSDATE + 1/24 "COL2"
        ,SYSDATE - 2/24 "COL3"
--        ,SYSDATE +30 "COL4"
FROM DUAL;

--ㅇ 현재 시간과 현재 시간 기준 1일 2시간 3분 4초 후를 조회함 
SELECT SYSDATE "현재 시간"
        ,SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60))
FROM DUAL;
-- 2023-10-20 15:54:36	2023-10-21 17:57:40

-- 방법 1
SELECT SYSDATE "현재 시간"
        ,SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;

-- 방법 2
SELECT SYSDATE "현재 시간"
                ,SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) +4) / (24*60*60) 
FROM DUAL;
-- 2023-10-20 16:08:40	2023-10-21 18:11:44

--ㅇ 날짜 - 날짜 -> 일수
SELECT TO_DATE('2024-03-19','YYYY-MM-DD') - TO_DATE('2023-08-22', 'YYYY-MM-DD') "COL1"
FROM DUAL;
--210

--ㅇ 데이터 타입의 변환 
SELECT TO_DATE('2023-10-20', 'YYYY-MM-DD') "COL1"
FROM DUAL;
-- 2023-10-20 00:00:00

SELECT TO_DATE('2023-10-32', 'YYYY-MM-DD') "COL1"
FROM DUAL;
-- 에러 발생 
-- ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2023-02-29', 'YYYY-MM-DD') "COL1"
FROM DUAL;
-- 에러 발생
-- ORA-01839: date not valid for month specified

SELECT TO_DATE('2023-13-20', 'YYYY-MM-DD') "COL1"
FROM DUAL;
-- 에러발생
-- ORA-01843: not a valid month

--ㅇ ADD_MONTHS() 개월 수를 더하거나 빼주는 함수
SELECT SYSDATE "COL1"
        ,ADD_MONTHS(SYSDATE, 2) "COL2"
        ,ADD_MONTHS(SYSDATE, 3) "COL3"
        ,ADD_MONTHS(SYSDATE, -2) "COL4"
        ,ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
/*
2023-10-20 16:19:09	-- 현재
2023-12-20 16:19:09 -- 2개월 후 
2024-01-20 16:19:09	-- 3개월 후
2023-08-20 16:19:09	-- 2개월 후
2023-07-20 16:19:09 -- 3개월 전
*/

--ㅇ MONTHS_BETWEEN()
--> 첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-08', 'YYYY-MM-DD')) "COL1"
FROM DUAL;
-- 257.409200642174432497013142174432497013

--> 개월 수의 차이를 반환화는 함수
-- 결과 값의 부호가 음수로 반환되었을 경우에 
-- 첫번째 인자값에 ㄷ해당하는 날짜보다 
-- 두 번째 인자값에 해당하는 날짜가 미래 라는 의미로 확인할 수 있음

--ㅇ NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
    , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
-- 2023-10-21 16:25:24	
-- 2023-10-23 16:25:24

-- 추가 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH'
-- Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
      ,NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--Session이(가) 변경되었습니다.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--Session이(가) 변경되었습니다.

SELECT SYSDATE "COL1" -- 2023-10-20
                , LAST_DAY(SYSDATE) "COL2" --2023-10-31
                , LAST_DAY(TO_DATE('2023-02-12','YYYY-MM-DD')) "COL3" --2023-02-28 
                 , LAST_DAY(TO_DATE('2020-02-12','YYYY-MM-DD')) "COL4" -- 2020-02-29
FROM DUAL;

--ㅇ 복무기간은 22개월

--1. 전역 일자 구하기 
--2. 하루 꼬박꼬박 3끼 식사를 해야함 
--3. 몇 끼를 먹어야 집에 갈 수 있을까

-- SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-08', 'YYYY-MM-DD')) "COL1"
-- TO_DATE('2024-03-19','YYYY-MM-DD') - TO_DATE('2023-08-22', 'YYYY-MM-DD')

SELECT SYSDATE COL1
        ,ADD_MONTHS(SYSDATE, 22) "COL2"
        ,(TO_DATE('2025-08-20', 'YYYY-MM-DD')- TO_DATE(SYSDATE,'YYYY-MM-DD'))*3 "COL2"
FROM DUAL;
-- 2023-10-20	2025-08-20	2010

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session이(가) 변경되었습니다.

--ㅇ 현재 날짜 및 시간으로부터 
-- 수료일 2024-03-19 18:00 분까지 
-- 남은 기간을 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성

--       현재 시간              수료일             일       시간      분       초 
--2023-10-20 17:09:10   2024-03-19 18:00:00       140일      0        49       50
-- SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-08', 'YYYY-MM-DD')) "COL1"
--        ,SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"

SELECT SYSDATE "현재시간"
     , TO_DATE('2024-03-19 18:00:00') "수료일"
     , TRUNC(TO_DATE('2024-03-19 18:00:00') - SYSDATE) "일"
     , TRUNC((TO_DATE('2024-03-19 18:00:00','YYYY-MM-DD HH24:MI:SS') - SYSDATE)/24) "시간"
     , TRUNC((TO_DATE('2024-03-19 18:00:00') - SYSDATE)/(24*60*60)) "분"
     
FROM DUAL;







