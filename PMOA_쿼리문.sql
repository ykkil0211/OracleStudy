-- �� ��ü ȸ�� ��ȸ ����
SELECT M.MEM_CODE
      ,M.ID
      ,M.PW
      ,M.NICKNAME
      ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM ) AS POST
      ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2) AS COMMENTS
      , M.KDATE
      , MB.MBTI
FROM MEMBER M
LEFT JOIN
(
    SELECT (
                SELECT COUNT(APP.AP_CODE)
                FROM MEMBER m1 
                LEFT JOIN APP_OPENING APP ON m1.MEM_CODE = APP.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS APP_NUM
            ,
            (
                SELECT COUNT(TQ.TQ_CODE)
                FROM MEMBER m2
                LEFT JOIN TECH_QNA TQ  ON m2.MEM_CODE = TQ.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TQ_NUM
            ,(
                SELECT COUNT(CQ.CQ_CODE)
                FROM MEMBER m1 
                LEFT JOIN C_QnA CQ ON m1.MEM_CODE = CQ.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(PO.P_CODE)
                FROM MEMBER m2
                LEFT JOIN PORTFOLIO PO  ON m2.MEM_CODE = PO.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS PO_NUM
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
)PT ON M.MEM_CODE = PT.MEM_CODE
LEFT JOIN 
(
            SELECT (
                SELECT COUNT(AO.AC_CODE)
                FROM MEMBER M1
                LEFT JOIN AO_COMMENT AO ON AO.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS AO_NUM
            ,
            (
                SELECT COUNT(AOR.A2_CODE)
                FROM MEMBER M2
                LEFT JOIN AO_REPLY2 AOR ON AOR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS AOR_NUM2
            ,
            (
                SELECT COUNT(TC.TC_CODE)
                FROM MEMBER m1
                LEFT JOIN TQ_COMMENT tc ON m1.MEM_CODE = tc.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS TC_NUM
            ,
            (
                SELECT COUNT(tr.T2_CODE) AS TT_COUNT
                FROM MEMBER m2 LEFT JOIN TQ_REPLY2 tr  ON m2.MEM_CODE = tr.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TT_NUM
            ,(
                SELECT COUNT(CQ.CQC_CODE)
                FROM MEMBER M1
                LEFT JOIN CQ_COMMENT CQ ON CQ.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(CQR.CQ2_CODE)
                FROM MEMBER M2
                LEFT JOIN CQ_REPLY2 CQR ON CQR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS CQR_NUM2
            ,(
                SELECT COUNT(P.PC_CODE)
                FROM MEMBER M1
                LEFT JOIN P_COMMENT P ON P.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS P_NUM
            ,
            (
                SELECT COUNT(PR.P2_CODE)
                FROM MEMBER M2
                LEFT JOIN P_REPLY2 PR ON PR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS PR_NUM2
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
) CT ON M.MEM_CODE = CT.MEM_CODE
     JOIN 
        MBTI MB ON MB.MBTI_CODE = M.MBTI_CODE
GROUP BY M.MEM_CODE, M.ID, M.PW, M.NICKNAME, M.KDATE, MB.MBTI
        ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM )
        ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2)
ORDER BY M.MEM_CODE;
----------------------------------------------------------------------------------------(�ϴ� �� ���� ���� �ƴ�);; �ٽ� �ؾ��� �׸��� ������Ʈ �ڵ嵵 �־��� 
-- �� �г�Ƽ ���� ȸ�� 
-- ��� �ڵ�, �̸�, ���̵�, ������, �Ű� ����, �Ű� ����, �Ű� ����, �г�Ƽ ���� 

select m.mem_code as MEM_CODE -- ���� ��û ���ñ� �Ű�ó��
     , m.nickname as NICKNAME
     , m.id as NAME
     , m.kdate as KDATE
     , aor.aor_code as �Ű�����
     , rep.reason as �Ű���
     , aor.kdate as �Ű�¥
     , pen.name as �г�Ƽ 
     , pre.reason as ó������
     , aop.kdate as ó����¥
     , pta.target as ó��
from member m
    join ao_report aor on aor.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = aor.rr_code
    join ao_process aop on aop.aor_code = aor.aor_code
    join p_reason pre on pre.pre_code = aop.pre_code
    join p_target pta on pta.ptg_code = aop.ptg_code
    join penalty pen on pen.pe_code = aop.pe_code 
union all -- ������û ��� �Ű�ó�� 
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , aoc.acr_code as �Ű�����
     , rep.reason as �Ű���
     , aoc.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , aocp.kdate as ó����¥
     , pta.target as ó��
from member m
    join aoc_report aoc on aoc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = aoc.rr_code
    join aoc_process aocp on aocp.acr_code = aoc.acr_code
    join p_reason pre on pre.pre_code = aocp.pre_code
    join p_target pta on pta.ptg_code = aocp.ptg_code
    join penalty pen on pen.pe_code = aocp.pe_code 
)
union all
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , ao2.a2r_code as �Ű�����
     , rep.reason as �Ű���
     , ao2.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , ao2p.kdate as ó����¥
     , pta.target as ó��
     
from member m -- ���� ��û �Խ��� ���� �Ű� ó��
    join ao2_report ao2 on ao2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = ao2.rr_code
    join AO2_PROCESS ao2p on ao2p.a2r_code = ao2.a2r_code
    join penalty pen on pen.pe_code = ao2p.pe_code 
    join p_reason pre on pre.pre_code = ao2p.pre_code
    join p_target pta on pta.ptg_code = ao2p.ptg_code
    join penalty pen on pen.pe_code = ao2p.pe_code 
)
union all -- ��� ��û �Խ��� �Ű� ó�� 
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tq.tqr_code as �Ű�����
     , rep.reason as �Ű���
     , tq.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tqr.kdate as ó����¥
     , pta.target as ó��     
from member m
    join tq_report tq on tq.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tq.rr_code
    join tq_process tqr on tqr.tqr_code = tq.tqr_code
    join penalty pen on pen.pe_code = tqr.pe_code 
    join p_reason pre on pre.pre_code = tqr.pre_code
    join p_target pta on pta.ptg_code = tqr.ptg_code
    join penalty pen on pen.pe_code = tqr.pe_code 
)
union all --��� �Խ��� ��� �Ű� ó��
(
 select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tqc.qcr_code as �Ű�����
     , rep.reason as �Ű���
     , tqc.kdate as �Ű�¥     
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tqcr.kdate as ó����¥
     , pta.target as ó�� 
from member m
    join tqc_report tqc on tqc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tqc.rr_code
    join tqc_process tqcr on tqcr.qcr_code = tqc.qcr_code
    join penalty pen on pen.pe_code = tqcr.pe_code 
    join p_reason pre on pre.pre_code = tqcr.pre_code
    join p_target pta on pta.ptg_code = tqcr.ptg_code
    join penalty pen on pen.pe_code = tqcr.pe_code 
)
union all -- ��� �Խ��� ���� �Ű� ó��
(  select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tq2.q2r_code as �Ű�����
     , rep.reason as �Ű���
     , tq2.kdate as �Ű�¥     
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tq2r.kdate as ó����¥
     , pta.target as ó�� 
from member m
    join tq2_report tq2 on tq2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tq2.rr_code
    join tq2_process tq2r on tq2r.q2r_code = tq2.q2r_code
    join penalty pen on pen.pe_code = tq2r.pe_code 
    join p_reason pre on pre.pre_code = tq2r.pre_code
    join p_target pta on pta.ptg_code = tq2r.ptg_code
    join penalty pen on pen.pe_code = tq2r.pe_code 
)
union all -- Ŀ���� �Խ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cq.qr_code as �Ű�����
     , rep.reason as �Ű���
     , cq.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cqp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cq_report cq on cq.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cq.rr_code
    join cq_process cqp on cqp.qr_code = cq.qr_code
    join penalty pen on pen.pe_code = cqp.pe_code 
    join p_reason pre on pre.pre_code = cqp.pre_code
    join p_target pta on pta.ptg_code = cqp.ptg_code
    join penalty pen on pen.pe_code = cqp.pe_code 
)
union all -- Ŀ���� ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cqc.cr_code as �Ű�����
     , rep.reason as �Ű���
     , cqc.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cqpc.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cqc_report cqc on cqc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cqc.rr_code
    join cqc_process cqpc on cqpc.cr_code = cqc.cr_code
    join penalty pen on pen.pe_code = cqpc.pe_code 
    join p_reason pre on pre.pre_code = cqpc.pre_code
    join p_target pta on pta.ptg_code = cqpc.ptg_code
    join penalty pen on pen.pe_code = cqpc.pe_code 
)
union all -- Ŀ���� ���� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cq2.c2_code as �Ű�����
     , rep.reason as �Ű���
     , cq2.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cq2p.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cq2_report cq2 on cq2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cq2.rr_code
    join cq2_process cq2p on cq2p.c2_code = cq2.c2_code
    join penalty pen on pen.pe_code = cq2p.pe_code 
    join p_reason pre on pre.pre_code = cq2p.pre_code
    join p_target pta on pta.ptg_code = cq2p.ptg_code
    join penalty pen on pen.pe_code = cq2p.pe_code 
)
union all -- ��Ʈ������ �Խñ� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , pr.pr_code as �Ű�����
     , rep.reason as �Ű���
     , pr.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , pp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join p_report pr on pr.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = pr.rr_code
    join p_process pp on pr.pr_code = pp.pr_code
    join penalty pen on pen.pe_code = pp.pe_code 
    join p_reason pre on pre.pre_code = pp.pre_code
    join p_target pta on pta.ptg_code = pp.ptg_code
    join penalty pen on pen.pe_code = pp.pe_code 
)
union all -- ��Ʈ������ ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , pr.pr_code as �Ű�����
     , rep.reason as �Ű���
     , pr.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , pp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join p_report pr on pr.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = pr.rr_code
    join p_process pp on pr.pr_code = pp.pr_code
    join penalty pen on pen.pe_code = pp.pe_code 
    join p_reason pre on pre.pre_code = pp.pre_code
    join p_target pta on pta.ptg_code = pp.ptg_code
    join penalty pen on pen.pe_code = pp.pe_code 
)
union all -- ��Ʈ������ ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , p2r.p2r_code as �Ű�����
     , rep.reason as �Ű���
     , p2r.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , p2p.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join p2_report p2r on p2r.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = p2r.rr_code
    join p2_process p2p on p2r.p2r_code = p2p.p2r_code
    join penalty pen on pen.pe_code = p2p.pe_code 
    join p_reason pre on pre.pre_code = p2p.pre_code
    join p_target pta on pta.ptg_code = p2p.ptg_code
    join penalty pen on pen.pe_code = p2p.pe_code 
);

