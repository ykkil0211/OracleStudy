select user
from dual;
/*
��Ʈ������ �±� ���	        PT_LIST             ��
��Ʈ�������Խ��� ���	        P_COMMENT           ��
������Ʈ (����Ȯ��)	        C_PROJECT           ��
������Ʈ ���� �±� ���	    PTAG_LIST           ��
������Ʈ �߰� ���� ����	    ADDITIONAL_OPEN     ��
������Ʈ Ż�� ����	        W_REASON            ��
������Ʈ Ż�� ���� ���	    W_MEMBERLIST        ��
������Ʈ ��ü	            D_PROJECT           ��
������Ʈ ��ü ����	        D_REASON            ��
������Ʈ ��ü ��ǥ	        D_VOTE              ��
������ ����	            PROFILE             ��
���� �Խ��� ���	            PROTEST_REPLY       ��
ȸ�� ��ų �±�	            SKIL_TAG            ��
ȸ�� ����	                MEM_INFO            ��
ȸ�Ƿ�	                MINUTES             ��
ȸ�Ƿ� ���	            MI_COMMENT
*/

--100 ���������� �±� 
CREATE TABLE P_TAG
( PT_CODE VARCHAR2(10)
, P_CODE VARCHAR2(10)
, PTL_CODE VARCHAR2(10)
, CONSTRAINT PT_PK PRIMARY KEY (PT_CODE)
);
--==>> Table P_TAG��(��) �����Ǿ����ϴ�.


CREATE SEQUENCE PT_SEQ
START WITH 1
NOCACHE;
--==>> Sequence PT_SEQ��(��) �����Ǿ����ϴ�.


--101 �������� �±� ���
CREATE TABLE PT_LIST
( PTL_CODE  VARCHAR2(10)
, NAME      VARCHAR2(100)
, CONSTRAINT PTL_PK PRIMARY KEY(PTL_CODE)
);
--==>> Table PT_LIST��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE PTL_SEQ
START WITH 1
NOCACHE;
--==> Sequence PTL_SEQ��(��) �����Ǿ����ϴ�.



--102 ��Ʈ�������Խ��� ��� --- �������� 
CREATE TABLE P_COMMENT
( PC_CODE    VARCHAR2(10)
, KDATE     DATE DEFAULT SYSDATE
, CONTENT   VARCHAR2(4000)
, P_CODE    VARCHAR2(10)
, MEM_CODE VARCHAR2(10)
, CONSTRAINT PC_PK PRIMARY KEY(PC_CODE)
);
--==> Table P_COMMENT��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE PC_SEQ
START WITH 1
NOCACHE;
--==>Sequence PC_SEQ��(��) �����Ǿ����ϴ�.

-- ��Ʈ������ �Խ��ǿ� �ִ� P_CODE�� ����
ALTER TABLE P_COMMENT
        ADD CONSTRAINT P_P_CODE_FK FOREIGN KEY(P_CODE)
                        REFERENCES PORTFOLIO(P_CODE);
--==>> Table P_COMMENT��(��) ����Ǿ����ϴ�.

ALTER TABLE P_COMMENT
        ADD CONSTRAINT P_MEM_CODE_FK FOREIGN KEY(MEM_CODE)
                        REFERENCES MEMBER(MEM_CODE);
--==>> Table P_COMMENT��(��) ����Ǿ����ϴ�.

--103 ������Ʈ (����Ȯ��)
CREATE TABLE C_PROJECT
( CP_CODE   VARCHAR2(10)
, KDATE     DATE DEFAULT SYSDATE
, AP_CODE VARCHAR2(10)
, CONSTRAINT CP_PK PRIMARY KEY(CP_CODE)
);
--==>> Table C_PROJECT��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE CP_SEQ
START WITH 1
NOCACHE;
--==>> Sequence CP_SEQ��(��) �����Ǿ����ϴ�.

-- ���� ��û�� �ִ� AP_CODE�� ���� ����(x)
ALTER TABLE C_PROJECT
        ADD CONSTRAINT C_AP_CODE FOREIGN KEY (AP_CODE)
                        REFERENCES APP_OPENING(AP_CODE);
--==>> Table C_PROJECT��(��) ����Ǿ����ϴ�.


--104 ������Ʈ ���� �±� ���
CREATE TABLE PTAG_LIST
( PL_CODE VARCHAR2(10)
, NAME VARCHAR2(100)
, CONSTRAINT PL_PK PRIMARY KEY(PL_CODE)
);
--==>> Table PTAG_LIST��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE PL_SEQ
START WITH 1
NOCACHE;
--==>> Sequence PL_SEQ��(��) �����Ǿ����ϴ�.


--105 ������Ʈ �߰� ���� ����
CREATE TABLE ADDITIONAL_OPEN
( AO_CODE VARCHAR2(10)
, TITLE VARCHAR2(100)
, SUMMARY VARCHAR2(4000)
, CONTENT VARCHAR2(4000)
, KDATE DATE DEFAULT SYSDATE 
, VIEWS NUMBER
, AP_CODE   VARCHAR2(10)
, CONSTRAINT ADDITIONAL_PK PRIMARY KEY(AO_CODE)
);
--==>>Table ADDITIONAL_OPEN��(��) �����Ǿ����ϴ�.


CREATE SEQUENCE AD_SEQ
START WITH 1
NOCACHE;
--==>> Sequence AD_SEQ��(��) �����Ǿ����ϴ�.

-- ���� ��û�� �ִ� AP_CODE�� ����
ALTER TABLE ADDITIONAL_OPEN
        ADD CONSTRAINT ADD_AP_CODE FOREIGN KEY (AP_CODE)
                        REFERENCES APP_OPENING(AP_CODE);
