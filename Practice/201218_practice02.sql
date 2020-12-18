-- 2020. 12. 18 practice02

/*
문제 1.
매니저가 있는 직원 수 출력(haveMngCnt = 106)
*/
SELECT  COUNT(manager_id) "haveMngCnt"
FROM    employees;

/*
문제 2. 
#1 최고임금(salary)과  최저임금을 “최고임금", “최저임금”  타이틀로 출력
#2 “최고임금 – 최저임금”이란 타이틀로 출력
*/
SELECT  MAX(salary) 최고임금,
        MIN(salary) 최저임금,
        MAX(salary)-MIN(salary) "최고임금-최저임금"
FROM    employees;

/*
문제 3.
마지막으로 신입사원이 들어온 날 출력
다음 형식으로 출력 ex) 2014년 07월 10일
*/
SELECT  TO_CHAR(MAX(hire_date),'yyyy"년" mm"월" dd"일"')"마지막 사원 입사일"
FROM    employees;

/*
문제 4.
#1 부서별로 평균임금, 최고임금, 최저임금을 부서아이디(department_id)와 함께 출력
#2 부서번호(department_id) 내림차순 정렬
*/
SELECT  department_id 부서ID,
        ROUND(AVG(salary),2) 평균임금,
        MAX(salary) 최고임금,
        MIN(salary) 최저임금
FROM    employees
GROUP BY department_id
ORDER BY department_id;

/*
문제 5.
#1 업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무아이디(job_id)와 함께 출력
#2 최저임금 내림차순, 평균임금(소수점 반올림), 오름차순 정렬
(정렬순서는 최소임금 2500 구간일때 확인해볼 것)
*/
SELECT  job_id,
        AVG(salary) 평균임금,
        MAX(salary) 최고임금,
        MIN(salary) 최저임금
FROM    employees
GROUP BY job_id
ORDER BY 최저임금 desc, 평균임금 asc;-- 최저임금이 같을 경우 평균임금 올림차순 정렬, >> ORDER BY MIN(salary) desc, AVG(salary) asc;

/*
문제 6.
가장 오래 근속한 직원의 입사일 출력
다음 형식으로 출력 ex) 2001-01-13 토요일
*/
SELECT  TO_CHAR(MIN(hire_date),'yyyy-mm-dd day') "최고선임 입사일"
FROM    employees;

/*
문제 7.
#1 평균임금과 최저임금의 차이가 2000 미만인 부서(department_id)의 평균임금, 최저임금 그리고 (평균임금 – 최저임금)를 (평균임금 – 최저임금) 출력
#2 임금편차 내림차순 정렬
*/
SELECT  department_id 부서ID,
        ROUND(AVG(salary),0) 평균임금,
        MIN(salary) 최저임금,
        ROUND(AVG(salary)-MIN(salary),0) 임금편차
FROM    employees
GROUP BY department_id
HAVING  AVG(salary)-MIN(salary) < 2000
ORDER BY 임금편차 desc;-- >> ORDER BY ROUND(AVG(salary)-MIN(salary),0) desc;

/*
문제 8.
#1 업무(JOBS)별로 최고임금과 최저임금의 차이 출력
#2 임금편차 내림차순 정렬
*/
SELECT  job_id 업무,
        MAX(salary)-MIN(salary) 임금편차
FROM    employees
GROUP BY job_id
ORDER BY 임금편차 desc;-- >> MAX(salary)-MIN(salary) desc;

/*
문제 9.
2005년 이후 입사자중 관리자별로 평균급여 최소급여 최대급여를 알아보려고 한다.
#1 출력은 관리자별로 평균급여 5000이상 중에 평균급여 최소급여 최대급여 출력
#2 평균급여 내림차순으로 정렬
#3 평균급여 소수점 첫째짜리에서 반올림 출력
*/
SELECT  manager_id 매니저ID,
        ROUND(AVG(salary),1) 평균임금,
        MIN(salary) 최소급여,
        MAX(salary) 최대급여
FROM    employees
GROUP BY manager_id, hire_date
HAVING  AVG(salary) >= 5000
        and hire_date >= '05.01.01'
ORDER BY 평균임금 desc;-- >> ORDER BY ROUND(AVG(salary),1) desc;

/*
문제 10.
아래회사는 보너스 지급을 위해 직원을 입사일 기준으로 나눌려고 합니다. 
#1 입사일이 02/12/31일 이전이면 '창립맴버,
#2 03년은 '03년입사’,
#3 04년은 ‘04년입사’ 
#4 이후입사자는 ‘상장이후입사’
#5 optDate 컬럼 데이터로 출력
#6 입사일 오름차순 정렬
*/
SELECT  first_name 이름,
        hire_date 입사일,
        CASE    WHEN hire_date <= '02.12.31'    THEN '창립맴버'
                WHEN hire_date BETWEEN '03.01.01' and '03.12.31'    THEN '03년 입사'
                WHEN hire_date BETWEEN '04.01.01' and '04.12.31'    THEN '04년 입사'
                ELSE '상장 이후 입사'
        end "optDate"       
FROM    employees
ORDER BY 입사일 asc;-- >> ORDER BY hire_date asc;