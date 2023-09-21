```sql
-- DQL (SELECT)
/*
    DQL: Data Query Language
    SELECT
        [����]
            SELECT Į��1, Į��2, ...
            FROM ���̺��;
        [Ư¡]
            - �����͸� ��ȸ�� �� ���
            - ��ȸ�� ����� RESULT SET(�������)���� ǥ���ȴ�
            - ���̺� ���� Į���� ��ȸ�ϸ� �ȵ�
*/

-- EMPLOYEE ���̺��� ��ü ����� ���, �̸�, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��ü ����� ��� �÷�(*) ���� ��ȸ
SELECT * FROM EMPLOYEE;

-- ������ ��ҹ��� ��� X

/*
    �������
    SELECT������ ��� ���� ����
*/
-- �̸�, ���� ��ȸ
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- �̸�, ����(���ʽ� ����) ��ȸ
-- ��� ���� �� NULL���� �����ϸ� ������� ������ NULL
SELECT EMP_NAME, SALARY*12*(1+BONUS) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���� �� ���� ����
-- ���� �ð�: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE "�ٹ� �ϼ�" FROM EMPLOYEE;
-- Į���� ��Ī �ο� AS(��������)
-- ��Ī�� ���� �����ϰ� �ʹٸ� ""�� �����ֱ�

/*
    ���ͷ�
    SELECT������ ���ͷ��� ��� ����
*/
SELECT EMP_NAME, EMAIL, 123, 'ABC' FROM EMPLOYEE;

-- ����
-- ��� ���̺��� ��� ����� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE;
-- ����
-- ��� ���̺��� ��� ����� �̸�, �̸���, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, EMAIL, PHONE FROM EMPLOYEE;
-- ����
-- ��� ���̺��� ��� ����� �̸�, ����, ���� ��ȸ
-- ������ ����*12�� ���
-- �� ������ȸ ����� Į�� ��Ī�� �������� ����
SELECT EMP_NAME, SALARY, SALARY*12 ���� FROM EMPLOYEE;
-- ����
-- ��� ���̺��� ��� ����� �����ڵ�(JOB_CODE) ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

/*
    DISTINCT
        Į���� ���Ե� �ߺ��� ����
        SELECT������ �� ���� ��� ����
        Į���� ��������� ��� �����ؾ� �ߺ����� �Ǵ�
*/

-- ���� �ڵ� ��ȸ(�ߺ�����)
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
-- �μ� �ڵ� ��ȸ(�ߺ�����)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
-- ���� �ڵ�, �μ��ڵ� ��� ��ȸ(�ߺ�����)
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;

/*
    ���� ������
        ���� Į�� �� / ���� ���ͷ� �� / Į���� ���ͷ� �� �������ش�
        ||
*/

-- ���, �����, �޿� ��ȸ
SELECT EMP_ID || EMP_NAME AS ���, SALARY FROM EMPLOYEE;
SELECT EMP_ID || '����� ���� ' || EMP_NAME || ' ����� �޿��� ' || SALARY || '�Դϴ�.' FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    WHERE
        [����]
            SELECT Į��1, Į��2, ...
            FROM ���̺��
            WHERE ���ǽ�;
            
            ��ȸ�Ϸ��� ROW�� ���ǽ��� �����ؾ� ��ȸ�ȴ�
            ���ǽĿ� ������ ��� ����
*/

-- �μ��ڵ尡 D9�� ������� ��� Į�� ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
-- �μ��ڵ尡 D9�� �ƴ� ������� ��� Į�� ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE != 'D9';
-- != , ^= , <> �� ��ȣ ��� ���� �ǹ̸� ������.

-- EMPLOYEE ���̺��� �޿��� 400���� �̻��� ��������
-- ������, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- EMPLOYEE ���̺��� ���� ��(ENT_YN Į�� ���� 'N')�� �������� ���, �̸�, �Ի��� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, HIRE_DATE 
FROM EMPLOYEE 
WHERE ENT_YN='N';
-- EMPLOYEE ���̺��� ������ 5000 �̻��� ������ ������, �޿�, ����, �Ի��� ��ȸ
SELECT EMP_NAME ������, SALARY �޿�, SALARY*12 ����, HIRE_DATE �Ի���
FROM EMPLOYEE 
WHERE SALARY*12>=50000000;
-- 3. EMPLOYEE ���̺��� �μ� �ڵ尡 D6�̸鼭 �޿��� 300���� �̻��� �������� ���, ������, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�̸�", DEPT_CODE AS "�μ� �ڵ�", SALARY AS "�޿�"
FROM EMPLOYEE
WHERE DEPT_CODE='D6' AND SALARY >= 3000000;
-- 4. EMPLOYEE ���̺��� �޿��� 400���� �̻�, ���� �ڵ尡 J2�� ����� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY>=4000000 AND JOB_CODE='J2';
-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ���, ������, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID AS ���, EMP_NAME AS ������, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY>=3500000 AND SALARY<=6000000;

--------------------------------------------------------------------------------

/*
    BETWEEN A AND B
    A �̻� B ����
*/

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ���, ������, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- EMPLOYEE ���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ���, ������, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE ���̺��� �Ի��� '90/01/01' ~ '01/01/01'�� ����� ��� Į�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
-- ���ڿ��� �Է������� ����Ŭ�� �˾Ƽ� ��¥�� �ν��ϰ� ��
ORDER BY HIRE_DATE;

/*
    LIKE
    [����]
        WHERE �񱳴���÷� LIKE 'Ư�� ����';
        - ���Ϸ��� �÷� ���� ������ Ư�� ���Ͽ� ������ ��� TRUE�� �����Ѵ�.
        - Ư�� ���Ͽ��� '%', '_'�� ���ϵ�ī��� ����� �� �ִ�.
          '%' : 0���� �̻�
            ex) �񱳴���÷� LIKE '����%'  => �񱳴���÷� �� �߿� '����'�� �����ϴ� ��� ���� ��ȸ�Ѵ�.
                �񱳴���÷� LIKE '%����'  => �񱳴���÷� �� �߿� '����'�� ������ ��� ���� ��ȸ�Ѵ�.
                �񱳴���÷� LIKE '%����%' => �񱳴���÷� �� �߿� '����'�� ���ԵǾ� �ִ� ��� ���� ��ȸ�Ѵ�.
                
          '_' : 1����
            ex) �񱳴���÷� LIKE '_����'  => �񱳴���÷� �� �߿� '����'�տ� ������ �� ���ڰ� ���� ��� ���� ��ȸ�Ѵ�.
                �񱳴���÷� LIKE '__����' => �񱳴���÷� �� �߿� '����'�տ� ������ �� ���ڰ� ���� ��� ���� ��ȸ�Ѵ�.

*/

-- EMPLOYEE ���̺��� ���� �� ���� ����� �����, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- EMPLOYEE ���̺��� �̸� �߿� '��'�� ���Ե� ����� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE ���̺��� ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���Į�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMPLOYEE ���̺��� �̸��� �� _ �� ���ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ��� �����, �̸��� ��ȸ
-- ex) sun_di@kh.or.kr, yoo_js@kh.or.kr, ...
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';

---- �ǽ� -----------------------------------------------------------------------
-- 1. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 2. DEPARTMENT ���̺��� �ؿܿ����ο� ���� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';
--------------------------------------------------------------------------------
