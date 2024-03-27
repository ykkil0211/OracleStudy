SELECT USER
FROM DUAL;
--HR

-- 정규화 (Normalization) --

-- ㅇ 정규화란?
-- 한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해 
-- 어떤 하나의 테이블을 식별자를 가지는 여러 개의 테이블로 나누는 과정을 말함


-- ex) 윤수가 옥장판을 판매함
-- 고객리스트 -> 거래처 직원의 명단이 적혀있는 수첩의 정보를 데이터베이스화 하려고 함

-- 테이블명 : 거래처 직원 
/*
     100BYTE         100BYTE     100BYTE    100BYTE   100BYTE  100BYTE  100BYTE
    거래처 회사명     회사주소    회사전화  거래처직원명  직급   이메일   휴대폰
        LG          서울 여의도  02-345-6789   최혜인     부장   chi@na  010-23...
        LG          서울 여의도  02-345-6789   채다선     과장   cds@na  010-76...
        LG          서울 여의도  02-345-6789   정현욱     대리   chy@na  010-98...
        LG          서울 여의도  02-345-6789   정한올     부장   chw@na  010-39...
        SK          서울 소곡동  02-345-6789   임하성     부장   khs@na  010-11...
        LG          부산 동래구  051-221-2211  이주형     대리   lgh@na  010-55...
        SK          서울 소곡동  02-987-6543   오수경     과장   osk@na  010-88...


가정) 서울 여의도 LG(본사)라는 회사에 근무하는 거래처 직우너 명단이 100만 명이라고 가정 
(한 행(레코드)은 700BYTE

어느날 서울 여의도에 위치한 LG본사가 "경기 분당"으로 사옥을 이전하게 됨
회사주소는 "경기분당"으로 바뀌고, 회사전화는 031-111-2222로 바뀌게 됨

그러면 100만 명의 회사주소와 회사전화를 변경 

이때 수행되어야 할 쿼리문 

UPDATE 거래처직원 
SET 회사주소 = '경기분당', 회사전화번호 = '031-111-2222'
WHERE 거래처회사원 = 'LG' AND 회사주소 = '서울 여의도';

100만개 행을 하드디스크상에서 읽어다가 메모리에 로드시켜 주어야함 
즉 100만 * 70BYTE를 모두 하드 디스크상에서 읽어다가 메모리에 로드시켜 주어야함

-> 이는 테이블의 설계가 잘못되었으므로 
DB 서버는 조만간 메모리 고갈로 인해 DOWN 될 것 

-> 그러므로 정규화 과정을 수행해야함 
*/ 


-- 제 1 정규형
--> 어떤 하나의 테이블에 반복되는 컬럼 값들이 존재한다면
-- 값들이 반복되어 나오는 컬럼을 분리하여 새로운 테이블을 만듦
/*
-- 테이블명 : 회사 --> 부모 테이블 (참조 받는 테이블)
   --------------------------------------------------------
    회사ID    거래처 회사명     회사주소    회사전화  
   --------------------------------------------------------
     10        LG          서울 여의도  02-345-6789     
     20        SK          서울 소곡동  02-987-6543  
     30        LG          부산 동래구  051-221-2211  
   --------------------------------------------------------
   
    ------------------------------------------------------
    회사ID    거래처 회사명     회사주소    회사전화
++++++                                        
참조받는 컬럼
     10        LG          서울 여의도  02-345-6789     
     20        SK          서울 소곡동  02-987-6543  
     30        LG          부산 동래구  051-221-2211  
    ------------------------------------------------------


-- 테이블명 : 직원 -> 자식 테이블 ( 참조하는 테이블)


    ------------------------------------------------------
    거래처 직원명  직급   이메일   휴대폰      회사ID
                                                =====
                                            참조GK는 컬럼
    ------------------------------------------------------
        최혜인     부장   chi@na  010-23...      10
        채다선     과장   cds@na  010-76...      10
        정현욱     대리   chy@na  010-98...      10
        정한올     부장   chw@na  010-39...      10
        임하성     부장   khs@na  010-11...      20
        이주형     대리   lgh@na  010-55...      30
        오수경     과장   osk@na  010-88...      20
                            :
    ------------------------------------------------------
*/
--> 제 1 정규화를 수행하는 과정에서 분리된 테이블은 반드시 부모 테이블과
-- 자식 테이블의 관계를 갖게 됨

