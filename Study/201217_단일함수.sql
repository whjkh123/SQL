-- 단일함수
-- #문자함수
-- INITCAP(column, '문자열') > 입력 column 데이터의 첫 글자만 대문자로 변경
SELECT  email,
        INITCAP(email),
        department_id
FROM    employees
WHERE   department_id = 100;

-- LOWER(column) > 입력 column 데이터를 전부 소문자로 변경
-- UPPER(column) > 입력 column 데이터를 전부 대문자로 변경
SELECT  first_name,
        LOWER(first_name),
        UPPER(first_name)    
FROM    employees
WHERE   department_id = 100;

-- SUBSTR(column, 시작위치, 글자수) > 입력 된 문자열에서 특정길이의 문자열 출력
-- 양수 > 왼쪽에서 오른쪽으로..
-- 양수 > 오른쪽에서 왼쪽으로..
SELECT  first_name,
        SUBSTR(first_name,3),-- 3번재부터 끝까지의 문자 출력
        SUBSTR(first_name,1,3),-- 1번Woqnxj 3개의 문자 출력
        SUBSTR(first_name,-3,2)-- 끝에서 3번째부터 2개의 문자 출력
FROM    employees
WHERE   department_id = 100;

-- LPAD(column, 자리수, '문자열') > 왼쪽 공백에 특정 문자열 출력
-- RPAD(column, 자리수, '문자열') > 오른쪽 공백에 특정 문자열 출력
SELECT  first_name,
        LPAD(first_name,10,'*'),-- 문자열이 10자리가 되게끔 왼쪽에 '*' 추가
        RPAD(first_name,10,'*')-- 문자열이 10자리가 되게끔 오른쪽에 '*' 추가
FROM    employees;

-- REPLACE(column, 문자1, 문자2) > column에서 문자1을 문자2로 변경
SELECT  first_name,
        REPLACE(first_name,'a','*')-- 'a'를 '*'로 변경
FROM    employees
WHERE   department_id = 100;

SELECT  first_name,
        REPLACE(first_name,'a','*'),
        REPLACE(first_name, SUBSTR(first_name, 2, 3),'***')-- 2번째부터 3개의 문자를 '***'로 변경
FROM    employees
WHERE   department_id = 100;

-- #숫자함수
-- ROUND(숫자, 출력을 원하는 자리수) > 주어진 숫자를 반올림
SELECT  ROUND(123.456,2) "r2",-- 소수점 2번째자리 반올림하여 출력
        ROUND(123.456,0) "r0",-- 소수점 0번째자리 반올림하여 출력(정수 출력)
        ROUND(123.456,-1) "r-1"-- 정수 1번째자리 반올림하여 출력
FROM    dual;

SELECT  salary,
        ROUND(salary,-3) "s-3"-- 정수 3번째자리 반올림하여 출력
FROM    employees;

-- TRUNC(숫자, 출력을 원하는 자리수) > 주어진 숫자 버림
SELECT  TRUNC(123.456,2) "t2",-- 소수점 2번째자리 버림하여 출력
        TRUNC(123.456,0) "t0",-- 소수점 0번째자리 버림하여 출력(정수 출력)
        TRUNC(123.456,-1) "t-1"-- 정수 1번째자리 버림하여 출력
FROM    dual;

SELECT  salary,
        TRUNC(salary,-3) "s-3"-- 정수 3번째자리 버림하여 출력
FROM    employees;

-- #날짜함수
-- SYSDATE > 현재 날짜 출력
SELECT  SYSDATE
FROM    dual;

SELECT  SYSDATE
FROM    employees;

-- MONTH_BETWEEN(d1, d2) > d1부터 d2사이의 개월수 출력
SELECT  SYSDATE,
        hire_date,
        MONTHS_BETWEEN(SYSDATE, hire_date),-- 현재 날짜부터 입사일사이의 개월수 출력
        TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date),0) 근무월수
FROM    employees
WHERE   department_id = 100;

-- LAST_DAY(m) > m월의 마지막 날 출력
SELECT  LAST_DAY('19/06/06'),
        LAST_DAY(SYSDATE)
FROM    dual;

-- #변환함수
-- TO_CHAR(숫자, '출력형식') > 숫자형을 문자형으로 변환
SELECT  first_name,
        salary,
        salary*12,    
        TO_CHAR(salary*12, '$999,999,999.00'),
        TO_CHAR(salary*12, '999,999,999')
FROM    employees
WHERE   department_id = 100;

-- TO_CHAR(날짜, '출력형식') > 날짜를 문자형으로 변환
SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss'),
        TO_CHAR(SYSDATE, 'year-month-day hh24:mi:ss')
FROM    dual;