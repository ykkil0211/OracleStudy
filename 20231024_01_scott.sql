SELECT USER 
FROM DUAL;

-- 서브쿼리를 활용하여 
-- TBL_SAWON 테이블을 대상으로 다음과 같이 조회할 수 있도록 함 
-- 사원명 성별 현재나이 급여 나이보너스 
-- VIEW_SAWON을 이용하는것은 아님
-- 나이보너스는 현재 나이가 40세 이상이면 급여의 70%
-- 30세 이상 40세 미만이면 급여의 50%
-- 20세 이상 30세 미만으로 급여의 30%로 함

-- 또한 이렇게 완성된 조회 구문을 통해 
-- VIEW_SAWON2라는 이름의 뷰(VIEW)를 생성할 수 있도록 함 


SELECT T.*
        , CASE WHEN T.현재나이 >= 40 THEN T.급여 * 0.7
               WHEN T.현재나이 >= 30 THEN T.급여 * 0.5
               WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
               ELSE 0
            END 나이보너스
FROM
(
SELECT SANAME "사원명"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
               WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
               ELSE '성별확인불가'
        END "성별"
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
            END "현재나이"
        , SAL 급여
FROM TBL_SAWON
) T;

/*
강혜성	남자	27	3000	900
박가영	여자	29	4000	1200
박나영	여자	25	4000	1200
최혜인	여자	27	5000	1500
아이유	여자	19	1000	0
이하이	여자	18	1000	0
인순이	여자	59	2000	1400
선동열	남자	55	2000	1400
이이경	남자	19	1500	0
선우용녀	여자	58	1300	910
이윤수	남자	29	4000	1200
선우선	여자	18	2000	0
남진	남자	59	2000	1400
이주형	남자	25	2000	600
남궁민	남자	22	2300	690
*/

CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.사원명, T.성별, T.급여, T.나이
    , CASE WHEN T.나이 >= 40 THEN T.급여*0.7
           WHEN T.나이 <= 39 AND T.나이>= 30 THEN T.급여*0.5
           WHEN T.나이 <= 29 AND T.나이>= 20 THEN T.급여*0.3
           ELSE 0
        END "나이보너스"
FROM (
    SELECT SANAME 사원명
         , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남'  
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여'
                ELSE '성별확인불가'
          END "성별"
        , SAL 급여
        , CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
              WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
              THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
              ELSE -1
          END "나이"
    FROM TBL_SAWON
)T;
-- View VIEW_SAWON2이(가) 생성되었습니다.

SELECT *
FROM VIEW_SAWON2;
/*
강혜성	남	3000	27	900
박가영	여	4000	29	1200
박나영	여	4000	25	1200
최혜인	여	5000	27	1500
아이유	여	1000	19	0
이하이	여	1000	18	0
인순이	여	2000	59	1400
선동열	남	2000	55	1400
이이경	남	1500	19	0
선우용녀	여	1300	58	910
이윤수	남	4000	29	1200
선우선	여	2000	18	0
남진	남	2000	59	1400
이주형	남	2000	25	600
남궁민	남	2300	22	690
*/
-----------------------------------------------------------------------------

-- ㅇ RANK() -> 등수(순위)를 반환하는 함수

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서명", SAL "급여"
        , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP;
/*
7839	KING	10	5000	1
7902	FORD	20	3000	2
7788	SCOTT	20	3000	2
7566	JONES	20	2975	4
7698	BLAKE	30	2850	5
7782	CLARK	10	2450	6
7499	ALLEN	30	1600	7
7844	TURNER	30	1500	8
7934	MILLER	10	1300	9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	13
7369	SMITH	20	800	14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서명", SAL "급여"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
        , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP;

/*
7839	KING	10	5000	1	1
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7698	BLAKE	30	2850	1	5
7782	CLARK	10	2450	2	6
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7934	MILLER	10	1300	3	9
7521	WARD	30	1250	4	10
7654	MARTIN	30	1250	4	10
7876	ADAMS	20	1100	4	12
7900	JAMES	30	950	6	13
7369	SMITH	20	800	5	14
*/

SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서명", SAL "급여"
        ,RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
        , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP ORDER BY DEPTNO;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	6
7934	MILLER	10	1300	3	9
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	3	4
7876	ADAMS	20	1100	4	12
7369	SMITH	20	800	5	14
7698	BLAKE	30	2850	1	5
7499	ALLEN	30	1600	2	7
7844	TURNER	30	1500	3	8
7654	MARTIN	30	1250	4	10
7521	WARD	30	1250	4	10
7900	JAMES	30	950	6	13
*/