--> 부모 테이블 -> 참조받는 컬럼 -> PRIMARY KEY(기본기, 고유키)
--> 자식 테이블 -> 참조하는 컬럼 -> FOREIGN KEY(외래키, 참조키)

-- ㅇ 참조 받는 컬림이 갖는 특징 
-- 반드시 고유한 값(데이터)만이 들어와야 됨
-- 즉, 중복값(데이터)가 없어야 함
-- 또한, 비어있으면(NULL이 있어서는 안됨)
-- 즉, NOT NULL이 있어야 함 

--> 1 정규형을 수행하는 과정에서 부모 테이블의 PRIMARY KEY는 항상
-- 자식 테이블의 FOREIGN KEY로 전이됨

-- 테이블이 분리(분할)되기 이전 상태로 조회

/*
SELECT A.거래처회사명,A.회사주소,A.회사전화
      ,B.거래처직원명,B.직급,B이메일,B.휴대폰
FROM 회사 A,직원 B
WHERE A.회사ID = B.회사ID;
*/

/*
    가정) 서울 여의도 LG(본사)라는 회사에 근무하는 거래처 직우너 명단이 100만 명이라고 가정 
    (한 행(레코드)은 700BYTE
    
    어느날 서울 여의도에 위치한 LG본사가 "경기 분당"으로 사옥을 이전하게 됨
    회사주소는 "경기분당"으로 바뀌고, 회사전화는 031-111-2222 로 바뀌게 됨
    
    
    그러면 회사 테이블에서 1건의 회사주소와 회사 전화번호를 변경해야 함 
    
    이때 수행되어야 할 쿼리문 
    
    UPDATE 거래처직원 
    SET 회사주소 = '경기분당', 회사전화번호 = '031-111-2222'
    WHERE 거래처회사원 = 'LG' AND 회사주소 = '서울 여의도';
    
    100만개 행을 하드디스크상에서 읽어다가 메모리에 로드시켜 주어야함 
    즉 100만 * 70BYTE를 모두 하드 디스크상에서 읽어다가 메모리에 로드시켜 주어야함
    
    
    UPDATE 거래처직원 
    SET 회사주소 = '경기분당', 회사전화번호 = '031-111-2222'
    WHERE 거래처회사원 = 'LG' AND 회사주소 = '서울 여의도';
    
    바뀌면!
    
    UPDATE 회사 
    SET 회사 주소 =' 경기분당', 회사번호 = '031-111-2222'
    WHERE 거래처회사명 = 'LG'
        AND 회사주소 = '서울여의도';

    1개 행을 하드디스크상에서 읽어다가 메모리에 로드시켜 주어야함 
    즉, 1 * 400BYTE를 하드 디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말임 

    -> 정규화 이전에는 100만 건을 처리해야 할 업무에서 1건만 처리하면 되는 업무로 
    바뀐 상황이기 때문에 DB서버는 메모리 고갈이 일어나지 않고 아주 빠르게 처리될 것
    
-- 거래처회사명, 회사전화             |  SELECT 거래처회사명, 회사전화
SELECT 거래처회사명, 회사 전화        |  FROM 거래처직원
FROM 회사;                            | -> 200만 * 70Byte
--> 3 * 40 Byte  


-- 거래처직원명, 직급 

SELECT 거래처직원명, 직급           | SELECT 거래처직원명, 직급
FROM 직원;                          | FROM 거래처직원
--> 200만 * 50 Byte                 | -> 200만 * 70 Byte

-- 거래처회사명, 거래처직원명

SELECT 거래처회사명, 거래처직원명       | SELECT 거래처회사명, 거래처직원명
FROM 회사 A JOIN 직원 B                 | FROM 거래처직원
ON A.회사ID = B.회사.ID;                | 
--> (3*40 Byte) + (200만 * 50 Byte)      -> 200만 * 70 Byte
        
*/

