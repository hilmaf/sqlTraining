/*
<< ���� ���� �� ���� ���α׷� >>

1. ��� �� ���̺� ����
    - ȸ������
    - �α���
    - ��й�ȣ �����ϱ�
    - �г��� �����ϱ�
    - ���������� ��ȸ�ϱ�
    - ȸ��Ż��

    === MEMBER ===
    MEMBER_NUM      NUMBER
    MEMEBR_ID       VARCHAR2(100)
    MEMBER_PWD      VARCHAR2(100)
    MEMBER_NICK     VARCHAR2(100)
    ENROLL_DATE     TIMESTAMP
    WITHDRAW_YN     CHAR(1)
    
    
    - ���� ��ǰ ���
    - ���� ���� ���
    === PRODUCT === 
    GAME_NUM        NUMBER
    GAME_TITLE      VARCHAR2(200)
    GAME_PRICE      NUMBER
    GAME_GENRE      VARCHAR2(50)
    ENROLL_DATE     TIMESTAMP
    PUBLISHER       VARCHAR2(100)
    DISCONTINUED_YN CHAR(1)
    
    - ���� ����
    - ���� ���� ��� ��ȸ
    - ���� ȯ��
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
2. ��ɿ� �ɸ´� ������ �غ�
*/
-- ȸ������
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
    , '����'
    , SYSDATE
    , 'N');
-- �α���
SELECT *
    FROM MEMBER
    WHERE MEMBER_ID = 'USER01' 
    AND MEMBER_PWD = '1234';
-- ��й�ȣ �����ϱ�
UPDATE MEMBER
    SET MEMBER_PWD = '4321'
    WHERE MEMBER_ID = 'USER01' 
    AND MEMBER_PWD = '1234';
-- �г��� �����ϱ�
UPDATE MEMBER
    SET MEMBER_NICK = '����'
    WHERE MEMBER_NICK = '����' 
    AND MEMBER_NUM = 1;
-- ���������� ��ȸ�ϱ�
SELECT *
    FROM MEMBER
    WHERE 
        MEMBER_NUM=1 
        AND MEMBER_ID='USER01' 
        AND MEMBER_PWD = '1234';
-- ȸ�� Ż���ϱ�
UPDATE MEMBER
    SET WITHDRAW_YN = 'Y'
    WHERE MEMBER_ID = 'USER01'
    AND MEMBER_PWD = '1234';
    
-- ���� ��ǰ ���
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
    , '�ŵ� ���� Ÿ����'
    , 20000
    , SYSDATE
    , '�ùķ��̼�'
    , 'Eggcode'
    , 'N'
);
-- ���� ��ǰ ���� ����
UPDATE PRODUCT
    SET GAME_PRICE = '21000'
    WHERE GAME_NUM = 1;
    
