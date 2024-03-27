SELECT USER
FROM DUAL;
-- SCOTT

-- ㅇ  PL/SQL ㅇ--

--1. PL/SQL(Procedural Language extension to SQL)
-- 프로그래밍 언어의 특성을 가지는 SQL의 확장이며 
-- 데이터 조작과 질의 문장은 PL/SQL의 절차적 코드 안에 포함됨 
-- 또한, PL/SQL을 사용하면 SQL로 할 수 없는 절차적 작업이 가능함
-- 여기에서 "절차적" 이라는 단어가 가지는 의미는 어떤 것이 어떤 과정을 거쳐 어떻게 완료되는지
-- 그 방법을 정확하게 코드에 기술하는 것을 의미함

--2. PL/SQL은 절차적으로 표현하기 위해 변수를 산언할 수 있는 기능
-- 참과 거짓을 구별할 수 있는 기능
-- 실행 흐름을 컨트롤 할 수 있는 기능 등을 제공함 

--3. PL/SQL은 블럭 구조로 되어 있으며 블록은 선언 부분, 실행부분, 예외 처리 부분의 세 부분으로 구성 
-- 또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같음

--4. 형식 및 구조 
/*
[DECLARE]
-- 선언문(DECARATIONS)
BEGIN
    -- 실행문(STATEMENTS)
    
    [EXCEPTION]
    -- 예외 처리문(EXCEPTION HANDLERS)
END;
*/

-- 5. 변수 선언
/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
END;
*/

-- ㅇ 블럭(영역)을 잡아(선택하여) 실행

-- ㅇ "DBMS_OUTPUT.PUT_LINE()"을 통해 화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;
-- 작업이 완료되었습니다.

-- 변수에 임의의 값을 대입하고 출력하는 구문 작성 
DECLARE
    -- 선언부 
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- 실행부 
    --System.out.println(v1);
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.

/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 변수에 임의의 값을 대입하고 출력하는 구문 작성 
DECLARE
    --선언부
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 + 20; -- NUM1 = NUM1 + 20; -> NUM1 += 20;(오라클은 이런거 없음) 
    V2 := V2 || '정한올';  
    V3 := V3|| ' World!';
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO정한올
ORACLE World!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ㅇ IF문(조건문)
-- IF ~ END IF;

-- ㅇ IF문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL의 IF 문장은 다른 언어의 IF 조건문과 거의 유사함 
-- 일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 함 
-- TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고 
-- FALSE 나 NULL이면 ELSE 와 END IF; 사이의 문장을 수행하게 됨 

-- 2. 형식 및 구조 
/*
IF 조건 
    THEN 처리문;
END IF;
*/

/*
IF 조건
    THEN 처리문;
ELSE 
    처리문;
END IF;
*/

/*
IF 조건 
    THEN 처리문;
ELSIF
    THEN 처리문;
ELSIF 
    THEN 처리문;
ELSIF
    THEN 처리문;
END IF
*/

-- ㅇ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
 -- GRADE   NUMBER -- 최대 값
    GRADE   CHAR; -- 최소 값 (한 글자만 담을 수 있음)
BEGIN
    GRADE := 'B';
    
    -- DBMS_OUTPUT.PUT_LINE(GRADE);
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FALSE');
    END IF;
END;
/*
FALSE


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


DECLARE
 -- GRADE   NUMBER -- 최대 값
    GRADE   CHAR; -- 최소 값 (한 글자만 담을 수 있음)
BEGIN
    GRADE := 'B';
    
    -- DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FALSE');
    END IF;
END;
/*
BEST


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
 -- GRADE   NUMBER -- 최대 값
    GRADE   CHAR; -- 최소 값 (한 글자만 담을 수 있음)
BEGIN
    GRADE := 'B';
    
    -- DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('GOOD');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('FALSE');
    END IF;
END;
/*
BEST


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ㅇ CASE문 (조건문)

-- CASE문 (조건문)

-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조 
/*
CASE 변수 
     WHEN 값1 THEN 실행문;
     WHEN 값2 THEN 실행문;
     ELSE 실행문;
END CASE;
*/

ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    -- 선언부
    -- (주요 변수 선언)
    SEL NUMBER := &NUM;
    RESULT VARCHAR2(20) := '확인불가';
BEGIN
    -- 실행부
    -- (테스트)
   -- DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
   -- DBMS_OUTPUT.PUT_LINE('RESULT : '  || RESULT);
   
   -- (연산 및 처리)
   /*
   CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('확인불가');
   END CASE;
   */
   CASE SEL
        WHEN 1 THEN RESULT := '남자';
        WHEN 2 THEN RESULT := '여자';
        ELSE 
            RESULT := '확인불가';
   END CASE;
   
   -- (결과 출력)
   DBMS_OUTPUT.PUT_LINE('처리결과는 ' || RESULT || ' 입니당');
