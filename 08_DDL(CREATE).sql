-- DDL

/*
    <DDL(Data Definition Language)>
        ������ ���� ���� ����Ŭ���� �����ϴ� ��ü�� �����(CREATE), �����ϰ�(ALTER), �����ϴ�(DROP) ��
        ���� ������ ���� �ƴ� �������� ���� ��ü�� �����ϴ� ���� DB ������, �����ڰ� �ַ� ����Ѵ�.

        * ����Ŭ������ ��ü : ���̺�, ��, ������, �ε���, Ʈ����, ���ν���, �Լ�, ����� ���
        
    <CREATE>
        �����ͺ��̽��� ��ü�� �����ϴ� �����̴�.
    
    <TABLE(���̺�)>
        ���̺��� ��� ���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü�� �����ͺ��̽� ������ ��� �����ʹ� ���̺� ����ȴ�.
        
    <���̺� ����>
        [����]
            CREATE TABLE ���̺�� (
                Į���� �ڷ���(ũ��) [DEFAULT �⺻��] [��������],
                Į���� �ڷ���(ũ��) [DEFAULT �⺻��] [��������],
                ...
            );
*/

CREATE TABLE MEMBER(
    ID              VARCHAR2(100)
    , PWD           VARCHAR2(100)
    , NICK          VARCHAR2(100)
    , ENROLL_DATE   TIMESTAMP
);

SELECT *
FROM MEMBER;

-- ���̺� ���� Ȯ��
DESC MEMBER;

/*
    <Į���� �ּ� �ޱ�>
        [����]
            COMMENT ON COLUMN ���̺��.Į���� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.ID IS '���̵�';
COMMENT ON COLUMN MEMBER.PWD IS '��й�ȣ';
COMMENT ON COLUMN MEMBER.NICK IS '�г���';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '�����Ͻ�';


/*
    ������ ��ųʸ�(��Ÿ ������)
        �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ��ü���� ������ �����ϴ� �ý��� ���̺��̴�.
        ����ڰ� ��ü�� �����ϰų� ��ü�� �����ϴ� ���� �۾��� �� �� �����ͺ��̽��� ���ؼ� �ڵ����� ���ŵǴ� ���̺��̴�.
        �����Ϳ� ���� �����Ͱ� ����Ǿ� �ִٰ� �ؼ� ��Ÿ �����Ͷ�� �Ѵ�.
        
    USER_TABLES         : ����ڰ� ������ �ִ� ���̺���� �������� ������ Ȯ���ϴ� �� ���̺��̴�. 
    USER_TAB_COLUMNS    : ���̺�, ���� Į���� ���õ� ������ ��ȸ�ϴ� �� ���̺��̴�.
*/

SELECT * FROM USER_TABLES;
SELECT * FROM USER_TAB_COLUMNS;

-- INSERT
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE) VALUES('USER01', '1234', 'NICK01', SYSDATE);
INSERT INTO MEMBER VALUES('USER01', '1234', 'NICK01', SYSDATE);

INSERT INTO MEMBER(ID, PWD) VALUES('USER01', '1234');

SELECT * FROM MEMBER;
-- COMMIT
COMMIT;
SHOW AUTOCOMMIT; 
-- AUTOCOMMIT ���� Ȯ��
SET AUTOCOMMIT ON; 
-- �ѱ�
SET AUTOCOMMIT OFF;
-- ����

--------------------------------------------------------------------------------