--==>> Table ADDITIONAL_OPEN��(��) ����Ǿ����ϴ�.

--106 ������Ʈ Ż�� ����	        
CREATE TABLE W_REASON 
( WR_CODE   VARCHAR2(10)
, REASON    VARCHAR2(100)
, PE_CODE   VARCHAR2(10)
, CONSTRAINT WR_PK PRIMARY KEY(WR_CODE)
);
--==>> Table W_REASON��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE WR_SEQ
START WITH 1
NOCACHE;
--==>> Sequence WR_SEQ��(��) �����Ǿ����ϴ�.

-- �г�Ƽ ���̺��� PE_CODE�� ������ 
ALTER TABLE W_REASON
            ADD CONSTRAINT WR_PE_CODE_FK FOREIGN KEY (PE_CODE)
                                    REFERENCES PENALTY(PE_CODE);
--==>> Table W_REASON��(��) ����Ǿ����ϴ�.

--107 ������Ʈ Ż�� ���� ���	
CREATE TABLE W_MEMBERLIST
( WM_CODE   VARCHAR2(10)
, KDATE     DATE DEFAULT SYSDATE
, MA_CODEA  VARCHAR2(10)
, MA_CODEP  VARCHAR2(10)
, WR_CODE   VARCHAR2(10)
, CONSTRAINT WM_PK PRIMARY KEY(WM_CODE)
);
--==>> Table W_MEMBERLIST��(��) �����Ǿ����ϴ�.


CREATE SEQUENCE WM_SEQ
START WITH 1
NOCACHE;
--==>> Sequence WM_SEQ��(��) �����Ǿ����ϴ�.

-- ��� ������ �ִ� MA_CODE�� ������ ������ ����� FK�� ����
ALTER TABLE W_MEMBERLIST
    ADD CONSTRAINT WM_MA_CODEA_FK FOREIGN KEY (MA_CODEA)
                                REFERENCES MEMBER_APPLY(MA_CODE);
--==>> Table W_MEMBERLIST��(��) ����Ǿ����ϴ�.

                                
-- ��� ������ �ִ� MA_CODE�� ������ ������ ����� FK�� ����
ALTER TABLE W_MEMBERLIST    
    ADD CONSTRAINT WM_MA_CODEP_FK FOREIGN KEY (MA_CODEP)
                                REFERENCES MEMBER_APPLY(MA_CODE);
--==>> Table W_MEMBERLIST��(��) ����Ǿ����ϴ�.


--108 ������Ʈ ��ü	
CREATE TABLE D_PROJECT
( DP_CODE   VARCHAR2(10)
, KDATE     DATE DEFAULT SYSDATE 
, CP_CODE   VARCHAR2(10)
, DR_CODE   VARCHAR2(10)
, CONSTRAINT DP_PK PRIMARY KEY (DP_CODE)
);
--==>> Table D_PROJECT��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE DP_SEQ
START WITH 1
NOCACHE;
--==>> Sequence DP_SEQ��(��) �����Ǿ����ϴ�.

-- ������Ʈ ���� Ȯ�� ���̺��� CP_CODE�� ����
ALTER TABLE D_PROJECT 
        ADD CONSTRAINT DP_CP_CODE_FK FOREIGN KEY (CP_CODE)
                        REFERENCES C_PROJECT(CP_CODE);
--==>> Table D_PROJECT��(��) ����Ǿ����ϴ�.


-- ������Ʈ ��ü���� ���̺��� DR_CODE�� ����     
ALTER TABLE D_PROJECT 
        ADD CONSTRAINT DP_DR_CODE_FK FOREIGN KEY (DR_CODE)
                        REFERENCES D_REASON(DR_CODE);
--==>> Table D_PROJECT��(��) ����Ǿ����ϴ�.


--109 ������Ʈ ��ü ����
CREATE TABLE D_REASON
( DR_CODE   VARCHAR2(10)
, REASON    VARCHAR2(100)
, CONSTRAINT DR_PK PRIMARY KEY(DR_CODE)
);
--==>> Table D_REASON��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE DR_SEQ
START WITH 1
NOCACHE;
--==>> Sequence DR_SEQ��(��) �����Ǿ����ϴ�.


--110 ������Ʈ ��ü ��ǥ
CREATE TABLE D_VOTE
( DV_CODE   VARCHAR2(10)
, SDATE     DATE DEFAULT SYSDATE 
, CONTENT   VARCHAR2(500)
, EDATE     DATE
, CP_CODE   VARCHAR2(10)
, CONSTRAINT DV_PK PRIMARY KEY(DV_CODE)
);
--==>> Table D_VOTE��(��) �����Ǿ����ϴ�.

ALTER TABLE D_VOTE RENAME COLUMN DC_CODE TO DV_CODE;


CREATE SEQUENCE DV_SEQ
START WITH 1
NOCACHE;
--==>> Sequence DV_SEQ��(��) �����Ǿ����ϴ�.

-- ������Ʈ (����Ȯ��) ���̺��� CP_CODE�� ����
ALTER TABLE D_VOTE
        ADD CONSTRAINT DV_CP_CODE_FK FOREIGN KEY (CP_CODE)
        REFERENCES C_PROJECT(CP_CODE);
--==>> Table D_VOTE��(��) ����Ǿ����ϴ�.


