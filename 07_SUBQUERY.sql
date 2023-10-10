/*
    <SUBQUERY>
        하나의 SQL 문 안에 포함된 또 다른 SQL 문을 뜻한다. 
        메인 쿼리(기존 쿼리)를 보조하는 역할을 하는 쿼리문이다.
*/


SELECT *
FROM ( SELECT * FROM EMPLOYEE )
;

SELECT (SELECT 10 FROM DUAL) + 20
FROM DUAL
;


-- 노옹철 사원과 같은 부서 사람들의 사원명 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (
                        SELECT DEPT_CODE
                        FROM EMPLOYEE
                        WHERE EMP_NAME = '노옹철'
                   )
;

--------------------------------------

/*
    <서브 쿼리 구분>
        
*/
  
  
/*      
    <단일행,단일열 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행과 열의 개수가 1개 일 때 (단일행, 단일열)
        비교 연산자(단일행 연산자) 사용 가능 (=, !=, <>, ^=, >, <, >=, <=, ...)
*/

-- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의 이름, 급여 조회
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY < (
                    SELECT AVG(SALARY)
                    FROM EMPLOYEE
                )
;

-- 2) 최저 급여를 받는 직원의 이름, 급여 조회
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY = (
                    SELECT MIN(SALARY)
                    FROM EMPLOYEE
                )
;

-- 3) 노옹철 사원의 급여보다 더 많은 급여를 받는 사원들의 사원명, 급여 조회
SELECT EMP_NAME , SALARY
FROM EMPLOYEE
WHERE SALARY > (
                    SELECT SALARY
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '노옹철'
                )
;

-- 4) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
SELECT DEPT_CODE , SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
                        SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE
                    )
;


-- 5) 전지연 사원이 속해있는 부서원들 조회 (단, 전지연 사원은 제외)
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
                        WHERE EMP_NAME = '전지연'
                    ) 
AND E.EMP_NAME != '전지연'
;

/*
    <다중행 서브 쿼리>
        서브 쿼리의 조회 결과 값의 행의 개수가 여러 행 일 때
        
        IN / NOT IN (서브 쿼리) : 여러 개의 결과값 중에서 한 개라도 일치하는 값이 있다면 혹은 없다면 TRUE를 리턴한다.
        ANY : 여러 개의 값들 중에서 한 개라도 만족하면 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다. 
            ANY(100, 200, 300)
            SALARY = ANY(...)  : IN과 같은 결과
            SALARY != ANY(...) : NOT IN과 같은 결과
            SALARY > ANY(...)  : 최소값 보다 크면 TRUE
            SALARY < ANY(...)  : 최대값 보다 작으면 TRUE
        ALL : 여러 개의 값들 모두와 비교하여 만족해야 TRUE, IN과 다른 점은 비교 연산자를 함께 사용한다는 점이다.
            ALL(100, 200, 300)
            SALARY > ALL(...)  : 최대값 보다 크면 TRUE
            SALARY < ALL(...)  : 최소값 보다 작으면 TRUE
*/

-- 부서별 최고 급여를 받는 직원의 이름, 급여, 부서코드 조회
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
                
-- 부사수가 있는 사원의 이름 조회
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

-- 대리 직급의 사원들 중
-- 급여가 과장 직급의 최소 급여보다 높은 직원
-- 직급, 사원명, 급여 조회
SELECT
    JOB_CODE
    , E.EMP_NAME
    , E.SALARY
FROM EMPLOYEE E
JOIN JOB J USING(JOB_CODE)
WHERE J.JOB_NAME = '대리'
AND E.SALARY > ANY(
                    SELECT SALARY
                    FROM EMPLOYEE E
                    JOIN JOB J USING(JOB_CODE)
                    WHERE J.JOB_NAME = '과장'
                );

/*
    다중 열 서브쿼리
*/

-- 하이유 사원과 같은 부서코드, 같은 직급코드를 가진 사원의 이름, 부서코드, 직급코드 조회
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
                                WHERE EMP_NAME = '하이유'
                              );

/*
    다중행, 다중열 서브쿼리
    
*/


-- 인라인 뷰 : FROM절에 서브쿼리문 작성
-- 활용: 상위 N명, 하위 N명 조회 가능해짐
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
-- 결과 조회 안되는 이유
-- 실행순서와 관련이 있음
-- 해결 방법
-- 인라인뷰를 다시 한 번 
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
-- ROWNUM은 ORDER BY가 실행되기 전에 매겨진다.
-- 따라서 서브쿼리문을 활용해 실행순서를 조정해주어야 함.

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY ROWNUM ASC, SALARY DESC;
-- 이렇게 하면 급여순 정렬이 안됨

SELECT ROWNUM, EMP_NAME
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ); -- 가능
     
SELECT ROWNUM, *
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ); -- 오류
     
SELECT ROWNUM, A.*
FROM (
        SELECT EMP_ID, EMP_NAME, SALARY
        FROM EMPLOYEE
        ORDER BY SALARY DESC
     ) A
     ; -- 오류 해결
     
-- WITH(ORACLE)


/*
    <RANK 함수>
        [표현법]
            RANK() OVER(정렬 기준) / DENSE_RANK() OVER(정렬 기준)
        
         RANK() OVER(정렬 기준)         : 중복 순위 이후의 등수를 동일한 인원수만큼 건너뛰고 순위를 계산한다.
                                         (EX. 공동 1위가 2명이면 다음 순위는 3위)
         DENSE_RANK() OVER(정렬 기준)   : 중복 순위 이후의 등수를 무조건 1씩 증가한다.
                                         (EX. 공동 1위가 2명이면 다음 순위는 2위)
*/

-- 급여 높은 순으로 순위 매기기
-- 순위, 사원명, 급여 조회
SELECT
    DENSE_RANK() OVER(ORDER BY SALARY DESC) "급여 순위"
    , EMP_NAME
    , SALARY
FROM EMPLOYEE
;

-- 급여 상위 3명
SELECT
    DENSE_RANK() OVER(ORDER BY SALARY DESC) "급여 순위"
    , EMP_NAME
    , SALARY
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 3
; -- 오류 : WHERE절에 ROWNUM은 사용 가능, RANK함수는 사용 불가능

SELECT * -- 질무우우우운 ~~~~~~
FROM (
        SELECT
            DENSE_RANK() OVER(ORDER BY SALARY DESC) "급여 순위"
            , EMP_NAME
            , SALARY
        FROM EMPLOYEE
      )
WHERE "급여 순위" <=3
;