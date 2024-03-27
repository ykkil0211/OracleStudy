--#1 �ּ�
--#1-1[����Ű] ctrl + /
--1�� �ּ��� ó��(������ �ּ��� ó��)
 
--#1-2[����Ű] alt + shift + c
/*
������
(������)
�ּ���
ó��
*/
 
--#2 ���� ���� ����
--#2-1[����Ű] ctrl + enter, F9
--�� ���� ����Ŭ ������ ������ �ڻ��� ���� ��ȸ
show user;
--USER��(��) "SYS"�Դϴ�.
--> ctrl + enter: sqlplus ������ �� ����ϴ� ��ɾ�
 
select user
from dual;
-- DUAL: ������ ���̺�, ���̶�� �θ�. �ϳ��� ��� �ϳ��� ���� ����
--==>> SYS
 
-- ������ ��ü�� ��ҹ��� ����X
-- �� ���� ��쿡�� ��ҹ��� ����O
 
--#3 ��ҹ��� ����[����Ű] Alt + '
-- ��� Aa ��ư Ŭ���� �빮�ڡ�ҹ���
SELECT USER
FROM dual;
--==>> SYS
 
SELECT 1+2
FROM DUAL;
--==>> 3
 
SELECT          1           +           2
FROM Dual;
--==>> 3
 
 
 
SELECT 1+2
FROMDual;
--==>> �����߻�
--(ORA-00923: FROM keyword not found where expected)
 
SELECT ����Ŭ����;
--(ORA-00923: FROM keyword not found where expected)
 
SELECT ����Ŭ����
FROM DUAL;
--(ORA-00904: "����Ŭ����": invalid identifier)
 
SELECT "����Ŭ����"
FROM DUAL;
--(ORA-00904: "����Ŭ����": invalid identifier)
 
SELECT '����Ŭ����'
FROM DUAL;
--==>> ����Ŭ����
--** ���ڿ� ���� ����ǥ
 
SELECT '�� �� �� �� ���ܿ� ����Ŭ ����'
FROM DUAL;
--==>> �� �� �� �� ���ܿ� ����Ŭ ����
 
SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28
 
SELECT 10 * 5
FROM DUAL;
--==>> 50
 
SELECT 10 * 5.0
FROM DUAL;
--==>> 50
 
SELECT 4 / 2
FROM DUAL;
--==>> 2
 
SELECT 10 / 2.5
FROM DUAL;
--==>> 2
 
SELECT 10 / 2.4
FROM DUAL;
--==>> 4.16666666666666666666666666666666666667
 
SELECT 4.0 / 2
FROM DUAL;
--==>> 2
 
SELECT 5 / 2
FROM DUAL;
--==>> 2.5
--** ���� / ���� ���� ���ϴ� �������θ� ����x
 
SELECT 100 - 78
FROM DUAL;
--==>> 22
 
SELECT '���ġ' + '��Ѹ�'
FROM DUAL;
--==>> (ORA-01722: invalid number)
--** ���ڿ����� ��ġ��x
 
--�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	EXPIRED & LOCKED
MDSYS	EXPIRED & LOCKED
CTXSYS	EXPIRED & LOCKED
DBSNMP	EXPIRED & LOCKED
XDB	EXPIRED & LOCKED
APPQOSSYS	EXPIRED & LOCKED
*/
 
SELECT *
FROM DBA_USERS;
/*
SYS	                0		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
SYSTEM	            5		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP		10G 11G 	N	PASSWORD
ANONYMOUS	        35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP			N	PASSWORD
HR	                43		OPEN		24/04/14	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
FLOWS_FILES	        44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APEX_040000	        47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
OUTLN	            9		EXPIRED & LOCKED	23/10/16	23/10/16	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DIP	                14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
ORACLE_OCM	        21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XS$NULL	    2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
MDSYS	            42		EXPIRED & LOCKED	14/05/29	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
CTXSYS	            32		EXPIRED & LOCKED	23/10/16	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
DBSNMP	            29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
XDB	                34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
APPQOSSYS	        30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
*/
 
SELECT USERNAME, CREATED
FROM DBA_USERS;
/*
SYS	            14/05/29
SYSTEM	        14/05/29
ANONYMOUS	    14/05/29
HR	            14/05/29
APEX_PUBLIC_USER	14/05/29
FLOWS_FILES	    14/05/29
APEX_040000	    14/05/29
OUTLN	        14/05/29
DIP	            14/05/29
ORACLE_OCM	    14/05/29
XS$NULL	        14/05/29
MDSYS	        14/05/29
CTXSYS	        14/05/29
DBSNMP	        14/05/29
XDB	            14/05/29
APPQOSSYS	    14/05/29
*/
 
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--Session��(��) ����Ǿ����ϴ�.
--> ��DBA�� �� �����ϴ� Oracle Data Dictionary View��
-- ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
 
SELECT USERNAME, CREATED
FROM DBA_USERS;
/*
SYS	            2014-05-29
SYSTEM	        2014-05-29
ANONYMOUS	    2014-05-29
HR	            2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	    2014-05-29
APEX_040000	    2014-05-29
OUTLN	        2014-05-29
DIP	            2014-05-29
ORACLE_OCM	    2014-05-29
XS$NULL	        2014-05-29
MDSYS	        2014-05-29
CTXSYS	        2014-05-29
DBSNMP	        2014-05-29
XDB	            2014-05-29
APPQOSSYS	    2014-05-29
*/
 