-- ㅇ DENSE_RANK() -> 서열을 반환하는 함수 
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서명", SAL "급여"
        ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
        ,DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP ORDER BY DEPTNO;

/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서명", SAL "급여"
        ,DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
        ,DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP ORDER BY 3, 4 DESC;
/*
7839	KING	10	5000	1	1
7782	CLARK	10	2450	2	5
7934	MILLER	10	1300	3	8
7902	FORD	20	3000	1	2
7788	SCOTT	20	3000	1	2
7566	JONES	20	2975	2	3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	800	4	12
7698	BLAKE	30	2850	1	4
7499	ALLEN	30	1600	2	6
7844	TURNER	30	1500	3	7
7654	MARTIN	30	1250	4	9
7521	WARD	30	1250	4	9
7900	JAMES	30	950	5	11
*/

-- ㅇ EMP 테이블의 사원 데이터를
-- 사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목으로 조회

SELECT ENAME "사원명" , DEPTNO "부서번호", SAL*12+ NVL(COMM,0) "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY  SAL*12+ NVL(COMM,0) DESC) "부서별연봉순위"
     ,DENSE_RANK() OVER(ORDER BY SAL*12+ NVL(COMM,0) DESC) "전체연봉순위"
FROM EMP ORDER BY DEPTNO;

------------------------------------------------------------------------------------------

SELECT T.사원명, T.부서번호, T.연봉
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY  T.연봉 DESC) "부서별연봉순위"
     ,DENSE_RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM (
    SELECT ENAME "사원명"
         , DEPTNO "부서번호"
         , SAL*12+ NVL(COMM,0) "연봉"
    FROM EMP
)T ORDER BY 2,4;

/*
KING	10	60000	1	1
CLARK	10	29400	2	5
MILLER	10	15600	3	9
FORD	20	36000	1	2
SCOTT	20	36000	1	2
JONES	20	35700	3	3
ADAMS	20	13200	4	11
SMITH	20	9600	5	13
BLAKE	30	34200	1	4
ALLEN	30	19500	2	6
TURNER	30	18000	3	7
MARTIN	30	16400	4	8
WARD	30	15500	5	10
JAMES	30	11400	6	12
*/

-- ㅇ EMP 테이블에서 전체연봉순위가 1등부터 5등까지..
-- 사원명, 부서번호, 연봉 전체연봉순위 항목으로 조회 

SELECT T.*
FROM (
    SELECT ENAME 사원명, DEPTNO 부서번호, SAL*12 + NVL(COMM,0) 연봉
    , DENSE_RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) 전체연봉순위
    FROM EMP
    
)T 
WHERE 전체연봉순위 < 6;

SELECT T.*
FROM (
    SELECT ENAME 사원명, DEPTNO 부서번호, SAL*12 + NVL(COMM,0) 연봉
    , DENSE_RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) 전체연봉순위
    FROM EMP
)T 
WHERE 전체연봉순위 <= 5;
--에러발생(서브 쿼리를 안만들고 했을 경우에 오류가 뜸)

-- 위 내용의 RANK() OVER() 함수를 WHERE 조건절에서 사용한 경우이며
-- 이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러임
-- 이 경우, 우리는 INLINE VIEW를 활용하여 풀이해야 함 

/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	3
BLAKE	30	34200	4
CLARK	10	29400	5
*/

-- EMP 테이블에서 각 부서별로 연봉 등수가 1등부터 2등 까지만 조회 
-- 사원명, 부서번호, 부서내연봉등수, 전체연봉등수 항목을 
-- 조회할 수 있도록 쿼리문 구성

SELECT T.*
FROM (
    SELECT ENAME 사원명, DEPTNO 부서번호, SAL*12 + NVL(COMM,0) 연봉
        , RANK() OVER(ORDER BY SAL*12 + NVL(COMM,0) DESC) 전체연봉순위
        , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12 + NVL(COMM,0) DESC) 부서별연봉순위
    FROM EMP
)T
WHERE 부서별연봉순위 <=2;

/*
KING	10	60000	1	1
CLARK	10	29400	6	2
FORD	20	36000	2	1
SCOTT	20	36000	2	1
BLAKE	30	34200	5	1
ALLEN	30	19500	7	2
*/

-- 정정 
-- LN() 자연 로그 존재함
SELECT LN(95) COL1
FROM DUAL;
-- 4.55387689160054083460978676511404117675 

