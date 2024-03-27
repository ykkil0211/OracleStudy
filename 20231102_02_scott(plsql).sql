SELECT USER
FROM DUAL;
-- SCOTT

-- ��  PL/SQL ��--

--1. PL/SQL(Procedural Language extension to SQL)
-- ���α׷��� ����� Ư���� ������ SQL�� Ȯ���̸� 
-- ������ ���۰� ���� ������ PL/SQL�� ������ �ڵ� �ȿ� ���Ե� 
-- ����, PL/SQL�� ����ϸ� SQL�� �� �� ���� ������ �۾��� ������
-- ���⿡�� "������" �̶�� �ܾ ������ �ǹ̴� � ���� � ������ ���� ��� �Ϸ�Ǵ���
-- �� ����� ��Ȯ�ϰ� �ڵ忡 ����ϴ� ���� �ǹ���

--2. PL/SQL�� ���������� ǥ���ϱ� ���� ������ ����� �� �ִ� ���
-- ���� ������ ������ �� �ִ� ���
-- ���� �帧�� ��Ʈ�� �� �� �ִ� ��� ���� ������ 

--3. PL/SQL�� �� ������ �Ǿ� ������ ����� ���� �κ�, ����κ�, ���� ó�� �κ��� �� �κ����� ���� 
-- ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����

--4. ���� �� ���� 
/*
[DECLARE]
-- ����(DECARATIONS)
BEGIN
    -- ���๮(STATEMENTS)
    
    [EXCEPTION]
    -- ���� ó����(EXCEPTION HANDLERS)
END;
*/

-- 5. ���� ����
/*
DECLARE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ;
BEGIN
END;
*/

-- �� ��(����)�� ���(�����Ͽ�) ����

-- �� "DBMS_OUTPUT.PUT_LINE()"�� ���� ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����
SET SERVEROUTPUT ON;
-- �۾��� �Ϸ�Ǿ����ϴ�.

-- ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ� 
DECLARE
    -- ����� 
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- ����� 
    --System.out.println(v1);
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

/*
10
HELLO
Oracle


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ� 
DECLARE
    --�����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- �����
    -- (���� �� ó��)
    V1 := V1 + 20; -- NUM1 = NUM1 + 20; -> NUM1 += 20;(����Ŭ�� �̷��� ����) 
    V2 := V2 || '���ѿ�';  
    V3 := V3|| ' World!';
    -- (��� ���)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO���ѿ�
ORACLE World!


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� IF��(���ǹ�)
-- IF ~ END IF;

-- �� IF��(���ǹ�)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL�� IF ������ �ٸ� ����� IF ���ǹ��� ���� ������ 
-- ��ġ�ϴ� ���ǿ� ���� ���������� �۾��� ������ �� �ֵ��� �� 
-- TRUE �̸� THEN �� ELSE ������ ������ �����ϰ� 
-- FALSE �� NULL�̸� ELSE �� END IF; ������ ������ �����ϰ� �� 

-- 2. ���� �� ���� 
/*
IF ���� 
    THEN ó����;
END IF;
*/

/*
IF ����
    THEN ó����;
ELSE 
    ó����;
END IF;
*/

/*
IF ���� 
    THEN ó����;
ELSIF
    THEN ó����;
ELSIF 
    THEN ó����;
ELSIF
    THEN ó����;
END IF
*/

-- �� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
 -- GRADE   NUMBER -- �ִ� ��
    GRADE   CHAR; -- �ּ� �� (�� ���ڸ� ���� �� ����)
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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


DECLARE
 -- GRADE   NUMBER -- �ִ� ��
    GRADE   CHAR; -- �ּ� �� (�� ���ڸ� ���� �� ����)
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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

DECLARE
 -- GRADE   NUMBER -- �ִ� ��
    GRADE   CHAR; -- �ּ� �� (�� ���ڸ� ���� �� ����)
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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� CASE�� (���ǹ�)

-- CASE�� (���ǹ�)

-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. ���� �� ���� 
/*
CASE ���� 
     WHEN ��1 THEN ���๮;
     WHEN ��2 THEN ���๮;
     ELSE ���๮;
END CASE;
*/

ACCEPT NUM PROMPT '����1 ����2 �Է��ϼ���';

DECLARE
    -- �����
    -- (�ֿ� ���� ����)
    SEL NUMBER := &NUM;
    RESULT VARCHAR2(20) := 'Ȯ�κҰ�';
BEGIN
    -- �����
    -- (�׽�Ʈ)
   -- DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
   -- DBMS_OUTPUT.PUT_LINE('RESULT : '  || RESULT);
   
   -- (���� �� ó��)
   /*
   CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('�����Դϴ�.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Ȯ�κҰ�');
   END CASE;
   */
   CASE SEL
        WHEN 1 THEN RESULT := '����';
        WHEN 2 THEN RESULT := '����';
        ELSE 
            RESULT := 'Ȯ�κҰ�';
   END CASE;
   
   -- (��� ���)
   DBMS_OUTPUT.PUT_LINE('ó������� ' || RESULT || ' �Դϴ�');
