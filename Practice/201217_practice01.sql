-- 2020. 12. 17 practice01

/*
문제 1.
전체직원의 다음 정보를 조회하세요.
#1 정렬은 입사일(hire_date)의 올림차순(ASC)으로 가장 선임부터 출력
#2 이름(first_name last_name), 월급(salary), 전화번호(phone_number), 입사일(hire_date) 순서
#3 “이름”, “월급”, “전화번호”, “입사일” 로 컬럼이름을 대체
*/
SELECT  first_name || ' ' || last_name 이름,
        salary 월급,
        phone_number 전화번호,
        hire_date 입사일
FROM    employees
ORDER BY hire_date asc;

/*
문제 2.
업무(jobs)별로 업무이름(job_title)과 최고월급(max_salary)을 월급의 내림차순(DESC)로 정렬
*/
SELECT  job_title,
        max_salary
FROM    jobs
ORDER BY max_salary desc;

/*
문제 3.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 이름, 매니저아이디, 커미션 비율, 월급 을 출력
*/
SELECT  first_name || ' ' || last_name,
        manager_id,
        commission_pct,
        salary
FROM    employees
WHERE   commission_pct is null
        and salary > 3000;
        
/*
문제 4.
최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을 최고월급의(max_salary) 내림차순(DESC)으로 정렬하여 출력
*/
SELECT  job_title,
        max_salary
FROM    jobs
WHERE   max_salary >= 10000
ORDER BY max_salary desc;

/*
문제 5.
#1 월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트를 월급순(내림차순) 출력
#2 단 커미션퍼센트 가 null 이면 0 으로 출력
*/
SELECT  first_name,
        salary,
        NVL(commission_pct,0)
FROM    employees
WHERE   salary BETWEEN 10000 and 14000
ORDER BY salary desc;

/*
문제 6.
#1 부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 출력
#2 입사일은 1977-12 와 같이 표시
*/
SELECT  first_name,
        salary,
        TO_CHAR(hire_date, 'yyyy-mm'),
        department_id
FROM    employees
WHERE   department_id = 10
        or department_id = 90
        or department_id = 100;
        
/*
문제 7.
이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 출력
*/
SELECT  first_name,
        salary
FROM    employees
WHERE   first_name like '%S%'
        or first_name like '%s%';
        
/*
문제 8.
전체 부서를 출력하려고 합니다.
순서는 부서이름이 긴 순서대로 출력
*/
SELECT  department_name
FROM    departments
ORDER BY length(department_name)desc;-- order by length(column) desc(asc); > column 데이터 값이 긴 순서대로 오름차순(내림차순) 정렬

/*
문제 9.
정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고 올림차순(ASC)으로 정렬하여 출력
*/
SELECT  UPPER(country_name)
FROM    countries
ORDER BY country_name asc;

/*
문제 10.
#1 입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력
#2 전화번호는 545-343-3433 과 같은 형태로 출력
*/
SELECT  first_name,
        salary,
        REPLACE(phone_number,'.','-'),
        hire_date
FROM    employees
WHERE   hire_date < '03/12/31';