------------------------------------------------------------------- �� ���̺�
create or replace view ALL_MEMBER_VIEW 
as
SELECT M.MEM_CODE
      ,M.ID
      ,M.PW
      ,M.NICKNAME
      ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM ) AS POST
      ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2) AS COMMENTS
      , M.KDATE
      , MB.MBTI
FROM MEMBER M
LEFT JOIN
(
    SELECT (
                SELECT COUNT(APP.AP_CODE)
                FROM MEMBER m1 
                LEFT JOIN APP_OPENING APP ON m1.MEM_CODE = APP.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS APP_NUM
            ,
            (
                SELECT COUNT(TQ.TQ_CODE)
                FROM MEMBER m2
                LEFT JOIN TECH_QNA TQ  ON m2.MEM_CODE = TQ.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TQ_NUM
            ,(
                SELECT COUNT(CQ.CQ_CODE)
                FROM MEMBER m1 
                LEFT JOIN C_QnA CQ ON m1.MEM_CODE = CQ.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(PO.P_CODE)
                FROM MEMBER m2
                LEFT JOIN PORTFOLIO PO  ON m2.MEM_CODE = PO.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS PO_NUM
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
)PT ON M.MEM_CODE = PT.MEM_CODE
LEFT JOIN 
(
            SELECT (
                SELECT COUNT(AO.AC_CODE)
                FROM MEMBER M1
                LEFT JOIN AO_COMMENT AO ON AO.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS AO_NUM
            ,
            (
                SELECT COUNT(AOR.A2_CODE)
                FROM MEMBER M2
                LEFT JOIN AO_REPLY2 AOR ON AOR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS AOR_NUM2
            ,
            (
                SELECT COUNT(TC.TC_CODE)
                FROM MEMBER m1
                LEFT JOIN TQ_COMMENT tc ON m1.MEM_CODE = tc.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS TC_NUM
            ,
            (
                SELECT COUNT(tr.T2_CODE) AS TT_COUNT
                FROM MEMBER m2 LEFT JOIN TQ_REPLY2 tr  ON m2.MEM_CODE = tr.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TT_NUM
            ,(
                SELECT COUNT(CQ.CQC_CODE)
                FROM MEMBER M1
                LEFT JOIN CQ_COMMENT CQ ON CQ.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(CQR.CQ2_CODE)
                FROM MEMBER M2
                LEFT JOIN CQ_REPLY2 CQR ON CQR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS CQR_NUM2
            ,(
                SELECT COUNT(P.PC_CODE)
                FROM MEMBER M1
                LEFT JOIN P_COMMENT P ON P.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS P_NUM
            ,
            (
                SELECT COUNT(PR.P2_CODE)
                FROM MEMBER M2
                LEFT JOIN P_REPLY2 PR ON PR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS PR_NUM2
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
) CT ON M.MEM_CODE = CT.MEM_CODE
     JOIN 
        MBTI MB ON MB.MBTI_CODE = M.MBTI_CODE
GROUP BY M.MEM_CODE, M.ID, M.PW, M.NICKNAME, M.KDATE, MB.MBTI
        ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM )
        ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2)
ORDER BY M.MEM_CODE;
--==>> View ALL_MEMBER_VIEW��(��) �����Ǿ����ϴ�.


-- ��ü ȸ�� �� ��ȸ 
SELECT MEM_CODE, ID, PW, NICKNAME, POST, COMMENTS, KDATE, MBTI
FROM ALL_MEMBER_VIEW
ORDER BY MEM_CODE;



----- �г�Ƽ ���� ȸ�� ��ȸ 
CREATE OR REPLACE VIEW PENALTY_ALL_MEMBER
AS
select m.mem_code as MEM_CODE -- ���� ��û ���ñ� �Ű�ó��
     , m.nickname as NICKNAME
     , m.id as NAME
     , m.kdate as KDATE
     , aor.aor_code as TYPE
     , rep.reason as R_CONTENT
     , aor.kdate as R_DATE
     , pen.name as PENALTY
     , pre.reason as REASON
     , aop.kdate as PRO_DATE
     , pta.target as PROCESS
from member m
    join ao_report aor on aor.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = aor.rr_code
    join ao_process aop on aop.aor_code = aor.aor_code
    join p_reason pre on pre.pre_code = aop.pre_code
    join p_target pta on pta.ptg_code = aop.ptg_code
    join penalty pen on pen.pe_code = aop.pe_code 
union all -- ������û ��� �Ű�ó�� 
( select m.mem_code as �̸�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , aoc.acr_code as �Ű�����
     , rep.reason as �Ű���
     , aoc.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , aocp.kdate as ó����¥
     , pta.target as ó��
from member m
    join aoc_report aoc on aoc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = aoc.rr_code
    join aoc_process aocp on aocp.acr_code = aoc.acr_code
    join p_reason pre on pre.pre_code = aocp.pre_code
    join p_target pta on pta.ptg_code = aocp.ptg_code
    join penalty pen on pen.pe_code = aocp.pe_code 
)
union all
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , ao2.a2r_code as �Ű�����
     , rep.reason as �Ű���
     , ao2.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , ao2p.kdate as ó����¥
     , pta.target as ó��
     
from member m -- ���� ��û �Խ��� ���� �Ű� ó��
    join ao2_report ao2 on ao2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = ao2.rr_code
    join AO2_PROCESS ao2p on ao2p.a2r_code = ao2.a2r_code
    join penalty pen on pen.pe_code = ao2p.pe_code 
    join p_reason pre on pre.pre_code = ao2p.pre_code
    join p_target pta on pta.ptg_code = ao2p.ptg_code
    join penalty pen on pen.pe_code = ao2p.pe_code 
)
union all -- ��� ��û �Խ��� �Ű� ó�� 
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tq.tqr_code as �Ű�����
     , rep.reason as �Ű���
     , tq.kdate as �Ű�¥
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tqr.kdate as ó����¥
     , pta.target as ó��     
from member m
    join tq_report tq on tq.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tq.rr_code
    join tq_process tqr on tqr.tqr_code = tq.tqr_code
    join penalty pen on pen.pe_code = tqr.pe_code 
    join p_reason pre on pre.pre_code = tqr.pre_code
    join p_target pta on pta.ptg_code = tqr.ptg_code
    join penalty pen on pen.pe_code = tqr.pe_code 
)
union all --��� �Խ��� ��� �Ű� ó��
(
 select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tqc.qcr_code as �Ű�����
     , rep.reason as �Ű���
     , tqc.kdate as �Ű�¥     
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tqcr.kdate as ó����¥
     , pta.target as ó�� 
from member m
    join tqc_report tqc on tqc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tqc.rr_code
    join tqc_process tqcr on tqcr.qcr_code = tqc.qcr_code
    join penalty pen on pen.pe_code = tqcr.pe_code 
    join p_reason pre on pre.pre_code = tqcr.pre_code
    join p_target pta on pta.ptg_code = tqcr.ptg_code
    join penalty pen on pen.pe_code = tqcr.pe_code 
)
union all -- ��� �Խ��� ���� �Ű� ó��
(  select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , tq2.q2r_code as �Ű�����
     , rep.reason as �Ű���
     , tq2.kdate as �Ű�¥     
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , tq2r.kdate as ó����¥
     , pta.target as ó�� 
from member m
    join tq2_report tq2 on tq2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = tq2.rr_code
    join tq2_process tq2r on tq2r.q2r_code = tq2.q2r_code
    join penalty pen on pen.pe_code = tq2r.pe_code 
    join p_reason pre on pre.pre_code = tq2r.pre_code
    join p_target pta on pta.ptg_code = tq2r.ptg_code
    join penalty pen on pen.pe_code = tq2r.pe_code 
)
union all -- Ŀ���� �Խ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cq.qr_code as �Ű�����
     , rep.reason as �Ű���
     , cq.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cqp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cq_report cq on cq.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cq.rr_code
    join cq_process cqp on cqp.qr_code = cq.qr_code
    join penalty pen on pen.pe_code = cqp.pe_code 
    join p_reason pre on pre.pre_code = cqp.pre_code
    join p_target pta on pta.ptg_code = cqp.ptg_code
    join penalty pen on pen.pe_code = cqp.pe_code 
)
union all -- Ŀ���� ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cqc.cr_code as �Ű�����
     , rep.reason as �Ű���
     , cqc.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cqpc.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cqc_report cqc on cqc.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cqc.rr_code
    join cqc_process cqpc on cqpc.cr_code = cqc.cr_code
    join penalty pen on pen.pe_code = cqpc.pe_code 
    join p_reason pre on pre.pre_code = cqpc.pre_code
    join p_target pta on pta.ptg_code = cqpc.ptg_code
    join penalty pen on pen.pe_code = cqpc.pe_code 
)
union all -- Ŀ���� ���� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , cq2.c2_code as �Ű�����
     , rep.reason as �Ű���
     , cq2.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , cq2p.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join cq2_report cq2 on cq2.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = cq2.rr_code
    join cq2_process cq2p on cq2p.c2_code = cq2.c2_code
    join penalty pen on pen.pe_code = cq2p.pe_code 
    join p_reason pre on pre.pre_code = cq2p.pre_code
    join p_target pta on pta.ptg_code = cq2p.ptg_code
    join penalty pen on pen.pe_code = cq2p.pe_code 
)
union all -- ��Ʈ������ �Խñ� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , pr.pr_code as �Ű�����
     , rep.reason as �Ű���
     , pr.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , pp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join p_report pr on pr.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = pr.rr_code
    join p_process pp on pr.pr_code = pp.pr_code
    join penalty pen on pen.pe_code = pp.pe_code 
    join p_reason pre on pre.pre_code = pp.pre_code
    join p_target pta on pta.ptg_code = pp.ptg_code
    join penalty pen on pen.pe_code = pp.pe_code 
)
union all -- ��Ʈ������ ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , pr.pcr_code as �Ű�����
     , rep.reason as �Ű���
     , pr.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , pp.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join pc_report pr on pr.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = pr.rr_code
    join pc_process pp on pr.pcr_code = pp.pcr_code
    join penalty pen on pen.pe_code = pp.pe_code 
    join p_reason pre on pre.pre_code = pp.pre_code
    join p_target pta on pta.ptg_code = pp.ptg_code
    join penalty pen on pen.pe_code = pp.pe_code 
    
)
union all -- ��Ʈ������ ��� �Ű� ó��
( select m.mem_code as ȸ���ڵ�
     , m.nickname as �г���
     , m.id as ���̵�
     , m.kdate as ������
     , p2r.p2r_code as �Ű�����
     , rep.reason as �Ű���
     , p2r.kdate as �Ű�¥      
     , pen.name as �г�Ƽ
     , pre.reason as ó������
     , p2p.kdate as ó����¥
     , pta.target as ó��          
    from member m
    join p2_report p2r on p2r.mem_code = m.mem_code
    join report_reason rep on rep.rr_code = p2r.rr_code
    join p2_process p2p on p2r.p2r_code = p2p.p2r_code
    join penalty pen on pen.pe_code = p2p.pe_code 
    join p_reason pre on pre.pre_code = p2p.pre_code
    join p_target pta on pta.ptg_code = p2p.ptg_code
    join penalty pen on pen.pe_code = p2p.pe_code 
);
--==>> View PENALTY_ALL_MEMBER��(��) �����Ǿ����ϴ�.


SELECT *
FROM PENALTY_ALL_MEMBER;

-- ��ü ���Ƽ ȸ�� ��ȸ
SELECT MEM_CODE, NICKNAME, TO_CHAR(KDATE, 'YYYY-MM-DD') AS KDATE, TYPE, R_CONTENT, TO_CHAR(R_DATE, 'YYYY-MM-DD') AS R_DATE, PENALTY, REASON, TO_CHAR(PRO_DATE, 'YYYY-MM-DD') AS P, PROCESS
FROM PENALTY_ALL_MEMBER
ORDER BY MEM_CODE;


-- ��ü ȸ�� �� ��ȸ 
SELECT MEM_CODE, ID, PW, NICKNAME, POST, COMMENTS, TO_CHAR(KDATE, 'YYYY-MM-DD') AS KDATE, MBTI
FROM ALL_MEMBER_VIEW
ORDER BY MEM_CODE;


---------------------------------------------------------------------------- Ż���� ȸ�� ��ü ��ȸ
CREATE OR REPLACE VIEW CLOSE_MEMBER_VIEW
AS
SELECT M.MEM_CODE
      ,M.ID
      ,M.PW
      ,M.NICKNAME
      , M.KDATE
      ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM ) AS POST
      ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2) AS COMMENTS
      , MB.MBTI
      ,TO_CHAR(CLO.KDATE,'YYYY-MM-DD') AS CLOSE_DATE
