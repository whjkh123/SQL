-- 그룹함수 > 그룹함수의 결과는 1개의 row만 남게 된다.
SELECT  AVG(salary),-- 그룹함수의 결과는 row 데이터를 1개 밖에 낼 수 없다.
        first_name  -- 따라서 first_name은 출력할 수 없으므로 오류 발생    
FROM    employees;

-- AVG(column) > 평균값 반환
SELECT  AVG(salary)
FROM    employees;

-- COUNT(*,column) > 총 건수 반환
SELECT  COUNT(*)-- null 데이터를 포함한 모든 건수 반환
FROM    employees;

SELECT  COUNT(commission_pct)-- null 데이터를 제외한 건수 반환
FROM    employees;

SELECT  COUNT(salary)
FROM    employees
WHERE   salary > 16000;

-- SUM(column) > 총 합 반환
SELECT  SUM(salary)
FROM    employees;

SELECT  SUM(salary),
        COUNT(salary),
        AVG(salary)
FROM    employees;

SELECT  SUM(salary),
        COUNT(salary),
        AVG(NVL(salary,0)),-- salary 데이터가 null일 경우 0으로 간주하여 평균 산출
        ROUND(AVG(NVL(salary,0)),2)-- salary 평균값을 소수점 2번째자리 반올림하여 산출
FROM    employees;

-- MAX(column)/MIN(column) > 최대/최소 데이터 값 반환
SELECT  MAX(salary),
        MIN(salary)
FROM    employees;

-- GROUP BY > GROUP BY에 참여한 column 혹은 그룹함수만 출력 가능
SELECT  department_id,
        AVG(salary)-- 그룹함수 오류 발생
FROM    employees;

SELECT  department_id,
        ROUND(AVG(salary),2)
FROM    employees
GROUP BY department_id-- 각 department_id별 평균 반환
ORDER BY department_id asc;

SELECT  department_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id
ORDER BY department_id asc;

SELECT  department_id,
        job_id,
        COUNT(*),
        SUM(salary)        
FROM    employees
GROUP BY department_id;-- job_id에 대한 기준이 없어 오류 발생

SELECT  department_id,
        job_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id, job_id-- 각 column별로 기준을 세워 각 column 데이터 값의 수를 카운트
ORDER BY department_id asc;

-- 총 급여가 20000 이상인 부서의 부서번호, 인원수, 급여합계 출력
SELECT  department_id,
        COUNT(*),
        SUM(salary)
FROM    employees
WHERE   SUM(salary) >= 20000-- WHERE절은 그룹함수에 사용 불가
GROUP BY department_id;

-- HAVING > 그룹함수와 GROUP BY에 참여한 column만 출력 가능
-- 총 급여가 20000 이상인 부서의 부서번호, 인원수, 급여합계 출력
SELECT  department_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id
HAVING SUM(salary) >= 20000;-- GROUP BY절에서의 WHERE

-- CASE ~ END
SELECT  employee_id,
        salary,
        job_id,
        CASE    WHEN job_id = 'AC_ACCOUNT'  THEN salary+salary*0.1
                WHEN job_id = 'SA_REP'  THEN salary+salary*0.2
                WHEN job_id = 'ST_CLERK'    THEN salary+salary*0.3
                ELSE salary
        END realSalary        
FROM    employees;

-- DECODE(조건식) > CASE ~ END와 동일
SELECT  employee_id,
        salary,
        job_id,
        DECODE(job_id, 'AC_ACCOUNT', salary+salary*0.1,
                       'SA_REP', salary+salary*0.2,
                       'ST_CLERK', salary+salary*0.3,
                salary) realSalary
FROM    employees;

/*
직원의 이름, 부서, 팀을 출력하세요.
팀은 코드로 결정하며
#1 부서코드가 10~50 이면 ‘A-TEAM’
#2 60~100이면 ‘B-TEAM’
#3 110~150이면 ‘C-TEAM’
#4 나머지는 ‘팀없음’ 으로 출력하세요.
 */
SELECT  first_name,
        department_id,
        CASE    WHEN department_id >= 10 and department_id <= 50    THEN 'A-TEAM'
                WHEN department_id >= 60 and department_id <= 100   THEN 'B-TEAM'
                WHEN department_id >= 110 and department_id <= 150  THEN 'C-TEAM'
                ELSE '팀없음'
        END TEAM        
FROM    employees
ORDER BY department_id;