-- 사용자계정 생성

/*
    << 사용자 계정 생성 >>
    관리자 계정으로만 작업 가능
    
    [문법]
    CREATE USER 계정명 IDENTIFIED BY 비밀번호;
    주의) 오라클 21C버전에서는 계정명 앞에 'C##'을 붙여주어야 함
*/

CREATE USER C##KH IDENTIFIED BY 1234;

/*
    << 권한 부여 >>
    관리자 계정으로만 작업 가능
    [문법]
    GRANT 권한1, 권한2, 권한3, ... TO 계정명;
    
    << 권한 확인 >>
    ROLE_SYS_PRIVS
    
    << 권한 해제 >>
    관리자 계정으로만 작업 가능
    [문법]
    REVOKE 권한 FROM 계정명
*/

GRANT RESOURCE, CONNECT TO C##KH;

SELECT * FROM ROLE_SYS_PRIVS;

REVOKE RESOURCE FROM C##KH;

-- 오라클 에러코드: ORA - XXXX
    