FROM MEMBER M
LEFT JOIN
(
    SELECT (
                SELECT COUNT(APP.AP_CODE)
                FROM MEMBER m1 
                LEFT JOIN APP_OPENING APP ON m1.MEM_CODE = APP.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS APP_NUM
            ,
            (
                SELECT COUNT(TQ.TQ_CODE)
                FROM MEMBER m2
                LEFT JOIN TECH_QNA TQ  ON m2.MEM_CODE = TQ.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TQ_NUM
            ,(
                SELECT COUNT(CQ.CQ_CODE)
                FROM MEMBER m1 
                LEFT JOIN C_QnA CQ ON m1.MEM_CODE = CQ.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(PO.P_CODE)
                FROM MEMBER m2
                LEFT JOIN PORTFOLIO PO  ON m2.MEM_CODE = PO.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS PO_NUM
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
)PT ON M.MEM_CODE = PT.MEM_CODE
LEFT JOIN 
(
            SELECT (
                SELECT COUNT(AO.AC_CODE)
                FROM MEMBER M1
                LEFT JOIN AO_COMMENT AO ON AO.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS AO_NUM
            ,
            (
                SELECT COUNT(AOR.A2_CODE)
                FROM MEMBER M2
                LEFT JOIN AO_REPLY2 AOR ON AOR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS AOR_NUM2
            ,
            (
                SELECT COUNT(TC.TC_CODE)
                FROM MEMBER m1
                LEFT JOIN TQ_COMMENT tc ON m1.MEM_CODE = tc.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY m1.MEM_CODE
                
            ) AS TC_NUM
            ,
            (
                SELECT COUNT(tr.T2_CODE) AS TT_COUNT
                FROM MEMBER m2 LEFT JOIN TQ_REPLY2 tr  ON m2.MEM_CODE = tr.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY m2.MEM_CODE
            ) AS TT_NUM
            ,(
                SELECT COUNT(CQ.CQC_CODE)
                FROM MEMBER M1
                LEFT JOIN CQ_COMMENT CQ ON CQ.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS CQ_NUM
            ,
            (
                SELECT COUNT(CQR.CQ2_CODE)
                FROM MEMBER M2
                LEFT JOIN CQ_REPLY2 CQR ON CQR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS CQR_NUM2
            ,(
                SELECT COUNT(P.PC_CODE)
                FROM MEMBER M1
                LEFT JOIN P_COMMENT P ON P.MEM_CODE = M1.MEM_CODE
                WHERE M1.MEM_CODE = M.MEM_CODE
                GROUP BY M1.MEM_CODE
            ) AS P_NUM
            ,
            (
                SELECT COUNT(PR.P2_CODE)
                FROM MEMBER M2
                LEFT JOIN P_REPLY2 PR ON PR.MEM_CODE = M2.MEM_CODE
                WHERE M2.MEM_CODE = M.MEM_CODE
                GROUP BY M2.MEM_CODE
            ) AS PR_NUM2
            , M.MEM_CODE AS MEM_CODE
    FROM MEMBER M
) CT ON M.MEM_CODE = CT.MEM_CODE
     JOIN 
        MBTI MB ON MB.MBTI_CODE = M.MBTI_CODE
     JOIN CLOSE_MEMBER CLO ON CLO.MEM_CODE = M.MEM_CODE
GROUP BY M.MEM_CODE, M.ID, M.PW, M.NICKNAME, M.KDATE, MB.MBTI
        ,(PT.APP_NUM + PT.TQ_NUM + PT.CQ_NUM + PT.PO_NUM )
        ,(CT.TC_NUM + CT.TT_NUM + CT.CQ_NUM + CT.CQR_NUM2 + CT.AO_NUM + CT.AOR_NUM2 + CT.P_NUM + CT.PR_NUM2)
        ,CLO.KDATE
ORDER BY M.MEM_CODE;
--==>> View CLOSE_MEMBER_VIEW��(��) �����Ǿ����ϴ�.


SELECT MEM_CODE, ID, PW, NICKNAME, KDATE, POST, COMMENTS, MBTI, CLOSE_DATE
FROM CLOSE_MEMBER_VIEW
ORDER BY MEM_CODE;

----------------------------------------------------------------------- �Խ��� ���� ������ 
-- ���� ��û
SELECT COUNT(*) AS COUNT
FROM APP_OPENING;

--��� �Խ���
SELECT COUNT(*) AS COUNT
FROM TECH_QNA;

-- Ŀ���� �Խ���
SELECT COUNT(*)
FROM C_QNA
WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE('2024-02-23', 'YYYY-MM-DD');


DESC C_QNA;

-- ��Ʈ������ �Խ���
SELECT COUNT(*) AS COUNT
FROM PORTFOLIO;

-- ��ü �Ű� ����

--1. �Խ���
SELECT COUNT(*)
FROM AO_REPORT;
--1
SELECT COUNT(*)
FROM CQ_REPORT;
--1
SELECT COUNT(*)
FROM TQ_REPORT;
--6
SELECT COUNT(*)
FROM P_REPORT;
--0

-- �Խ��� ��ü �Ű��
CREATE OR REPLACE VIEW POST_REPORT_VIEW
AS
SELECT AO_REPORT_COUNT + CQ_REPORT_COUNT + TQ_REPORT_COUNT + P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AO_REPORT AOR
     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQ_REPORT CQR
     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQ_REPORT TQR
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM P_REPORT PRE
     );
--==>> View POST_REPORT_VIEW��(��) �����Ǿ����ϴ�.

SELECT COUNT
FROM POST_REPORT_VIEW;


-- ��� ��ü �Ű��
CREATE OR REPLACE VIEW VIEW_COMMENT_REPORT
AS
SELECT AO_REPORT_COUNT + CQ_REPORT_COUNT + TQ_REPORT_COUNT + P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AOC_REPORT AOC
     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQC_REPORT CQC
     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQC_REPORT TQC
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM PC_REPORT PCR
     );
     
SELECT COUNT
FROM VIEW_COMMENT_REPORT;

-- ��ü ���� �Ű� ��ȸ ����
CREATE OR REPLACE VIEW VIEW_REPLY2_REPORT
AS
SELECT AO_REPORT_COUNT + CQ_REPORT_COUNT + TQ_REPORT_COUNT + P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AO2_REPORT AOC
     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQ2_REPORT CQC
     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQ2_REPORT TQC
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM P2_REPORT PCR
     );
 
 
     
SELECT COUNT
FROM POST_REPORT_VIEW;    

SELECT COUNT
FROM VIEW_COMMENT_REPORT;
     
SELECT COUNT
FROM VIEW_REPLY2_REPORT;

SELECT COUNT(*)
FROM TEAM_REPORT;

-- ��ü �Ű� ���� ��ȸ ����
CREATE OR REPLACE VIEW REPORT_COUNT_VIEW
AS
SELECT PRV + VCR + VRR + TR AS REPORT_COUNT
FROM 
    (
        SELECT COUNT AS PRV
        FROM POST_REPORT_VIEW 
    ) 
    ,
    (
        SELECT COUNT AS VCR
        FROM VIEW_COMMENT_REPORT 
    ) 
    ,
    (
        SELECT COUNT AS VRR
        FROM VIEW_REPLY2_REPORT
    ) 
    , 
    (
        SELECT COUNT(*) AS TR
        FROM TEAM_REPORT    
    );
--==>> View REPORT_COUNT_VIEW��(��) �����Ǿ����ϴ�.

-- ��ü ȸ�� ��
SELECT COUNT(*) AS COUNT
FROM MEMBER;

-- ��ü ���� �Ű� �� 
SELECT REPORT_COUNT
FROM REPORT_COUNT_VIEW;


-------------------------- ���� ���� �Ű� �� 
-- �Խ��� ���� ���� ��ü �Ű��
CREATE OR REPLACE VIEW POST_REPORT_VIEW_TODAY
AS
SELECT AO_REPORT_COUNT
      +CQ_REPORT_COUNT
      +TQ_REPORT_COUNT
      +P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AO_REPORT AOR
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQ_REPORT CQR
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQ_REPORT TQR
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM P_REPORT PRE
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     );
--==>> View POST_REPORT_VIEW_TODAY��(��) �����Ǿ����ϴ�.

SELECT *
FROM POST_REPORT_VIEW_TODAY;

-- ��� ���� ���� ��ü �Ű��
CREATE OR REPLACE VIEW VIEW_COMMENT_REPORT_TODAY
AS
SELECT AO_REPORT_COUNT + CQ_REPORT_COUNT + TQ_REPORT_COUNT + P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AOC_REPORT AOC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQC_REPORT CQC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')

     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQC_REPORT TQC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
         
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM PC_REPORT PCR
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     );
--==>> View VIEW_COMMENT_REPORT_TODAY��(��) �����Ǿ����ϴ�.

SELECT *
FROM VIEW_COMMENT_REPORT_TODAY;

-- ���� ���� ���� �Ű� ��ü ����
CREATE OR REPLACE VIEW VIEW_REPLY2_REPORT_TODAY
AS
SELECT AO_REPORT_COUNT + CQ_REPORT_COUNT + TQ_REPORT_COUNT + P_REPORT_COUNT AS COUNT
FROM
    (
         SELECT COUNT(*) AS AO_REPORT_COUNT
         FROM AO2_REPORT AOC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')

     )
     ,
    (
         SELECT COUNT(*) AS CQ_REPORT_COUNT
         FROM CQ2_REPORT CQC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')

     )
     ,
    (
         SELECT COUNT(*) AS TQ_REPORT_COUNT
         FROM TQ2_REPORT TQC
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     )
     ,
    (
         SELECT COUNT(*) AS P_REPORT_COUNT
         FROM P2_REPORT PCR
         WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD')
     );
 --==>> View VIEW_REPLY2_REPORT_TODAY��(��) �����Ǿ����ϴ�.

-- ���� ���� �Խù� �Ű� ���� ��ȸ 
SELECT COUNT
FROM POST_REPORT_VIEW_TODAY;

-- ���� ���� �Խù� ��� �Ű� ���� ��ȸ 
SELECT COUNT
FROM VIEW_COMMENT_REPORT_TODAY;


-- ���� ���� ���� �Ű� ���� ��ȸ 
SELECT COUNT
FROM VIEW_REPLY2_REPORT_TODAY;

-- ���� ���� �� �Ű� ���� ��ȸ 
SELECT COUNT(*) AS COUNT
FROM TEAM_REPORT
WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') = TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD');

-- ������� ������ ������Ʈ�� ����, �Ű� ����, ������ ����
SELECT COUNT(*) AS COUNT
FROM C_PROJECT
WHERE TO_DATE(TO_CHAR(KDATE,'YYYY-MM-DD'), 'YYYY-MM-DD') <= TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD'), 'YYYY-MM-DD');


-- �Ϸ� ���� ��� ������Ʈ ��ȸ 
CREATE OR REPLACE VIEW DAY_PRO_VIEW
AS
SELECT ONE, TWO, THREE, FOUR
FROM
    (
        SELECT COUNT(*) AS ONE
        FROM C_PROJECT CP, APP_OPENING APP 
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS TWO
        FROM C_PROJECT CP, APP_OPENING APP 
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 1)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS THREE
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 2)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS FOUR
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 3)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    );
 -- View DAY_PRO_VIEW��(��) �����Ǿ����ϴ�.
 
 SELECT *
 FROM C_PROJECT;