/*
    <���� ����(CONSTRAINT)>
        ����ڰ� ���ϴ� ������ �����͸� �����ϱ� ���ؼ� ���̺� �ۼ� �� �� Į���� ���� ����� ���� ���� ���������� ������ �� �ִ�.
        ���� ������ ������ ���Ἲ ������ �������� �Ѵ�. (�������� ��Ȯ���� �ϰ����� ������Ű�� ��)
        
        * ���� : NOT NULL, UNIQUE, CHECK,PRIMARY KEY, FOREIGN KEY
        ����) DEFAULT : ���������� �ƴ�.
        +) UNIQUE(ID, PWD)ó�� ��� �ߺ��Ұ� ó���ϸ�
        USER01, 1234 // USER01, 4321�� �ߺ� �ƴϾ INSERTó����
        [����]
            1) Į�� ����
                CRATE TABLE ���̺�� (
                    Į���� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�] ��������,
                    ...
                );
            
            2) ���̺� ����
                CRATE TABLE ���̺�� (
                    Į���� �ڷ���(ũ��),
                    ...,
                    [CONSTRAINT �������Ǹ�] ��������(Į����)
                );
*/
CREATE TABLE MEMBER(
    ID              VARCHAR2(100)   NOT NULL UNIQUE
    , PWD           VARCHAR2(100)   NOT NULL
    , NICK          VARCHAR2(100)
    , ENROLL_DATE   TIMESTAMP       DEFAULT SYSDATE
    , QUIT_YN       CHAR(1)         CHECK(QUIT_YN IN('Y', 'N'))
);

DROP TABLE MEMBER;

INSERT INTO MEMBER(ID) VALUES('USER01'); -- ����: NOT NULL ����
INSERT INTO MEMBER(ID, PWD) VALUES('USER01', '1234');
INSERT INTO MEMBER(ID, PWD, NICK) VALUES('USER02', '5678', NULL);
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE) VALUES('USER03', '1357', NULL, NULL);
INSERT INTO MEMBER(ID, PWD, NICK) VALUES('USER03', '1357', NULL);
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE) VALUES('USER01', '1234', NULL, DEFAULT);
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE, QUIT_YN) VALUES('USER01', '1234', NULL, DEFAULT, 'N');
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE, QUIT_YN) VALUES('USER02', '2222', NULL, DEFAULT, 'Y');
INSERT INTO MEMBER(ID, PWD, NICK, ENROLL_DATE, QUIT_YN) VALUES('USER03', '3333', NULL, DEFAULT, 'A');

-- Į�� ����
--CREATE TABLE MEMBER(
--    NO              NUMBER          PRIMARY KEY
--    , ID            VARCHAR2(100)   NOT NULL UNIQUE
--    , PWD           VARCHAR2(100)   CONSTRAINT �����ڵ�00123�н����峴�� NOT NULL
--    , NICK          VARCHAR2(100)
--    , ENROLL_DATE   TIMESTAMP       DEFAULT SYSDATE
--    , QUIT_YN       CHAR(1)         CHECK(QUIT_YN IN('Y', 'N'))
--);

-- ���̺� ����
CREATE TABLE MEMBER(
    NO              NUMBER       
    , ID            VARCHAR2(100) 
    , PWD           VARCHAR2(100)   
    , NICK          VARCHAR2(100)
    , ENROLL_DATE   TIMESTAMP       
    , QUIT_YN       CHAR(1)
    , UNIQUE(ID)
    , CHECK( QUIT_YN IN ('Y', 'N') )
    , PRIMARY KEY(NO)
);
 -- , NOT NULL(ID) : NOT NULL ���������� ���̺� �������� ���� �Ұ���

CREATE TABLE SCORE(
    MEMBER_NO       NUMBER
    , GRADE         CHAR(1)
    , FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(NO)
);

DROP TABLE SCORE;
SELECT * FROM MEMBER;
SELECT * FROM SCORE;
-- PRIMARY KEY: NOT NULL, UNIQUE�� ���Ҿ� INDEX�� �ڵ����� �������
INSERT INTO MEMBER(NO, ID, PWD, NICK) VALUES(1, 'USER01', '1234', 'NICK01');
INSERT INTO SCORE(MEMBER_NO, GRADE) VALUES(1, 'A');
INSERT INTO SCORE(MEMBER_NO, GRADE) VALUES(2, 'A'); -- MEMBER���̺� ���� NO ���� �Ұ�
INSERT INTO SCORE(MEMBER_NO, GRADE) VALUES(NULL, 'B'); -- NULL�� ���� BUT NOT NULL �����������

-- ON DELETE SET NULL
-- ON DELETE CASCADE