--111 ������ ����
CREATE TABLE PROFILE
( PI_CODE   VARCHAR2(10)
, PATH      VARCHAR2(1000)
, MEM_CODE  VARCHAR2(10)
, CONSTRAINT PI_PK PRIMARY KEY(PI_CODE)
);
--==>> Table PROFILE��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE PI_SEQ
START WITH 1
NOCACHE;
--==>>Sequence PI_SEQ��(��) �����Ǿ����ϴ�.

-- �Ϲ� ȸ�� ���̺��� MEM_CODE�� ����
ALTER TABLE PROFILE
        ADD CONSTRAINT PROF_MEM_CODE_FK FOREIGN KEY (MEM_CODE)
                                    REFERENCES MEMBER(MEM_CODE);
--==>> Table PROFILE��(��) ����Ǿ����ϴ�.


--112 ���� �Խ��� ���
CREATE TABLE PROTEST_REPLY
( PROC_CODE VARCHAR2(10)
, KDATE DATE DEFAULT SYSDATE
, CONTENT VARCHAR2(4000)
, PROTEST_CODE  VARCHAR2(10)
, ADMIN_CODE    VARCHAR2(10)
, CONSTRAINT PROC_PK PRIMARY KEY(PROC_CODE)
);
--==>> Table PROTEST_REPLY��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE PROC_SEQ
START WITH 1
NOCACHE;
--==>> Sequence PROC_SEQ��(��) �����Ǿ����ϴ�.

-- ������-���� �Խ����� PROTRST_CODE �ڵ带 ����  
ALTER TABLE PROTEST_REPLY
            ADD CONSTRAINT PROT_PROTEST_CODE_FK FOREIGN KEY(PROTEST_CODE)
            REFERENCES PROTEST(PROTEST_CODE);
--==>> Table PROTEST_REPLY��(��) ����Ǿ����ϴ�.


ALTER TABLE PROTEST_REPLY
            ADD CONSTRAINT PROT_ADMIN_CODE_FK FOREIGN KEY(ADMIN_CODE)
            REFERENCES ADMIN(ADMIN_CODE);
--==>> Table PROTEST_REPLY��(��) ����Ǿ����ϴ�.


--113 ȸ�� ��ų �±�
CREATE TABLE SKIL_TAG
( KT_CODE   VARCHAR2(10)
, SL_CODE   VARCHAR2(10)
, MEM_CODE  VARCHAR2(10)
, CONSTRAINT KT_PK PRIMARY KEY(KT_CODE)
);
--==>> Table SKIL_TAG��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE KT_SEQ
START WITH 1
NOCACHE;
--==>> Sequence KT_SEQ��(��) �����Ǿ����ϴ�.

-- ��ų�ױ׸�� ���̺��� SL_CODE�� ��
ALTER TABLE SKIL_TAG
            ADD CONSTRAINT SK_SL_CODE_FK FOREIGN KEY(SL_CODE)
            REFERENCES ST_LIST(SL_CODE);
--==>> Table SKIL_TAG��(��) ����Ǿ����ϴ�.


-- ȸ������ ���̺��� MEM_CODE�� ����
ALTER TABLE SKIL_TAG
            ADD CONSTRAINT SK_MEM_CODE_FK FOREIGN KEY(MEM_CODE)
            REFERENCES  MEMBER(MEM_CODE);
--==>> Table SKIL_TAG��(��) ����Ǿ����ϴ�.

--114 ȸ�� ����
CREATE TABLE MEM_INFO
( MI_CODE   VARCHAR2(10)
, EMAIL     VARCHAR2(50)
, BDAY      DATE
, ISG_OPEN  NUMBER
, ISB_OPEN  NUMBER
, ISE_OPEN  NUMBER
, MEM_CODE  VARCHAR2(10)
, GENDER_CODE VARCHAR2(10)
, CONSTRAINT MI_PK PRIMARY KEY(MI_CODE)
);
--==>> Table MEM_INFO��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE MI_SEQ
START WITH 1
NOCACHE;
--==>> Sequence MI_SEQ��(��) �����Ǿ����ϴ�.

-- �Ϲ� ȸ�� ���̺��� MEM_CODE�� ����
ALTER TABLE MEM_INFO
            ADD CONSTRAINT ME_MEM_CODE_FK FOREIGN KEY(MEM_CODE)
            REFERENCES  MEMBER(MEM_CODE);
--==>> Table MEM_INFO��(��) ����Ǿ����ϴ�.

ALTER TABLE MEM_INFO
            ADD CONSTRAINT ME_GENDER_CODE_FK FOREIGN KEY(GENDER_CODE)
            REFERENCES  GENDER(GENDER_CODE);
--==>> Table MEM_INFO��(��) ����Ǿ����ϴ�.

--115 ȸ�Ƿ�
CREATE TABLE MINUTES
( MN_CODE  VARCHAR2(10)
, KDATE     DATE DEFAULT SYSDATE
, TITLE     VARCHAR2(100)
, CONTENT   VARCHAR2(4000)
, MA_CODE   VARCHAR2(4000)
, CONSTRAINT MN_PK PRIMARY KEY(MN_CODE)
);
--==>> Table MINUTES��(��) �����Ǿ����ϴ�.

CREATE SEQUENCE MN_SEQ
START WITH 1
NOCACHE;
--==>> Sequence MIN_SEQ��(��) �����Ǿ����ϴ�.

-- ��� ���� ���̺��� MA_CODE�� ��
ALTER TABLE MINUTES
            ADD CONSTRAINT MIN_MA_CODE_FK FOREIGN KEY(MA_CODE)
            REFERENCES  MEMBER_APPLY(MA_CODE);
--==>> Table MINUTES��(��) ����Ǿ����ϴ�.


