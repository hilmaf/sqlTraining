--춘 대학교 워크북 과제
--SQL03_SELECT(Option)

-- 1번
-- 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
SELECT 
    STUDENT_NAME AS "학생 이름"
    , STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;

-- 2번
-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오
SELECT
    STUDENT_NAME
    , STUDENT_SSN
FROM TB_STUDENT
ORDER BY SUBSTR(STUDENT_SSN, 1, 2) DESC;

-- 3번
-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름", "학번", "거주지 주소"가 출력되도록 한다.
SELECT
    STUDENT_NAME        AS "학생이름"
    , STUDENT_NO        AS "학번"
    , STUDENT_ADDRESS   AS "거주지 주소"
FROM TB_STUDENT
WHERE 
    (SUBSTR(STUDENT_ADDRESS, 1, 2) = '강원' 
    OR SUBSTR(STUDENT_ADDRESS, 1, 2) = '경기')
    AND TO_CHAR(EXTRACT(YEAR FROM ENTRANCE_DATE)) = '19%'
ORDER BY STUDENT_NAME;

-- 4번
-- 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과 코드'는 학과 테이블을 조회해서 찾아 내도록 하자)
SELECT
    PROFESSOR_NAME
FROM TB_PROFESSOR P
LEFT JOIN TB_DEPARTMENT D ON P.DEPARTMENT_NO = D.DEPARTMENT_NO 
WHERE P.DEPARTMENT_NO = '005'
ORDER BY SUBSTR(P.PROFESSOR_SSN, 1, 6) ASC;

-- 5번
-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다. 
-- 학점이 높은 학생부터 표시하고,
-- 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해 보시오.
-- 워크북 결과와 동일하게 소수점 아래 2자리까지 0으로 표현하기 위해서 TO_CHAR(NUMBER, 'FM9.00') 포맷 사용
SELECT
    S.STUDENT_NAME
    , TO_CHAR(G.POINT, 'FM9.00')
FROM TB_STUDENT S
LEFT JOIN TB_GRADE G ON S.STUDENT_NO = G.STUDENT_NO
WHERE G.CLASS_NO = 'C3118100'
ORDER BY G.POINT DESC, S.STUDENT_NO ASC;

-- 6번
-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL문을 작성하시오.
SELECT
    S.STUDENT_NO
    , S.STUDENT_NAME
    , D.DEPARTMENT_NAME
FROM TB_STUDENT S
LEFT JOIN TB_DEPARTMENT D ON S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY S.STUDENT_NAME;

-- 7번
-- 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL문장을 작성하시오.
SELECT
    C.CLASS_NAME
    , D.DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_DEPARTMENT D ON D.DEPARTMENT_NO = C.DEPARTMENT_NO;


-- 8번 *****
-- 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.
SELECT
    C.CLASS_NAME
    , P.PROFESSOR_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR CP ON CP.CLASS_NO = C.CLASS_NO
LEFT JOIN TB_PROFESSOR P ON CP.PROFESSOR_NO = P.PROFESSOR_NO
GROUP BY C.CLASS_NAME;

-- 9번
-- 8번의 결과 중 '인문 사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL문을 작성하시오.

                        
-- 10번
-- '음악학과' 학생들의 평점을 구하려고 한다. 
-- 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1자리까지만 반올림하여 표시한다.)



-- 11번
-- 학번이 A313047인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다.
-- 이때 사용할 SQL문을 작성하시오.



-- 12번
-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 
-- 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.




-- 13번
-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 
-- 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- 결과 행의 수는 동일하나 정렬 기준이 없어 다른 순서를 보임



-- 14번
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 
-- 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- "지도교수 미지정"으로 표시하도록 하는 SQL 문을 작성하시오. 
-- 단 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.


-- 15번
-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 
-- 그 학생의 학번, 이름, 학과, 이름, 평점을 출력하는 SQL문을 작성하시오.


-- 16번
-- 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.


-- 17번
-- 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.

                       
-- 18번
-- 국어국문학과에서 총점수가 가장 높은 학생의 이름과 학번을 표시하는 SQL문을 작성하시오



-- 19번
-- 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 
-- 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 
-- 평점은 소수점 한자리까지만 반올림하여 표시되도록 한다.