-- ㅇ 추가
-- TRIM()
SELECT TRIM('            TEST                  ') COL1
     , LTRIM('           TEST                         ') COL2
     , RTRIM('                 TEST                   ') COL3
FROM DUAL;
/*
TEST	TEST                         	                 TEST
*/

--- 그룹 함수 ---
-- SUM 합, AVG() 평균, COUNT() 카운트, MAX() 최대값, MIN() 최소값
-- , VARIENCE() 분산, STDDEV() 표준편차

-- 그룹 함수의 가장 큰 특징 
-- 처리해야 할 데이터들 중 NULL이 존재한다면(포함되어 있다면)
-- 이 NULL은 제외한 상태로 연산을 수행한다는 것 
-- 즉, NULL은 연산의 대상에서 제외함

-- ㅇ SUM() 합
-- EMP 테이블을 대상으로 전체 사원들의 급여 총 합을 조회함 
SELECT SAL
FROM EMP;
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/

SELECT SUM(SAL) -- 모든 급여의 합
FROM EMP;
-- 29025

SELECT COMM
FROM EMP;
/*

300
500

1400




0




*/
SELECT SUM(COMM) -- NULL + 300 + 500 + NULL + ... + NULL => 이건 아님(연산 대상에서 제외하고 다 더한 값임)
FROM EMP;
-- 2200

-- ㅇ COUNT() 행(레코드)의 갯수 조회 -> 데이터가 몇 건인지.. 확인 
SELECT COUNT(ENAME)
FROM EMP;
-- 14

SELECT COUNT(COMM)
FROM EMP;
-- 4

SELECT COUNT(*)
FROM EMP;
-- 14

-- ㅇ AVG() 평균 반환
SELECT AVG(SAL) COL1
      , SUM(SAL) / COUNT(SAL) COL2
      , 29025 / 14 COL3
FROM EMP;
-- 2073.214285714285714285714285714285714286	
-- 2073.214285714285714285714285714285714286
-- 2073.214285714285714285714285714285714286

SELECT AVG(COMM) COL1
     , SUM(COMM) / COUNT(COMM) COL2
     , 2200 / 4 COL3
     , 2200 / 14
FROM EMP;
-- 550
-- 550
-- 550	
-- 157.142857142857142857142857142857142857

-- 데이터가 NULL인 컬럼의 레코드는 연산 대상에서 제외되기 때문에
-- 주의하여 연산 처리해야함 

SELECT SUM(COMM) / COUNT(*) COL1
FROM EMP;
-- 157.142857142857142857142857142857142857

-- VARIANCE() / STDDEV()
-- 분산과 표준편차
-- 표준편차의 제곱이 분산, 분산의 제곱근이 표준편차

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--> 1398313.87362637362637362637362637362637
--> 1182.503223516271699458653359613061928508

SELECT POWER(STDDEV(SAL),2) COL1
    , VARIANCE(SAL) COL2
FROM EMP;
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

SELECT SQRT(VARIANCE(SAL)) COL1
    , STDDEV(SAL) COL2
FROM EMP;

/*
1182.503223516271699458653359613061928508
1182.503223516271699458653359613061928508
*/

-- MAX(), MIN()
-- 최대값 / 최소값
SELECT MAX(SAL) COL1
    , MIN(SAL)
FROM EMP;
-- 5000
-- 800

--주의
SELECT ENAME, SUM(SAL)
FROM EMP;
-- 에러발생
-- ORA-00937: not a single-group group function

SELECT ENAME
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL)
FROM EMP;
-- 에러발생
-- ORA-00937: not a single-group group function

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
/*
10	8750
20	10875
30	9400
*/

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;

/*
10	2450 ┐
10	5000 │10
10	1300 ┘
20	2975 ┐
20	3000 │
20	1100 │20
20	800  │
20	3000 ┘
30	1250 ┐
30	1500 │
30	1600 │30
30	950  │
30	2850 │
30	1250 ┘
*/

-- 기존 테이블 제거
DROP TABLE TBL_EMP;
-- Table TBL_EMP이(가) 삭제되었습니다.

-- 실습 테이블 다시 생성(복사)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
-- Table TBL_EMP이(가) 생성되었습니다.

DESC TBL_EMP;
/*

이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2)    

*/

