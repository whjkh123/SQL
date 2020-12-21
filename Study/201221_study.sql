-- JOIN
SELECT  first_name,
        department_name,
        e.department_id-- department_id >> 오류 중복된 column은 사용불가 >> 로드 된 테이블 중 하나를 지정
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;

-- 모든 직원이름, 부서이름, 업무명 을 출력
SELECT  first_name 직원명,
        department_name 부서명,
        job_title 업무명
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id
        and e.job_id = j.job_id;
        
-- LEFT OUTER JOIN > 왼쪽 테이블의 모든 row 출력
SELECT  e.department_id "e.부서명",
        first_name 직원명,
        d.department_id "d.부서명"
FROM    employees e LEFT OUTER JOIN departments d
   ON   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;
/*
ORACLE 명령어 > null 데이터가 있는 쪽에 '(+)'
FROM    employees e LEFT OUTER JOIN departments d
WHERE   e.department_id = d.department_id(+)
*/

-- RIGHT OUTER JOIN > 오른쪽 테이블의 모든 row 출력
SELECT  e.department_id "e.부서명",
        first_name 직원명,
        d.department_id "d.부서명"
FROM    employees e RIGHT OUTER JOIN departments d
   ON   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;
/*
ORACLE 명령어 > null 데이터가 있는 쪽에 '(+)'
FROM    employees e LEFT OUTER JOIN departments d
WHERE   e.department_id(+) = d.department_id
*/

-- ※ LEFT JOIN과 RIGHT JOIN의 결과는 다르다.

-- SELF JOIN > 자기자신과 join
SELECT  emp.employee_id,
        emp.first_name 직업명,
        emp.manager_id,
        man.first_name 관리자명    
FROM    employees emp, employees man
WHERE   emp.manager_id = man.employee_id
ORDER BY emp.employee_id asc;

SELECT  emp.department_id 부서ID,
        emp.employee_id 직원ID,
        emp.first_name 직원명,
        emp.manager_id 관리자ID,
        man.first_name 관리자명    
FROM    employees emp LEFT OUTER JOIN employees man-- employees를 기준으로 잡았기 때문에 employees.employee_id 데이터를 가진 'Steven' 출력
   ON   emp.manager_id = man.employee_id
ORDER BY emp.employee_id asc;

-- 잘못된 JOIN > employees.salary 데이터와 locations.location_id 데이터의 형식이 '우연히 일치'하여 조인은 가능하나 이는 잘못된 사용이다.
SELECT  first_name,
        salary,
        location_id,
        street_address
FROM    employees e, locations l
WHERE   e.salary = l.location_id
ORDER BY salary asc;