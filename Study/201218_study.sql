-- 그룹함수 ※그룹함수의 결과는 1개의 로우 데이터만 존재
SELECT  AVG(salary),-- 그룹함수 AVG()
        first_name-- AVG()는 모든 salary 데이터의 평균값을 출력 >> 대표값은 1개이므로 first_name 데이터 표기 불가
FROM    employees;

-- AVG(column) > coumn 데이터의 평균 반환
SELECT  ROUND(AVG(NVL(salary,0)),2)-- null인 salary 데이터를 0으로 간주하여 평균값을 내고 소수점 2번째자리 반올림하여 출력
FROM    employees;

-- COUNT(*)/(column) > 총 건수 반환
SELECT  COUNT(*),-- null 데이터를 포함한 모든 데이터 수 반환
        COUNT(first_name)-- 총 직원 수 반환
FROM    employees;

SELECT  COUNT(commission_pct)-- commission_pct 데이터에 존재하는 null 데이터를 제외한 수 반환
FROM    employees;

-- 급여가 16000 이상 인 직원 수 반환
SELECT  COUNT(salary)
FROM    employees
WHERE   salary > 16000;

-- SUM(column) > column 데이터의 총 합 반환
SELECT  SUM(salary)
FROM    employees;

SELECT  SUM(salary),
        COUNT(salary),
        AVG(salary)-- 데이터를 대표값으로써 1개만 갖는 그룹함수끼리는 얼마든 혼용 가능
FROM    employees;

-- MAX/MIN(column) > 최대/최소 데이터 값 반환
SELECT  MAX(salary),-- 최대급여
        MIN(salary)-- 최소급여
FROM    employees;

-- GROUP BY > GROUP BY에 참여한 column 혹은 그룹함수만 출력 가능
-- 각 부서별 평균임금 출력
SELECT  department_id,
        ROUND(AVG(salary),2)
FROM    employees
GROUP BY department_id-- 각각의 department_id 평균 반환
ORDER BY department_id asc;

-- 각 부서별 직원 수, 총 급여 출력
SELECT  department_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id
ORDER BY department_id;

-- 각 부서별 업무를 담당하는 직원 수, 총 급여 출력 
SELECT  department_id,
        job_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id, job_id
ORDER BY department_id asc;

-- HAVING > GROUP BY절에서의 WHERE, 그룹함수와 GROUP BY에 참여한 column만 출력 가능
-- 총 급여가 20000 이상 인 부서의 부서번호, 인원수, 총 급여 출력
SELECT  department_id,
        COUNT(*),
        SUM(salary)
FROM    employees
GROUP BY department_id
HAVING  SUM(salary) >= 20000
ORDER BY SUM(salary) asc;

-- CASE ~ END > java if ~ else if와 비슷
-- 특정 직함의 급여 보너스 출력
SELECT  salary,
        job_id,
        CASE    WHEN job_id = 'AC_ACCOUNT'  THEN salary*0.1
                WHEN job_id = 'SA_REP'  THEN salary*0.2
                WHEN job_id = 'ST_CLERK'    THEN salary*0.3
                ELSE salary
        END "Bonus"        
FROM    employees;

-- DECODE(조건식) > CASE ~ END와 동일한 함수
-- DECODE를 활용한 특정 직함 보너스 출력
SELECT  salary,
        job_id,
        DECODE(job_id, 'AC_ACCOUNT', salary*0.1,
                       'SA_REP', salary*0.2,
                       'ST_CLERK', salary*0.3,
                       salary) "Bonus"
FROM    employees;

/*
#1 부서코드가 10 ~ 50 이면 'A-TEAM'
#2 60 ~ 100 이면 'B-TEAM'
#3 110 ~ 150 이면 'C-TEAM'
#4 나머지는 '팀없음'으로 직원의 이름, 부서, 팀 출력
*/
SELECT  first_name,
        department_id,
        CASE    WHEN department_id BETWEEN 10 and 50    THEN 'A-TEAM'
                WHEN department_id BETWEEN 60 and 100   THEN 'B-TEAM'
                WHEN department_id BETWEEN 110 and 150  THEN 'C-TEAM'
                ELSE '팀없음'
        END TEAM
FROM    employees
ORDER BY department_id asc;

-- 위의 예제를 활용해 각 팀별 인원수 출력 >> 현재로썬 구현 불가
SELECT  department_id,
        CASE    WHEN department_id BETWEEN 10 and 50    THEN 'A-TEAM'
                WHEN department_id BETWEEN 60 and 100   THEN 'B-TEAM'
                WHEN department_id BETWEEN 110 and 150  THEN 'C-TEAM'
                ELSE '팀없음'
        END TEAM,
        COUNT('TEAM')
FROM    employees
GROUP BY department_id, 'TEAM'
ORDER BY department_id asc;