END;
/*
�����Դϴ�.


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

/*
ó������� ���� �Դϴ�


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

*/

-- �� �ܺ� �Է� ó�� 
-- ACCEPT ����
-- ACCEPT ������ PROMPT '�޼���';
--> �ܺ� �����κ��� �Է¹��� �����͸� ���� ������ ������ �� 
-- "&�ܺκ�����" ���·� �����ϰ� ��

-- �� ������ ���� 2���� �ܺηκ��� (����ڷκ���) �Է¹޾�
-- �̵��� ���� ����� ����ϴ� PL/SQL ������ �ۼ��� 
-- ���� ��)
-- ù ��° ������ �Է��ϼ��� -> 10
-- �� ��° ������ �Է��ϼ��� -> 20
--> 10 + 20 = 30

ACCEPT NUM PROMPT 'ù ��° ������ �Է��ϼ���';
ACCEPT NUM2 PROMPT '�� ��° ������ �Է��ϼ���';

DECLARE
    A NUMBER := &NUM;
    B NUMBER := &NUM2; 
    TOTAL NUMBER := 0;
    
    SUM1 NUMBER := A + B;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(A ||'+'|| B ||'='|| SUM1);
    
    -- �׽�Ʈ 
    DBMS_OUTPUT.PUT_LINE(A);
    DBMS_OUTPUT.PUT_LINE(B);
    DBMS_OUTPUT.PUT_LINE(TOTAL);
END;

-- ����ڷκ��� �Է¹��� �޿��� ȭ������� �����Ͽ� ����ϴ� ���α׷��� �ۼ�
-- �� �Է¿� ���� ��ȯ �ݾ��� ���ǻ� 1õ����, 10�� �̻� �����ϴٰ� ����

-- �Է� ���� �ݾ� 990
-- ȭ�� ����� 1 ��� 4 ���ʿ� 1 �ʿ� 4

ACCEPT NUM PROMPT '�ݾ��� �Է��ϼ��� : '
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
    
    -- ���
    DBMS_OUTPUT.PUT_LINE('ȭ�� : '||NUM );
    DBMS_OUTPUT.PUT_LINE('500�� :'|| A ||'�� '|| '100�� : '|| B ||'�� '||'50�� : '||C ||'�� '||'10�� : '|| D||'�� ');
END;

------------------------------------------------------------------------------------------------------------------------

ACCEPT INPUT PROMPT '�ݾ��� �Է��ϼ��� : '
DECLARE
    
-- �ֿ� ���� ���� 
    MONEY NUMBER := &INPUT;     -- ������ ���� �Է°��� ��Ƶ� ����
    MONEY2 NUMBER := &INPUT;    -- ��� ����� ���� �Է°��� ��Ƶ� ����
                                -- (MONEY ������ ������ ó���ϴ� �������� ���� ���ϱ� ����)

    M500 NUMBER; -- 500     -- 500�� ¥�� ������ ��Ƶ� ����
    M100 NUMBER; -- 100     -- 100�� ¥�� ������ ��Ƶ� ����
    M50 NUMBER; -- 50       -- 50�� ¥�� ������ ��Ƶ� ����
    M10 NUMBER; -- 10       -- 10�� ¥�� ������ ��Ƶ� ����

BEGIN  
    -- ���� �� ó�� 
    
    -- MONEY�� 500���� ������ ���� ���ϰ� �������� ���� -- 500�� ���� 
    -- MONEY�� 500���� ������ ���� ������ �������� ���� -- 500�� ���� Ȯ���ϰ� ���� �ݾ��� �ݾ����� MONEY�� ����
    M500 := TRUNC(MONEY/500);
    MONEY := MOD(MONEY,500);

    -- MONEY�� 100���� ������ ���� ���ϰ� �������� ���� -- 100�� ����
    -- MONEY�� 100������ ������ ���� ������ �������� ���� -- 100���� ������ Ȯ���ϰ� ���� �ݾ��� �ݾ����� MONEY�� ���� 
    M100 := TRUNC(MONEY/100);
     MONEY := MOD(MONEY,100);
    
    -- MONEY�� 50���� ������ ���� ���ϰ� �������� ���� -- 50�� ���� 
    -- MONEY�� 50���� ������ ���� ������ �������� ���� -- 50���� ������ Ȯ���ϰ� ���� �ݾ��� �ݾ����� MONEY�� ����
     M50 := TRUNC(MONEY/50);
     MONEY := MOD(MONEY,50);
    
    -- MONEY�� 10���� ������ ���� ���ϰ� �������� ���� -- 10���� ���� 
     M10 := TRUNC(MONEY/10);
    
    -- ��� ��� 
    -- ���յ� ���(ȭ�� ������ ����)�� ���Ŀ��°� ���� �����

