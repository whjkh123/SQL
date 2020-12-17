-- INITCAP(column, '문자열') > column 데이터 값의 첫 글자만 대문자로 변경
SELECT  email,
        INITCAP(email)-- ABANDA >> Abanda
FROM    employees;

-- LOWER/UPPER(column) > column 데이터 값을 전부 소문자/대문자로 변경
SELECT  first_name,
        LOWER(first_name),-- Ellen >> ellen
        UPPER(first_name)-- Ellen >> ELLEN
FROM    employees;

-- SUBSTR(column, 시작위치, 글자수) > column 문자열 데이터에서 특정길이의 문자열 출력
-- 양수 > 왼쪽에서 오른쪽으로..
-- 음수 > 오른쪽에서 왼쪽으로..
SELECT  first_name,
        SUBSTR(first_name,3),-- Ellen >> len
        SUBSTR(first_name,1,3),-- Ellen >> Ell
        SUBSTR(first_name,-3,2)-- Ellen >> le
FROM    employees;

-- LPAD/RPAD(column, 자리수, '문자열') > 왼쪽/오른쪽 공백에 특정 문자열 출력
SELECT  first_name,
        LPAD(first_name,10,'*'),-- Ellen >> *****Ellen
        RPAD(first_name,10,'*')-- Ellen >> Ellen*****
FROM    employees;

-- REPLACE(colmun, 문자1, 문자2) > column 문자1 데이터를 문자2로 변경
SELECT  first_name,
        REPLACE(first_name,'a','*'),-- Sundar >> Sund*r
        REPLACE(first_name, SUBSTR(first_name,2,3),'***')-- Sundar >> S***ar
FROM    employees;

-- Round(숫자, 출력을 원하는 자리수) > 입력된 숫자 데이터를 반올림하여 출력
SELECT  ROUND(15.193,2),-- 15.193 >>  15.19
        ROUND(15.193,0),-- 15.193 >> 15
        ROUND(15.193,-1)-- 15.193 >> 20
FROM    dual;

-- TRUNC(숫자, 출력을 원하는 자리수) > 입력된 숫자 데이터를 버림하여 출력
SELECT  TRUNC(15.796,2),-- 15.796 >> 15.79
        TRUNC(15.796,0),-- 15.796 >> 15
        TRUNC(15.796,-1)-- 15.796 >> 10
FROM    dual;

-- SYSDATE > 날짜 출력
SELECT  SYSDATE
FROM    dual;

-- MONTH_BETWWEN(d1, d2) > d1부터 d2 사이의 개월수 출력
SELECT  SYSDATE,
        hire_date,
        MONTHS_BETWEEN(SYSDATE,hire_date),
        TRUNC(MONTHS_BETWEEN(SYSDATE,hire_date),0)
FROM    employees;

-- LAST_DAY(m) > m월의 마지막 날 출력
SELECT  LAST_DAY(SYSDATE)-- SYSDATE: 2020.12.17
FROM    dual;

-- TO_CHAR(숫자, '숫자형식') > 숫자형을 특정 형식으로 변환
SELECT  salary,
        salary*12,
        TO_CHAR(salary*12, '999,999,999'),
        TO_CHAR(salary*12, '$999,999,999.00')
FROM    employees;

-- TO_CHAR(날짜, '출력형식') > 날짜를 특정 형식으로 변환
SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'yyyy.mm.dd hh24:mi:ss'),
        TO_CHAR(SYSDATE, 'yyyy month day hh:mi:ss')-- yyyy를 month처럼 year(ex: 2020년)로 변환해주는 기능은 없음
FROM    dual;

-- NVL(column, null일 때 값) > 데이터 값이 null일 경우 특정 값으로 반환
SELECT  first_name,
        commission_pct,
        NVL(commission_pct,0)
FROM    employees;

-- NVL2(column, null이 아닐 때 값, null일 때 값) > 데이터 값이 null일 때와 아닐 때 특정 값으로 반환
SELECT  first_name,
        commission_pct,
        NVL2(commission_pct,100,0),
        NVL2(commission_pct,'available','unavailable')
FROM    employees;