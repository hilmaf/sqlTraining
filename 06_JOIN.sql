-- JOIN

/*
    <JOIN>
        �� ���� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� �����̴�.
        
        1. � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
            �����Ű�� Į���� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ�Ѵ�.(��ġ�ϴ� ���� ���� ���� ��ȸ X)
            
            1) ����Ŭ ���� ����
                [ǥ����]
                    SELECT Į��, Į��, ...
                    FROM ���̺�1, ���̺�2
                    WHERE ���̺�1.Į���� = ���̺�2.Į����;
                
                - FROM ���� ��ȸ�ϰ��� �ϴ� ���̺���� �޸�(,)�� �����Ͽ� �����Ѵ�.
                - WHERE ���� ��Ī ��ų Į���� ���� ������ �����Ѵ�.
            
            2) ANSI ǥ�� ����
                [ǥ����]
                    SELECT Į��, Į��, ...
                    FROM ���̺�1
                    [INNER] JOIN ���̺�2 ON (���̺�1.Į���� = ���̺�2.Į����);
                
                - FROM ���� ������ �Ǵ� ���̺��� ����Ѵ�.
                - JOIN ���� ���� ��ȸ�ϰ��� �ϴ� ���̺��� ��� �� ��Ī ��ų Į���� ���� ������ ����Ѵ�.
                - ���ῡ ����Ϸ��� Į������ ���� ��� ON ���� ��ſ� USING(Į����) ������ ����Ѵ�.
*/


-- �����, �μ��ڵ�, �μ��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
;


-- �����, �����ڵ�, ���޸� ��ȸ
SELECT EMP_NAME , E.JOB_CODE , JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
;

--SELECT EMP_NAME , E.JOB_CODE , JOB_NAME
--FROM EMPLOYEE E , JOB J
--WHERE E.JOB_CODE = J.JOB_CODE;

-- NATURAL JOIN



/*
    2. ���� JOIN
        ���� ���� ���̺� �����ϴ� ��쿡 ����Ѵ�.
*/

-- ����̸�, �μ��ڵ�, �μ���, �����ڵ�
SELECT EMP_NAME , DEPT_CODE , DEPT_TITLE , NATIONAL_CODE
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
;

/*
    3. �ܺ� ���� (OUTER JOIN)
        ���̺� ���� JOIN �� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ�� �����ϴ�.
        ��, �ݵ�� �����̵Ǵ� ���̺�(�÷�)�� �����ؾ� �Ѵ�. (LEFT/RIGHT/(+))
*/

-- ����� , �μ��̸�
SELECT EMP_NAME , DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
;



/*
    4. ī�׽þȰ�(CARTESIAN PRODUCT) / ���� ����(CROSS JOIN)
        ���εǴ� ��� ���̺��� �� ����� ���μ��� ��� ���ε� �����Ͱ� �˻��ȴ�.
        ���̺��� ����� ��� ������ ����� ������ ��� -> ����ȭ�� ����
*/

-- �μ��̸� , �����ڵ�
SELECT DEPT_TITLE, NATIONAL_CODE
FROM DEPARTMENT
CROSS JOIN LOCATION
;


/*
    5. �� ����(NON EQUAL JOIN)
        ���� ���ǿ� ��ȣ(=)�� ������� �ʴ� ���ι��� �� �����̶�� �Ѵ�.
        ������ �÷� ���� ��ġ�ϴ� ��찡 �ƴ�, ���� ������ ���ԵǴ� ����� �����ϴ� ����̴�.
        ( = �̿ܿ� �� ������ >, <, >=, <=, BETWEEN AND, IN, NOT IN ���� ����Ѵ�.)
        
        -- ANSI �������δ� JOIN ON �������θ� ����� �����ϴ�. (USING ��� �Ұ�)
*/

-- ����� , �޿� , �޿����
SELECT EMP_NAME, SALARY , SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL
;


/*
    6. ��ü ����(SELF JOIN)
        ���� ���̺��� �ٽ� �ѹ� �����ϴ� ��쿡 ����Ѵ�.
*/