-- 테이블명 : 주문 
/*
------------------------------------------------------------------------
      고객ID             제품코드            주문일자        주문수량
    ++++++++++++++++++++++++++++++++++++++++++++++++++
                            P.K 
------------------------------------------------------------------------
 UJY1234(엄재용)     P-KKBK(꿀꽈배기)  2023-10-30 07:20:31      20
 PBK8835(박범구)     P-KKBC(꼬북칩)    2023-10-30 07:21:31      20
 PNK3235(박나영)     P-KKDS(쿠크다스)  2023-10-30 08:10:10      13
 PKY5834(박가영)     P-SWKK(새우깡)    2023-10-30 09:07:04      12
                                :
                                :
---------------------------------------------------------------------
*/

-- ㅇ 하나의 테이블에 존재하는 PRIMARY KEY의 최대 개수는 1개임
-- 하지만 PRIMARY KEY를 이루는(구성하는) 컬럼의 개수는 복수(여러개)인 것이 가능함
-- 컬럼 1개로만 구성된 PRIMARY KEY를 SINGLE PRIMARY KEY라고 부름
-- (단일 개인키)
-- 두 개 이상의 컬럼으로 구성된 PRIMARY KEY를 COMPOSITE PRIMARY KEY라고 부름
-- (복합 개인키)

-- 제 2 정규형
--> 제 2 정규화를 마친 결과물에서 PRIMARY KEY가 SINGLE COLUMN이라면
-- 제 2 정규화는 수행하지 않음 
-- 하지만, PRIMARY KEY가 COMPOSITE COLUMN 이라면 반드시 제 2 정규형이 실행되어야 함 


--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야 하는데 
-- 식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
-- 이를 분리하여 새로운 테이블을 생성해 줌
-- 이 과정을 제 2 정규화 라고 함 

/*
-- 테이블명 : 과목 -> 부모테이블
--------------------------------------------------------------------------
 과목번호 과목명   교수번호  교수자명  강의실코드   강의실설명
 ++++++++          +++++++
           P.K
--------------------------------------------------------------------------
 J0101   자바기초     21     슈바이처   A301    전산실습관 3층 40석 규모
 J0102   자가중급     22     테슬라     T502    전자공학관 5층 60석 규모
 03188   오라클중급   22     테슬라     A301    전산실습관 3층 40석 규모
 03189   오라클심화   10     장영실     T502    전자공학관 5층 60석 규모
 J3345   JSP 응용     20     맥스웰     K101    인문과학관 1층 90석 규모
                            :
-------------------------------------------------------------------------
 
-- 테이블명 : 점수 -> 자식테이블 
--------------------------------------------------
과목번호      교수번호    학번            점수
======================
         F.K
++++++++                +++++++
            P.K
--------------------------------------------------
 03188          22    2308225(김동민)      92
 03188          22    2308227(김수환)      80
 03189          10    2308029(노은하)      92
                    :
--------------------------------------------------
*/


-- 제 3 정규형
-- 식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 의존적인 상황이라면 이를 분리하여
-- 새로운 테이블을 생성해 주어야하는데 이를 제 3 정규형이라고 함 


-- ㅇ 관계(Releation)의 종류 

-- 1 : 다(many) 
--> 제 1 정규화를 적용하여 수행을 마친 결과물에서 나타나는 바람직한 관계
-- 관계형 데이터베이스를 활용하는 과정에서 추구해야 하는 관계.

-- 1 : 1
--> 논리적, 물리적으로 존재할 수 잇는 관계이긴 하지만
-- 관계형 데이터베이스 설계 과정에서 가급적이면 피해야 할 관계


-- 다(many) : 다(many)
--> 논리적인 모델리에서는 존재할 수 있지만 
-- 실제 물리적인 모델링에서는 존재할 수 없는 관계
/*
-- 테이블명 : 고객                                                  - 테이블명 : 제품
--------------------------------------------------                  ---------------------------------------------------
고객번호   고객명    이메일        전화번호                          제품번호     제품명      제품단가    제품설명
--------------------------------------------------                  ---------------------------------------------------
 1001      강혜성    khs@test...   010-1....                          pswk        새우깡        500        새우가...
 1002      길현욱    khw@test...   010-2....                          pkjk        감자깡        700        감자를...
 1003      김경태    kkt@test...   010-3....                          pkkm        고구마깡      800        고구마를...
 1004      김다슬    kds@test...   010-4....                          pjkc        자갈치        400        자갈을...
                  :                                                                         :
-----------------------------------------------------               ---------------------------------------------------


                                            - 테이블명 : 주문접수(판매)
                                        ----------------------------------------------------------
                                        주문번호  고객번호   제품번호   주문일자    주문수량
                                           :
                                           25       1001      pjkc    2023-10-30..    20
                                           26       1002      pjkc    2023-10-30..    20
                                           27       1003      pkkm    2023-10-30..    10
                                           28       1003      pkkm    2023-10-30..    13
                                        ----------------------------------------------------------
*/
-- 제 4 정규형
--> 위에서 확인할 내용과 같이 "many"(다) : "many"(다) 관계를 
-- 1(일) : many(다) 관계로 깨뜨리는 과정이 바로 제 4 정규화 수행 과정임
-- 파생 테이블 생성 -> 다:다 관계를 1:다 관계로 깨뜨리는 역활 수행



