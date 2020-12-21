-- JOIN
SELECT  first_name,
        department_name,
        e.department_id-- department_id >> 오류 중복된 column은 사용불가 >> 로드 된 테이블 중 하나를 지정
FROM    employees e, departments d
WHERE   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;

SELECT  first_name,
        department_id
FROM    employees
WHERE   department_id is null
ORDER BY department_id asc, first_name asc;

SELECT  department_id
FROM    departments
ORDER BY department_id;

-- 모든 직원이름, 부서이름, 업무명 을 출력
SELECT  first_name 직원명,
        department_name 부서명,
        job_title 업무명
FROM    employees e, departments d, jobs j
WHERE   e.department_id = d.department_id
        and e.job_id = j.job_id;
        
-- LEFT OUTER JOIN > 왼쪽 테이블의 모든 row 출력
-- RIGHT OUTER JOIN > 오른쪽 테이블의 모든 row 출력
SELECT  e.department_id "e.부서명",
        first_name,
        d.department_id "d.부서명"
FROM    employees e LEFT OUTER JOIN departments d
   ON   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;

SELECT  e.department_id "e.부서명",
        first_name,
        d.department_id "d.부서명"
FROM    employees e, departments d           -- employees e LEFT OUTER JOIN departments d
WHERE   e.department_id = d.department_id(+) -- ON  e.department_id = d.department_id;, null이 올 수 있는 쪽에 '+'를 붙여준다.
ORDER BY d.department_id asc, first_name asc;

SELECT  e.department_id "e.부서명",
        first_name,
        d.department_id "d.부서명"
FROM    employees e RIGHT OUTER JOIN departments d
   ON   e.department_id = d.department_id
ORDER BY d.department_id asc, first_name asc;

SELECT  e.department_id "e.부서명",
        first_name,
        d.department_id "d.부서명"
FROM    employees e, departments d           -- employees e RIGHT OUTER JOIN departments d
WHERE   e.department_id(+) = d.department_id -- ON  e.department_id = d.department_id;, null이 올 수 있는 쪽에 '+'를 붙여준다.
ORDER BY d.department_id asc, first_name asc;

-- RIGHT OUTER JOIN → LEFT OUTER JOIN > 기준 변경
SELECT  d.department_id "d.부서명",
        first_name,
        e.department_id "e.부서명"
FROM    departments d LEFT OUTER JOIN employees e
   ON   d.department_id = e.department_id
ORDER BY d.department_id asc, first_name asc;

-- FULL OUTER JOIN
