SELECT USER
FROM DUAL;
-- SCOTT

-- 알아만두자...
DROP TABLE TBL_JUMUN PURGE;

DELETE TBL_JUMUN
WHERE DEPTNO = 50;

-- UNION / UNION ALL
-- 실습 테이블 생성(테이블명 : TBL_JUBUN)
CREATE TABLE TBL_JUMUN -- 주문 테이블 생성 
(  JUNO     NUMBER          -- 주문번호
 , JECODE   VARCHAR2(30)    -- 제품 코드 
 , JUSU     NUMBER          -- 주문수량
 , JUDAY    DATE DEFAULT SYSDATE   
);
-- Table TBL_JUMUN이(가) 생성되었습니다.
-- 고객의 주문이 발생되었을 경우 주문 내용에 대한
-- 데이터가 입력될 수 있도록 처리하는 테이블 

-- 실습 진행 간 제품 코드(JUCODE)에는
-- 편의상 제품의 코드를 참조한다고 가정하고 제품의 이픔을 입력한다 

INSERT INTO TBL_JUMUN
VALUES(1, '포스틱', 20, TO_DATE('2001-11-01 09:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(2, '빅파이', 10, TO_DATE('2001-11-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(3, '사또밥', 30, TO_DATE('2001-11-01 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(4, '포카칩', 20, TO_DATE('2001-11-02 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(5, '포카칩', 30, TO_DATE('2001-11-01 09:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(6, '빅파이', 20, TO_DATE('2001-11-04 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(7, '홈런볼', 10, TO_DATE('2001-11-05 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(8, '홈런볼', 10, TO_DATE('2001-11-05 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(9, '오예스', 20, TO_DATE('2001-11-07 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(10, '사또밥', 10, TO_DATE('2001-11-08 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(11, '빼빼로', 20, TO_DATE('2001-11-09 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(12, '감자깡', 10, TO_DATE('2001-11-10 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(13, '빼빼로', 20, TO_DATE('2001-11-11 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(14, '홈런볼', 20, TO_DATE('2001-11-12 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(15, '포카칩', 10, TO_DATE('2001-11-13 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(16, '포카칩', 20, TO_DATE('2001-11-16 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(17, '마이쮸', 20, TO_DATE('2001-11-17 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(18, '맛동산', 30, TO_DATE('2001-11-18 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(19, '맛동산', 20, TO_DATE('2001-11-19 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_JUMUN
VALUES(20, '꼬북칩', 30, TO_DATE('2001-11-20 11:10:10', 'YYYY-MM-DD HH24:MI:SS'));

SELECT *
FROM TBL_JUMUN;

-- ㅇ 커밋
COMMIT;

-- ㅇ 날짜에 대한 세션 설정 변경 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Session이(가) 변경되었습니다.

-- ㅇ 확인
SELECT *
FROM TBL_JUMUN;
/*
1	포스틱	20	2001-11-01 09:10:10
2	빅파이	10	2001-11-01 10:10:10
3	사또밥	30	2001-11-01 11:10:10
4	포카칩	20	2001-11-02 11:10:10
5	포카칩	30	2001-11-01 09:10:10
6	빅파이	20	2001-11-04 11:10:10
7	홈런볼	10	2001-11-05 11:10:10
8	홈런볼	10	2001-11-05 11:10:10
9	오예스	20	2001-11-07 11:10:10
10	사또밥	10	2001-11-08 11:10:10
11	빼빼로	20	2001-11-09 11:10:10
12	감자깡	10	2001-11-10 11:10:10
13	빼빼로	20	2001-11-11 11:10:10
14	홈런볼	20	2001-11-12 11:10:10
15	포카칩	10	2001-11-13 11:10:10
16	포카칩	20	2001-11-16 11:10:10
17	마이쮸	20	2001-11-17 11:10:10
18	맛동산	30	2001-11-18 11:10:10
19	맛동산	20	2001-11-19 11:10:10
20	꼬북칩	30	2001-11-20 11:10:10
*/

-- 추가 데이터 입력 -> 2001년부터 시작된 주문이 현재(2023)까지 계속 발생
INSERT INTO TBL_JUMUN VALUES(98764, '꼬북칩', 10 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98765, '빼빼로', 30 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98766, '빼빼로', 20 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98767, '에이스', 40 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98768, '홈런볼', 10 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98769, '감자깡', 20 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98770, '맛동산', 10 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98771, '웨하스', 20 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98772, '맛동산', 30 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98773, '오레오', 20 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98774, '빼빼로', 50 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_JUMUN VALUES(98775, '오감자', 10 , SYSDATE);
-- 1 행 이(가) 삽입되었습니다.

-- ㅇ 확인
SELECT *
FROM TBL_JUMUN;
/*
1	포스틱	20	2001-11-01 09:10:10
2	빅파이	10	2001-11-01 10:10:10
3	사또밥	30	2001-11-01 11:10:10
4	포카칩	20	2001-11-02 11:10:10
5	포카칩	30	2001-11-01 09:10:10
6	빅파이	20	2001-11-04 11:10:10
7	홈런볼	10	2001-11-05 11:10:10
8	홈런볼	10	2001-11-05 11:10:10
9	오예스	20	2001-11-07 11:10:10
10	사또밥	10	2001-11-08 11:10:10
11	빼빼로	20	2001-11-09 11:10:10
12	감자깡	10	2001-11-10 11:10:10
13	빼빼로	20	2001-11-11 11:10:10
14	홈런볼	20	2001-11-12 11:10:10
15	포카칩	10	2001-11-13 11:10:10
16	포카칩	20	2001-11-16 11:10:10
17	마이쮸	20	2001-11-17 11:10:10
18	맛동산	30	2001-11-18 11:10:10
19	맛동산	20	2001-11-19 11:10:10
20	꼬북칩	30	2001-11-20 11:10:10
                :
                :
98764	꼬북칩	10	2023-10-26 12:46:08
98765	빼빼로	30	2023-10-26 12:46:58
98766	빼빼로	20	2023-10-26 12:47:16
98767	에이스	40	2023-10-26 12:47:46
98768	홈런볼	10	2023-10-26 12:48:18
98769	감자깡	20	2023-10-26 12:48:36
98770	맛동산	10	2023-10-26 12:48:58
98771	웨하스	20	2023-10-26 12:49:18
98772	맛동산	30	2023-10-26 12:49:39
98773	오레오	20	2023-10-26 12:50:06
98774	빼빼로	50	2023-10-26 12:50:22
98775	오감자	10	2023-10-26 12:50:52
*/

-- ㅇ 현욱이가 과자 쇼핑몰 운영 중 
-- TBL_JUMUN 테이블이 무거워진 상황
-- 어플리케이션과의 연동으로 인해 주문 내역을
-- 앞으로는 다른 테이블에 저장될 수 있도록 만다느는 것은 거의 불가능함 
-- 기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황
-- -> 결과적으로.. 현재까지 누적된 주문 데이터 중 금일 발생한 
-- 주문 내역을 제외하고 나머지 데이터를 다른 테이블(TBL_JUMUNBACKUP)로 데이터를 이관하여 백업을 수행할 계획 

CREATE TABLE TBL_JUMUNBACKUP
AS 
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY,'YYYY-MM-DD') < TO_CHAR(SYSDATE,'YYYY-MM-DD');

SELECT *
FROM TBL_JUMUNBACKUP;
/*
1	포스틱	20	2001-11-01 09:10:10
2	빅파이	10	2001-11-01 10:10:10
3	사또밥	30	2001-11-01 11:10:10
4	포카칩	20	2001-11-02 11:10:10
5	포카칩	30	2001-11-01 09:10:10
6	빅파이	20	2001-11-04 11:10:10
7	홈런볼	10	2001-11-05 11:10:10
8	홈런볼	10	2001-11-05 11:10:10
9	오예스	20	2001-11-07 11:10:10
10	사또밥	10	2001-11-08 11:10:10
11	빼빼로	20	2001-11-09 11:10:10
12	감자깡	10	2001-11-10 11:10:10
13	빼빼로	20	2001-11-11 11:10:10
14	홈런볼	20	2001-11-12 11:10:10
15	포카칩	10	2001-11-13 11:10:10
16	포카칩	20	2001-11-16 11:10:10
17	마이쮸	20	2001-11-17 11:10:10
18	맛동산	30	2001-11-18 11:10:10
19	맛동산	20	2001-11-19 11:10:10
20	꼬북칩	30	2001-11-20 11:10:10
*/

--------------------------------------------------------------------------------
CREATE TABLE TBL_JUMUNBACKUP
AS 
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
-- TABLE TBL_JUNUNBACKUP이(가) 생성되었습니다.

SELECT *
FROM TBL_JUMUNBACKUP;
--> TBL_JUMUN 테이블의 데이터들 중 금일 주문 내역 이외의 데이터는 
-- 모두 TBL_JUMUNBACKUP 테이블에 백업을 모두 마친 상태

-- TBL_JUMUN 테이블의 데이터들 중 
-- 백업을 마친 데이터들 즉 금일 발생한 주문 내역이 아닌 데이터들 제거 

DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
-- 20개 행 이(가) 삭제되었습니다.

-- 확인 
SELECT *
FROM TBL_JUMUN;
/*
98764	꼬북칩	10	2023-10-26 12:46:08
98765	빼빼로	30	2023-10-26 12:46:58
98766	빼빼로	20	2023-10-26 12:47:16
98767	에이스	40	2023-10-26 12:47:46
98768	홈런볼	10	2023-10-26 12:48:18
98769	감자깡	20	2023-10-26 12:48:36
98770	맛동산	10	2023-10-26 12:48:58
98771	웨하스	20	2023-10-26 12:49:18
98772	맛동산	30	2023-10-26 12:49:39
98773	오레오	20	2023-10-26 12:50:06
98774	빼빼로	50	2023-10-26 12:50:22
98775	오감자	10	2023-10-26 12:50:52
*/

-- 커밋
COMMIT;
-- 커밋 완료 

-- 아직 제품 발송이 이루어지지 않은 금일 주문 데이터를 제외하고 
-- 이전의 모든 주문 데이터들이 삭제된 상황이므로 
-- 테이블은 행(레코드)의 갯숙다 줄어들어 매우 가벼워진 상태임 

-- 그런데, 지금까지 주문받은 내역에 대한 정보를 제품별 총 주문량으로 
-- 나타내어야 할 상황이 발생하게 되었음 
-- 그렇다면, TBL_JUMUNBACKUP 테이블의 레코드(행)와 TBL_JUMUN 테이블의 레코드(행)를 
-- 모두 합쳐 하나의 테이블을 조회 하는것과 같은 결과를 확인할 수 있도록 조화가 이루어져야 함

-- 컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우 
-- JOIN을 사용하지만 레코드와 레코드를 결합하고자 할 때 UNION / NUION ALL을 사용하고 있음 

SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

-------------------------------------------

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

-- UNION은 항상 결과물의 첫 번째 컬럼을 기준으로 
-- 오름차순 정렬을 수행함 
-- 반면, UNION ALL은 결합된 순서(쿼리문에서 테이블을 명시한 순서)대로 
-- 조회한 결과를 있는 그대로 반환함( -> 정렬 없음)
-- 이로 인해 UNION이 부화가 더 큼 ( -> 리소스 소모가 더 큼)
-- 또한, UNION은 결과물에 대한 중복된 레코드(행)가 존재할 경우
-- 중복을 제거하고 1개 행만 조회된 결과를 반환하게 됨 

-- ㅇ 지금까지 주문받은 데이터를 통해 
-- 제품별 총 주문량을 조회 할 수 있는 쿼리를 구성함 

SELECT T.JECODE, SUM(T.JUSU)
FROM
(
    SELECT *
    FROM TBL_JUMUN 
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP 
)T GROUP BY JECODE
ORDER BY 2;

-- ㅇ INTERSECT / MINUS(교집합/차집합)

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서 
-- 제품코드와 주문수량의 값이 똑같은 행만 추출해서 조회하고자 함 
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE, JUSU
FROM TBL_JUMUN;
/*
맛동산	30
빼빼로	20
홈런볼	10
*/
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
MINUS
SELECT JECODE, JUSU
FROM TBL_JUMUN;
/*
감자깡	10
꼬북칩	30
마이쮸	20
맛동산	20
빅파이	10
빅파이	20
사또밥	10
사또밥	30
오예스	20
포스틱	20
포카칩	10
포카칩	20
포카칩	30
홈런볼	20
*/

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로 
-- 제품코드와 주문량의 값이 똑같은 행의 정보를 
-- 주문번호, 제품코드, 주문량, 주문일자 항목으로 조회 

SELECT T.*
FROM(
SELECT JECODE, JUSU,JUNO,JUDAY
FROM TBL_JUMUNBACKUP
INTERSECT 
SELECT JECODE, JUSU,JUNO,JUDAY
FROM TBL_JUMUN
)T;

-- 방법 1
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1 WHERE (T1.JECODE,T1.JUSU) IN ( SELECT JECODE, JUSU
                                     FROM TBL_JUMUN
                                     INTERSECT
                                     SELECT JECODE, JUSU
                                     FROM TBL_JUMUNBACKUP);
                
-- 방법 2           
SELECT T1.*
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T1 JOIN (  SELECT JECODE, JUSU
             FROM TBL_JUMUN
             INTERSECT
             SELECT JECODE, JUSU
             FROM TBL_JUMUNBACKUP) T2 ON T1.JECODE = T2.JECODE AND T1.JUSU = T2.JUSU;
             
----------------------------------------------------------------------------------------

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	WARD	1250
30	SALES	TURNER	1500
30	SALES	ALLEN	1600
30	SALES	JAMES	950
30	SALES	BLAKE	2850
30	SALES	MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D;
-- 에러 발생
-- ORA-00905: missing keyword

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E NATURAL JOIN DEPT D;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP E JOIN DEPT D USING (DEPTNO);

/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	WARD	1250
30	SALES	TURNER	1500
30	SALES	ALLEN	1600
30	SALES	JAMES	950
30	SALES	BLAKE	2850
30	SALES	MARTIN	1250
*/

-------------------------------------------------------------------------------

-- ㅇ TBL_EMP 테이블에서 급여가 가장 많은 사원의 사원번호, 사원명, 직종명
-- 급여 항목을 조회함 

SELECT *
FROM EMP;

SELECT *
FROM DEPT;

SELECT T.사원번호,T.이름, T.직종명, T.월급
FROM (
    SELECT EMPNO 사원번호, JOB 직종명, SAL 월급,ENAME 이름
        ,RANK() OVER (ORDER BY SAL DESC) 순위
    FROM TBL_EMP
)T WHERE T.순위 = 1;

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM TBL_EMP);
--> 7839	KING	PRESIDENT	5000

-- ANY 

-- =ALL
SELECT SAL
FROM TBL_EMP;
--> 
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
1500
2000
1700
2500
1000
*/

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = ANY(800,1600,1250,2975,1250,2850,2450,3000,5000
            ,1500,1100,950,3000,1300,1500,2000,1700,2500,1000);

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(SELECT SAL 
                 FROM TBL_EMP);
-- 모든 아이들이 같은걸 찾겠다는 의미 
S
-- ㅇ TBL_EMP 테이블에서 20번 부서에 근무하는 사원들 중 급여가 가장 많은 사원의
-- 사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 작성 

SELECT EMPNO, DEPTNO ,ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL >= ALL (SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20);
                  
SELECT EMPNO, DEPTNO ,ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL = (SELECT MAX(SAL)
                           FROM TBL_EMP
                           WHERE DEPTNO = 20);
                  
SELECT *
FROM TBL_EMP
WHERE DEPTNO = 20;