-- �����ȣ, ����� , �����ȣ, �����
SELECT 
    A.EMP_ID        AS �����ȣ
    , A.EMP_NAME    AS ����̸�
    , A.MANAGER_ID  AS �����ȣ
    , NVL(B.EMP_NAME , '�������')    AS ����̸�
FROM EMPLOYEE A
LEFT OUTER JOIN EMPLOYEE B ON A.MANAGER_ID = B.EMP_ID
ORDER BY A.EMP_ID
;


---------------------------------------------------------------------------------
-- 1. DEPARTMENT ���̺�� LOCATION ���̺��� �����Ͽ� �μ� �ڵ�, �μ���, ���� �ڵ�, �������� ��ȸ
SELECT 
    D.DEPT_ID
    , D.DEPT_TITLE
    , L.LOCAL_CODE
    , L.LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
;

-- 2. EMPLOYEE ���̺�� DEPARTMENT ���̺��� �����ؼ� ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ����� ��ȸ
SELECT E.EMP_ID, E.EMP_NAME, E.BONUS, D.DEPT_TITLE
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID 
WHERE BONUS IS NOT NULL
;

-- 3. EMPLOYEE ���̺�� DEPARTMENT ���̺��� �����ؼ� �λ�����ΰ� �ƴ� ������� �����, �μ���, �޿��� ��ȸ
SELECT
    E.EMP_NAME
    , D.DEPT_TITLE
    , E.SALARY
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE D.DEPT_TITLE != '�λ������' OR D.DEPT_TITLE IS NULL
;

-- 4. EMPLOYEE ���̺�, DEPARTMENT ���̺�, LOCATION ���̺��� �����ؼ� ���, �����, �μ���, ������ ��ȸ
SELECT 
    E.EMP_ID
    , E.EMP_NAME
    , D.DEPT_TITLE
    , L.LOCAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
LEFT JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
;


-- 5. ���, �����, �μ���, ������, ������ ��ȸ
SELECT 
    E.EMP_ID            
    , E.EMP_NAME        AS �����
    , D.DEPT_TITLE      AS �μ���
    , L.LOCAL_NAME      AS ������
    , N.NATIONAL_NAME   AS ������
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
LEFT JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
LEFT JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
;



-- 6. ���, �����, �μ���, ������, ������, �޿� ��� ��ȸ
SELECT 
    E.EMP_ID            
    , E.EMP_NAME        AS �����
    , D.DEPT_TITLE      AS �μ���
    , L.LOCAL_NAME      AS ������
    , N.NATIONAL_NAME   AS ������
    , S.SAL_LEVEL       AS "�޿� ���"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
LEFT JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
LEFT JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE
LEFT JOIN SAL_GRADE S ON E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
;




------------------------- ���� �ǽ� ���� -------------------------
-- 1. ������ �븮�̸鼭 ASIA �������� �ٹ��ϴ� �������� ���, �����, ���޸�, �μ���, �ٹ�����, �޿��� ��ȸ�ϼ���.
SELECT E.EMP_ID AS "���",
       E.EMP_NAME AS "�����", 
       J.JOB_NAME AS "���޸�", 
       D.DEPT_TITLE AS "�μ���", 
       L.LOCAL_NAME AS "�ٹ�����", 
       E.SALARY AS "�޿�"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '�븮' 
  AND L.LOCAL_NAME LIKE 'ASIA%';
  
-- 2. 70���� �̸鼭 �����̰�, ���� �� ���� �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�ϼ���.
SELECT E.EMP_NAME AS "�����",
       E.EMP_NO AS "�ֹι�ȣ",
       D.DEPT_TITLE AS "�μ���",
       J.JOB_NAME AS "���޸�"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
--WHERE SUBSTR(E.EMP_NO, 1, 1) = '7'
WHERE E.EMP_NO LIKE '7%'
  AND SUBSTR(E.EMP_NO, 8, 1) = '2'
  AND E.EMP_NAME LIKE '��%';
  
