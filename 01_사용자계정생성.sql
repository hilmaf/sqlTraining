-- ����ڰ��� ����

/*
    << ����� ���� ���� >>
    ������ �������θ� �۾� ����
    
    [����]
    CREATE USER ������ IDENTIFIED BY ��й�ȣ;
    ����) ����Ŭ 21C���������� ������ �տ� 'C##'�� �ٿ��־�� ��
*/

CREATE USER C##KH IDENTIFIED BY 1234;

/*
    << ���� �ο� >>
    ������ �������θ� �۾� ����
    [����]
    GRANT ����1, ����2, ����3, ... TO ������;
    
    << ���� Ȯ�� >>
    ROLE_SYS_PRIVS
    
    << ���� ���� >>
    ������ �������θ� �۾� ����
    [����]
    REVOKE ���� FROM ������
*/

GRANT RESOURCE, CONNECT TO C##KH;

SELECT * FROM ROLE_SYS_PRIVS;

REVOKE RESOURCE FROM C##KH;

-- ����Ŭ �����ڵ�: ORA - XXXX
    