--116 ȸ�Ƿ� ���
CREATE TABLE MI_COMMENT
( MNC_CODE  VARCHAR2(10)
, COMMENTS   VARCHAR2(4000)
, KDATE     DATE DEFAULT SYSDATE
, MA_CODE   VARCHAR2(10)
, MN_CODE   VARCHAR2(10)
, CONSTRAINT MNC_PK PRIMARY KEY(MNC_CODE)
);
--==>> Table MI_COMMENT��(��) �����Ǿ����ϴ�.


CREATE SEQUENCE MNC_SEQ
START WITH 1
NOCACHE;
--==>> Sequence MNC_SEQ��(��) �����Ǿ����ϴ�.

ALTER TABLE MI_COMMENT
            ADD CONSTRAINT MI_MA_CODE_FK FOREIGN KEY(MA_CODE)
            REFERENCES  MEMBER_APPLY(MA_CODE);
--==>> Table MI_COMMENT��(��) ����Ǿ����ϴ�.


ALTER TABLE MI_COMMENT
            ADD CONSTRAINT MI_MN_CODE_FK FOREIGN KEY(MN_CODE)
            REFERENCES  MINUTES(MN_CODE);
--==>> Table MI_COMMENT��(��) ����Ǿ����ϴ�.


SELECT *
FROM MEMBER;
-- �� TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0'))

------------------ ��Ʈ������ �Խ���
INSERT INTO PORTFOLIO
VALUES (TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0')), '�̷¼� �ѹ��� ���ּ���.', '��¼�� ��¼�� ���� ��¼��',SYSDATE,2,'MEM0001');

INSERT INTO PORTFOLIO
VALUES (TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0')), '�̷¼� �ѹ��� ���ֶ�!!.', '�Ｚ ���� �;��',SYSDATE,245,'MEM0002');

INSERT INTO PORTFOLIO
VALUES (TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0')), '�� �̷� ����̾�~!.', '���� �ǵ�� ����',SYSDATE,17,'MEM0003');

INSERT INTO PORTFOLIO
VALUES (TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0')), '�̰� ���� �������� �� ����.', 'īī�� �尡��~',SYSDATE,82,'MEM0004');

INSERT INTO PORTFOLIO
VALUES (TO_CHAR('P' || LPAD(P_SEQ.NEXTVAL, 4, '0')), '���� ���� �̰� ����� ��...', '�� ������ ���?',SYSDATE,0,'MEM0005');

SELECT *
FROM PORTFOLIO;

--------- ��Ʈ������ �Խ��� ���
INSERT INTO P_COMMENT
VALUES (TO_CHAR('PC' || LPAD(PC_SEQ.NEXTVAL, 4, '0')), SYSDATE,'�� �������� ���� ���� ��','P0001','MEM0005');

INSERT INTO P_COMMENT
VALUES (TO_CHAR('PC' || LPAD(PC_SEQ.NEXTVAL, 4, '0')), SYSDATE,'�� ������ �߼� ���� �� ��','P0001','MEM0006');

INSERT INTO P_COMMENT
VALUES (TO_CHAR('PC' || LPAD(PC_SEQ.NEXTVAL, 4, '0')), SYSDATE,'�̰ɷ� ��� ����� ��','P0001','MEM0001');

INSERT INTO P_COMMENT
VALUES (TO_CHAR('PC' || LPAD(PC_SEQ.NEXTVAL, 4, '0')), SYSDATE,'�ǰڳ�? ������','P0001','MEM0001');

INSERT INTO P_COMMENT
VALUES (TO_CHAR('PC' || LPAD(PC_SEQ.NEXTVAL, 4, '0')), SYSDATE,'�� ����','P0001','MEM0002');

SELECT *
FROM P_COMMENT;

------------ ��Ʈ������ �Խ��� ���� 
INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '�ԼҸ� �ҰŸ� ���� ���� ��','MEM0006', 'PC0003');

INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '��� �ϸ� �Ǵµ�??','MEM0001', 'PC0003');

INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '���븸 �����ϸ� �ɵ�?','MEM0002', 'PC0003');

INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '���븸 �����ϸ� �ɵ�?','MEM0002', 'PC0004');

INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '��ӳ� �̷��� ������~!','MEM0007', 'PC0005');

INSERT INTO P_REPLY2
VALUES (TO_CHAR('P2' || LPAD(P2_SEQ.NEXTVAL, 4, '0')), SYSDATE, '���� ���~!~!~!~!~!~!','MEM0009', 'PC0005');

SELECT *
FROM P_REPLY2;


--------- ��Ʈ������ �±� ��� 
INSERT INTO PT_LIST
VALUES (TO_CHAR('PTL' || LPAD(PTL_SEQ.NEXTVAL, 4, '0')), '�ڹ�');

INSERT INTO PT_LIST
VALUES (TO_CHAR('PTL' || LPAD(PTL_SEQ.NEXTVAL, 4, '0')), 'SQL');

INSERT INTO PT_LIST
VALUES (TO_CHAR('PTL' || LPAD(PTL_SEQ.NEXTVAL, 4, '0')), '���̽�');

INSERT INTO PT_LIST
VALUES (TO_CHAR('PTL' || LPAD(PTL_SEQ.NEXTVAL, 4, '0')), '��Ʋ��');

INSERT INTO PT_LIST
VALUES (TO_CHAR('PTL' || LPAD(PTL_SEQ.NEXTVAL, 4, '0')), '�ڹ� ��ũ��Ʈ');

SELECT *
FROM PT_LIST;

