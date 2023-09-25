/*
<< 게임 구입 및 관리 프로그램 >>

1. 기능 및 테이블 설계
    - 회원가입
    - 로그인
    - 비밀번호 변경하기
    - 닉네임 변경하기
    - 마이페이지 조회하기
    - 회원탈퇴

    === MEMBER ===
    MEMBER_NUM      NUMBER
    MEMEBR_ID       VARCHAR2(100)
    MEMBER_PWD      VARCHAR2(100)
    MEMBER_NICK     VARCHAR2(100)
    ENROLL_DATE     TIMESTAMP
    WITHDRAW_YN     CHAR(1)
    
    
    - 게임 상품 등록
    - 게임 가격 등록
    === PRODUCT === 
    GAME_NUM        NUMBER
    GAME_TITLE      VARCHAR2(200)
    GAME_PRICE      NUMBER
    GAME_GENRE      VARCHAR2(50)
    ENROLL_DATE     TIMESTAMP
    PUBLISHER       VARCHAR2(100)
    DISCONTINUED_YN CHAR(1)
    
    - 게임 구매
    - 게임 구매 목록 조회
    - 게임 환불
    === ORDER ===
    ORDER_NUM       NUMBER
    PRODUCT_NUM     NUMBER  (GAME_NUM)
    BUYER_NUM       NUMBER  (MEMBER_NUM)
    CARD_TYPE       VARCHAR2(10)
    PURCHASE_DATE   TIMESTAMP
    
*/

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEMBER_NUM      NUMBER
    , MEMBER_ID     VARCHAR2(100)
    , MEMBER_PWD    VARCHAR2(100)
    , MEMBER_NICK   VARCHAR2(100)
    , ENROLL_DATE   TIMESTAMP
    , WITHDRAW_YN   CHAR(1)
);

DROP TABLE PRODUCT;
CREATE TABLE PRODUCT(
    GAME_NUM            NUMBER
    , GAME_TITLE        VARCHAR2(200)
    , GAME_PRICE        NUMBER
    , GAME_GENRE        VARCHAR2(50)
    , ENROLL_DATE       TIMESTAMP
    , PUBLISHER         VARCHAR2(100)
    , DISCONTINUED_YN   CHAR(1)   
);

DROP TABLE ORDER;
CREATE TABLE ORDER(
    ORDER_NUM           NUMBER
    , PRODUCT_NUM       NUMBER
    , BUYER_NUM         NUMBER
    , PAYMENT_TYPE      VARCHAR2(10)
    , PURCHASE_DATE     TIMESTAMP
);

/*
2. 기능에 걸맞는 쿼리문 준비
*/
-- 회원가입
INSERT INTO MEMBER(
    MEMBER_NUM
    , MEMBER_ID
    , MEMBER_PWD
    , MEMBER_NICK
    , ENROLL_DATE
    , WITHDRAW_YN)
    VALUES(
    1
    , 'USER01'
    , '1234'
    , '공자'
    , SYSDATE
    , 'N');
-- 로그인
SELECT *
    FROM MEMBER
    WHERE MEMBER_ID = 'USER01' 
    AND MEMBER_PWD = '1234';
-- 비밀번호 변경하기
UPDATE MEMBER
    SET MEMBER_PWD = '4321'
    WHERE MEMBER_ID = 'USER01' 
    AND MEMBER_PWD = '1234';
-- 닉네임 변경하기
UPDATE MEMBER
    SET MEMBER_NICK = '맹자'
    WHERE MEMBER_NICK = '공자' 
    AND MEMBER_NUM = 1;
-- 마이페이지 조회하기
SELECT *
    FROM MEMBER
    WHERE 
        MEMBER_NUM=1 
        AND MEMBER_ID='USER01' 
        AND MEMBER_PWD = '1234';
-- 회원 탈퇴하기
UPDATE MEMBER
    SET WITHDRAW_YN = 'Y'
    WHERE MEMBER_ID = 'USER01'
    AND MEMBER_PWD = '1234';
    
-- 게임 상품 등록
INSERT INTO PRODUCT(
     GAME_NUM
    , GAME_TITLE
    , GAME_PRICE
    , GAME_GENRE
    , ENROLL_DATE
    , PUBLISHER
    , DISCONTINUED_YN
) VALUES (
    1
    , '매드 게임 타이쿤'
    , 20000
    , SYSDATE
    , '시뮬레이션'
    , 'Eggcode'
    , 'N'
);
-- 게임 상품 가격 변경
UPDATE PRODUCT
    SET GAME_PRICE = '21000'
    WHERE GAME_NUM = 1;
    
