SELECT USER
FROM DUAL;
--==> SYS

-- ���� �ο�(SYS �� SCOTT)
GRANT CREATE ANY JOB TO SCOTT;
-- Grant��(��) �����߽��ϴ�.

GRANT EXECUTE ON DBMS_SCHEDULER TO SCOTT;
-- Grant��(��) �����߽��ϴ�.

GRANT EXECUTE ON DBMS_ISCHED TO SCOTT;
-- Grant��(��) �����߽��ϴ�.

GRANT CREATE JOB, MANAGE SCHEDULER TO SCOTT;
-- Grant��(��) �����߽��ϴ�.