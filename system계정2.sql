-- 과제용 계정 생성
CREATE USER C##KH_WORKBOOK IDENTIFIED BY 1234;

-- 권한 부여
GRANT CONNECT, RESOURCE TO C##KH_WORKBOOK;

-- 테이블스페이스 권한 부여
ALTER USER C##KH_WORKBOOK DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;