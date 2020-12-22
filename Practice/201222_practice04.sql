-- 2020. 12. 22 practice04

/*
문제 1.
#1 평균급여보다 적은 급여을 받는 직원은
#2 몇명인지 출력(56건)
*/
-- step.1 >> 평균급여 조회
SELECT  ROUND(AVG(salary),0)
FROM    employees;

-- step.2 >> 평균급여보다 적은 급여를 받는 직원 수 조회
SELECT  COUNT(salary)
FROM    employees
WHERE   salary < 6462;-- ROUND(AVG(salary),)

-- step.3 >> JOIN
SELECT  COUNT(salary)
FROM    employees
WHERE   salary < (SELECT    ROUND(AVG(salary),0)
                  FROM      employees);

/*
문제 2. 
#1 평균급여 이상, 최대급여 이하의 월급을 받는 사원의
#2 직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를
#3 급여의 오름차순정렬하여 출력(51건)
*/
-- step.1 >> 평균급여 조회
SELECT  ROUND(AVG(salary),0)
FROM    employees;

-- step.2 >> 최고급여 조회
SELECT  MAX(salary)
FROM    employees;

-- step.3 >> JOIN
SELECT  employee_id,
        first_name,
        salary,
        ROUND(AVG(salary),0),
        MAX(salary)
FROM    employees
WHERE   salary >= (SELECT   ROUND(AVG(salary),0)-- 평균급여
                   FROM     employees)
        and salary <= (SELECT   MAX(salary)-- 최고급여
                       FROM     employees)
GROUP BY employee_id, salary, first_name
ORDER BY salary asc;

/*
문제 3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id)를 출력(1건)
*/
SELECT  l.location_id,
        l.street_address,
        l.postal_code,
        l.city,
        l.state_province,
        l.country_id
FROM    employees e, departments d, locations l
WHERE   e.employee_id = d.manager_id
        and d.location_id = l.location_id
        and first_name IN (SELECT   first_name
                           FROM     employees
                           WHERE    first_name = 'Steven')
        and last_name IN (SELECT    last_name
                          FROM      employees
                          WHERE     last_name = 'King');

/*
문제 4.
#1 job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의
#2 사번,이름,급여를
#3 급여의 내림차순 출력 -ANY연산자 사용(74건)
*/
-- step.1 >> 'ST_MAN'업무를 맡은 직원의 급여 조회
SELECT  employee_id,
        first_name,
        salary
FROM    employees
WHERE   job_id = 'ST_MAN';

-- step.2 >> JOIN
SELECT  employee_id,
        first_name,
        salary,
        job_id
FROM    employees
WHERE   salary <ANY (SELECT    salary
                     FROM      employees
                     WHERE     job_id = 'ST_MAN')
ORDER BY salary desc;

-- ※'ST_MAN'업무를 맡은 직원보다 적은 급여를 받는 직원을 조회하려면 기준은 최소값으로 잡아야하지 않을까?
SELECT  employee_id,
        first_name,
        salary,
        job_id
FROM    employees
WHERE   salary <ALL (SELECT salary
                     FROM   employees
                     WHERE  job_id = 'ST_MAN')
ORDER BY salary desc;

/*
문제 5. 
각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회 
단 조회결과는 급여의 내림차순으로 정렬 
조건절비교, 테이블조인 2가지 방법으로 작성(11건)
*/
-- 5-1. 조건절
SELECT  employee_id,
        first_name,
        salary,
        department_id
FROM    employees
WHERE   (department_id, salary) IN
  (SELECT   department_id,
            MAX(salary)
   FROM     employees
   GROUP BY department_id);

-- 5-2. TABLE JOIN
SELECT  e.employee_id,
        e.first_name,
        e.salary,
        e.department_id
FROM    employees e, (SELECT    department_id,
                                MAX(salary) maxS 
                      FROM      employees
                      GROUP BY department_id) s
WHERE   e.department_id = s.department_id
        and e.salary = s.maxS;

/*
문제 6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
#1 연봉 총합이 가장 높은 업무부터
#2 업무명(job_title)과 연봉 총합을 조회(19건)
*/
-- step.1 >> 각 업무별 연봉 총합
SELECT  job_id,
        SUM(salary)
FROM    employees
GROUP BY job_id;

-- step.2 >> JOIN
SELECT  job_title
FROM    employees e, jobs j, (SELECT    job_id,
                                        SUM(salary) sumS
                              FROM      employees
                              GROUP BY job_id) js
WHERE   e.job_id = j.job_id
        and e.salary = js.sumS;

/*
문제 7.
#1 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의
#2 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회(38건)
*/
-- step.1 >> 각 부서 평균급여 조회
SELECT  department_id,
        ROUND(AVG(salary),0) avgS
FROM    employees
GROUP BY department_id;

-- step.2 >> JOIN
SELECT  employee_id,
        first_name,
        salary
FROM    employees e, (SELECT    department_id,
                                ROUND(AVG(salary),0) avgS
                      FROM      employees
                      GROUP BY department_id) s
WHERE   e.department_id = s.department_id
        and e.salary > s.avgS;