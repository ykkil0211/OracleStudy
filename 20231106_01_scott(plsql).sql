SELECT USER
FROM DUAL;
-- SCOTT

-- ㅇ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
-- 프로시저를 작성함 
-- 단 ID와 PW가 일치하는 경우에만 수정을 진행 할 수 있게금 처리함 
-- 프로시저명 : PRG_STUDENT_UPDATE()
/*
EXEC PRC_STUDENT_UPDATE('moon','java006','010-9999-9999','강원도 횡성');
--> 데이터 수정 X 

EXEC PRC_STUDENT_UPDATE('moon','java006','010-9999-9999','강원도 횡성');
--> 데이터 수정 ㅇ
*/

-- 방법 1 
CREATE OR REPLACE PROCEDURE PRG_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0; -- 패스워드 일치:1 / 패스워드불일치 :2
BEGIN
    
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = 'moon';
    
    IF (V_PW = V_PW2)       -- 패스워드 일치
        THEN V_FLAG := 1;
    ELSE                    -- 패스워드 불일치
        V_FLAG := 2;
    END IF;
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID AND V_FLAG=1;  
    
    COMMIT;

END;
-- Procedure PRG_STUDENT_UPDATE이(가) 컴파일되었습니다.
CREATE OR REPLACE PROCEDURE PRG_STUDENT_UPDATE
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2 TBL_IDPW.PW%TYPE;
    V_FLAG NUMBER := 0; -- 패스워드 일치:1 / 패스워드불일치 :2
BEGIN
        UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
                FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
                ON T1.ID = T2.ID) T
        SET T.TEL = V_TEL, T.ADDR = V_ADDR
        WHERE T.ID =V_ID AND T.PW = V_PW ;
END;
-- Procedure PRG_STUDENT_UPDATE이(가) 컴파일되었습니다.

--TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성함
          
--NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG으로 구성된 컬럼 중
-- NUM(사원번호) 항목을 제외한 데이터 입력 시 해당 항목의 값은 기존 부여된 사우너 번호의 마지막 번호 그 다음 번호를 
-- 자동으로 입력 처리할 수 있는 프로시저로 구성함
-- 프로시저명 : PRC_INSA_INSERT()
/*
실행 예)
EXEC PRC_INSA_INSERT('최혜인', '970812-2234567', SYSDATE, '서울', '010-2509-1783', '개발부','대리',20000000,2000000);
-> 위와 같이 프로시저 호출 및 실행 

1061 최혜인 970812-2234567 2023-11-06 서울 010-2509-1783 개발부 대리 2000000 2000000
의 신규 데이터가 신규 입력된 상황 
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME            IN TBL_INSA.NAME%TYPE 
, V_SSN             IN TBL_INSA.SSN%TYPE
, V_IBSADATE        IN TBL_INSA.IBSADATE%TYPE
, V_CITY            IN TBL_INSA.CITY%TYPE
, V_TEL             IN TBL_INSA.TEL%TYPE
, V_BUSEO           IN TBL_INSA.BUSEO%TYPE
, V_JIKWI           IN TBL_INSA.JIKWI%TYPE
, V_BASICPAY        IN TBL_INSA.BASICPAY%TYPE
, V_SUDANG          IN TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM TBL_INSA.NUM%TYPE;
BEGIN
    -- 기존 부여된 사원번호의 마지막 번호 
    SELECT MAX(NVL(NUM,1)) INTO V_NUM
    FROM TBL_INSA;

    -- 데이터 입력 쿼리문 작성 
    INSERT INTO TBL_INSA(NUM,NAME,SSN,IBSADATE,CITY,TEL,BUSEO,JIKWI,BASICPAY,SUDANG)
        VALUES ((V_NUM+1), V_NAME, V_SSN, V_IBSADATE, V_CITY,V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
    
    COMMIT;
        
END;
-- Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

-- 20231106_02_SCOTT.sql 파일을 활용하여 TBL_상품, TBL_입고 테이블을 대상으로
-- TBL_입고 테이블에 데이터 입력 시 (즉, 이복 이벤트 발생 시) 
-- TBL_상품 테이블의 해당 상품에 대한 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성 
-- 단 이 과정에서 입고 번호는 자동 증가 처리함 (시퀀스 사용 안함)
-- TBL_입고 테이블 구성 컬럼은 입고번호, 상품코드, 입고일자, 입고수량, 입고단가이며 
-- 프로시저 호출을 통해 전달할 파라미터는 상품코드, 입고수량, 입고단가임
-- 프로시저명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드  IN TBL_입고.상품코드%TYPE
, V_입고수량  IN TBL_입고.입고수량%TYPE
, V_입고단가  IN TBL_입고.입고단가%TYPE
)
IS
    V_입고번호 TBL_입고.입고번호%TYPE;
BEGIN
    
    SELECT NVL(MAX(입고번호),0) + 1 INTO V_입고번호
    FROM TBL_입고;
    
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
        VALUES(V_입고번호, V_상품코드,SYSDATE, V_입고수량, V_입고단가);
        
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    COMMIT;
    
END;

---------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드  IN TBL_입고.상품코드%TYPE
, V_입고수량  IN TBL_입고.입고수량%TYPE
, V_입고단가  IN TBL_입고.입고단가%TYPE
)
IS
    -- 선언부
    -- 선언한 변수에 값 담아내기
    -- 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호 TBL_입고.입고번호%TYPE;
BEGIN
    -- 실행부
    -- SELECT 쿼리문 수행 -> 입고번호 확인
    SELECT NVL(MAX(입고번호),0) INTO V_입고번호
    FROM TBL_입고;
    
    -- INSERT 쿼리문 수행
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, V_입고수량, V_입고단가);
        
    -- UPDATE 쿼리문 수행 
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리 
    EXCEPTION 
        WHEN OTHERS THEN ROLLBACK;  
    
    --커밋
    COMMIT;
    
END;

-------------------------------------------------------------------------------

-- ㅇㅇ 프로시저 내에서의 예외처리 ㅇㅇ --

-- ㅇ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 작성 
-- 단, 이 프로시저를 통해 데이터를 입력할 경우 
-- CITY(지역) 항목에 '서울', '경기', '대전'만 입력이 가능하도록 구성함 
-- 이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하려는 경우 
-- (즉, 유효하지 않은 데이터 입력을 시도하려는 경우)
-- 예외에 대한 처리를 하려고 함 
-- 프로시저명 : PRC_MEMBER_INSERT()

/*
실행 예)
EXEC PRC_MEMBER_INSERT('박범구','010-1111-1111','서울');
-- 데이터 입력 o
EXEC PRC_MEMBER_INSERT('김경태','010-2222-2222','부산');
-- 데이터 입력 X

*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT 
( V_NAME        IN TBL_MEMBER.NAME%TYPE
, V_TEL         IN TBL_MEMBER.TEL%TYPE
, V_CITY        IN TBL_MEMBER.CITY%TYPE
)
IS
    --실행 영역의 쿼리문 수행을 위해 필요한 변수 선언 
    V_NUM TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK
    USER_DEFINE_ERROR EXCEPTION;
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성 
    IF (V_CITY NOT IN ('서울','경기','대전'))
        -- 예외 발생 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 선언한 변수에 값 담아내기 
    
    SELECT NVL(MAX(NUM),0) INTO V_NUM
    FROM TBL_MEMBER;
    
    -- 쿼리문 구성 -> INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    -- 예외 처리 구문 무조건 커밋 전에 사용 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001,'서울,경기,대전만 입력이 가능합니다.'); -- 20000번 이후로 사용자 정의 예외 처리 가능 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
            
    -- 커밋
    COMMIT;
    
END;

-- Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.

-- ㅇ TBL_출고 테이블에 데이터 입력 시 (즉, 출고 이벤트 발생 시)
-- TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성함 
-- 단, 출고번호는 입고번호와 마찬가지로 자동 증가
-- 또한, 출고수량이 재고수량보다 많은 경우 
-- 출고 액션을 취소할 수 있도록 처리(출고가 이루어지지 않도록) -> 예외처리 활용
-- 프로시저명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT('H001',10,600);

-> 이 시점에서의 상품 테이블의 바밤바 재고수량은 70

EXEC PRC_출고_INSERT('H001', 80, 600);

--에러발생
-- (20002, 재고 부족)
*/

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN TBL_출고.상품코드%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE 
, V_출고단가    IN TBL_출고.출고단가%TYPE
)
IS
    V_출고번호 TBL_출고.출고번호%TYPE;
    
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    IF (V_재고수량 < V_출고수량)
        -- 예외 발생 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(출고번호),0) INTO V_출고번호
    FROM TBL_출고;
    
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES((V_출고번호+1), V_상품코드, V_출고수량, V_출고단가);
        
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리 구문 무조건 커밋 전에 사용 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족'); -- 20000번 이후로 사용자 정의 예외 처리 가능 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    COMMIT;

