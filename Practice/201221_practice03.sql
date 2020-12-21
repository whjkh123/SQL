-- 2020. 12. 21 practice03

/*
문제 1.
#1 직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회(106건)
#2 부서이름(department_name) 오름차순 정렬
#3 사번(employee_id) 내림차순 정렬
*/
SELECT  e.employee_id 사번,
        e.first_name 이름,
        e.last_name 성,
        d.department_name 부서명
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
ORDER BY d.department_name asc, e.employee_id desc;

/*
문제 2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
#1 직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를
#2 사번(employee_id) 오름차순 정렬
#3 부서가 없는 Kimberely(사번 178)은 생략(106건)
*/
SELECT  e.employee_id 사번,
        e.first_name 이름,
        e.salary 급여,
        d.department_name 부서명,
        j.job_title 현재업무
FROM    employees e, jobs j, departments d
WHERE   e.department_id = d.department_id
        and e.job_id = j.job_id
ORDER BY e.employee_id asc;

/*
문제 2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시(107건)
*/
SELECT  e.employee_id 사번,
        e.first_name 이름,
        e.salary 급여,
        d.department_name 부서명,
        j.job_title 현재업무
FROM    employees e, jobs j, departments d
WHERE   e.department_id = d.department_id(+)
        and e.job_id = j.job_id
ORDER BY e.employee_id asc;

/*
문제 3.
도시별로 위치한 부서들을 파악하려고 합니다.
#1 도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력 
#2 부서가 없는 도시는 생략(27건)
*/
SELECT  l.location_id 도시ID,
        l.city 도시명,
        d.department_name 부서명,
        d.department_id 부서ID
FROM    departments d, locations l
WHERE   d.location_id = l.location_id
ORDER BY l.location_id asc;

/*
문제 3-1.
문제3에서 부서가 없는 도시도 표시(43건)
*/
SELECT  l.location_id 도시ID,
        l.city 도시명,
        d.department_name 부서명,
        d.department_id 부서ID
FROM    departments d RIGHT OUTER JOIN locations l
   ON   d.location_id = l.location_id
ORDER BY l.location_id asc;

/*
문제 4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬(25건)
*/
SELECT  r.region_name 지역명,
        c.country_name 나라명
FROM    countries c, regions r
WHERE   c.region_id = r.region_id
ORDER BY r.region_name asc, c.country_name desc;

/*
문제 5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회(37건)
*/
SELECT  e.employee_id 직원ID,
        e.first_name 직원명,
        e.hire_date 직원입사일,
        m.first_name 관리자명,
        m.hire_date 관리자입사일
FROM    employees e, employees m
WHERE   e.manager_id = m.employee_id
        and e.hire_date < m.hire_date;
        
/*
문제 6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
#1 나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력
#2 값이 없는 경우 생략(27건)
*/
SELECT  c.country_name 나라명,
        c.country_id 나라ID,
        l.city 도시명,
        l.location_id 도시ID,
        d.department_name 부서명,
        d.department_id 부서ID
FROM    departments d, locations l, countries c
WHERE   d.location_id = l.location_id
        and l.country_id = c.country_id
ORDER BY c.country_name;

/*
문제 7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
#1 과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력
#2 이름은 first_name과 last_name을 합쳐 출력(2건)
*/
SELECT  e.employee_id 사번,
        e.first_name || ' ' || e.last_name 직원명,
        e.job_id 업무ID,
        jh.start_date 업무시작일,
        jh.end_date 업무종료일
FROM   employees e, job_history jh
WHERE   e.employee_id = jh.employee_id
        and jh.job_id = 'AC_ACCOUNT';
        
/*
문제 8.
#1 각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name)
#2 매니저(manager)의 이름(first_name)
#3 위치(locations)한 도시(city)
#4 나라(countries)의 이름(countries_name)
#5 지역구분(regions)의 이름(resion_name)까지 전부 출력(11건)
*/
SELECT  d.department_id 부서번호,
        d.department_name 부서명,
        e.first_name 관리자명,
        l.city 도시명,
        c.country_name 나라명,
        r.region_name 지역명