-- 역정규형(비정규형)

-- A 경우 -> 

-- 테이블명 : 부서                       -- 테이블명 : 사원                                   +   
------------------------                 --------------------------------------------------   + --------
-- 부서번호 부서명 주소                   사원번호  사원명  직급   급여  입사일  부서번호         부서명
-------------------------                --------------------------------------------------   + ---------
-- 10개 레코드(행)                        1,000,000개 레코드(행)
-------------------------                ---------------------------------------------------  + ---------

-- 조회 결과물
-----------------------------
-- 부서명 사원명 직급 급여
-----------------------------

--> "부서" 테이블과 "사원" 테이블을 JOIN 했을 때의 크기 
-- (10 * 30Byte) + (1000000*60Byte) = 300 + 6000000 = 60000300Byte

--> "사원" 테이블을 역정규화 한 후 이 테이블만 읽었을때의 크기 
-- (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
-- 1000000 *

-- B 경우 -> 

-- 테이블명 : 부서                       -- 테이블명 : 사원                                   +   
------------------------                 --------------------------------------------------   + --------
-- 부서번호 부서명 주소                   사원번호  사원명  직급   급여  입사일  부서번호         부서명
-------------------------                --------------------------------------------------   + ---------
-- 500,000개 레코드(행)                        1,000,000개 레코드(행)
-------------------------                ---------------------------------------------------  + ---------

-- 조회 결과물
-----------------------------
-- 부서명 사원명 직급 급여
-----------------------------

--> "부서" 테이블과 "사원" 테이블을 JOIN 했을 때의 크기 
-- (500000 * 30Byte) + (1000000*60Byte) = 15000000 + 6000000 = 750000Byte

--> "사원" 테이블을 역정규화 한 후 이 테이블만 읽었을때의 크기 
-- (즉, 부서 테이블의 부서명 컬럼을 사원 테이블에 추가한 경우)
-- 1000000 * 70 Byte = 7000000Byte

------------------------------------------------------------------------------------------------------------------


-- ㅇ 참고 

/*
1. 관계 (realationship, relation)
  - 모든 엔트리(entry)는 단일값을 가짐
  - 각 열(colum)은 유일한 이름을 가지며 순서는 무의미함
  - 테이블은 모든 행(row == 튜플 == tuple)은 동일하지 않으며 순서는 무의미함
  
2. 속성(attribute)
  - 테이블의 열(colum)을 나타냄
  - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
  - 일반 파일(file)의 항목 (아이템 == item == 필드 == field)에 해당
  - 엔티티(entity)의 특성과 상태를 기술
  - 속성(attiribute)의 이름은 모두 달라야 함 
  
3. 튜플(tuple)
  - 테이블의 행(row == 엔티티 == entity)
  - 연관된 몇 개의 속성으로 구성
  - 개념 정보 단위
  - 일반 파일(file)의 레코드(record)에 해당함
  - 튜플 변수 (tuple variable)
    : 튜플(tuple)을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수
    
4. 도메인(domain)
  - 각 속성(attribute)이 가질 수 있도록 허용된 값들의 집합
  - 속성 명과 도메인 명이 반드시 동일할 필요는 없음.
  - 모든 릴레이션에서 모든 속성들의 도메인은 우너자적(atomic) 이어야 함
  - 원자적 도메인 : 도메인의 원소가 더 이상 나누어질 수 없는 단일체의 때를 나타냄
  
5. 릴레이션(relation)
  - 파일 시스템에서 파일과 같은 개념
  - 중복된 튜플(tuple == entity == 엔티티)를 포함하지 않음 -> 모두 상이함( 튜플의 유일성)
  - 릴레이션은 튜플 (tuple == entity == 엔티티)의 집합, 따라서 튜플의 순서는 무의미함
  - 속성(attirbute)간에는 순서가 없음 

*/

--------------------------------------------------------------------------------

-- ㅇ 무결성(Integrity) ㅇ -- 
/*
1. 무결성에는 개체 무결성(Entity Integrity)
              참조 무결성(Realation Integrity)
              도메인 무결성(Domain Intergrity)이 있음
2. 개체 무결성 (Entity Integrity)
    개체 무결성은 릴레이션에서 저장되는 튜플(tuple)의 유일성을 보장하기 위한 제약조건

3. 참조 무결성 (Realational Integrity)
    참조 무결성은 릴레이션 간의 데이터 일관성을 보장하기 위한 제약조건 
   
4. 도메인 무결성 (Domain Intergrity)
    도메인 무결성은 허용 가능한 값의 범위를 지정하기 위한 제약조건 
   
5. 제약조건의 종류 
   - primary key(PK:P) -> 기본키, 고유키, 식별키, 식별자
     해당 컬럼의 값은 반드시 존재해야 하며, 유일해야 함
     (not bull 과 unique가 결합된 형태)
   
   - froegin key(FK:F:R) -> 외래키, 외부키, 참조키
    해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와 일치하거나 NULL값을 가짐 
   
   - NOT NULL(NN:CK:C)
    해당 컬럼은 NULL을 포함할 수 없음 
    
   - CHECK(CK:C)
    해당 컬럼에 저장 가능한 데이터의 범위나 조건을 정함
*/

-----------------------------------------------------------------------------------------

-- ㅇ PRIMARY KEY ㅇ 

-- 1. 테이블에 대한 기본 키를 생성함 

-- 2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합임
--    기본 키는 테이블 당 하나만 존재
--    그러나 반드시 하나의 컬럼으로만 구성되는 것은 아님 
--    NULL 일 수 없고, 이미 테이블에 존재하고 있는 테이터를 다시 입력할 수 없도록 처리 (유일성)
--    UNIQUE INDEX가 오라클 내부적으로 자동으로 생성 

-- 3. 형식 및 구조 
--   ㅇ 컬럼 레벨의 형식
--    컬럼명 데이터 타입 [CONSTRAINT CONSTRINT명] PRIMARY KEY[(컬럼명,...)]

--   ㅇ 테이블 레벨의 형식
--      컬럼명 데이터 타입,
--      컬럼명 데이터 타입,
--      CONSTRAINT CONSTRING명 PRIMARY KEY(컬럼명, ...)
-- 4. CONSTRAINT 추가 시 CONSTRAINT명을 생략하면 
--   오라클 서버가 자동적으로 CONSTRINT명을 부여 
--   일반적으로 CONSTRIANT명은 "테이블_컬럼명_CONSTRAINT약자" 형식으로 기술

-- ㅇ PK 지정 실습(1. 컬럼 레벨의 형식)
--테이블 생성 
CREATE TABLE TBL_TEST1
(COL1 NUMBER(5) PRIMARY KEY
,COL2 VARCHAR2(30)
);
-- 
--Table TBL_TEST1이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;

DESC TBL_TEST1;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

-- 데이터 입력 
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'TEST');
-- 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST(COL1,COL2) VALUES(1,'TEST'); --> 에러발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1,'ABCD'); --> 에러발생 
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2,'TEST');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3,NULL);
INSERT INTO TBL_TEST1(COL1) VALUES(4);
INSERT INTO TBL_TEST1(COL1) VALUES(4); --> 에러 발생
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5,'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL,NULL); --> 에러발생
INSERT INTO TBL_TEST1(COL2) VALUES('ABCD'); --> 에러발생

