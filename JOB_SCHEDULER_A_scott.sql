SELECT USER
FROM DUAL;
--==>> SCOTT


-- �����ٷ� ���� �۵����� Ȯ���� ����
-- ���̺� �� ���ν��� ����


--�� �ǽ� ���̺� ����(TBL_TEST)
CREATE TABLE TBL_TEST
( NOW_COL   VARCHAR2(30)
);
--==>> Table TBL_TEST��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���ν��� ����(PRC_TEST)
CREATE OR REPLACE PROCEDURE PRC_TEST
( P_NOW_COL IN VARCHAR2
)
IS
BEGIN
    INSERT INTO TBL_TEST(NOW_COL) VALUES(P_NOW_COL);
    COMMIT;
END;
--==> Procedure PRC_TEST��(��) �����ϵǾ����ϴ�.

--�� ��¥ �ð� ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


--�� �׽�Ʈ(Ȯ��)
SELECT TRUNC(SYSDATE)+ 12/24
FROM DUAL;
--==>> 2024-02-19 12:00:00


--�� �����ٷ� �� ���

BEGIN
    DBMS_SCHEDULER.CREATE_JOB
    ( JOB_NAME => 'JOB_PRC_TEST'
    -- �� �̸��� ��ϵ� �� �̸��� �� ����ũ�ϱ⸸ �ϸ� �ǰ�,
    -- �����ٷ����� ���� ������ �� �� �̸��� �Ķ���ͷ� �Է��Ͽ� �����ϰ� �ȴ�.
    
    , START_DATE => TRUNC(SYSDATE)+ 12/24
    , REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=1;'
    -- START_DATE �� REPEAT_INTERVAL �� �����ٷ��� ����� ����
    -- ���� �ð����� �ݺ��ǵ��� �ϴ� �ɼ����� ���� ���� ���谡 �ִ�.
    -- START_DATE  �� ���� ���ʷ� ����Ǵ� �ð��� �����ϰ� �Ǹ�,
    -- REPEAT_INTERVAL �� �ݺ��Ǵ� ������ �����ϰ� �ȴ�.
    -- ����, ������ START_DATE �� TRUNC(SYSDATE+1) + 12/24 �� ���� �����ߴٸ�
    -- TRUNC(SYSDATE+1) �� ������ �ǹ��Ѵ�.
    -- ��, ��SELECT TRUNC(SYSDATE+1) FROM DUAL�� �� ���� �������� �����ϸ�
    -- ���� ���ڰ� ��ȸ�Ǵ� ���� Ȯ���� �� �ִ�.
    -- ��12/24�� �� ������ �ǹ��ϴ� ���� �ȴ�.
    , END_DATE => SYSDATE + 5
    -- END_DATE �� ���� ���� �ð��� �ǹ��Ѵ�.
    -- �������� �ݺ� ������ �����Ϸ��� NULL �� �����ϰ� �ȴ�.
    -- �ð��� ������� �����ϸ� ����Ǳ⸦ �ٶ��ٸ�
    -- ��TRUNC(SYSDATE+7)���� ���� ����ϰ� �ȴ�.
    --, JOB_CLASS => 'DEFAULT_JOB_CLASS'
    , JOB_TYPE => 'PLSQL_BLOCK'
    
    , JOB_ACTION => 'BEGIN PRC_TEST(TO_CHAR(SYSDATE, ''YYYY-MM-DD HH24:MI:SS'')); END;'
    -- ������ ���� �Ǿ�� �ϴ� ������
    , COMMENTS => 'JOB ��� �ǽ�'
    );
    
    DBMS_SCHEDULER.ENABLE('JOB_PRC_TEST');
END;
--==>> PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.


--�� �����ٷ� �� ��� ���� Ȯ��

