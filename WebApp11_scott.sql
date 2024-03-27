SELECT USER
FROM DUAL;
--==>> SCOTT

--�� ���� ���̺� ����

DROP TABLE TBL_SCORE;
--==>> Table TBL_SCORE��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���̺� ���� (TBL_SCORE)

CREATE TABLE TBL_SCORE
( SID   NUMBER
, NAME  VARCHAR2(30)
, KOR   NUMBER(3)
, ENG   NUMBER(3)
, MAT   NUMBER(3)
);
--==>> Table TBL_SCORE��(��) �����Ǿ����ϴ�.


--�� ������ ���̺� �������� �߰�

ALTER TABLE TBL_SCORE
ADD CONSTRAINT SCORE_SID_PK PRIMARY KEY(SID);
--==>> Table TBL_SCORE��(��) ����Ǿ����ϴ�.


ALTER TABLE TBL_SCORE
ADD CONSTRAINT SCORE_KOR_CK CHECK(KOR BETWEEN 0 AND 100);
--==>> Table TBL_SCORE��(��) ����Ǿ����ϴ�.

ALTER TABLE TBL_SCORE
ADD CONSTRAINT SCORE_ENG_CK CHECK(ENG BETWEEN 0 AND 100);
--==>> Table TBL_SCORE��(��) ����Ǿ����ϴ�.

ALTER TABLE TBL_SCORE
ADD CONSTRAINT SCORE_MAT_CK CHECK(MAT BETWEEN 0 AND 100);
--==>> Table TBL_SCORE��(��) ����Ǿ����ϴ�.


--�� ���� ������ ����

DROP SEQUENCE SCORESEQ;
--==>> Sequence SCORESEQ��(��) �����Ǿ����ϴ�.


--�� �ǽ� ���� ������ �ٽ� ����

CREATE SEQUENCE SCORESEQ
NOCACHE;
--==>> Sequence SCORESEQ��(��) �����Ǿ����ϴ�.


--�� ����Ʈ ��ȸ ������ ����
--   (��ȣ, �̸�, ��������, ��������, ��������, ����, ���)

SELECT SID, NAME, KOR, ENG, MAT
    , (KOR+ENG+MAT) AS TOT
    , (KOR+ENG+MAT)/3 AS AVG
FROM TBL_SCORE
ORDER BY SID;
--> �� �� ����
SELECT SID, NAME, KOR, ENG, MAT, (KOR+ENG+MAT) AS TOT, (KOR+ENG+MAT)/3 AS AVG FROM TBL_SCORE ORDER BY SID;

SELECT COUNT(*) AS COUNT FROM TBL_SCORE
;

--�� ������ �Է� ������ ����

INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT)
VALUES(SCORESEQ.NEXTVAL, '���ϼ�', 90, 80, 70);
--> �� �� ����
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '���ϼ�', 90, 80, 70)
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� ���� ������ �߰� �Է�
INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) VALUES(SCORESEQ.NEXTVAL, '������', 80, 70, 60)
;
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.



--�� Ȯ��

SELECT *
FROM TBL_SCORE;
--==>>
/*
========================
SID	NAME	    KOR	ENG	MAT
========================
1	���ϼ�	90	80	70
2	������	80	70	60
========================
*/



--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.