END;
/*
여자입니다.


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

/*
처리결과는 남자 입니당


PL/SQL 프로시저가 성공적으로 완료되었습니다.

*/

-- ㅇ 외부 입력 처리 
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때 
-- "&외부변수명" 형태로 접근하게 됨

-- ㅇ 임의의 정수 2개를 외부로부터 (사용자로부터) 입력받아
-- 이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성함 
-- 실행 예)
-- 첫 번째 정수를 입력하세요 -> 10
-- 두 번째 정수를 입력하세요 -> 20
--> 10 + 20 = 30

ACCEPT NUM PROMPT '첫 번째 정수를 입력하세요';
ACCEPT NUM2 PROMPT '두 번째 정수를 입력하세요';

DECLARE
    A NUMBER := &NUM;
    B NUMBER := &NUM2; 
    TOTAL NUMBER := 0;
    
    SUM1 NUMBER := A + B;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(A ||'+'|| B ||'='|| SUM1);
    
    -- 테스트 
    DBMS_OUTPUT.PUT_LINE(A);
    DBMS_OUTPUT.PUT_LINE(B);
    DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

-- 사용자로부터 입력받은 급여를 화폐단위로 구분하여 출력하는 프로그램을 작성
-- 단 입력에 대한 반환 금액은 편의상 1천만원, 10원 이상만 가능하다고 가정

-- 입력 받은 금액 990
-- 화폐 오백원 1 백원 4 오십원 1 십원 4

ACCEPT NUM PROMPT '금액을 입력하세요 : '
DECLARE

    NUM NUMBER := &NUM;
    
    A NUMBER := 0; -- 500
    B NUMBER := 0; -- 100
    C NUMBER := 0; -- 50
    D NUMBER := 0; -- 10
    
    -- 650 = 500 100 50
BEGIN

    IF NUM > 500 
        THEN A := TRUNC(NUM / 500); 
    END IF;

    IF NUM > 100
        THEN B := TRUNC((NUM - (500*A))/100);
    END IF;
    
    IF NUM > 50
        THEN C := TRUNC((NUM - ((500*A)+(100*B)))/50);
    END IF;
    
    IF NUM > 10
        THEN D := TRUNC((NUM - ((500*A)+(100*B)+(50*C)))/10);
    END IF;
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('화페 : '||NUM );
    DBMS_OUTPUT.PUT_LINE('500원 :'|| A ||'개 '|| '100원 : '|| B ||'개 '||'50원 : '||C ||'개 '||'10원 : '|| D||'개 ');
END;

------------------------------------------------------------------------------------------------------------------------

ACCEPT INPUT PROMPT '금액을 입력하세요 : '
DECLARE
    
-- 주요 변수 선언 
    MONEY NUMBER := &INPUT;     -- 연산을 위해 입력값을 담아둘 변수
    MONEY2 NUMBER := &INPUT;    -- 결과 출력을 위해 입력값을 담아둘 변수
                                -- (MONEY 변수가 연산을 처리하는 과정에서 값이 변하기 때문)

    M500 NUMBER; -- 500     -- 500원 짜리 개수를 담아둘 변수
    M100 NUMBER; -- 100     -- 100원 짜리 개수를 담아둘 변수
    M50 NUMBER; -- 50       -- 50원 짜리 개수를 담아둘 변수
    M10 NUMBER; -- 10       -- 10원 짜리 개수를 담아둘 변수

BEGIN  
    -- 연산 및 처리 
    
    -- MONEY를 500으로 나눠서 몫을 취하고 나머지는 버림 -- 500원 개수 
    -- MONEY를 500으로 나눠서 몫은 버리고 나머지는 취함 -- 500원 개수 확인하고 남은 금액이 금액으로 MONEY를 갱신
    M500 := TRUNC(MONEY/500);
    MONEY := MOD(MONEY,500);

    -- MONEY를 100으로 나눠서 몫을 취하고 나머지는 버림 -- 100원 개수
    -- MONEY를 100원으로 나눠서 몫은 버리고 나머지를 취함 -- 100원의 개수를 확인하고 남은 금액이 금액으로 MONEY를 갱신 
    M100 := TRUNC(MONEY/100);
     MONEY := MOD(MONEY,100);
    
    -- MONEY를 50으로 나눠서 몫은 취하고 나머지는 버림 -- 50원 개수 
    -- MONEY를 50으로 나눠서 몫은 버리고 나머지를 취함 -- 50원의 개수를 확인하고 남은 금액이 금액으로 MONEY를 갱신
     M50 := TRUNC(MONEY/50);
     MONEY := MOD(MONEY,50);
    
    -- MONEY를 10으로 나눠서 몫을 취하고 나머지는 버림 -- 10원의 개수 
     M10 := TRUNC(MONEY/10);
    
    -- 결과 출력 
    -- 취합된 결과(화폐 단위별 개수)를 형식에맞게 최종 출력함