-- 3. ���ʽ��� �޴� �������� �����, ���ʽ�, ����, �μ���, �ٹ������� ��ȸ�ϼ���.
--    ��, �μ� �ڵ尡 ���� ����� ��µ� �� �ְ� Outer JOIN ���
SELECT E.EMP_NAME AS "�����",
       NVL(E.BONUS, 0) AS "���ʽ�",
       TO_CHAR(E.SALARY * 12, '99,999,999') AS "����",
       D.DEPT_TITLE AS "�μ���",
       L.LOCAL_NAME AS "�ٹ�����"
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT OUTER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 4. �ѱ��� �Ϻ����� �ٹ��ϴ� �������� �����, �μ���, �ٹ�����, �ٹ� ������ ��ȸ�ϼ���.
SELECT E.EMP_NAME AS "�����", 
       D.DEPT_TITLE AS "�μ���", 
       L.LOCAL_NAME AS "�ٹ�����", 
       N.NATIONAL_NAME AS "�ٹ�����"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

-- 5. �� �μ��� ��� �޿��� ��ȸ�Ͽ� �μ���, ��� �޿�(���� ó��)�� ��ȸ�ϼ���.
--    ��, �μ� ��ġ�� �ȵ� ������� ��յ� ���� �����Բ� ���ּ���^^
SELECT NVL(D.DEPT_TITLE, '�μ�����') AS "�μ���", 
       TO_CHAR(ROUND(AVG(NVL(SALARY, 0))), '99,999,999') AS "�޿����"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
ORDER BY D.DEPT_TITLE;

-- 6. �� �μ��� �� �޿��� ���� 1000���� �̻��� �μ���, �޿��� ���� ��ȸ�Ͻÿ�.
SELECT D.DEPT_TITLE AS "�μ���", 
       TO_CHAR(SUM(SALARY), '99,999,999') AS "�޿��� ��"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(SALARY) >= 10000000
ORDER BY D.DEPT_TITLE;

-- 7. ���, �����, ���޸�, �޿� ���, ������ ��ȸ (NON EQUAL JOIN �Ŀ� �ǽ� ����)
--    �̶� ���п� �ش��ϴ� ���� �Ʒ��� ���� ��ȸ �ǵ��� �Ͻÿ�.
--    �޿� ����� S1, S2�� ��� '���'
--    �޿� ����� S3, S4�� ��� '�߱�'
--    �޿� ����� S5, S6�� ��� '�ʱ�'
SELECT E.EMP_ID AS "���", 
       E.EMP_NAME AS "�����", 
       J.JOB_NAME AS "���޸�",
       S.SAL_LEVEL AS "�޿� ���",
       CASE 
            WHEN S.SAL_LEVEL IN ('S1', 'S2') THEN '���' 
            WHEN S.SAL_LEVEL IN ('S3', 'S4') THEN '�߱�'
            WHEN S.SAL_LEVEL IN ('S5', 'S6') THEN '�ʱ�'
       END AS "����"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

-- 8. ���ʽ��� ���� �ʴ� ������ �� ���� �ڵ尡 J4 �Ǵ� J7�� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
SELECT E.EMP_NAME AS "�����", 
       J.JOB_NAME AS "���޸�", 
       E.SALARY AS "�޿�"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE E.BONUS IS NULL
  AND E.JOB_CODE IN ('J4', 'J7');
  
-- 9. �μ��� �ִ� �������� �����, ���޸�, �μ���, �ٹ� ������ ��ȸ�Ͻÿ�.
SELECT EMP_NAME  AS "�����", 
       JOB_NAME  AS "���޸�", 
       DEPT_TITLE  AS "�μ���", 
       LOCAL_NAME  AS "�ٹ� ����"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

-- 10. �ؿܿ������� �ٹ��ϴ� �������� �����, ���޸�, �μ� �ڵ�, �μ����� ��ȸ�Ͻÿ�
SELECT E.EMP_NAME AS "�����", 
       J.JOB_NAME AS "���޸�", 
       E.DEPT_CODE AS "�μ� �ڵ�", 
       D.DEPT_TITLE AS "�μ���"
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE LIKE '�ؿܿ���%'
ORDER BY E.EMP_NAME;

-- 11. �̸��� '��'�ڰ� ����ִ� �������� ���, �����, ���޸��� ��ȸ�Ͻÿ�.
SELECT E.EMP_ID AS "���",
       E.EMP_NAME AS "�����",
       J.JOB_NAME AS "���޸�"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NAME LIKE '%��%';