SELECT USER
FROM DUAL;
--==>> SCOTT
 
 
-- (현재 SCOTT 으로 연결된 상태)
-- ** 블록 잡아서 실행할 것~!!!
 
--■■■ 암호화 및 복호화 02 ■■■--
 
--○ 패키지 선언(CRYPTPACK)
--//** 패키지: 암호화 복호화 쓰겠다는 의미.선언부와 몸체부로 구성
CREATE OR REPLACE PACKAGE CRYPTPACK
AS
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
 
END CRYPTPACK;
--==>> Package CRYPTPACK이(가) 컴파일되었습니다.
 
--○ 패키지 몸체(CTYPTPACK)
CREATE OR REPLACE PACKAGE BODY CRYPTPACK
IS
    -- 전역변수(속성)
    CRYPTED_STRING VARCHAR2(2000);
    
    -- 함수(암호화)
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
        PIECES_OF_EIGHT NUMBER := ((FLOOR(LENGTH(STR)/8 + .9))*8);
        -- 글자수를 8로 나눠...FLOOR 절삭...
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT
        ( INPUT_STRING      => RPAD(STR, PIECES_OF_EIGHT)   
        -- '=>': 프로시저를 호출하면서 파라미터를 넘길때 호출하는 기호
        -- 파라미터가 많을 때 특정한 이름을 부여해서 넘길 수 있음
        , KEY_STRING        => RPAD(HASH, 8, '#')
        , ENCRYPTED_STRING  => CRYPTED_STRING
        );
        RETURN CRYPTED_STRING;
    END;
    
    -- 함수(복호화)
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT
        ( INPUT_STRING      => XCRYPT
        , KEY_STRING        => RPAD(HASH, 8, '#')
        , DECRYPTED_STRING  => CRYPTED_STRING
        );
        RETURN TRIM(CRYPTED_STRING);
    END;
    
END CRYPTPACK;
--==>> Package Body CRYPTPACK이(가) 컴파일되었습니다.