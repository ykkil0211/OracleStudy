SELECT USER
FROM DUAL;
--==>> SCOTT
 
 
-- (���� SCOTT ���� ����� ����)
-- ** ��� ��Ƽ� ������ ��~!!!
 
--���� ��ȣȭ �� ��ȣȭ 02 ����--
 
--�� ��Ű�� ����(CRYPTPACK)
--//** ��Ű��: ��ȣȭ ��ȣȭ ���ڴٴ� �ǹ�.����ο� ��ü�η� ����
CREATE OR REPLACE PACKAGE CRYPTPACK
AS
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
 
END CRYPTPACK;
--==>> Package CRYPTPACK��(��) �����ϵǾ����ϴ�.
 
--�� ��Ű�� ��ü(CTYPTPACK)
CREATE OR REPLACE PACKAGE BODY CRYPTPACK
IS
    -- ��������(�Ӽ�)
    CRYPTED_STRING VARCHAR2(2000);
    
    -- �Լ�(��ȣȭ)
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
        PIECES_OF_EIGHT NUMBER := ((FLOOR(LENGTH(STR)/8 + .9))*8);
        -- ���ڼ��� 8�� ����...FLOOR ����...
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT
        ( INPUT_STRING      => RPAD(STR, PIECES_OF_EIGHT)   
        -- '=>': ���ν����� ȣ���ϸ鼭 �Ķ���͸� �ѱ涧 ȣ���ϴ� ��ȣ
        -- �Ķ���Ͱ� ���� �� Ư���� �̸��� �ο��ؼ� �ѱ� �� ����
        , KEY_STRING        => RPAD(HASH, 8, '#')
        , ENCRYPTED_STRING  => CRYPTED_STRING
        );
        RETURN CRYPTED_STRING;
    END;
    
    -- �Լ�(��ȣȭ)
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
--==>> Package Body CRYPTPACK��(��) �����ϵǾ����ϴ�.