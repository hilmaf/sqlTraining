-- 기능 SQL
--------------
-- 영수증 상신
--------------
-- 영수증 처리상태 '상신변경' -> '승인중'
UPDATE RECEIPT
SET _RECEIPT_PROCESSING_STATE = '승인중'
WHERE RECEIPT_SERIAL = ?;

-- 상신이력 테이블에 행 추가
INSERT INTO RECEIPT_APPLICATION_HISTORY(
    NO
    , MEMBER_NO
    , RECEIPT_NO)
VALUES(SEQ_RECEIPT_APPLICATION.NEXTVAL, ?, ?);

---------------
-- 영수증 상신취소
---------------
-- 영수증 처리상태 '승인중' -> '상신변경'
UPDATE RECEIPT
SET SEQ_RECEIPT_PROCESSING_STATE = '상신필요'
WHERE RECEIPT_SERIAL = ?;
-- 상신이력 테이블 취소일자 칼럼 업데이트
UPDATE RECEIPT_APPLICATION_HISTORY
SET CANCEL_DATE = SYSDATE
WHERE RECEIPT_SERIAL = ?;



--------------
-- 영수증 상신이력 조회
--------------
SELECT
    RAH.SEQ_RECEIPT_APPLICATION
    , M.NAME                    직원명
    , R.RECEIPT_SERIAL          영수증고유번호
    , RAH.APPLICATION_DATE      상신일자
    , RAH.CANCEL_DATE           취소일자
    , RAH.NOTE                  비고
FROM RECEIPT_APPLICATION_HISTORY RAH
LEFT JOIN MEMBER M ON M.NO = RAH.MEMBER_NO
LEFT JOIN RECEIPT R ON R.NO = RAH.RECEIPT_NO;


---------------
-- 통계(카테고리별 통계) : 카테고리별 가격 정보
---------------
SELECT SUM(P.TOTAL_PRICE)
FROM PRODUCT P
JOIN RECEIPT R ON R.NO = P.RECEIPT_NO
JOIN CATEGORY C ON C.NO = R.CATEGORY_NO
GROUP BY C.NO;

---------------
-- 통계(카드사별 통계) : 카드별 가격 정보
---------------
SELECT SUM(P.TOTAL_PRICE)
FROM PRODUCT P
LEFT JOIN RECEIPT R ON R.NO = P.RECEIPT_NO
LEFT JOIN MEMBER M ON M.NO = R.MEMBER_NO
LEFT JOIN CARD C ON C.MEMBER_NO = M.NO
LEFT JOIN CARD_COMPANY CC ON CC.NO = C.CARD_COMPANY_NO
GROUP BY CC.CARD_COMPANY_NAME;

---------------
-- 유저별 통계
---------------

