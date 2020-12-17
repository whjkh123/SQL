-- 1. 사원의 이름, 전화번호, 입사일, 연봉 출력
SELECT  first_name,
        phone_number,
        hire_date,
        salary*12
FROM    employees;

-- 2. 사원의 이름, 성, 급여, 전화번호, 이메일, 입사일 출력
SELECT  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
FROM    employees;

-- 3. 사원의 이름(first_name), 전화번호(phone_number), 입사일(hire_date), 급여(salary) 출력 > 표기 변경
SELECT  first_name 이름,
        phone_number 전화번호,
        hire_date 입사일,
        salary 급여
FROM    employees;

-- 4. 사원의 사원번호, 이름, 성, 급여, 전화번호, 이메일, 입사일 출력 > 표기 변경
SELECT  employee_id 사원번호,
        first_name 이름,
        last_name 성,
        salary 급여,
        phone_number 전화번호,
        email 이메일,
        hire_date 입사일
FROM    employees;

-- 5. 성명(성과 이름 사이에 '-'로 구분), 급여, 연봉(급여*12), 성과금(급여*12+5000), 전화번호 > 표기변경
SELECT  first_name || '-' || last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 성과금,
        phone_number 전화번호
FROM    employees;

-- 6. 급여가 15000 이상인 사원들의 이름과 연봉 출력
SELECT  first_name,
        salary*12
FROM    employees
where   salary >= 15000;

-- 7. 07/01/01 이후에 입사한 사원들의 이름, 입사일 출력
SELECT  first_name,
        hire_date
FROM    employees
where   hire_date >= '07/01/01';

-- 8. 이름이 'Lex'인 직원의 연봉 출력
SELECT  salary*12
FROM    employees
where   first_name = 'Lex';

-- 9. 급여가 14000 이하이거나 17000 이상인 사원의 이름, 연봉 출력
SELECT  first_name,
        salary*12
FROM    employees
where   salary BETWEEN 14000 and 17000;-- salary >= 14000 and salary <= 17000;
                                       -- between = 특정구간 데이터 출력

-- 10. 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름, 입사일 출력
SELECT  first_name,
        hire_date
FROM    employees
where   hire_date >= '04/01/01'
        and hire_date <= '05/12/31';
        
-- 11. 급여가 2100, 3100, 4100, 5100 인 사원의 이름, 연봉 출력
SELECT  first_name,
        salary*12
FROM    employees
where   salary in (2100, 3100, 4100, 5100);-- in = 복수의 조건 검사

-- 12. 이름에 'am'을 포함한 사원의 이름, 급여 출력
SELECT  first_name,
        salary
FROM    employees
where   first_name like '%am%';

-- 13. 이름의 두번째 글자가 'a' 인 사원의 이름, 급여 출력
SELECT  first_name,
        salary
FROM    employees
where   first_name like '_a%';

-- 14. 이름의 네번째 글자가 'a' 인 사원의 이름 출력
SELECT  first_name
FROM    employees
where   first_name like '___a%';

-- 15. 이름이 4글자인 사원 중 끝에서 두번째 글자가 'a' 인 사원의 이름 출력
SELECT  first_name
FROM    employees
where   first_name like '__a_';

-- 16. 커미션비율이 있는 사원의 이름, 연봉, 커미션비율 출력
SELECT  first_name,
        salary*12,
        commission_pct    
FROM    employees
where   commission_pct is not null;

-- 17. 담당매니저와 커미션비율이 없는 직원의 이름 출력
SELECT  first_name
FROM    employees
where   manager_id is null
        and commission_pct is null;
        
-- 18. 부서번호를 오름차순 정렬하고 부서번호, 급여, 이름 출력
SELECT  department_id,
        salary,
        first_name
FROM    employees
order by department_id asc;

-- 19. 급여가 10000 이상인 직원의 이름과 급여를 급여가 큰 직원부터 출력
SELECT  first_name,
        salary
FROM    employees
order by salary desc;

-- 20. 부서번호를 오름차순 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호, 급여, 이름 출력
SELECT  department_id,
        salary,
        first_name
FROM    employees
order by department_id asc, salary desc;