-- 확인 
SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	TEST
3	
4	
5	ABCD
*/

--커밋
COMMIT;

DESC TBL_TEST1;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/

SELECT *
FROM USER_CONSTRAINTS;
/*
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	REG_ID_PK	    P	REGIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	REG_ID_PK		
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	COUNTRY_C_ID_PK		
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_CITY_NN	    C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_ID_PK	    P	LOCATIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	LOC_ID_PK		
HR	LOC_C_ID_FK	    R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_ID_PK	    P	DEPARTMENTS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	DEPT_ID_PK		
HR	DEPT_LOC_FK	    R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_ID_PK	    P	JOBS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JOB_ID_PK		
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMAIL_UK		
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMP_ID_PK		
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JHIST_EMP_ID_ST_DATE_PK		
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME			2014-05-29				
HR	SYS_C007015	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2023-10-30	HR	SYS_C007015		
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
-- HR	SYS_C007015	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2023-10-30	HR	SYS_C007015		

-- ㅇ 제약조건이 지정된 컬럼 확인(조회)

SELECT *
FROM USER_CONS_COLUMNS;
/*
HR	REGION_ID_NN	REGIONS	REGION_ID	
HR	REG_ID_PK	REGIONS	REGION_ID	1
HR	COUNTRY_ID_NN	COUNTRIES	COUNTRY_ID	
HR	COUNTRY_C_ID_PK	COUNTRIES	COUNTRY_ID	1
HR	COUNTR_REG_FK	COUNTRIES	REGION_ID	1
HR	LOC_ID_PK	LOCATIONS	LOCATION_ID	1
HR	LOC_CITY_NN	LOCATIONS	CITY	
HR	LOC_C_ID_FK	LOCATIONS	COUNTRY_ID	1
HR	DEPT_ID_PK	DEPARTMENTS	DEPARTMENT_ID	1
HR	DEPT_NAME_NN	DEPARTMENTS	DEPARTMENT_NAME	
HR	DEPT_MGR_FK	DEPARTMENTS	MANAGER_ID	1
HR	DEPT_LOC_FK	DEPARTMENTS	LOCATION_ID	1
HR	JOB_ID_PK	JOBS	JOB_ID	1
HR	JOB_TITLE_NN	JOBS	JOB_TITLE	
HR	EMP_EMP_ID_PK	EMPLOYEES	EMPLOYEE_ID	1
HR	EMP_LAST_NAME_NN	EMPLOYEES	LAST_NAME	
HR	EMP_EMAIL_NN	EMPLOYEES	EMAIL	
HR	EMP_EMAIL_UK	EMPLOYEES	EMAIL	1
HR	EMP_HIRE_DATE_NN	EMPLOYEES	HIRE_DATE	
HR	EMP_JOB_NN	EMPLOYEES	JOB_ID	
HR	EMP_JOB_FK	EMPLOYEES	JOB_ID	1
HR	EMP_SALARY_MIN	EMPLOYEES	SALARY	
HR	EMP_MANAGER_FK	EMPLOYEES	MANAGER_ID	1
HR	EMP_DEPT_FK	EMPLOYEES	DEPARTMENT_ID	1
HR	JHIST_EMPLOYEE_NN	JOB_HISTORY	EMPLOYEE_ID	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_EMP_FK	JOB_HISTORY	EMPLOYEE_ID	1
HR	JHIST_START_DATE_NN	JOB_HISTORY	START_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	START_DATE	
HR	JHIST_EMP_ID_ST_DATE_PK	JOB_HISTORY	START_DATE	2
HR	JHIST_END_DATE_NN	JOB_HISTORY	END_DATE	
HR	JHIST_DATE_INTERVAL	JOB_HISTORY	END_DATE	
HR	JHIST_JOB_NN	JOB_HISTORY	JOB_ID	
HR	JHIST_JOB_FK	JOB_HISTORY	JOB_ID	1
HR	JHIST_DEPT_FK	JOB_HISTORY	DEPARTMENT_ID	1
HR	SYS_C007015	TBL_TEST1	COL1	1
*/

SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';
-- HR	SYS_C007015	TBL_TEST1	COL1	1

-- ㅇ USER_CONSTRAINTS 와 USER_CONS_COLUMNS를 대상으로 제약조건이 설정된 내용에 대해서 
-- 제약조건이 설정된 내용에 대해서 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회 

SELECT A.OWNER, A.CONSTRAINT_NAME, A.TABLE_NAME, A.CONSTRAINT_TYPE,B.COLUMN_NAME
FROM USER_CONSTRAINTS A, USER_CONS_COLUMNS B
WHERE A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
AND A.TABLE_NAME = 'TBL_TEST1';
/*
HR	SYS_C007015	TBL_TEST1	P	COL1
*/

SELECT A.OWNER, A.CONSTRAINT_NAME, A.TABLE_NAME, A.CONSTRAINT_TYPE,B.COLUMN_NAME
FROM USER_CONSTRAINTS A JOIN USER_CONS_COLUMNS B
ON A.CONSTRAINT_NAME =  B.CONSTRAINT_NAME
 AND A.TABLE_NAME = 'TBL_TEST1';


-- ㅇ PK 지정 실습(2. 테이블 레벨 형식)
-- 테이블 생성 
CREATE TABLE TBL_TEST2
( COL1 NUMBER(5)        
, COL2 VARCHAR2(30)     
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);

