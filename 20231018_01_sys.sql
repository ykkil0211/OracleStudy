--�� ���ӵ� ����� ���� ��ȸ 
SELECT USER
FROM DUAL;
-->SYS

--------------------------------------------------------------------------------
-- SCOTT ������ Ȱ���� �� �ִ� ȯ�� ���� 

--�� ����� ���� ����(SCOTT /TIGER)

create user scott
identified by tiger;
-- User SCOTT��(��) �����Ǿ����ϴ�.

-- ����� ������ ����(��) �ο�
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
-- Grant��(��) �����߽��ϴ�.

-- SCOTT ����� ������ �⺻ ���̺����̽��� USERS�� ����(����)
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--> User SCOTT��(��) ����Ǿ����ϴ�.

--�� SOCOTT ����� ������ �ӽ� ���̺����̽��� TEMP�� ����(����)
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--> User SCOTT��(��) ����Ǿ����ϴ�.

--�� ����� ���� Ȯ��
SELECT *
FROM DBA_USERS;
--> SCOTT	49		OPEN		24/04/15	USERS	TEMP	23/10/18	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD





