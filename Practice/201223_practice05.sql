-- 2020. 12. 23 practice05

/*
문제 1.
#1 담당 매니저가 배정되어있으나 커미션비율이 없고,
#2 월급이 3000초과인 직원의 
#3 이름, 매니저아이디, 커미션 비율, 월급 출력(45건)
*/
SELECT  first_name 이름,
        manager_id 매니저ID,
        commission_pct "커미션 비율",
        salary 월급
FROM    employees
WHERE   salary > 3000
        and commission_pct is null
        and manager_id is not null;

/*
문제 2.
#1 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 조회 
#2 조건절비교 방법으로 작성
#3 급여의 내림차순으로 정렬
#4 입사일은 2001-01-13 토요일 형식으로 출력
#5 전화번호는 515-123-4567 형식으로 출력(11건)
*/
SELECT  employee_id 사번,
        first_name 이름,
        salary 급여,
        TO_CHAR(hire_date, 'yyyy-mm-dd day') 입사일,
        REPLACE(phone_number,'.','-') 전화번호,
        department_id 부서ID
FROM    employees
WHERE   (department_id, salary) IN (SELECT  department_id,
                                            MAX(salary)
                                    FROM    employees
                                    GROUP BY department_id)
ORDER BY salary desc;
/*
문제 3.
매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
#1 통계대상(직원)은 2005년 이후의 입사자
#2 매니저별 평균급여가 5000이상만 출력
#3 매니저별 평균급여의 내림차순정렬 출력
#4 매니저별 평균급여는 소수점 첫째자리에서 반올림
#5 출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여(9건)
*/
-- step.1 >> '05/01/01' 이후 입사한 평균급여 5000 이상인 매니저 조회
SELECT  ROUND(AVG(salary),1),
        MIN(salary),
        MAX(salary),
        manager_id
FROM    employees
WHERE   hire_date >= '05/01/01'
GROUP BY manager_id
HAVING  ROUND(AVG(salary),1) >= 5000;

-- step.2 >> JOIN
SELECT  m.manager_id 매니저ID,
        first_name 매니저명,
        avgm "매니저 평균급여",
        minm "매니저 최저급여",
        maxm "매니저 최고급여"
FROM    employees e, (SELECT  ROUND(AVG(salary),1) avgm,
                              MIN(salary) minm,
                              MAX(salary) maxm,
                              manager_id
                      FROM    employees
                      WHERE   hire_date >= '05/01/01'
                      GROUP BY manager_id
                      HAVING  ROUND(AVG(salary),1) >= 5000) m
WHERE   e.employee_id = m.manager_id
ORDER BY m.avgm desc;

/*
문제 4.
#1 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name) 조회
#2 부서가 없는 직원(Kimberely)도 표시(106명)
*/
SELECT  e.employee_id 사번,
        e.first_name 직원명,
        d.department_name 부서명,
        m.first_name 매니저명
FROM    employees e, departments d, employees m
WHERE   e.department_id = d.department_id(+)
        and e.manager_id = m.employee_id;
/*
문제 5.
#1 2005년 이후 입사한 직원중에
#2 입사일이 11번째에서 20번째의 직원의 
#3 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력
*/
-- step.1 >> 2005년 이후 입사한 직원 조회
SELECT  e.employee_id,
        e.first_name,
        d.department_name,
        e.hire_date        
FROM    employees e, departments d
WHERE   hire_date >= '05/01/01'
        and e.department_id = d.department_id
ORDER BY e.hire_date asc;

-- step.2 >> 정렬된 테이블에 'ROWNUM' 부여
SELECT  ROWNUM,
        et.employee_id,
        et.first_name,
        et.department_name,
        et.hire_date
FROM    (SELECT  e.employee_id,
                 e.first_name,
                 d.department_name,
                 e.hire_date        
         FROM    employees e, departments d
         WHERE   hire_date >= '05/01/01'
                 and e.department_id = d.department_id
         ORDER BY e.hire_date asc) et;
         
-- step.3 >> 조건문 실행
SELECT  rt.employee_id 사번,
        rt.first_name 이름,
        rt.department_name 부서명,
        rt.hire_date 입사일
FROM    (SELECT  ROWNUM rown,
                 et.employee_id,
                 et.first_name,
                 et.department_name,
                 et.hire_date
         FROM    (SELECT  e.employee_id,
                          e.first_name,
                          d.department_name,
                          e.hire_date        
                  FROM    employees e, departments d
                  WHERE   hire_date >= '05/01/01'
                          and e.department_id = d.department_id
                  ORDER BY e.hire_date asc) et) rt
WHERE   rt.rown BETWEEN 11 and 20;
/*
문제 6.
#1 가장 늦게 입사한 직원의
#2 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name) 조회
*/
-- step.1 >> 가장 늦은 입사일 조회 >> 08/04/21(2)
SELECT  max(hire_date)
FROM    employees;

-- step.2 >> 가장 늦게 입사한 직원 조회
SELECT  e.first_name || ' ' || e.last_name 이름,
        e.salary 연봉,
        d.department_name 부서명
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
        and hire_date = (SELECT  max(hire_date)-- and hire_date = (가장 늦은 입사일)
                         FROM    employees);

/*
문제 7.
#1 평균연봉(salary)이 가장 높은 부서
#2 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary) 조회
*/

/*
문제 8.
평균 급여(salary)가 가장 높은 부서 조회
*/

/*
문제 9.
평균 급여(salary)가 가장 높은 지역 지역
*/

/*
문제 10.
평균 급여(salary)가 가장 높은 업무 조회 
*/
