
--1�� �ּ��� ó��(������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��
*/

-- �� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ

show user
--USER��(��) "SYS"�Դϴ�.
-- -> sqlplus �����϶� ����ϴ� ��ɾ�

SELECT USER
FROM dual;
-- > SYS

select user
from dual;
-- > SYS

select 1 + 2
from dual;
-- > 3

select 1 + 2
fromdual;
-- 00923. 00000 - "FROM keyword not found where expected"

select ����Ŭ����
-- ���� �߻�
-- (00923. 00000 -  "FROM keyword not found where expected")

select ����Ŭ ����
from dual;
--> ���� �߻�
--> 00923. 00000 -  "FROM keyword not found where expected"

select "����Ŭ ����"
from dual;
--> �����߻�
--> 00904. 00000 -  "%s: invalid identifier"


select '����Ŭ ����'
from dual;
-- ����Ŭ ����

select '�� �� �� �� ���ܿ� ����Ŭ ����'
from dual;
--> �� �� �� �� ���ܿ� ����Ŭ ����

select 3.14 + 3.14
from dual;
--> 6.28

select 10 * 5
from dual;
--> 50

select 10 * 0.5
from dual;
--> 5

select 4/2
from dual;
--> 2

select 10/2.5
from dual;
--> 4

select 10/2.4
from dual;
--> 4.16666666666666666666666666666666666667

select 4.0/2
from dual;
--> 2

select 5/2
from dual;
--> 2.5

select 100 -78
from dual
--> 22

select '�赿��'+ '���ѿ�'
from dual;
--> ���� ����Ŭ�� ���ڿ����� ���ڿ��� ������ �� ����
--> 00933. 00000 -  "SQL command not properly ended"

-- �� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ

select USERNAME, ACCOUNT_STATUS
from DBA_USERS;



/*
SYS                         	OPEN
SYSTEM	                    OPEN
ANONYMOUS	                OPEN
HR	                        OPEN
APEX_PUBLIC_USER            	LOCKED
FLOWS_FILES	                LOCKED
APEX_040000	                LOCKED
OUTLN	                    EXPIRED & LOCKED
DIP	                        EXPIRED & LOCKED
ORACLE_OCM	                EXPIRED & LOCKED
XS$NULL	                    EXPIRED & LOCKED
MDSYS	                    EXPIRED & LOCKED
CTXSYS	                    EXPIRED & LOCKED
DBSNMP	                    EXPIRED & LOCKED
XDB	                        EXPIRED & LOCKED
APPQOSSYS	                EXPIRED & LOCKED
*/

select *
from DBA_USERS;

/*
SYS	0		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP
SYSTEM	5		OPEN		24/04/13	SYSTEM	TEMP	14/05/29	DEFAULT	SYS_GROUP
ANONYMOUS	35		OPEN		14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
HR	43		OPEN		24/04/14	USERS	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APEX_PUBLIC_USER	45		LOCKED	14/05/29	14/11/25	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
FLOWS_FILES	44		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APEX_040000	47		LOCKED	14/05/29	14/11/25	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
OUTLN	9		EXPIRED & LOCKED	23/10/16	23/10/16	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
DIP	14		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
ORACLE_OCM	21		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
XS$NULL	2147483638		EXPIRED & LOCKED	14/05/29	14/05/29	SYSTEM	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
MDSYS	42		EXPIRED & LOCKED	14/05/29	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
CTXSYS	32		EXPIRED & LOCKED	23/10/16	23/10/16	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
DBSNMP	29		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
XDB	34		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
APPQOSSYS	30		EXPIRED & LOCKED	14/05/29	14/05/29	SYSAUX	TEMP	14/05/29	DEFAULT	DEFAULT_CONSUMER_GROUP
*/

select username, created
from dba_users;

/*
SYS	                2014-05-29
SYSTEM	            2014-05-29
ANONYMOUS	        2014-05-29
HR	                2014-05-29
APEX_PUBLIC_USER    2014-05-29
FLOWS_FILES	        2014-05-29
APEX_040000	        2014-05-29
OUTLN	            2014-05-29
DIP	                2014-05-29
ORACLE_OCM	        2014-05-29
XS$NULL	            2014-05-29
MDSYS	            2014-05-29
CTXSYS	            2014-05-29
DBSNMP	            2014-05-29
XDB	                2014-05-29
APPQOSSYS	        2014-05-29
*/

alter session set nls_date_format = 'yyyy-mm-dd';

--> "DBA_"�� �����ϴ� Oracle Data Dictionary View�� ������ ������ �������� �������� ��쿡�� ��ȸ�� ������

-- �� "hr" ����� ������ ��� ���·� ���� 

alter user hr account lock;
-- User HR��(��) ����Ǿ����ϴ�.

select username, account_status
from dba_users;

--> HR	LOCKED

-- �� "hr" ����� ������ �ٽ� ��� ���� ���·� ����

ALTER USER HR ACCOUNT UNLOCK;
-- User HR��(��) ����Ǿ����ϴ�.

-------------------------------------------------------------------------------
-- �� TABLESPACE ���� 

-- TABLESPACE��?
-- ���׸�Ʈ(���̺�, �ε���, ....)�� ��Ƶδ� ����Ŭ�� ������ ���屸���� �ǹ� 
-- ����Ŭ�� ������ ���屸���� �ǹ�

CREATE TABLESPACE TBS_EDUA -- �����ϰ���. ���̺����̽��� TBS_EDUA��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF' -- ������ ������ ���� ��� �� �̸�
SIZE 4M                     -- ������(�뷮)
EXTENT MANAGEMENT LOCAL -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO; -- ���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� ����

-- ���̺����̽� ���� ������ �����ϱ� ����
-- �ش� ����� �������� ���͸� ������ �ʿ��� 
-- (C:\TESTDATA)

-- �� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES;

-- �� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)

