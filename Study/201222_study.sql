-- SubQuery > 하나의 SQL 질의문 내에 다른 SQL 질의문이 포함되어 있는 형태
-- 'Den'보다 급여를 많이 받는 사람의 이름과 급여 출력
-- #step.1 >> 'Den'의 급여 조회
SELECT  first_name,
        salary
FROM    employees
WHERE   first_name = 'Den';

-- #step.2 >> 11000('Den'의 급여)보다 급여가 많은 사람 조회
SELECT  first_name,
        salary
FROM    employees
WHERE   salary > 11000;

-- #step.3 >> JOIN
SELECT  first_name,
        salary
FROM    employees
WHERE   salary > (SELECT    salary
                  FROM      employees
                  WHERE first_name = 'Den');

-- 단일행 SubQuery > SubQuery의 결과가 1개의 Row인 경우
-- 급여를 가장 적게 받는 사원의 이름, 급여, 사번 출력
-- step.1 >> 가장 적은 급여 조회
SELECT  MIN(salary)
FROM    employees;

-- step.2 >> 급여가 2100(가장 적은 급여)인 사원 조회
SELECT  first_name,
        salary,
        employee_id
FROM    employees
WHERE   salary = 2100;

-- step.3 >> JOIN
SELECT  first_name,
        salary,
        employee_id
FROM    employees
WHERE   salary = (SELECT    MIN(salary)
                  FROM      employees);

-- 평균급여보다 적게 받는 사원의 이름, 급여 출력
-- step.1 >> 평균급여 조회
SELECT  ROUND(AVG(salary),2)
FROM    employees;

-- step.2 >> 평균급여보다 적게 받는 사원 조회
SELECT  first_name,
        salary
FROM    employees
WHERE   salary < 6461.83;

-- step.3 >> JOIN
SELECT  first_name,
        salary
FROM    employees
WHERE   salary < (SELECT    AVG(salary)
                  FROM      employees);

-- 다중행 SubQuery > SubQuery의 결과가 여러개의 Row인 경우
-- 부서번호가 '110'인 사원의 급여와 같은 모든 사원의 사번, 이름, 급여 출력
-- step.1 >> 부서번호가 '110'인 사원 조회
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   department_id = 110;

-- step.2 >> 급여가 110번 부서인 사원의 급여와 같은 모든 사원 조회
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary = 12008
        or salary = 8300;

-- step.3 >> JOIN(SubQuery IN)
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary IN
  (SELECT salary 
   FROM employees
   WHERE department_id = 110);

-- 각 부서별로 최고급여를 받는 사원 출력
-- step.1 >> 각 부서별 최고급여 조회
SELECT  department_id,
        MAX(salary)
FROM    employees
GROUP BY department_id;

-- step.2 >> JOIN(SubQuery IN)
SELECT  first_name,
        department_id,
        salary
FROM    employees
WHERE   (department_id, salary) IN-- (비교기준1, 비교기준2) >> 각 부서별 급여 ~ ...
    (SELECT department_id,
            MAX(salary)
     FROM   employees
     GROUP BY department_id);

-- 부서번호가 '110'인 직원의 급여보다 많은 급여를 받는 모든 직원의 사번, 이름, 급여 출력
-- step.1 >> 부서번호가 '110'인 직원 조회
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   department_id = 110;-- 12008(1), 8300(1)

-- step.2-1 >> JOIN(SubQuery ANY)
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary >ANY-- OR연산자 >> salary > 8300
    (SELECT salary    
     FROM   employees
     WHERE  department_id = 110);

-- step.2-2 >> JOIN(SubQuery ALL)
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary >ALL-- AND연산자 >> salary > 12008
    (SELECT salary
     FROM   employees
     WHERE  department_id = 110);

-- TABLE JOIN
-- 각 부서별 최고급여를 받는 사원 출력
-- step.1 각 부서별 최고급여 조회
SELECT  department_id,
        MAX(salary)
FROM    employees
GROUP BY department_id;

-- step.2 JOIN(TABLE JOIN)
SELECT  e.department_id,
        e.first_name,
        e.salary
FROM    employees e, (SELECT    department_id,
                                MAX(salary) salary
                      FROM      employees
                      GROUP BY department_id) max
WHERE   e.department_id = max.department_id
        and e.salary = max.salary;