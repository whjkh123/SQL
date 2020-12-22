-- SubQuery > 하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태
-- #1 'Den'(11000)보다 급여를 많이 받는 사람의 이름과 급여 출력
SELECT  first_name,
        salary
FROM    employees
WHERE   first_name = 'Den';-- 11000

SELECT  first_name,
        salary
FROM    employees
WHERE   salary > 11000;
-- ※'Den'의 급여가 변경될 경우 사용 불가

-- #2 'Den'(11000)보다 급여를 많이 받는 사람의 이름과 급여 출력
SELECT  first_name,
        salary
FROM    employees
WHERE   salary > (SELECT    salary
                  FROM      employees
                  WHERE     first_name = 'Den');

-- 단일행 SubQuery > SubQuery의 결과가 1개의 Row인 경우
-- 급여를 가장 적게 받는 사람의 이름, 급여, 사번 출력
SELECT  MIN(salary)
FROM    employees;

SELECT  first_name,
        salary,
        employee_id    
FROM    employees
WHERE   salary = 2100;
-- ※최저급여가 변경될 경우 사용 불가

SELECT  first_name,
        salary,
        employee_id    
FROM    employees
WHERE   salary = (SELECT    MIN(salary)
                  FROM      employees);
                  
-- 평균급여보다 적게 받는 사람의 이름, 급여를 출력
SELECT  ROUND(AVG(salary),2)
FROM    employees;

SELECT  first_name,
        salary
FROM    employees
WHERE   salary < 6464.83;
-- ※평균급여가 변경될 경우 사용 불가

SELECT  first_name,
        salary
FROM    employees
WHERE   salary < (SELECT    ROUND(AVG(salary),2)
                  FROM      employees);

-- 다중행 SubQuery > SubQuery의 결과가 여러개의 Row인 경우
-- 부서번호가 '110'인 사원의 급여와 같은 모든 사원의 사번, 이름, 급여 출력
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   department_id = 110;

SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary = 12008
        or salary = 8300;

SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary in (12008, 8300);

-- 다중행 변환
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM    employees
WHERE   salary IN (SELECT   salary
                   FROM     employees
                   WHERE    department_id = 110);

-- 각 부서별로 최고급여를 받는 사원 출력
SELECT  first_name,
        department_id,
        salary
FROM    employees
WHERE   (department_id, salary) IN
  (SELECT   department_id,
            MAX(salary) 
   FROM     employees
   GROUP BY department_id);

-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   department_id = 110;-- 12008(1), 8300(1)

SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary >ANY-- OR연산자 >> salary > 8300
    (SELECT salary
     FROM   employees
     WHERE  department_id = 110);

SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   salary >ALL-- AND연산자 >> salary > 12008
    (SELECT salary
     FROM   employees
     WHERE  department_id = 110);

-- TABLE JOIN
-- 각 부서별로 최고급여를 받는 사원 출력
-- #1 각 부서별 최고급여 TABLE
SELECT  department_id,
        MAX(salary)
FROM    employees
GROUP BY department_id;

-- #2 #1TABLE JOIN
SELECT  e.department_id,
        e.employee_id,
        e.first_name,
        e.salary
FROM    employees e, (SELECT    department_id,
                                MAX(salary) salary-- FROM employees e, salary s
                      FROM      employees         -- where e.salary = s.salary{MAX(salary)};
                      GROUP BY department_id) s
WHERE   e.department_id = s.department_id
        and e.salary = s.salary;