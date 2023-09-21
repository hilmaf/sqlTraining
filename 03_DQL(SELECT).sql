```sql
-- DQL (SELECT)
/*
    DQL: Data Query Language
    SELECT
        [문법]
            SELECT 칼럼1, 칼럼2, ...
            FROM 테이블명;
        [특징]
            - 데이터를 조회할 때 사용
            - 조회된 결과는 RESULT SET(결과집합)으로 표현된다
            - 테이블에 없는 칼럼을 조회하면 안됨
*/

-- EMPLOYEE 테이블에서 전체 사원의 사번, 이름, 월급을 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼(*) 정보 조회
SELECT * FROM EMPLOYEE;

-- 쿼리는 대소문자 상관 X

/*
    산술연산
    SELECT절에서 산술 연산 가능
*/
-- 이름, 연봉 조회
SELECT EMP_NAME, SALARY*12 FROM EMPLOYEE;

-- 이름, 연봉(보너스 포함) 조회
-- 산술 연산 중 NULL값이 존재하면 결과값은 무조건 NULL
SELECT EMP_NAME, SALARY*12*(1+BONUS) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식 간 연산 가능
-- 현재 시각: SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE "근무 일수" FROM EMPLOYEE;
-- 칼럼명에 별칭 부여 AS(생략가능)
-- 별칭에 띄어쓰기 포함하고 싶다면 ""로 감싸주기

/*
    리터럴
    SELECT절에서 리터럴을 사용 가능
*/
SELECT EMP_NAME, EMAIL, 123, 'ABC' FROM EMPLOYEE;

-- 연습
-- 사원 테이블에서 모든 사원의 모든 정보 조회
SELECT * FROM EMPLOYEE;
-- 연습
-- 사원 테이블에서 모든 사원의 이름, 이메일, 전화번호 조회
SELECT EMP_NAME, EMAIL, PHONE FROM EMPLOYEE;
-- 연습
-- 사원 테이블에서 모든 사원의 이름, 월급, 연봉 조회
-- 연봉은 월급*12로 계산
-- 단 연봉조회 결과는 칼럼 별칭을 연봉으로 지정
SELECT EMP_NAME, SALARY, SALARY*12 연봉 FROM EMPLOYEE;
-- 연습
-- 사원 테이블에서 모든 사원의 직원코드(JOB_CODE) 조회
SELECT JOB_CODE FROM EMPLOYEE;

/*
    DISTINCT
        칼럼에 포함된 중복값 제거
        SELECT절에서 한 번만 사용 가능
        칼럼이 여러개라면 모두 동일해야 중복으로 판단
*/

-- 직원 코드 조회(중복제거)
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;
-- 부서 코드 조회(중복제거)
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
-- 직원 코드, 부서코드 모두 조회(중복제거)
SELECT DISTINCT JOB_CODE, DEPT_CODE FROM EMPLOYEE;

/*
    연결 연산자
        여러 칼럼 값 / 여러 리터럴 값 / 칼럼과 리터럴 을 연결해준다
        ||
*/

-- 사번, 사원명, 급여 조회
SELECT EMP_ID || EMP_NAME AS 사원, SALARY FROM EMPLOYEE;
SELECT EMP_ID || '사번을 가진 ' || EMP_NAME || ' 사원의 급여는 ' || SALARY || '입니다.' FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    WHERE
        [문법]
            SELECT 칼럼1, 칼럼2, ...
            FROM 테이블명
            WHERE 조건식;
            
            조회하려는 ROW가 조건식을 만족해야 조회된다
            조건식에 연산자 사용 가능
*/

-- 부서코드가 D9인 사원들의 모든 칼럼 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';
-- 부서코드가 D9가 아닌 사원들의 모든 칼럼 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE != 'D9';
-- != , ^= , <> 세 기호 모두 같은 의미를 가진다.

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 직원들의
-- 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>=4000000;

-- EMPLOYEE 테이블에서 재직 중(ENT_YN 칼럼 값이 'N')인 직원들의 사번, 이름, 입사일 조회
SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, HIRE_DATE 
FROM EMPLOYEE 
WHERE ENT_YN='N';
-- EMPLOYEE 테이블에서 연봉이 5000 이상인 직원의 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME 직원명, SALARY 급여, SALARY*12 연봉, HIRE_DATE 입사일
FROM EMPLOYEE 
WHERE SALARY*12>=50000000;
-- 3. EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID AS "사번", EMP_NAME AS "이름", DEPT_CODE AS "부서 코드", SALARY AS "급여"
FROM EMPLOYEE
WHERE DEPT_CODE='D6' AND SALARY >= 3000000;
-- 4. EMPLOYEE 테이블에서 급여가 400만원 이상, 직급 코드가 J2인 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY>=4000000 AND JOB_CODE='J2';
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID AS 사번, EMP_NAME AS 직원명, DEPT_CODE AS 부서코드, SALARY AS 급여
FROM EMPLOYEE
WHERE SALARY>=3500000 AND SALARY<=6000000;

--------------------------------------------------------------------------------

/*
    BETWEEN A AND B
    A 이상 B 이하
*/

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE NOT SALARY BETWEEN 3500000 AND 6000000
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

-- EMPLOYEE 테이블에서 입사일 '90/01/01' ~ '01/01/01'인 사원의 모든 칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
-- 문자열로 입력했지만 오라클이 알아서 날짜로 인식하게 됨
ORDER BY HIRE_DATE;

/*
    LIKE
    [문법]
        WHERE 비교대상컬럼 LIKE '특정 패턴';
        - 비교하려는 컬럼 값이 지정된 특정 패턴에 만족할 경우 TRUE를 리턴한다.
        - 특정 패턴에는 '%', '_'를 와일드카드로 사용할 수 있다.
          '%' : 0글자 이상
            ex) 비교대상컬럼 LIKE '문자%'  => 비교대상컬럼 값 중에 '문자'로 시작하는 모든 행을 조회한다.
                비교대상컬럼 LIKE '%문자'  => 비교대상컬럼 값 중에 '문자'로 끝나는 모든 행을 조회한다.
                비교대상컬럼 LIKE '%문자%' => 비교대상컬럼 값 중에 '문자'가 포함되어 있는 모든 행을 조회한다.
                
          '_' : 1글자
            ex) 비교대상컬럼 LIKE '_문자'  => 비교대상컬럼 값 중에 '문자'앞에 무조건 한 글자가 오는 모든 행을 조회한다.
                비교대상컬럼 LIKE '__문자' => 비교대상컬럼 값 중에 '문자'앞에 무조건 두 글자가 오는 모든 행을 조회한다.

*/

-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 사원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 모든칼럼 조회
SELECT *
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- EMPLOYEE 테이블에서 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번 사원명, 이메일 조회
-- ex) sun_di@kh.or.kr, yoo_js@kh.or.kr, ...
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';

---- 실습 -----------------------------------------------------------------------
-- 1. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';
-- 2. DEPARTMENT 테이블에서 해외영업부에 대한 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';
--------------------------------------------------------------------------------