SELECT *
FROM TBL_TEST2;
/*
1	TEST1
2	ABCD
3	
4	
5	ABCD
*/

INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1, 'TEST1');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1, 'TEST1'); --> 에러
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(1, 'ABCD'); -- 에러
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST2(COL1) VALUES(4);
INSERT INTO TBL_TEST2(COL1) VALUES(4);
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST2(COL1,COL2) VALUES(5, 'ABCD'); --> 에러발생

SELECT *
FROM TBL_TEST2;
/*
1	TEST1
2	ABCD
3	
4	
5	ABCD
*/

-- 커밋 
COMMIT;

SELECT A.OWNER, A.CONSTRAINT_NAME, A.TABLE_NAME, A.CONSTRAINT_TYPE,B.COLUMN_NAME
FROM USER_CONSTRAINTS A JOIN USER_CONS_COLUMNS B
ON A.CONSTRAINT_NAME =  B.CONSTRAINT_NAME
 AND A.TABLE_NAME = 'TBL_TEST2';
-- HR	TEST2_COL1_PK	TBL_TEST2	P	COL1 
 
-- ㅇ PK 지정 실습 (3. 다중 컬럼 PK 지정)
-- 테이블 생성 
CREATE TABLE TBL_TEST3
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1,COL2)
);

INSERT INTO TBL_TEST3(COL1,COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(1, 'TEST'); -- 에러 발생 
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(1, 'ABCD');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(2, 'TEST');
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(3, NULL); -- 에러 발생 
INSERT INTO TBL_TEST3(COL1,COL2) VALUES(NULL, 'TEST'); -- 에러 발생

-- 확인 
SELECT *
FROM TBL_TEST3;
/*
1	ABCD
1	TEST
2	ABCD
2	TEST
*/

--커밋
COMMIT;
-- 커밋완료

-- ㅇ USER_CONSTRAINTS 와 USER_CONS_COLUMNS를 대상으로 제약조건이 설정된 내용에 대해서 
-- 제약조건이 설정된 내용에 대해서 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회 
SELECT A.OWNER, A.CONSTRAINT_NAME, A.TABLE_NAME, A.CONSTRAINT_TYPE,B.COLUMN_NAME
FROM USER_CONSTRAINTS A JOIN USER_CONS_COLUMNS B
ON A.CONSTRAINT_NAME =  B.CONSTRAINT_NAME
 AND A.TABLE_NAME = 'TBL_TEST3';
/*
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL1
HR	TEST3_COL1_COL2_PK	TBL_TEST3	P	COL2
*/


-- ㅇ PK 지정 실습(4. 테이블 생성 이후 제약조건 추가 설정)
CREATE TABLE TBL_TEST4
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
);
-- Table TBL_TEST4이(가) 생성되었습니다.

-- 이미 생성된(만들어져 있는) 상태의 테이블에 
-- 부여하려는 제약조건을 위반한 데이터가 포함되어 있을 경우 
-- 해당 테이블에 제약조건을 추가하는 것은 불가능함 

-- 제약조건 추가 
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
-- Table TBL_TEST4이(가) 변경되었습니다.

-- ㅇ USER_CONSTRAINTS 와 USER_CONS_COLUMNS를 대상으로 제약조건이 설정된 내용에 대해서 
-- 제약조건이 설정된 내용에 대해서 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명 항목을 조회 
SELECT A.OWNER, A.CONSTRAINT_NAME, A.TABLE_NAME, A.CONSTRAINT_TYPE,B.COLUMN_NAME
FROM USER_CONSTRAINTS A JOIN USER_CONS_COLUMNS B
ON A.CONSTRAINT_NAME =  B.CONSTRAINT_NAME
 AND A.TABLE_NAME = 'TBL_TEST4';
-- HR	TEST4_COL1_PK	TBL_TEST4	P	COL1
 
-- ㅇ 제약조건 확인 전용 뷰(VIEW) 생성 
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER OWNER, UC.CONSTRAINT_NAME CONSTRAINT_NAME, UC.TABLE_NAME TABLE_NAME
    ,UC.CONSTRAINT_TYPE CONSTRAINT_TYPE, UCC.COLUMN_NAME COLUMN_NAME
    , UC.SEARCH_CONDITION SEARCH_CONDITION, UC.DELETE_RULE DELETE_RULE
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
-- View VIEW_CONSTCHECK이(가) 생성되었습니다.

-- ㅇ 생성된 뷰(VIEW)를 통한 제약조건 확인 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME ='TBL_TEST4';
-- HR	TEST4_COL1_PK	TBL_TEST4	P	COL1		

----------------------------------------------------------------------------------------------------

-- ㅇㅇ UNIQUE(UK:U) ㅇㅇ
-- 1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고 유일할 수 있도록 설정하는 제약조건
--      PRIMARY KEY와 유사한 제약조건이지만, NULL을 허용한다는 차이점이 있음
--      내부적으로 PRIMARY KEY와 마찬가지로 UNIQUE INDEX가 자동 생성
--      하나의 테이블 내에서 UNIQUE 제약조건은 여러 번 설정하는 것이 가능함 
--      즉, 하나의 테이블에 UNIQUE 제약조건을 여러 개 만드는 것이 가능하다는 것임

--2. 형식 및 구조 
--      1. 컬럼 레벨의 형식 
--          - 컬럼명 데이터 타입 [CONSTRAINT CONSTRAINT명] UNIQUE

--      2. 테이블 레벨의 형식
--          - 컬럼명 데이터 타입,
--          - 컬럼명 데이터 타입,
--          CONSTRAINT CONSTRAINT명 UNTQUE(컬럼명, ...)

-- UK 지정 실습 (1. 컬럼 레벨의 형식)

-- 테이블 생성 
CREATE TABLE TBL_TEST5
( COL1 NUMBER(5) PRIMARY KEY
, COL2 VARCHAR2(30) UNIQUE
);
--> Table TBL_TEST5이(가) 생성되었습니다.

-- 제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
/*
HR	SYS_C007020	TBL_TEST5	P	COL1		
HR	SYS_C007021	TBL_TEST5	U	COL2		
*/

-- 데이터 입력 
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1,'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1,'TEST'); -- 에러 발생 
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2,'ABCD');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3,'ABCD'); -- 에러 발생(UNIQUE)
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3,NULL);
INSERT INTO TBL_TEST5(COL1) VALUES(4);
INSERT INTO TBL_TEST5(COL1,COL2) VALUES(5,'ABCD'); -- 에러 발생(UNIQUE)

SELECT *
FROM TBL_TEST5;

--커밋
COMMIT;

-- UK 지정 실습 (2. 테이블 레벨의 형식)

CREATE TABLE TBL_TEST6
( COL1 NUMBER(5) 
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL1_UK UNIQUE(COL2)
);
-- Table TBL_TEST6이(가) 생성되었습니다.

-- 제약조건 확인 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL1_UK	TBL_TEST6	U	COL2		
*/

-- UK 지정 실습(3. 테이블 생성 이후 제약조건 추가)
-- 테이블 생성 
CREATE TABLE TBL_TEST7
( COL1 NUMBER(5) 
, COL2 VARCHAR2(30)
); 
--> Table TBL_TEST7이(가) 생성되었습니다.

SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
-- 조회 결과 없음 

-- 제약 조건 추가 
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
-- + 
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST_COL1_PK UNIQUE(COL2);

ALTER TABLE TBL_TEST7
ADD (CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    ,CONSTRAINT TEST_COL1_PK UNIQUE(COL2));
-- Table TBL_TEST7이(가) 변경되었습니다.

-- 제약 조건 추가 이후 다시 확인 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST_COL1_PK	TBL_TEST7	U	COL2		
*/