-- �ϴ��� ��ü ������Ʈ ��ȸ
SELECT TODAY, O_DAY_AGO, T_DAY_AGO, TH_DAY_AGO
FROM DAY_PRO_VIEW;

SELECT *
FROM APP_OPENING;

-- �ְ� ������Ʈ ���� ��ȸ 
CREATE OR REPLACE VIEW WEEK_PRO_VIEW
AS
SELECT ONE, TWO, THREE, FOUR
FROM
    (
        SELECT COUNT(*) AS ONE
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS TWO
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(TO_CHAR(CP.KDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 7)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS THREE
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(TO_CHAR(CP.KDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 14)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS FOUR
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(TO_CHAR(CP.KDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')) <= TRUNC(SYSDATE - 21)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    );

-- �� ���� ��� ������Ʈ ��ȸ 
CREATE OR REPLACE VIEW MONTH_PRO_VIEW
AS
SELECT ONE, TWO, THREE, FOUR
FROM
    (
        SELECT COUNT(*) AS ONE
        FROM C_PROJECT CP, APP_OPENING APP
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(SYSDATE)
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS TWO
        FROM C_PROJECT CP
        JOIN APP_OPENING APP ON CP.AP_CODE = APP.AP_CODE
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(ADD_MONTHS(TO_DATE(SYSDATE,'YYYY-MM-DD'), -1))
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS THREE
        FROM C_PROJECT CP
        JOIN APP_OPENING APP ON CP.AP_CODE = APP.AP_CODE
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(ADD_MONTHS(TO_DATE(SYSDATE,'YYYY-MM-DD'), -1))
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    )
    ,
    (
        SELECT COUNT(*) AS FOUR
        FROM C_PROJECT CP
        JOIN APP_OPENING APP ON CP.AP_CODE = APP.AP_CODE
        WHERE TRUNC(TO_DATE(CP.KDATE, 'YYYY-MM-DD')) <= TRUNC(ADD_MONTHS(TO_DATE(SYSDATE,'YYYY-MM-DD'), -1))
             AND TRUNC(TO_DATE(SYSDATE,'YYYY-MM-DD')) < TRUNC(TO_DATE(APP.EDATE,'YYYY-MM-DD')) AND CP.AP_CODE = APP.AP_CODE
    );

 
SELECT *
FROM DAY_PRO_VIEW;
 
SELECT *
FROM WEEK_PRO_VIEW;
   
SELECT *
FROM MONTH_PRO_VIEW;

SELECT *
FROM APP_OPENING;