SELECT *
FROM DBA_DATA_FILES;
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	4	USERS	104857600	12800	AVAILABLE	4	YES	11811160064	1441792	1280	103809024	12672	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	2	SYSAUX	692060160	84480	AVAILABLE	2	YES	34359721984	4194302	1280	691011584	84352	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	3	UNDOTBS1	398458880	48640	AVAILABLE	3	YES	524288000	64000	640	397410304	48512	ONLINE
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	1	SYSTEM	377487360	46080	AVAILABLE	1	YES	629145600	76800	1280	376438784	45952	SYSTEM
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/

-- ������Ŭ ����� ���� ���� 
CREATE USER ghw IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
-- User GHW��(��) �����Ǿ����ϴ�.

--> ghw ��� ����� ������ ��������. (�������, �������)
-- �� ����� ������ �н������ java006$�� �Ұ��� 
-- �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ�� �⺻������ TBS_EDUA��� ���̺� �����̽��� ������ �� �ֵ��� ���� 

--  ������ ����Ŭ ����� ����(���� ������ �̸� �̴ϼ� ����)�� ���� ���� �õ�
-- ���� �Ұ�(����)
-- "CREATE SESSION" ������ ���� ������ ���� �Ұ�

-- �� ������ ����Ŭ ����� ����(���� ������ �̸� �̴ϼ� ����)�� 
-- ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�

GRANT CREATE SESSION TO GHW;
-- Grant��(��) �����߽��ϴ�.

-- �� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ 

SELECT *
FROM DBA_SYS_PRIVS;
-- GHW	CREATE SESSION	NO

GRANT CREATE TABLE TO GHW;

-- �� ���� ������ ����Ŭ ����� ������ 
-- ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ���� 

ALTER USER GHW
QUOTA UNLIMITED ON TBS_EDUA;
--> User GHW��(��) ����Ǿ����ϴ�.