-- ㅇ 실습 데이터 추가 입력
INSERT INTO TBL_EMP VALUES
(8001, '이윤수', 'CLERK', 7566, SYSDATE, 1500,10, NULL);
--1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '임하성', 'CLERK', 7566, SYSDATE, 2000,10, NULL);
--1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8003, '김민지', 'SALESMAN', 7698, SYSDATE, 1700,NULL, NULL);
--1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '정현욱', 'SALESMAN', 7698, SYSDATE, 2500 ,NULL, NULL);
--1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '박나영', 'SALESMAN', 7698, SYSDATE, 1000,NULL, NULL);
--1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
8001	이윤수	CLERK	    7566	2023-10-24	1500	        10	
8002	임하성	CLERK	    7566	2023-10-24	2000	        10	
8003	김민지	SALESMAN	7698	2023-10-24	1700		
8004	정현욱	SALESMAN	7698	2023-10-24	2500		
8005	박나영	SALESMAN	7698	2023-10-24	1000		
*/

-- 커밋
COMMIT;
-- 커밋 완료 

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
/*
20	800	
	1700	
	1000	
10	1300	
20	2975	
30	2850	
10	2450	
20	3000	
10	5000	
	2500	
20	1100	
30	950	
20	3000	
30	1250	1400
30	1250	500
30	1600	300
	1500	10
	2000	10
30	1500	0
*/

-- 오라클에서는 NULL을 가장 큰 값으로 간주함
-- (ORACLE 9I까지는 NULL을 가장 작은 값으로 간주했었음)
-- MSSQL은 NULL을 가장 작은 값으로 간주

-- ㅇ TBL_EMP 테이블을 대상으로 부서별 급여합 조회
-- 부서번호, 급여합 항목 조회 
SELECT DEPTNO 부서번호, SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
/*
10	8750
20	10875
30	9400
	8700
*/

SELECT DEPTNO 부서번호, SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700    -- 부서번호가 NULL인 사원들의 급여합
	37725   -- 모든부서 직원들의 급여합 
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);

/*
10	         8750
20	        10875
30	         9400
모든부서	29025
*/

-- EMP 테이블을 대상으로 위와 같이 조회되도록 쿼리문 작성

SELECT 
    CASE WHEN T.부서번호 IS NULL THEN '모든부서'
        ELSE TO_CHAR(T.부서번호)
    END DEPTNO
    , T.급여합
FROM 
(
    SELECT DEPTNO "부서번호", SUM(SAL) 급여합
    FROM TBL_EMP
    WHERE DEPTNO IS NOT NULL
    GROUP BY ROLLUP(DEPTNO)
)T;

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO),'모든부서') 부서번호, SUM(SAL) 급여합
FROM EMP
GROUP BY ROLLUP(DEPTNO);
-- ORA-01722: invalid number
-- 숫자타입이 아니라서 에러 발생
/*
10	8750
20	10875
30	9400
모든부서	29025
*/

SELECT NVL2(DEPTNO,TO_CHAR(DEPTNO),'모든부서') 부서번호, SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
모든부서	8700
모든부서	37725
*/

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700
	37725
*/

-- GROUPING()
SELECT GROUPING(DEPTNO), DEPTNO 부서번호, SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY DEPTNO;
/*
0	30	9400
0		8700
0	20	10875
0	10	8750
*/

SELECT GROUPING(DEPTNO), DEPTNO 부서번호, SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
0	10	8750
0	20	10875
0	30	9400
0		8700
1		37725
*/

-- 위에서 조회한 해당 내용을 
/*
10	8750
20	10875
30	9400
인턴	8700
모든부서	37725
이와 같이 조회되도록 쿼리문을 작성하기 
*/

-- NVL2(DEPTNO,TO_CHAR(DEPTNO),'모든부서')

-- 힌트
SELECT CASE WHEN GROUPING(DEPTNO) = 0 AND DEPTNO IS NULL THEN '인턴'
            WHEN GROUPING(DEPTNO) = 1 AND DEPTNO IS NULL THEN '모든부서'
            ELSE TO_CHAR(DEPTNO) 
         END "부서번호"
                             
        , SUM(SAL) 급여합
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
                             ELSE '모든부서'
                        END "부서번호"
        , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴')
                             ELSE '모든부서'
                        END "부서번호"
        , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10	8750
20	10875
30	9400
	8700
모든부서	37725
*/

-- ㅇ TBL_SAWON 테이블을 대승으로 다음과 같이 조회될 수 있도록 쿼리문 구성
/*
    성별      급여합
    남         XXX
    여        XXXXXX
모든사원      XXXXXX
*/

SELECT *
FROM TBL_SAWON;