--�� ��HR�� ����� ������ ��� ���·� ����
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.
 
--�� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
/*  :
HR	LOCKED
    :
*/
 
--�� ��HR�� ����� ������ �ٽ� ��� ���� ���·� ����
ALTER USER hr ACCOUNT UNLOCK;
/*  :
HR	OPEN
    :
*/
SELECT USER
FROM DUAL;
 
---------------------------------------------------------------------
--�� TABLESPACE ����
 
--�� TABLESPACE ��?
-- ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�) ����Ŭ�� ������ ���屸���� �ǹ��Ѵ�.
-- ����Ŭ�� ������ ���屸���� �ǹ��Ѵ�.
 
CREATE TABLESPACE TBS_EDUA              -- �����ϰڴ�. ���̺����̽���...TBS_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'   -- ������ ������ ���� ��� �� �̸�
SIZE 4M                                 -- ������(�뷮)
EXTENT MANAGEMENT LOCAL                 -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;          -- ���׸�Ʈ ����Ŭ ������ �ڵ����� ����
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.
 
--�� ���̺����̽� ���� ������ �����ϱ� ����
-- �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--(C:\TESTDATA)
 
--�� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES; -- ����Ŭ ������ �˾Ƽ� ó��
--==>> 
/*
SYSTEM	    8192	65536		    1	    2147483645	    2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	    8192	65536		    1	    2147483645	    2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		    1	    2147483645	    2147483645		65536	ONLINE	UNDO	    LOGGING	    NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	    8192	1048576	1048576	1		2147483645	            0	    1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	    8192	65536		    1	    2147483645	    2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		    1	    2147483645	    2147483645		65536	ONLINE	PERMANENT	LOGGING	    NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/
 
--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES;
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	    4	USERS	    104857600	12800	AVAILABLE	4	YES	11811160064	1441792	1280	103809024	12672	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	2	SYSAUX	    692060160	84480	AVAILABLE	2	YES	34359721984	4194302	1280	691011584	84352	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	3	UNDOTBS1	398458880	48640	AVAILABLE	3	YES	524288000	64000	640	397410304	48512	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	1	SYSTEM	    377487360	46080	AVAILABLE	1	YES	629145600	76800	1280	376438784	45952	SYSTEM
C:\TESTDATA\TBS_EDUA01.DBF	                    5	TBS_EDUA	4194304	    512	    AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/
 
--�� ����Ŭ ����� ���� ����
CREATE USER osk IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>> User OSK��(��) �����Ǿ����ϴ�.
--> osk ��� ����� ���� �����ϰڴ�. (����ڴ�. �������.)
-- �� ����� ������ �н������ java006$ �� �ϰڴ�.
-- �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ��
-- �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.
-- *** �߿�!!!*** �ι� �����ϸ� �ȵ�~!! 
 
--�� ������ ����Ŭ ����� ����(���� ������ �̸� �̴ϼ� ����)�� ���� ���� �õ�
-- -> ���� �Ұ�(����)
-- (����: ���� -�׽�Ʈ ����: ORA-01045: user OSK lacks CREATE SESSION privilege; logon denied)
-- ��CREATE SESSION�� ������ ���� ������ ���� �Ұ�.
 
--�� ������ ����Ŭ ����� ����(���� ������ �̸� �̴ϼ� ����)�� 
-- ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO OSK; 
--==>> Grant��(��) �����߽��ϴ�.
 
--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
/*      :
OSK	CREATE SESSION	NO
        :
*/
 
------------------------------------------------------------------------------
--�� ���� ������ ����� ������
-- ���̺� ���������ϵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO OSK;
 
--�� ���� ������ ����Ŭ ����� ������
-- ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮)����.
ALTER USER OSK
QUOTA UNLIMITED ON TBS_EDUA; --QUOTA �Ҵ緮
--==>> User OSK��(��) ����Ǿ����ϴ�.

----------------------------------------------------------------------------------------------------------------------------------
-- sys ������ ���� 
--�� ���ӵ� ����� ���� ��ȸ
SELECT USER
FROM DUAL;
--==>> SYS
 
--------------------------------------------------------------------------------
--SCOTT ������ Ȱ���� �� �ִ� ȯ�� ����
 
--�ۻ���� ���� ����(SCOTT / TIGER)
create user scott
identified by tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.
 
--�� ����� ������ ����(��) �ο�
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.
 
--�� SCOTT ����� ������ �⺻ ���̺����̽��� USERS �� ����(����)
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.
 
--�� SCOTT ����� ������ �ӽ� ���̺���̽��� TEMP �� ����(����)
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.
 
--�� ����� ���� Ȯ��
SELECT *
FROM DBA_USERS;
--==>>
/*  :
SCOTT	49		OPEN		24/04/15	USERS	TEMP	23/10/18	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD
    :
*/

GRANT CREATE VIEW TO SCOTT;