------------------------------------- ��Ʈ������ �±� 
INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0005','PTL0001');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0005','PTL0002');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0005','PTL0005');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0002','PTL0003');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0002','PTL0004');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0002','PTL0005');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0003','PTL0001');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0003','PTL0003');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0003','PTL0004');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0004','PTL0001');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0004','PTL0003');

INSERT INTO P_TAG
VALUES (TO_CHAR('PT' || LPAD(PT_SEQ.NEXTVAL, 4, '0')), 'P0004','PTL0004');

SELECT *
FROM P_TAG;

------------------------------------ ���������� �Խ��� �Ű� 
INSERT INTO P_REPORT
VALUES (TO_CHAR('PR' || LPAD(PR_SEQ.NEXTVAL, 4, '0')), '������ ��尨�� ����ϴ�;;',SYSDATE, 'P0002','RR0001','MEM0006');

INSERT INTO P_REPORT
VALUES (TO_CHAR('PR' || LPAD(PR_SEQ.NEXTVAL, 4, '0')), '�̻��Ѱ� ����°� ������~~~',SYSDATE, 'P0002','RR0001','MEM0007');

INSERT INTO P_REPORT
VALUES (TO_CHAR('PR' || LPAD(PR_SEQ.NEXTVAL, 4, '0')), '�׳� �̻��� �� ���Ƽ� �Ű��߾��~!~ ����?? ^.^',SYSDATE, 'P0003','RR0001','MEM0011');

INSERT INTO P_REPORT
VALUES (TO_CHAR('PR' || LPAD(PR_SEQ.NEXTVAL, 4, '0')), '�׳� �̻��� �� ���Ƽ� �Ű��߾��~!~ ����?? ���� ^.^',SYSDATE, 'P0003','RR0001','MEM0014');

INSERT INTO P_REPORT
VALUES (TO_CHAR('PR' || LPAD(PR_SEQ.NEXTVAL, 4, '0')), '�׳� �̻��� �� ���Ƽ� �Ű��߾��~!~ ����?? ���� ^.^',SYSDATE, 'P0005','RR0001','MEM0013');

SELECT *
FROM P_REPORT;



----------------------------------- ��Ʈ������ �Խ��� ��� �Ű� 
INSERT INTO PC_REPORT
VALUES (TO_CHAR('PCR' || LPAD(PCR_SEQ.NEXTVAL, 4, '0')), '�̷� ����� ó�� �޾ƺþ�;;', SYSDATE,'PC0011', 'RR0001', 'MEM0002');

INSERT INTO PC_REPORT
VALUES (TO_CHAR('PCR' || LPAD(PCR_SEQ.NEXTVAL, 4, '0')), '��� �̷� ���� �� ���� ����..?', SYSDATE,'PC0012', 'RR0001', 'MEM0003');

INSERT INTO PC_REPORT
VALUES (TO_CHAR('PCR' || LPAD(PCR_SEQ.NEXTVAL, 4, '0')), '�갡 �� �ǵ�Ⱦ��... ��¿�ǵ�~!~!', SYSDATE,'PC0013', 'RR0001', 'MEM0006');

INSERT INTO PC_REPORT
VALUES (TO_CHAR('PCR' || LPAD(PCR_SEQ.NEXTVAL, 4, '0')), '�׷��� ������ �� ������� �� ���� �ϴ°� ��...', SYSDATE,'PC0011', 'RR0001', 'MEM0001');

SELECT *
FROM PC_REPORT;



COMMIT;

---------------------------------------- ��Ʈ������ �Խ��� ���� �Ű� 
INSERT INTO P2_REPORT 
VALUES (TO_CHAR('P2R' || LPAD(P2R_SEQ.NEXTVAL, 4, '0')), '�弳 �߾��!!!!!',SYSDATE, 'RR0001','P20013','MEM0005');

INSERT INTO P2_REPORT 
VALUES (TO_CHAR('P2R' || LPAD(P2R_SEQ.NEXTVAL, 4, '0')), '�̷� ���� ����...?',SYSDATE,'RR0001','P20003','MEM0009');

INSERT INTO P2_REPORT 
VALUES (TO_CHAR('P2R' || LPAD(P2R_SEQ.NEXTVAL, 4, '0')), '�� �̻���� ������ ���µ� �� �̷��� ���Ѹ��� �ϴ°���? �ٷ�  ��� �尥�Կ�...',SYSDATE, 'RR0001','P20005','MEM0008');

INSERT INTO P2_REPORT 
VALUES (TO_CHAR('P2R' || LPAD(P2R_SEQ.NEXTVAL, 4, '0')), '���� �ٷ� �ĳ� �ĳ�~!',SYSDATE, 'RR0001','PC0006','MEM0008');

SELECT *
FROM P2_REPORT;

UPDATE P2_REPORT
SET P2_CODE = 'P20014'
WHERE P2R_CODE = 'P2R0007';

SELECT *
FROM P_REPLY2;