FROM    departments d, employees e, locations l, countries c, regions r
WHERE   d.manager_id = e.employee_id
        and d.location_id = l.location_id
        and l.country_id = c.country_id
        and c.region_id = r.region_id
ORDER BY c.region_id asc, c.country_name asc, d.department_id asc;
        
/*
문제 9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name)
부서명(department_name)
매니저(manager)의 이름(first_name)을 조회
부서가 없는 직원(Kimberely)도 표시(106명)
*/
SELECT  e.employee_id 사번,
        e.first_name || ' ' || e.last_name 직원명,
        d.department_name 부서명,
        m.first_name || ' ' || m.last_name 관리자명
FROM    employees e, departments d, employees m
WHERE   e.department_id = d.department_id(+)
        and e.manager_id = m.employee_id
ORDER BY e.employee_id asc;

-- 문제 9. 복수 LEFT OUTER JOIN >> Steven도 employee_id 데이터를 갖으므로 출력 >> 이를 제거하려면? >> INNER JOIN 사용 >> 해결
SELECT  e.employee_id 사번,
        e.first_name || ' ' || e.last_name 직원명,
        d.department_name 부서명,
        m.first_name || ' ' || m.last_name 관리자명
FROM    employees e
LEFT OUTER JOIN departments d
   ON   e.department_id = d.department_id
INNER JOIN employees m
   ON   e.manager_id = m.employee_id
ORDER BY e.employee_id asc;
/*
WHERE   e.department_id = d.department_id(+)
        and e.manager_id = m.employee_id
이를 JOIN문을 사용해 재정의
#1 e.department_id = d.department_id(+) >> LEFT OUTER JOIN departments d
                                            ON e.department_id = d.department_id >> 각 사원에 대한 정보를 출력하기 위한 것이므로 'employees'를 'e'로 정의해 기준으로 삼고
                                                                                    부서명을 불러오기 위해 'departments'를 'd'로 정의해 JOIN
#2 e.manager_id = m.employee_id >> 첫번째 시도 LEFT OUTER JOIN employees m
                                                ON e.manager_id = m.employee_id >> 'employees'를 'e'로 정의해 기준으로 삼고
                                                                                    SELF JOIN하여 각' m.employee_id' 데이터를 'e.manger_id'에 대입하여 관리자 산출
                                    실패 >> 'employees e'를 SELF JOIN 함으로써 'e.manager_id' 데이터는 갖지않지만(정확히는 NULL 데이터를 가졌다.), 'm.employee_id' 데이터를 가진 'Steven' 출력
                                            FROM A
                                            LEFT OUTER JOIN B
                                            ON A.depth = B.depth
                                            >> A ∪ B(A와 B의 합집합) 산출(e.manager_id, m.employee_id)
                                >> 두번째 시도 INNER JOIN employees m
                                                ON e.manager_id = m.employee_id ↔ WHERE e.manager_id = m.employee_id
                                                WHERE문을 풀어보면, 'e.manager_id' 데이터와 'm.employee_id' 데이터가 같으면 출력, 나머지 생략
                                                즉, 교집합을 검사 → 산출
                                                따라서, INNER JOIN 함으로써 'e.manager_id' 데이터와 'm.employee_id' 데이터 모두 갖는 row 데이터 산출 >> 'e.manager_id' 데이터를 갖지않은 'Steven' 생략
                                    성공
                                            FROM A
                                            INNER JOIN B
                                            ON A.depth = B.depth
                                            >> A ∩ B(A와 B의 교집합) 산출(m.employee_id) ↔ WHERE A.depth = B.depth
                                            ※JOIN ~ ON문 아래에는 또다른 JOIN ~ ON문만 올 수 있다.(WHERE문 사용 불가) 
*/