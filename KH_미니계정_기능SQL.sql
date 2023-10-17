-- ��� SQL
--------------
-- ������ ���
--------------
-- ������ ó������ '��ź���' -> '������'
UPDATE RECEIPT
SET _RECEIPT_PROCESSING_STATE = '������'
WHERE RECEIPT_SERIAL = ?;

-- ����̷� ���̺� �� �߰�
INSERT INTO RECEIPT_APPLICATION_HISTORY(
    NO
    , MEMBER_NO
    , RECEIPT_NO)
VALUES(SEQ_RECEIPT_APPLICATION.NEXTVAL, ?, ?);

---------------
-- ������ ������
---------------
-- ������ ó������ '������' -> '��ź���'
UPDATE RECEIPT
SET SEQ_RECEIPT_PROCESSING_STATE = '����ʿ�'
WHERE RECEIPT_SERIAL = ?;
-- ����̷� ���̺� ������� Į�� ������Ʈ
UPDATE RECEIPT_APPLICATION_HISTORY
SET CANCEL_DATE = SYSDATE
WHERE RECEIPT_SERIAL = ?;



--------------
-- ������ ����̷� ��ȸ
--------------
SELECT
    RAH.SEQ_RECEIPT_APPLICATION
    , M.NAME                    ������
    , R.RECEIPT_SERIAL          ������������ȣ
    , RAH.APPLICATION_DATE      �������
    , RAH.CANCEL_DATE           �������
    , RAH.NOTE                  ���
FROM RECEIPT_APPLICATION_HISTORY RAH
LEFT JOIN MEMBER M ON M.NO = RAH.MEMBER_NO
LEFT JOIN RECEIPT R ON R.NO = RAH.RECEIPT_NO;


---------------
-- ���(ī�װ��� ���) : ī�װ��� ���� ����
---------------
SELECT SUM(P.TOTAL_PRICE)
FROM PRODUCT P
JOIN RECEIPT R ON R.NO = P.RECEIPT_NO
JOIN CATEGORY C ON C.NO = R.CATEGORY_NO
GROUP BY C.NO;

---------------
-- ���(ī��纰 ���) : ī�庰 ���� ����
---------------
SELECT SUM(P.TOTAL_PRICE)
FROM PRODUCT P
LEFT JOIN RECEIPT R ON R.NO = P.RECEIPT_NO
LEFT JOIN MEMBER M ON M.NO = R.MEMBER_NO
LEFT JOIN CARD C ON C.MEMBER_NO = M.NO
LEFT JOIN CARD_COMPANY CC ON CC.NO = C.CARD_COMPANY_NO
GROUP BY CC.CARD_COMPANY_NAME;

---------------
-- ������ ���
---------------