SELECT NVL(T.성별,'모든인원') 성별, SUM(급여)
FROM (
    SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
                WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
                ELSE '확인불가'
            END "성별"
        ,SAL 급여
    FROM TBL_SAWON
)T 
GROUP BY ROLLUP(T.성별);

SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별       
                             ELSE '모든사원'
                        END 성별
        ,SUM(T.급여) 급여합
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(JUBUN,7,1) IN ('2','4') THEN '여자'
            ELSE '확인불가'
        END "성별"
          , SAL 급여
FROM TBL_SAWON
)T GROUP BY ROLLUP(T.성별);
/*
남자	    16800
여자	    20300
모든인원	37100
*/

--TBL_SAWON 테이블을 대상으로 다음과 같이 조회할 수 있도록 쿼리문 작성
/*
연령대     인원수
------------------
 10         XX
 20         XX
 50         XX
*/

-- SELECT T.나이, COUNT(T.나이) 인원수
SELECT NVL(T2.연령대,'전체나이') 나이 , COUNT(T2.연령대) 인원수
FROM (
    SELECT CASE SUBSTR(T.나이,1,1) WHEN '1' THEN '10대'
                                   WHEN '2' THEN '20대'
                                   WHEN '3' THEN '30대'
                                   WHEN '4' THEN '40대'
                                   WHEN '5' THEN '50대'
                                   ELSE '층정불가'
                            END 연령대
    FROM (      
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                  END "나이"
        FROM TBL_SAWON
    ) T 
)T2 
GROUP BY ROLLUP(T2.연령대);

SELECT NVL(T.나이,'연령대') COUNT(T.나이)
FROM (
SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
            ELSE -1
        END "나이"
    FROM TBL_SAWON
)T GROUP BY ROLLUP(T.나이);

-- 방법 1
SELECT NVL(T2.연령대,'전체나이') 나이 , COUNT(T2.연령대) 인원수
FROM (
    SELECT CASE SUBSTR(T.나이,1,1) WHEN '1' THEN '10대'
                                   WHEN '2' THEN '20대'
                                   WHEN '3' THEN '30대'
                                   WHEN '4' THEN '40대'
                                   WHEN '5' THEN '50대'
                                   ELSE '층정불가'
                            END 연령대
    FROM (      
        SELECT CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
                    WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)
                    ELSE -1
                  END "나이"
        FROM TBL_SAWON
    ) T 
)T2 
GROUP BY ROLLUP(T2.연령대);
/*
10대	4
20대	7
50대	4
전체나이	15
*/

-- 2번째 방법
-- 연령대
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대) 
                                ELSE '전체' END "연령대"
                                ,COUNT(*) 인원수
FROM(
SELECT TRUNC (CASE WHEN SUBSTR(JUBUN,7,1) IN ('1','2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1899)
            WHEN SUBSTR(JUBUN,7,1) IN ('3','4')  
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN,1,2)) + 1999)  -1) 
        END -1) "연령대"
FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);

/*
10대	4
20대	7
50대	4
전체나이	15
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1,2;
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	    1300    -- 10번 부서 CLERK 직종의 급여합
10	MANAGER	    2450    -- 10번 부서 MANAGER 직종의 급여합
10	PRESIDENT	5000    -- 10번 부서 PRESIDENT 직종의 급여합
10		        8750    -- 10번 부서 모든 직종의 급여합
20	ANALYST	    6000    -- 20번 부서 ANALYST 직종의 급여합
20	CLERK	    1900    -- 20번 부서 CLERK 직종의 급여합
20	MANAGER	    2975    -- 20번 부서 MANAGER 직종의 급여합
20		       10875    -- 20번 부서 모든 직종의 급여합
30	CLERK	     950    -- 30번 부서 CLERK 직종의 급여합
30	MANAGER	    2850    -- 30번 부서의 MANAGER 직종의 급여합
30	SALESMAN	5600    -- 30번 부서의 SALESMAN 직종의 급여합
30		        9400    -- 30번 부서의 모든 직종의 급여합
               29025    -- 모든 부서 모든 직종의 급여합
*/

-- CUBE() -> ROLLUP() 보다 더 자세한 결과를 반환받음
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
10		        8750
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
20		       10875
30	CLERK	    950
30	MANAGER	    2850
30	SALESMAN	5600
30		        9400
	ANALYST	    6000    -- 모든 부서 ANALYST 직좁의 급여합 -- 추가
	CLERK	    4150    -- 모든 부서 CLERK 직좁의 급여합 -- 추가
	MANAGER	    8275    -- 모든 부서 MANAGER 직좁의 급여합 -- 추가
	PRESIDENT	5000    -- 모든 부서 PRESIDENT 직좁의 급여합 -- 추가
	SALESMAN	5600    -- 모든 부서 SALESMAN 직좁의 급여합 -- 추가
               29025