----------------------------------------- ��Ʈ������ �Խ��� �Ű� ó�� 
INSERT INTO P_PROCESS
VALUES (TO_CHAR('PP' || LPAD(PP_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PR0011','ADMIN0001','PRE0001','PE0002','PTG0001'); 

INSERT INTO P_PROCESS
VALUES (TO_CHAR('PP' || LPAD(PP_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PR0007','ADMIN0002','PRE0001','PE0001','PTG0001');

INSERT INTO P_PROCESS
VALUES (TO_CHAR('PP' || LPAD(PP_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PR0008','ADMIN0002','PRE0001','PE0003','PTG0002');

INSERT INTO P_PROCESS
VALUES (TO_CHAR('PP' || LPAD(PP_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PR0009','ADMIN0003','PRE0001','PE0002','PTG0002');

INSERT INTO P_PROCESS
VALUES (TO_CHAR('PP' || LPAD(PP_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PR0010','ADMIN0001','PRE0001','PE0001','PTG0001'); 

SELECT *
FROM P2_PROCESS;

----------------------------------------- ��Ʈ������ �Խ��� ��� �Ű� ó�� 
INSERT INTO PC_PROCESS
VALUES (TO_CHAR('PRR' || LPAD(PRR_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PCR0001','ADMIN0001', 'PRE0001', 'PE0001','PTG0002');

INSERT INTO PC_PROCESS
VALUES (TO_CHAR('PRR' || LPAD(PRR_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PCR0002','ADMIN0001', 'PRE0001', 'PE0001','PTG0002');

INSERT INTO PC_PROCESS
VALUES (TO_CHAR('PRR' || LPAD(PRR_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PCR0003','ADMIN0003', 'PRE0001', 'PE0001','PTG0001');

INSERT INTO PC_PROCESS
VALUES (TO_CHAR('PRR' || LPAD(PRR_SEQ.NEXTVAL, 4, '0')), SYSDATE,'PCR0004','ADMIN0001','PRE0001', 'PE0001','PTG0002');

SELECT *
FROM PC_PROCESS;

---------------------------------------------- ��Ʈ������ �Խ��� ���� �Ű� ó�� 

INSERT INTO P2_PROCESS
VALUES (TO_CHAR('P2P' || LPAD(P2P_SEQ.NEXTVAL, 4, '0')),SYSDATE, 'P2R0001', 'PRE0001','PE0001','ADMIN0002','PTG0001');

INSERT INTO P2_PROCESS
VALUES (TO_CHAR('P2P' || LPAD(P2P_SEQ.NEXTVAL, 4, '0')),SYSDATE, 'P2R0002', 'PRE0001','PE0002','ADMIN0003','PTG0001');

INSERT INTO P2_PROCESS
VALUES (TO_CHAR('P2P' || LPAD(P2P_SEQ.NEXTVAL, 4, '0')),SYSDATE, 'P2R0003', 'PRE0001','PE0003','ADMIN0001','PTG0002');

INSERT INTO P2_PROCESS
VALUES (TO_CHAR('P2P' || LPAD(P2P_SEQ.NEXTVAL, 4, '0')),SYSDATE, 'P2R0004', 'PRE0001','PE0001','ADMIN0001','PTG0002');

SELECT *
FROM P2_PROCESS;

--TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0'))
------------------------------------------------ ȸ�Ƿ� 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 1ȸ�� ȸ�Ƿ�', '���� : ������ �����ϰ�, ���� : SELECT�� �ۼ�','MA0001'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0001'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0002');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0002'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0003');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0003'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0004');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '3�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0004');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0005');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0005'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 8ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0006');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 9ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0006'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '4�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0007');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '4�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0007'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0008');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0008'); 

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 1ȸ�� ȸ�Ƿ�', '���� : ������ ����, ���� : SELECT�� �ۼ�','MA0009');

INSERT INTO MINUTES
VALUES(TO_CHAR('MN' || LPAD(MN_SEQ.NEXTVAL, 4, '0')),SYSDATE, '2�� 2ȸ�� ȸ�Ƿ�', '���� : SELECT�� �ۼ�, ���� : ���ν��� ����','MA0009'); 

SELECT *
FROM MINUTES;

------------------------------------ ȸ�Ƿ� ��� 
INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '���ϽŰ� ���׿�', SYSDATE,'MA0001','MN0002'); 

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '���ϼ̾��~!!', SYSDATE,'MA0003','MN0002');

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�� ���� �ɱ� �����Ѱ� ��������??', SYSDATE,'MA0004','MN0003'); 

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�±±�', SYSDATE,'MA0005','MN0001');

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�±±�', SYSDATE,'MA0006','MN0001');

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�±±�', SYSDATE,'MA0007','MN0001');

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�±±�', SYSDATE,'MA0008','MN0001');

INSERT INTO MI_COMMENT
VALUES (TO_CHAR('MNC' || LPAD(MNC_SEQ.NEXTVAL, 4, '0')), '�±±�', SYSDATE,'MA0009','MN0001');

--------------------------------------------------------------------------------- �ų� ���� ���͸�
INSERT INTO MS_FILTER
VALUES (TO_CHAR('MSF' || LPAD(MSF_SEQ.NEXTVAL, 4, '0')), 36,'AP0001');

INSERT INTO MS_FILTER
VALUES (TO_CHAR('MSF' || LPAD(MSF_SEQ.NEXTVAL, 4, '0')), 0,'AP0002');

INSERT INTO MS_FILTER
VALUES (TO_CHAR('MSF' || LPAD(MSF_SEQ.NEXTVAL, 4, '0')), 37,'AP0003');

INSERT INTO MS_FILTER
VALUES (TO_CHAR('MSF' || LPAD(MSF_SEQ.NEXTVAL, 4, '0')), 34,'AP0004');

SELECT *
FROM MS_FILTER;

-------------------------------------------------------------------------------------- ���� ���͸� 
INSERT INTO A_FILTER 
VALUES (TO_CHAR('AF' || LPAD(AF_SEQ.NEXTVAL, 4, '0')), 'AP0001', 'AA0003');

INSERT INTO A_FILTER 
VALUES (TO_CHAR('AF' || LPAD(AF_SEQ.NEXTVAL, 4, '0')), 'AP0002', 'AA0004');

INSERT INTO A_FILTER 
VALUES (TO_CHAR('AF' || LPAD(AF_SEQ.NEXTVAL, 4, '0')), 'AP0003', 'AA0005');

INSERT INTO A_FILTER 
VALUES (TO_CHAR('AF' || LPAD(AF_SEQ.NEXTVAL, 4, '0')), 'AP0004', 'AA0001');

INSERT INTO A_FILTER 
VALUES (TO_CHAR('AF' || LPAD(AF_SEQ.NEXTVAL, 4, '0')), 'AP0005', 'AA0002');

SELECT *
FROM A_FILTER;

------------------------------------------------------------------------ ��� ���͸� 
INSERT INTO G_FILTER
VALUES (TO_CHAR('GF' || LPAD(GF_SEQ.NEXTVAL, 4, '0')), 'GRADE0001','MR0002', 'AP0001');

INSERT INTO G_FILTER
VALUES (TO_CHAR('GF' || LPAD(GF_SEQ.NEXTVAL, 4, '0')), 'GRADE0002','MR0002', 'AP0002');

INSERT INTO G_FILTER
VALUES (TO_CHAR('GF' || LPAD(GF_SEQ.NEXTVAL, 4, '0')), 'GRADE0003','MR0003', 'AP0003');

INSERT INTO G_FILTER
VALUES (TO_CHAR('GF' || LPAD(GF_SEQ.NEXTVAL, 4, '0')), 'GRADE0004','MR0003', 'AP0004');

INSERT INTO G_FILTER
VALUES (TO_CHAR('GF' || LPAD(GF_SEQ.NEXTVAL, 4, '0')), 'GRADE0005','MR0002', 'AP0005');

SELECT *
FROM G_FILTER;

------------------------------------------------------------------------------- ���� ���͸� 
INSERT INTO S_FILTER
VALUES(TO_CHAR('SF' || LPAD(SF_SEQ.NEXTVAL, 4, '0')), 'GENDER0001', 'AP0001');

INSERT INTO S_FILTER
VALUES(TO_CHAR('SF' || LPAD(SF_SEQ.NEXTVAL, 4, '0')), 'GENDER0001', 'AP0002');

INSERT INTO S_FILTER
VALUES(TO_CHAR('SF' || LPAD(SF_SEQ.NEXTVAL, 4, '0')), 'GENDER0002', 'AP0003');

INSERT INTO S_FILTER
VALUES(TO_CHAR('SF' || LPAD(SF_SEQ.NEXTVAL, 4, '0')), 'GENDER0002', 'AP0004');

INSERT INTO S_FILTER
VALUES(TO_CHAR('SF' || LPAD(SF_SEQ.NEXTVAL, 4, '0')), 'GENDER0001', 'AP0005');

SELECT *
FROM S_FILTER;

------------------------------------------------------------------------- ������Ʈ ��ü ��ǥ 
INSERT INTO D_VOTE
VALUES (TO_CHAR('DV' || LPAD(DV_SEQ.NEXTVAL, 4, '0')),TO_DATE('2024-02-09','YYYY-MM-DD'), '������ ����Դϴ�...',TO_DATE('2024-02-14','YYYY-MM-DD'),'CP0001');

SELECT *
FROM D_VOTE;

---------------------------------------------------------------------- ��ǥ 
INSERT INTO AG_LIST
VALUES (TO_CHAR('AL' || LPAD(AL_SEQ.NEXTVAL, 4, '0')),'MA0001', 'DV0001');

INSERT INTO AG_LIST
VALUES (TO_CHAR('AL' || LPAD(AL_SEQ.NEXTVAL, 4, '0')),'MA0002', 'DV0001');

SELECT *
FROM AG_LIST;

------------------------------------------------------------------------ �½�ũ
INSERT INTO TT_LIST
VALUES (TO_CHAR('TTL' || LPAD(TTL_SEQ.NEXTVAL, 4, '0')), '�������� �����');

INSERT INTO TT_LIST
VALUES (TO_CHAR('TTL' || LPAD(TTL_SEQ.NEXTVAL, 4, '0')), '���̺� ����');

INSERT INTO TT_LIST
VALUES (TO_CHAR('TTL' || LPAD(TTL_SEQ.NEXTVAL, 4, '0')), 'ȸ�Ƿ� �ۼ�');

INSERT INTO TT_LIST
VALUES (TO_CHAR('TTL' || LPAD(TTL_SEQ.NEXTVAL, 4, '0')), 'SQL ����');

SELECT *
FROM TT_LIST;

-------------------------------------------------------------------- �½�ũ �±� 
INSERT INTO TASK_TAG
VALUES (TO_CHAR('TT' || LPAD(TT_SEQ.NEXTVAL, 4, '0')),'TTL0001','TASK0001');

INSERT INTO TASK_TAG
VALUES (TO_CHAR('TT' || LPAD(TT_SEQ.NEXTVAL, 4, '0')),'TTL0002','TASK0002');

SELECT *
FROM TASK_TAG;

------------------------------------------------------------------------------- ������Ʈ ��ü 
INSERT INTO D_PROJECT 
VALUES (TO_CHAR('TT' || LPAD(TT_SEQ.NEXTVAL, 4, '0')), SYSDATE,'CP0001', 'DR0001');

SELECT *
FROM D_PROJECT;

------------------------------------------------------------------------------------ �� 
INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 5, 'ED0001','MA0001','MA0002');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 3, 'ED0002','MA0001','MA0002');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 5, 'ED0001','MA0002','MA0001');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 3, 'ED0002','MA0002','MA0001');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 1, 'ED0001','MA0002','MA0003');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 2, 'ED0002','MA0002','MA0003');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 1, 'ED0001','MA0003','MA0002');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 1, 'ED0002','MA0003','MA0002');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 4, 'ED0001','MA0001','MA0003');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 4, 'ED0002','MA0001','MA0003');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 5, 'ED0001','MA0003','MA0001');

INSERT INTO EVALUATION
VALUES (TO_CHAR('EV' || LPAD(EV_SEQ.NEXTVAL, 4, '0')), SYSDATE, 2, 'ED0002','MA0003','MA0001');

SELECT *
FROM EVALUATION;

----------------------------------------------------------------------------------------- ��� ���� 
INSERT INTO FINAL_REPORT 
VALUES (TO_CHAR('FR' || LPAD(FR_SEQ.NEXTVAL, 4, '0')),'��� ����','�����Դϴ�.',TO_DATE('2024-02-29','YYYY-MM-DD'), 'CP0001');

SELECT *
FROM FINAL_REPORT;

----------------------------------------------------------------------------------------- ���� ����
INSERT INTO RELEASE
VALUES (TO_CHAR('RE' || LPAD(RE_SEQ.NEXTVAL, 4, '0')), SYSDATE, 'TASK0001','CP0001');

SELECT *
FROM RELEASE;

------------------------------------------------------------------------------------- ���� ���� 
INSERT INTO D_LEADER
VALUES (TO_CHAR('DL' || LPAD(DL_SEQ.NEXTVAL, 4, '0')), SYSDATE, 'MA0003','RE0001');

SELECT *
FROM D_LEADER;

----------------------------------------------------------------------------------- ERD
INSERT INTO ERD
VALUES (TO_CHAR('ERD' || LPAD(DL_SEQ.NEXTVAL, 4, '0')), 'https://www.erdcloud.com/d/9A5ig9f7TQCyxe4Pj', 'FR0008');

INSERT INTO ERD
VALUES (TO_CHAR('ERD' || LPAD(DL_SEQ.NEXTVAL, 4, '0')), 'https://www.naver.com', 'FR0008');

INSERT INTO ERD
VALUES (TO_CHAR('ERD' || LPAD(DL_SEQ.NEXTVAL, 4, '0')), 'https://maplestory.nexon.com/Home/Main', 'FR0008');

SELECT *
FROM ERD;

--------------------------------------------------------------- ������ 
INSERT INTO FLOWCHART
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'https://fonts.google.com/icons?selected=Material+Symbols+Outlined:settings:FILL@0;wght@400;GRAD@0;opsz@24', 'FR0008');

INSERT INTO FLOWCHART
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'https://fonts.google.com/icons?selected=Material+Symbols+Outlined:settings:FILL@0;wght@400;GRAD@0;opsz@21', 'FR0008');

INSERT INTO FLOWCHART
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'https://fonts.google.com/icons?selected=Material+Symbols+Outlined:settings:FILL@0;wght@400;GRAD@0;opsz@17', 'FR0008');

SELECT *
FROM FLOWCHART;

----------------------------------------------------------------------------------
INSERT INTO FR_FILE
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'C:\Downloads','FR0008');

INSERT INTO FR_FILE
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'C:\Downloads','FR0008');

INSERT INTO FR_FILE
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'C:\Downloads','FR0008');

INSERT INTO FR_FILE
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'C:\Downloads','FR0008');

INSERT INTO FR_FILE
VALUES (TO_CHAR('FC' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), 'C:\Downloads','FR0008');

SELECT *
FROM FR_FILE;

-----------------------------------------------------------------------------------
INSERT INTO TEAM_FEEDBACK
VALUES (TO_CHAR('TF' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), '���� �ֿ����� �ð��̿����ϴ�. �ٽ� ����',SYSDATE, 'MA0001', 'FR0008');

INSERT INTO TEAM_FEEDBACK
VALUES (TO_CHAR('TF' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), '���� ���� �ð��̿��� HTML�� VIEW �ٽ� ����',SYSDATE, 'MA0002', 'FR0008');

INSERT INTO TEAM_FEEDBACK
VALUES (TO_CHAR('TF' || LPAD(FC_SEQ.NEXTVAL, 4, '0')), '���� �� ������ ������ �ӿ��� ������Ʈ �ϴϰ� �� ��ſ� �ð��̿��� ��',SYSDATE, 'MA0003', 'FR0008');

SELECT *
FROM TEAM_FEEDBACK;

---------------------------------------------------------------------------- üũ����Ʈ 
INSERT INTO CHECKLIST
VALUES (TO_CHAR('CK' || LPAD(CK_SEQ.NEXTVAL, 4, '0')), '���� ���� �� ������ �����', SYSDATE, 'ST0001', 


SELECT *
FROM CHECKLIST;

SELECT *
FROM STEP;

SELECT *
FROM EV_DEVISION;

SELECT *
FROM TASK;

-- Ż�� ���� 
SELECT *
FROM D_REASON;

-- ���� Ȯ��
SELECT *
FROM C_PROJECT;

SELECT *
FROM A_RESULT;

SELECT *
FROM APP_OPENING;

SELECT *
FROM MEMBER_APPLY;

SELECT *
FROM ROLE_COMP;

SELECT *
FROM MILESTONE;

------------------------------------------------------------------- ������
SELECT *
FROM APP_OPENING;

SELECT *
FROM MEMBER;

SELECT *
FROM TECH_QNA;

SELECT *
FROM C_QnA;

SELECT *
FROM PORTFOLIO;