--    DBMS_OUTPUT.OUT_LINE(MONEY);
    
    DBMS_OUTPUT.PUT_LINE('화페 : '||MONEY2 );
    DBMS_OUTPUT.PUT_LINE('500원 :'|| M500 ||'개 '|| '100원 : '||M100 ||'개 '||'50원 : '||M50 ||'개 '||'10원 : '|| M10||'개 ');

END;
/*
화페 : 660
500원 :1개 100원 : 1개 50원 : 1개 10원 : 1개 


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 기본 반복문 
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문

-- 2. 형식 및 구조 

/*
LOOP
    -- 실행문 
    
    EXIT WHEN 조건; -- 조건이 참인 경우 반복문을 빠져나감 

END LOOP;
*/

-- 1부터 10까지의 수 출력(LOOP문 활용)
DECLARE 
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N>=10;
        
        N := N + 1;
        
    END LOOP;
    
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- WHILE 반복문 
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE인 동안 일련의 문장을 반복하기 위해 
-- WHILE LOOP 구문을 사용함 
-- 조건은 반복이 시작되는 시점에 체크하게 되어 LOOP 내의 문장이 한 번도 수행하지 않을 경우도 있음 
-- LOOP를 시작할 때 조건이 FALSE이면, 반복 문장을 탈출하게 됨 

-- 2. 형식 및 구조 
/*
WHILE 조건 LOOP -- 조건이 참인 경우 반복 수행 
    -- 실행문;
END LOOP
*/

-- 1부터 10까지의 수 출력(WHILE LOOP문 활용)

DECLARE
    N NUMBER := 1;
BEGIN 
    
    WHILE N <= 10 LOOP 
        
        DBMS_OUTPUT.PUT_LINE(N);
        
        N := N+1;
        
    END LOOP;
    
END;

/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ㅇ FOR 반복문 
-- FOR LOOP ~ END LOOP;

-- 1. "시작수"에서 1씩 증가하여 "끝냄수"가 될 때까지 반복 수행
-- "끝냄수"가 될 때까지 반복 수행함 

--2. 형식 및 구조 
/*
FOR 카운터 IN [REVERSE] 시작수.. 끝냄수 LOOP
    -- 실행문;
END LOOP;
*/

DECLARE
    N NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
    DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- 사용자로부터 임의의 단(구구단)을 입력받아
-- 해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성함 

--1. LOOP 문의 경우
ACCEPT INPUT PROMPT '원하는 숫자를 입력하세요 : '
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER := 1;
BEGIN
    
    LOOP     
    
        DBMS_OUTPUT.PUT_LINE(NUM ||'*'|| N || '='|| NUM * N);
        
        N := N+1;
        
        EXIT WHEN N>=10;
        
    END LOOP;
    
END;

--2. WHILE LOOP의 경우
ACCEPT INPUT PROMPT '원하는 숫자를 입력하세요 : '
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER := 1;
BEGIN
    
    WHILE N<10 LOOP 
    
         DBMS_OUTPUT.PUT_LINE(NUM ||'*'|| N || '='|| NUM * N);
         
         N := N+1;

    END LOOP;
    
END;
--3. FOR LOOP문의 경우 
ACCEPT INPUT PROMPT '원하는 숫자를 입력하세요'
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM ||'*'|| N || '='|| NUM * N);
    END LOOP;
END;

-- ㅇ 구구단 전체(2단 ~ 9단)를 출력하는 PL/SQL 구문을 작성함
-- 단, 이중 반복문(반복문의 중첩) 구문을 활용

/*
실행 예)
-- 2단 --
2 * 1 = 2
    :
    :
-- 3단 --
    :
    :
*/

-- 방법 1
DECLARE
    N NUMBER := 2;
    N2 NUMBER := 1;
BEGIN
    
    FOR N IN 2 .. 9 LOOP
             DBMS_OUTPUT.PUT_LINE('--'||N||'단'||'--');
        FOR N2 IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*'|| N2 || '='|| N * N2);
        END LOOP;
    END LOOP;
END;

--방법 2
DECLARE 
    N NUMBER := 1;
    N2 NUMBER :=2;
BEGIN
    WHILE N<9 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE('--'||N||'단'||'--');
        WHILE N2<10 LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*'|| N2 || '='|| N * N2);
            N2 := N2+1;
        END LOOP;
        N2 :=1;
    END LOOP;
END;

--방법 3
DECLARE 
    N NUMBER :=1;
    N2 NUMBER :=2;
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('--'||N||'단'||'--');

        LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*'|| N2 || '='|| N * N2);
             EXIT WHEN N2>=9;
              N2 := N2+1;
        END LOOP;
         N2 := 1;
         
         N := N+1;
         EXIT WHEN N>=10;

    END LOOP;
END;

    