*/

-- ㅇ ROLLUP() 과 CUBE()는 
-- 그룹을 묶어주는 방식이 다름(차이) 

--EX
-- ROLLUP(A,B,C)
-- -> (A,B,C) / (A,B) / (A) / ()
-- CUBE(A,B,C)
-- -> (A,B,C) / (A,B) / (A,C) / (B,C) / (A) / (B) / (C) / ()

--> 위의 과정(ROLLUP())은 묶음 방식이 다소 모자랄 때가 있고 
--> 아래 과정(CUBE())은 묵음 방식이 다소 지나칠 때가 있기 때문에
-- 다음과 같은 방식의 쿼리를 더 많이 사용하게 됨
-- 다음 작성하는 쿼리는 조회하고자 하는 그룹만 
-- "GROUPING SETS"를 이용하여ㅛ 선택적으로 묶어주는 방식

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
                             ELSE '전체부서'
            END 부서번호
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '전체직종' 
            END 직종
    ,SUM(SAL) 급여함
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1,2;
/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750

20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875

30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400

인턴	CLERK	3500
인턴	SALESMAN	5200
인턴	전체직종	8700

전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
                             ELSE '전체부서'
            END 부서번호
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '전체직종' 
            END 직종
    ,SUM(SAL) 급여함
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1,2;

/*
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750

20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875

30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400

인턴	CLERK	3500
인턴	SALESMAN	5200
인턴	전체직종	8700

전체부서	ANALYST	6000
전체부서	CLERK	7650
전체부서	MANAGER	8275
전체부서	PRESIDENT	5000
전체부서	SALESMAN	10800

전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
                             ELSE '전체부서'
            END 부서번호
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '전체직종' 
            END 직종
    ,SUM(SAL) 급여함
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB),())
ORDER BY 1,2;
/* CUBE와 같음
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400
인턴	CLERK	3500
인턴	SALESMAN	5200
인턴	전체직종	8700
전체부서	ANALYST	6000
전체부서	CLERK	7650
전체부서	MANAGER	8275
전체부서	PRESIDENT	5000
전체부서	SALESMAN	10800
전체부서	전체직종	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO),'인턴') 
                             ELSE '전체부서'
            END 부서번호
     , CASE GROUPING(JOB) WHEN 0 THEN JOB 
                          ELSE '전체직종' 
            END 직종
    ,SUM(SAL) 급여함
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO),())
ORDER BY 1,2;
/* ROLLUP과 같음
10	CLERK	1300
10	MANAGER	2450
10	PRESIDENT	5000
10	전체직종	8750
20	ANALYST	6000
20	CLERK	1900
20	MANAGER	2975
20	전체직종	10875
30	CLERK	950
30	MANAGER	2850
30	SALESMAN	5600
30	전체직종	9400
인턴	CLERK	3500
인턴	SALESMAN	5200
인턴	전체직종	8700
전체부서	전체직종	37725
*/

--------------------------------------------------------------------------------
--ㅇ TBL_EMP 테이블을 대상으로 입사년도별 인원수를 조회

SELECT NVL(TO_CHAR(T.입사일),'전체년도') 입사일, COUNT(*) 인원수
FROM (
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사일"
    FROM TBL_EMP
)T GROUP BY ROLLUP(T.입사일);
/*
1980	1
1981	10
1982	1
1987	2
2023	5
전체년도	19
*/
SELECT EXTRACT(YEAR FROM HIREDATE) "입사일", COUNT(*) 인원수
FROM TBL_EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY')
ORDER BY 1;
-- 에러발생
-- ORA-00979: not a GROUP BY expression

SELECT TO_CHAR(HIREDATE,'YYYY') "입사일", COUNT(*) 인원수
FROM TBL_EMP
GROUP BY EXTRACT(YEAR FROM HIREDATE)
ORDER BY 1;
-- 에러발생
-- ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING(TO_CHAR(HIREDATE,'YYYY')) WHEN 0 
            THEN TO_CHAR(HIREDATE,'YYYY')
            ELSE '전체' 
        END 입사년도
       ,COUNT(*) 인원수
FROM TBL_EMP
GROUP BY CUBE (TO_CHAR(HIREDATE,'YYYY'))
ORDER BY 1;

/*
1980	1
1981	10
1982	1
1987	2
2023	5
전체	19
*/