--    DBMS_OUTPUT.OUT_LINE(MONEY);
    
    DBMS_OUTPUT.PUT_LINE('ȭ�� : '||MONEY2 );
    DBMS_OUTPUT.PUT_LINE('500�� :'|| M500 ||'�� '|| '100�� : '||M100 ||'�� '||'50�� : '||M50 ||'�� '||'10�� : '|| M10||'�� ');

END;
/*
ȭ�� : 660
500�� :1�� 100�� : 1�� 50�� : 1�� 10�� : 1�� 


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �⺻ �ݺ��� 
-- LOOP ~ END LOOP;

-- 1. ���ǰ� ������� ������ �ݺ��ϴ� ����

-- 2. ���� �� ���� 

/*
LOOP
    -- ���๮ 
    
    EXIT WHEN ����; -- ������ ���� ��� �ݺ����� �������� 

END LOOP;
*/

-- 1���� 10������ �� ���(LOOP�� Ȱ��)
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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- WHILE �ݺ��� 
-- WHILE LOOP ~ END LOOP;

-- 1. ���� ������ TRUE�� ���� �Ϸ��� ������ �ݺ��ϱ� ���� 
-- WHILE LOOP ������ ����� 
-- ������ �ݺ��� ���۵Ǵ� ������ üũ�ϰ� �Ǿ� LOOP ���� ������ �� ���� �������� ���� ��쵵 ���� 
-- LOOP�� ������ �� ������ FALSE�̸�, �ݺ� ������ Ż���ϰ� �� 

-- 2. ���� �� ���� 
/*
WHILE ���� LOOP -- ������ ���� ��� �ݺ� ���� 
    -- ���๮;
END LOOP
*/

-- 1���� 10������ �� ���(WHILE LOOP�� Ȱ��)

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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� FOR �ݺ��� 
-- FOR LOOP ~ END LOOP;

-- 1. "���ۼ�"���� 1�� �����Ͽ� "������"�� �� ������ �ݺ� ����
-- "������"�� �� ������ �ݺ� ������ 

--2. ���� �� ���� 
/*
FOR ī���� IN [REVERSE] ���ۼ�.. ������ LOOP
    -- ���๮;
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


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- ����ڷκ��� ������ ��(������)�� �Է¹޾�
-- �ش� �ܼ��� �������� ����ϴ� PL/SQL ������ �ۼ��� 

--1. LOOP ���� ���
ACCEPT INPUT PROMPT '���ϴ� ���ڸ� �Է��ϼ��� : '
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

--2. WHILE LOOP�� ���
ACCEPT INPUT PROMPT '���ϴ� ���ڸ� �Է��ϼ��� : '
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER := 1;
BEGIN
    
    WHILE N<10 LOOP 
    
         DBMS_OUTPUT.PUT_LINE(NUM ||'*'|| N || '='|| NUM * N);
         
         N := N+1;

    END LOOP;
    
END;
--3. FOR LOOP���� ��� 
ACCEPT INPUT PROMPT '���ϴ� ���ڸ� �Է��ϼ���'
DECLARE
    NUM NUMBER := &INPUT;
    N NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM ||'*'|| N || '='|| NUM * N);
    END LOOP;
END;

-- �� ������ ��ü(2�� ~ 9��)�� ����ϴ� PL/SQL ������ �ۼ���
-- ��, ���� �ݺ���(�ݺ����� ��ø) ������ Ȱ��

/*
���� ��)
-- 2�� --
2 * 1 = 2
    :
    :
-- 3�� --
    :
    :
*/

-- ��� 1
DECLARE
    N NUMBER := 2;
    N2 NUMBER := 1;
BEGIN
    
    FOR N IN 2 .. 9 LOOP
             DBMS_OUTPUT.PUT_LINE('--'||N||'��'||'--');
        FOR N2 IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*'|| N2 || '='|| N * N2);
        END LOOP;
    END LOOP;
END;

--��� 2
DECLARE 
    N NUMBER := 1;
    N2 NUMBER :=2;
BEGIN
    WHILE N<9 LOOP
        N := N+1;
        DBMS_OUTPUT.PUT_LINE('--'||N||'��'||'--');
        WHILE N2<10 LOOP
            DBMS_OUTPUT.PUT_LINE(N ||'*'|| N2 || '='|| N * N2);
            N2 := N2+1;
        END LOOP;
        N2 :=1;
    END LOOP;
END;

--��� 3
DECLARE 
    N NUMBER :=1;
    N2 NUMBER :=2;
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('--'||N||'��'||'--');

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

    