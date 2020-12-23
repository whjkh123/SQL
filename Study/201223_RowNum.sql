-- RowNum
-- 급여를 가장 많이 받는 5명의 직원 조회
-- step.1
SELECT  ROWNUM,-- 'ROWNUM' 명령어가 'ORDER BY' 보다 먼저 실행되어 의도한대로 조회 불가
        employee_id,
        first_name,
        salary
FROM    employees
WHERE   ROWNUM BETWEEN 1 and 5
ORDER BY salary desc;

-- step.2
SELECT  ROWNUM,
        e.employee_id,
        e.first_name,
        e.salary
FROM    (SELECT employee_id,-- 'employees' 테이블을 미리 정렬하여 로드
                first_name,
                salary
         FROM   employees
         ORDER BY salary desc) e
WHERE   ROWNUM BETWEEN 1 and 5;-- 시작지점을 '1'이 아닌 다른 수로 했을 때(ROWNUM BETWEEN 2 and 5;) 오류 발생
                               -- 'ROWNUM' 부여 후 'WHERE'문을 실행함으로써 'ROWNUM'의 시작 값(1)이 존재하지 않는 한 'WHERE'문은 구동 안됨

-- step.3
SELECT  re.rnum,-- #3 'ROWNUM'을 부여하는 것이 아닌, 이미 'ROWNUM'이 부여된 고정변수값 'rnum' 로드
        re.employee_id,
        re.first_name,
        re.salary
FROM    (SELECT  ROWNUM rnum,-- #2 정렬 된 'employees' 테이블에 'ROWNUM'을 부여한 뒤 로드, 메인쿼리문에서 활용할 수 있도록 별명 'rnum'을 부여함으로써 고정변수값으로 지정
                 e.employee_id,
                 e.first_name,
                 e.salary
         FROM    (SELECT employee_id,-- #1 'employees' 테이블을 'salary desc' 정렬하여 로드
                         first_name,
                         salary
                  FROM   employees
                  ORDER BY salary desc) e) re
WHERE   re.rnum BETWEEN 1 and 5;

-- 07년에 입사한 직원 중 급여가 많은 직원 3등부터 7등까지의 이름, 급여, 입사일 조회
-- step.1 >> 'hire_date' 조건에 맞는 'salary' 내림차순정렬
SELECT  first_name,
        salary,
        hire_date
FROM    employees
WHERE   hire_date BETWEEN '07/01/01' and '07/12/31'
ORDER BY salary desc;

-- step.2 >> 정렬된 테이블을 로드하여 'ROWNUM'부여
SELECT  ROWNUM,
        e.first_name,
        e.salary,
        e.hire_date
FROM    (SELECT  ROWNUM,
                 first_name,
                 salary,
                 hire_date
         FROM    employees
         WHERE   hire_date BETWEEN '07/01/01' and '07/12/31'
         ORDER BY salary desc) e
WHERE   ROWNUM BETWEEN 1 and 7;

-- step.3 >> 'ROWNUM'이 부여된 테이블을 로드하여 고정변수 'rown'(07년에 입사한 사원 목록을 급여 내림차순정렬하여 'ROWNUM'부여)으로 지정하여 변수 'rown'에 대해 조건문 시행
SELECT  re.first_name,
        re.salary,
        re.hire_date
FROM    (SELECT  ROWNUM rown,
                 e.first_name,
                 e.salary,
                 e.hire_date
         FROM    (SELECT  first_name,
                          salary,
                          hire_date
                  FROM    employees
                  WHERE   hire_date BETWEEN '07/01/01' and '07/12/31'
                  ORDER BY salary desc) e) re
WHERE   re.rown BETWEEN 3 and 7;