SELECT *
FROM USER_SCHEDULER_JOBS
WHERE JOB_NAME='JOB_PRC_TEST';
--==>>
/*
JOB_PRC_TEST		REGULAR	SCOTT					PLSQL_BLOCK	BEGIN PRC_TEST(TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')); END;	0			CALENDAR	24/02/19 12:00:00.000000000 +09:00	FREQ=DAILY; INTERVAL=1								24/02/24 11:11:18.000000000 +09:00	DEFAULT_JOB_CLASS	TRUE	TRUE	FALSE	SCHEDULED	3	0		0		0			24/02/19 12:00:00.000000000 +09:00			OFF	FALSE	TRUE		FALSE	1	NLS_LANGUAGE='KOREAN' NLS_TERRITORY='KOREA' NLS_CURRENCY='��' NLS_ISO_CURRENCY='KOREA' NLS_NUMERIC_CHARACTERS='.,' NLS_CALENDAR='GREGORIAN' NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS' NLS_DATE_LANGUAGE='KOREAN' NLS_SORT='BINARY' NLS_TIME_FORMAT='HH24:MI:SSXFF' NLS_TIMESTAMP_FORMAT='RR/MM/DD HH24:MI:SSXFF' NLS_TIME_TZ_FORMAT='HH24:MI:SSXFF TZR' NLS_TIMESTAMP_TZ_FORMAT='RR/MM/DD HH24:MI:SSXFF TZR' NLS_DUAL_CURRENCY='��' NLS_COMP='BINARY' NLS_LENGTH_SEMANTICS='BYTE' NLS_NCHAR_CONV_EXCP='FALSE'		1						FALSE	FALSE	JOB ��� �ǽ�	133168
*/



--�� ������ �ð��� �����ٷ� ���� ���������� ����Ǿ����� Ȯ��
SELECT *
FROM USER_SCHEDULER_JOB_LOG
WHERE JOB_NAME='JOB_PRC_TEST';
--( 11:24 ���� )
--==>> ��ȸ ��� ����
--( 12:01 rlwns)
--==>> 8861	24/02/19 12:00:00.038000000 +09:00	SCOTT	JOB_PRC_TEST		DEFAULT_JOB_CLASS	RUN	FAILED								


SELECT *
FROM USER_SCHEDULER_JOB_RUN_DETAILS
WHERE JOB_NAME = 'JOB_PRC_TEST';
--( 11:25 ���� )
--==>> ��ȸ ��� ����
--( 12:02 ���� )
--==>> 8861	24/02/19 12:00:00.038000000 +09:00	SCOTT	JOB_PRC_TEST		FAILED	6550	24/02/19 12:00:00.000000000 +09:00	24/02/19 12:00:00.022000000 +09:00	+00 00:00:00.000000	1	74,129	10752	+00 00:00:00.000000					"ORA-06550: line 1, column 756:
/*
PLS-00905: object SCOTT.PRC_TEST is invalid
ORA-06550: line 1, column 756:
PL/SQL: Statement ignored
"
*/

-- *) �ڿ� DETAILS �� �پ��ִ� �͵���, ������ �������� ��
-- ���� ������ Ȯ���� �� �ִ� DICTIONARY �̴�.


--�� ALL...DETAILS, DBA...DETAILS, USER...DETAILS �� ����
--  ��DETAILS���� ���� �����ٷ� �� �α� ��ųʸ� ���
--   ���� ���� ���� ���� ������ ��ȸ�� �� �ִ�.


SELECT *
FROM TBL_TEST;
--==>> ( 11:28 ���� )
--==>> ��ȸ ��� ����
/*
2024-02-19 13:00:00
*/

--�� �� ���� ����
DBMS_SCHEDULER.DROP_JOB('JOB_PRC_TEST');

--�� ���ν��� ���� ����
DROP PROCEDURE PRC_TEST;

--�� ���̺� ���� ����
DROP TABLE TBL_TEST;

INSERT INTO C_PROJECT(CP_CODE, CP_DATE, APP_OPENCODE) 
VALUES ( (SELECT ('CP' || (NVL(MAX(CP_CODE), 0) + 1)) FROM C_PROJECT) , SYSDATE, 4 );



