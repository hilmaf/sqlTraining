/*
    <SUBQUERY>
        �ϳ��� SQL �� �ȿ� ���Ե� �� �ٸ� SQL ���� ���Ѵ�. 
        ���� ����(���� ����)�� �����ϴ� ������ �ϴ� �������̴�.
*/


SELECT *
FROM ( SELECT * FROM EMPLOYEE )
;

SELECT (SELECT 10 FROM DUAL) + 20
FROM DUAL
;


-- ���ö ����� ���� �μ� ������� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (
                        SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '���ö'
                   )
;

--------------------------------------

/*
    <���� ���� ����>
        
*/
  
  
/*      
    <������,���Ͽ� ���� ����>
        ���� ������ ��ȸ ��� ���� ��� ���� ������ 1�� �� �� (������, ���Ͽ�)
        �� ������(������ ������) ��� ���� (=, !=, <>, ^=, >, <, >=, <=, ...)
*/

-- 1) �� ������ ��� �޿����� �޿��� ���� �޴� �������� �̸�, �޿� ��ȸ
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY < (
                    SELECT AVG(SALARY)
                    FROM EMPLOYEE
                )
;

-- 2) ���� �޿��� �޴� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY = (
                    SELECT MIN(SALARY)
                    FROM EMPLOYEE
                )
;

-- 3) ���ö ����� �޿����� �� ���� �޿��� �޴� ������� �����, �޿� ��ȸ
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY > (
                    SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '���ö'
                )
;

-- 4) �μ��� �޿��� ���� ���� ū �μ��� �μ� �ڵ�, �޿��� �� ��ȸ
SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
                        SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE
                    )
;


-- 5) ������ ����� �����ִ� �μ����� ��ȸ (��, ������ ����� ����)
SELECT E.EMP_ID, 
       E.EMP_NAME, 
       E.PHONE, 
       J.JOB_NAME, 
       D.DEPT_TITLE,
       E.HIRE_DATE
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
WHERE E.DEPT_CODE = (
                        SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '������'
                    ) 
AND E.EMP_NAME != '������'
;

/*
    <������ ���� ����>
        ���� ������ ��ȸ ��� ���� ���� ������ ���� �� �� ��
        
        IN / NOT IN (���� ����) : ���� ���� ����� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� Ȥ�� ���ٸ� TRUE�� �����Ѵ�.
        ANY : ���� ���� ���� �߿��� �� ���� �����ϸ� TRUE, IN�� �ٸ� ���� �� �����ڸ� �Բ� ����Ѵٴ� ���̴�. 
            ANY(100, 200, 300)
            SALARY = ANY(...)  : IN�� ���� ���
            SALARY != ANY(...) : NOT IN�� ���� ���
            SALARY > ANY(...)  : �ּҰ� ���� ũ�� TRUE
            SALARY < ANY(...)  : �ִ밪 ���� ������ TRUE
        ALL : ���� ���� ���� ��ο� ���Ͽ� �����ؾ� TRUE, IN�� �ٸ� ���� �� �����ڸ� �Բ� ����Ѵٴ� ���̴�.
            ALL(100, 200, 300)
            SALARY > ALL(...)  : �ִ밪 ���� ũ�� TRUE
            SALARY < ALL(...)  : �ּҰ� ���� ������ TRUE
*/

-- �μ��� �ְ� �޿��� �޴� ������ �̸�, �޿�, �μ��ڵ� ��ȸ
SELECT
    EMP_NAME
    , SALARY
    , DEPT_CODE
FROM EMPLOYEE
WHERE SALARY IN(
                    SELECT MAX(SALARY)
                    FROM EMPLOYEE
                    GROUP BY DEPT_CODE
                );
                
-- �λ���� �ִ� ����� �̸� ��ȸ
SELECT 
    EMP_ID
    , EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID IN(
                SELECT DISTINCT(
                    MANAGER_ID)
                FROM EMPLOYEE
                WHERE MANAGER_ID IS NOT NULL
                );

-- �븮 ������ ����� ��
-- �޿��� ���� ������ �ּ� �޿����� ���� ����
-- ����, �����, �޿� ��ȸ
SELECT
    JOB_CODE
    , E.EMP_NAME
    , E.SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '�븮'
AND E.SALARY > ANY(
                    SELECT SALARY
                    FROM EMPLOYEE E
                    JOIN JOB J USING(JOB_CODE)
                    WHERE J.JOB_NAME = '����'
                );

/*
    ���� �� ��������
*/

-- ������ ����� ���� �μ��ڵ�, ���� �����ڵ带 ���� ����� �̸�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT
    EMP_NAME
    , DEPT_CODE
    , JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (
                                SELECT
                                    DEPT_CODE
                                    , JOB_CODE
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������'
                              );

/*
    ������, ���߿� ��������
    
*/


-- �ζ��� �� : FROM���� ���������� �ۼ�
-- Ȱ��: ���� N��, ���� N�� ��ȸ ��������
SELECT *
FROM (SELECT * FROM EMPLOYEE)
;

-- TOP-N
SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     )
WHERE ROWNUM BETWEEN 4 AND 6
;
-- ��� ��ȸ �ȵǴ� ����
-- ��������� ������ ����
-- �ذ� ���
-- �ζ��κ並 �ٽ� �� �� 
SELECT *
FROM (
        SELECT ROWNUM RNUM, EMP_ID, EMP_NAME, SALARY
        FROM (
            SELECT EMP_ID, EMP_NAME, SALARY
            FROM EMPLOYEE
            ORDER BY SALARY DESC
         ) A
    )
WHERE RNUM BETWEEN 4 AND 6
;

-------------------------------------------------
-- ROWNUM�� ORDER BY�� ����Ǳ� ���� �Ű�����.
-- ���� ������������ Ȱ���� ��������� �������־�� ��.

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY ROWNUM ASC, SALARY DESC;
-- �̷��� �ϸ� �޿��� ������ �ȵ�

SELECT ROWNUM, EMP_NAME
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ); -- ����
     
SELECT ROWNUM, *
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ); -- ����
     
SELECT ROWNUM, A.*
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ) A
     ; -- ���� �ذ�
     
-- WITH(ORACLE)


/*
    <RANK �Լ�>
        [ǥ����]
            RANK() OVER(���� ����) / DENSE_RANK() OVER(���� ����)
        
         RANK() OVER(���� ����)         : �ߺ� ���� ������ ����� ������ �ο�����ŭ �ǳʶٰ� ������ ����Ѵ�.
                                         (EX. ���� 1���� 2���̸� ���� ������ 3��)
         DENSE_RANK() OVER(���� ����)   : �ߺ� ���� ������ ����� ������ 1�� �����Ѵ�.
                                         (EX. ���� 1���� 2���̸� ���� ������ 2��)
*/

-- �޿� ���� ������ ���� �ű��
-- ����, �����, �޿� ��ȸ
SELECT
    DENSE_RANK() OVER(ORDER BY SALARY DESC) "�޿� ����"
    , EMP_NAME
    , SALARY
FROM EMPLOYEE
;

-- �޿� ���� 3��
SELECT
    DENSE_RANK() OVER(ORDER BY SALARY DESC) "�޿� ����"
    , EMP_NAME
    , SALARY
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 3
; -- ���� : WHERE���� ROWNUM�� ��� ����, RANK�Լ��� ��� �Ұ���

SELECT * -- ��������� ~~~~~~
FROM (
        SELECT
            DENSE_RANK() OVER(ORDER BY SALARY DESC) "�޿� ����"
            , EMP_NAME
            , SALARY
        FROM EMPLOYEE
      )
WHERE "�޿� ����" <=3
;