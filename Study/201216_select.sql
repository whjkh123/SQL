-- select
SELECT
    *
FROM employees;-- ; > 문장 닫음(; 없을 시 아랫 문장도 한 문장으로 인식)

select * from departments;

-- 원하는 column 조회
select employee_id, first_name, last_name from employees;-- 오타를 방지하기 위해 먼저 해 테이블을 체크(select * from employees;) 한 뒤 조회 할 column 추가

select  employee_id,-- #2
        first_name,-- #3
        last_name-- #4
from    employees;-- 실행순서 > #1

-- 사원의 first_name, phone_number, hire_date, salary 출력
select  first_name,
        phone_number,
        hire_date,
        salary
from    employees;

-- 사원의 first_name, last_name, salary, phone_number, email, hire-date 출력
select  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from    employees;

--column 표기법 변경(table 원본 변경X) > column as [new column];
select  employee_id as empNo,
        first_name "f-name",-- as 생략 가능
                            -- 특수문자, 공백 사용 불가, 대/소문자 구분 > "" 사용    
        salary "연봉"
from    employees;

-- 사원의 이름(first_name), 성(last_name), 전화번호(phone_number), 입사일(hire_date), 급여(salary) 출력
select  first_name as 이름,
        last_name as 성,
        phone_number as 전화번호,
        hire_date as 입사일,
        salary as 급여
from    employees;

-- 사원의 사원번호, 이름(first_name), 성(last_name), 급여(salary), 전화번호(phone_number), 이메일(email), 입사일(hire_date) 출력
select  employee_id 사원번호,
        first_name 이름,
        last_name 성,
        salary 급여,
        phone_number 전화번호,
        email 이메일,
        hire_date 입사일
from    employees;

-- 연결연산자(Concatenation, ||) > column 붙이기
select  first_name || last_name 
from    employees;

select  first_name || ' ' || last_name as name
from    employees;

select  first_name || ' ''hire data is'' ' || hire_date 
from    employees;

-- 산술연산자
select  first_name,
        salary,
        salary*12 as 연봉
from    employees;

select  first_name,
        salary,
        salary*12 연봉,
        (salary+300)*12 상여금
from    employees;

/* 오류분석
select  job_id*12 >> '*'연산자는 숫자를 대상으로 한다. job_id는 문자
from    employees;
*/

-- 예제) 전체직원의 정보를 다음과 같이 출력하세요.
select  first_name || '-' || last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 연봉2,
        phone_number 전화번호
from    employees;

-- where
select  first_name
from    employees
where department_id = 10;

-- 연봉이 15000 이상인 사원들의 이름과 연봉 출력
select  first_name,-- #2
        salary-- #2 #4...
FROM    employees-- 실행순서 > #1
where salary*12 > 15000;-- #3 true일 경우 다음 row로 이동

-- 07/01/01 이후에 입사한 사원들의 이름과 입사일 출력
select  first_name,
        hire_date
FROM    employees
where hire_date >= '07/01/01';-- 문자, 날짜는 ''로 블럭

-- 이름이 Lex인 직원의 연봉 출력
select  salary*12-- column 값 비교
FROM    employees
where first_name = 'Lex';-- 문자, 날짜는 ''로 블럭
                         -- row 값 비교

-- and
-- 급여가 14000 이상 17000 이하인 사원의 이름, 급여 출력
SELECT  first_name,
        salary
FROM    employees
where   salary >= 14000
        and salary <= 17000;
        
-- or
-- 급여가 14000 이하이거나 17000 이상인 사원의 이름, 급여 출력
SELECT  first_name,
        salary
FROM    employees
where   salary <= 14000
        or salary >= 17000;
        
-- 입사일이 04/01/01 에서 05/12/31 사이인 사원의 이름, 입사일 출력
SELECT  first_name,
        hire_date
FROM    employees
where   hire_date >= '04/01/01'
        and hire_date <= '05/12/31';
        
-- between
SELECT  first_name,
        salary
FROM    employees
where   salary between 14000 and 17000;-- column between 조건문 > where salary >= 14000 and salary <= 17000;

-- in
-- 이름이 Neena, Lex, John인 사원의 이름, 성, 급여 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   first_name in ('Neena', 'Lex', 'John');-- ('')에 해당하는 데이터를 가진 row 출력 > where first_name = 'Neena' or first_name = 'Lex' or first_name = 'John'

-- 급여가 2100, 3100, 4100, 5100인 사원의 이름, 연봉 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   salary in (2100, 3100, 4100, 5100);

-- like
-- 이름이 'L'로 시작하는 사원의 이름, 급여 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   first_name like 'L%';-- 'L'로 시작하는 first_name 데이터

-- 이름에 'am'을 포함한 사원의 이름과 연봉 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   first_name like '%am%';-- 'am'을 포함하기만 하면 출력

-- 이름의 두번째 글자가 a 인 사원의 이름, 급여 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   first_name like '_a%';-- like '_ a%';

-- 이름의 네번째 글자가 a 인 사원의 이름 출력
SELECT  first_name,
        last_name    
FROM    employees
where   first_name like '___a%';-- like '_ _ _ a%';

-- 이름이 4글자인 사원 중 끝에서 두번째 글자가 a 인 사원의 이름 출력
SELECT  first_name || '-' || last_name 성명
FROM    employees
where   first_name like '__a_';-- like '_ _ a _';

-- null
-- employees table에서 급여가 13000에서 15000사이인 사원의 이름, 급여, 커미션%, 수당(급여*커미션) 출력
SELECT  first_name,
        last_name,
        salary,
        commission_pct,
        salary*commission_pct
FROM    employees
where   salary between 13000 and 15000;-- null은 오류가 아니라 입력 된 데이터가 없다는 의미

SELECT  first_name,
        last_name,
        commission_pct
FROM    employees
where   commission_pct is null;-- commission_pct = null;

-- 커미션비율이 있는 사원의 이름, 급여, 커미션비율 출력
SELECT  first_name,
        last_name,
        salary,
        commission_pct
FROM    employees
where   commission_pct is not null;-- commission_pct != null;

-- 담당매니저와 커미션비율이 없는 직원의 이름 출력
SELECT  first_name,
        last_name
FROM    employees
where   manager_id is null
        and commission_pct is null;
        
-- primary key(pk)
SELECT
    *
FROM    employees
where   employee_id = 110;-- employee_id = primary key(pk)

-- oerder by(정렬)
-- 급여가 9000 이상인 사원들의 급여 내림차순 정렬
SELECT  first_name,
        salary
FROM    employees
where   salary >= 9000
order by salary desc;-- 내림차순 정렬

SELECT  first_name,
        salary
FROM    employees
order by first_name desc;-- 내림차순 정렬

-- 급여가 9000 이상인 사원들의 급여 오름차순 정렬
SELECT  first_name,
        salary
FROM    employees
where   salary >= 9000
order by salary asc;-- 오름차순 정렬

SELECT  first_name,
        salary
FROM    employees
order by first_name asc;-- 오름차순 정렬

-- 예제) 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름 출력
SELECT  department_id,
        salary,
        first_name,
        last_name
FROM    employees
order by department_id asc;

-- 예제) 급여가 10000 이상인 직원의 이름과 급여를 급여가 큰 직원부터 출력
SELECT  first_name,
        last_name,
        salary
FROM    employees
where   salary >= 10000
order by salary desc;

-- 예제) 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호, 급여, 이름 출력
SELECT  department_id,
        salary,
        first_name,
        last_name
FROM    employees
order by department_id asc, salary desc;