END;

------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN TBL_출고.상품코드%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE 
, V_출고단가    IN TBL_출고.출고단가%TYPE
)
IS
    -- 주요 변수 선언
    V_출고번호 TBL_출고.출고번호%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    -- 사용자 정의 예외 선언
    USER_DEFINE_ERROR EXCEPTION;
    
BEGIN
    -- 쿼리문 수행 이전에 수행 여부를 확인하는 과정에서
    -- 재고수량 파악 -> 기존 재고를 확인하는 과정이 선행되어야 함
    -- 그래야 프로시저 호출 시 넘겨받는 출고수량과 비교가 가능하기 때문
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 출고를 정상적으로 진행해줄 것인지에 대한 여부 확인
    -- 위에서 파악한 재고수량보다 현재 프로시저에서 넘겨받은 출고수량이 많으면 예외처리 발생 
    
    IF (V_출고수량 > V_재고수량)
        -- 예외 발생 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- 출고번호 얻어내기 -> 위에서 선언한 변수에 값 담아내기
    SELECT NVL(MAX(출고번호),0) + 1 INTO V_출고번호
    FROM TBL_출고;
    
    -- 쿼리문 구성 -> INSERT(TBL_출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    
    -- 쿼리문 구성 -> UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 쿼리문 구성 -- INSERT(TBL_출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
        VALUES((V_출고번호+1), V_상품코드, V_출고수량, V_출고단가);
    
    -- 예외 처리 
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족'); -- 20000번 이후로 사용자 정의 예외 처리 가능 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    COMMIT;
    
END;

---------------------------------------------------------------------------------------------------------

-- ㅇ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저
-- 프로시저명 : PRC_출고_UPDATE()
/*
실행 예)
EREC PRC_출고_UPDATE(출고번호,변경수량); 수정    
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호        IN TBL_출고.출고번호%TYPE
, V_변경수량        IN TBL_출고.출고수량%TYPE
)
IS
    V_출고수량 TBL_출고.출고수량%TYPE;
    V_상품코드 TBL_상품.상품코드%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;


    USER_DEFINE_ERROR EXCEPTION;

BEGIN

    IF (V_재고수량 + V_출고수량) < V_변경수량
        -- 예외 발생 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    SELECT 출고수량 INTO V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;

    
    UPDATE TBL_출고
    SET 출고수량 = V_변경수량 
    WHERE 출고번호 = V_출고번호;
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 +  V_출고수량 - V_변경수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION 
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002,'재고 부족'); -- 20000번 이후로 사용자 정의 예외 처리 가능 
            ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
            
    COMMIT;
        
END;