select user
from dual;

-- ㅇ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저
-- 프로시저명 : PRC_출고_UPDATE()
/*
실행 예)
EREC PRC_출고_UPDATE(출고번호,변경수량); 수정    
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
  -- ① 매개변수 구성
  V_출고번호    IN TBL_출고.출고번호%TYPE
, V_출고수량    IN TBL_출고.출고수량%TYPE
)
IS
    -- ③ 필요한 변수 선언
    V_상품코드      TBL_상품.상품코드%TYPE;
    V_이전출고수량  TBL_출고.출고수량%TYPE;  
    V_재고수량      TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- ④ 선언한 변수에 값 담아내기 V_상품코드
    -- ⑥ V_이전출고수량
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;

    -- ⑧ 출고 정상수행여부 판단 필요
    --    변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --    (『재고수량 + 이전출고수량 < 현재출고수량』인 상황이라면... 사용자 정의 예외 발생)
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        -- THEN 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- ⑤ 
    UPDATE TBL_상품
    SET 재고수량 =  재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- ⑩ 예외 처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    
    -- ⑦ 커밋
    COMMIT;
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
2. PRC_입고_DELETE(입고번호)
3. PRC_출고_DELETE(출고번호)
*/

SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_상품;

SELECT *
FROM TBL_출고;

CREATE OR REPLACE PROCEDURE PRE_입고_UPDATE
( V_입고번호   IN TBL_입고.입고번호%TYPE
, V_입고수량   IN TBL_입고.입고수량%TYPE
)
IS
    V_상품코드  TBL_상품.상품코드%TYPE;
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_이전입고수량 TBL_입고.입고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    
    SELECT 입고수량, 상품코드 INTO V_이전입고수량, V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    
    IF (V_이전입고수량 - V_입고수량 < V_입고수량) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    UPDATE TBL_입고 
    SET 입고수량 = V_입고수량
    WHERE 입고번호 = V_입고번호;
    
    UPDATE TBL_상품 
    SET 재고수량 = 재고수량 - V_이전입고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
    WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
              ROLLBACK;
     WHEN OTHERS
        THEN ROLLBACK;
      
    COMMIT;
    
END;

-- Procedure PRE_입고_UPDATE이(가) 컴파일되었습니다.


CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(
 V_입고번호 IN  TBL_입고.입고번호%TYPE
)
IS
    V_입고수량 TBL_입고.입고수량%TYPE;
    V_상품코드 TBL_상품.상품코드%TYPE;
    V_재고수량 TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN

    SELECT 상품코드,입고수량 INTO V_상품코드, V_입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    IF (V_재고수량 - V_입고수량 < 0) 
        THEN RAISE USER_DEFINE_ERROR;
    END IF;

    DELETE 
    FROM TBL_입고 
    WHERE 입고번호 = V_입고번호; 
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    EXCEPTION
        WHEN USER_DEFINE_ERROR
        THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족~!!!');
              ROLLBACK; 
     WHEN OTHERS
        THEN ROLLBACK;
      
    COMMIT;
    
END;

--Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.

CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(
 V_출고번호 TBL_출고.출고번호%TYPE
)
IS
    
    V_출고수량 TBL_출고.출고수량%TYPE;
    V_상품코드 TBL_상품.상품코드%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;

BEGIN
    
    SELECT 상품코드,출고수량 INTO V_상품코드,V_출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;


    DELETE 
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
     
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량 
    WHERE 상품코드 = V_상품코드;
    
      
    COMMIT;
    
END;

-- Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.