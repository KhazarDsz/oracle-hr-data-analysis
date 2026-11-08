-- Project: Oracle HR Data Analysis
-- Layihə: Oracle HR bazasında işçilər, maaşlar və departamentlər üzrə analiz
-- Database: Oracle HR Sample Schema
-- Verilənlər bazası: Oracle-ın nümunə HR bazası
-- Tables used: EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS
-- İstifadə olunan cədvəllər: işçilər, departamentlər, vəzifələr və şəhərlər
-- Author: [Your Name]
-- Müəllif: [Adını burada yaz]
--
-- Run these queries in Oracle SQL Developer or another Oracle SQL client.
-- Sorğuları Oracle SQL Developer proqramında bir-bir işlədib nəticələrə baxa bilərsən.
-- The HR schema must be available and accessible.
-- Bunun üçün Oracle-da HR sxemi aktiv olmalı və istifadəçinə giriş icazəsi verilməlidir.


-- =========================================================
-- 1. Employees earning more than 5000
-- 1. Maaşı 5000-dən çox olan işçiləri tap
-- =========================================================
SELECT first_name, last_name, job_id, salary
FROM hr.employees
WHERE salary > 5000
ORDER BY salary DESC;


-- =========================================================
-- 2. Employee count by department
-- 2. Hər departamentdə neçə işçi olduğunu hesabla
-- =========================================================
SELECT d.department_name,
       COUNT(*) AS employee_count
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;


-- =========================================================
-- 3. Average salary by department
-- 3. Departamentlər üzrə orta maaşı hesabla
-- =========================================================
SELECT d.department_name,
       AVG(e.salary) AS average_salary
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;


-- =========================================================
-- 4. Top 5 highest-paid employees
-- 4. Ən yüksək maaş alan 5 işçini göstər
-- =========================================================
SELECT first_name, last_name, salary, job_id
FROM hr.employees
ORDER BY salary DESC
FETCH FIRST 5 ROWS ONLY;


-- =========================================================
-- 5. Employees earning more than 5000 with department name
-- 5. Maaşı 5000-dən çox olan işçiləri departament adı ilə göstər
-- =========================================================
SELECT e.first_name,
       e.last_name,
       e.salary,
       d.department_name
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
WHERE e.salary > 5000
ORDER BY e.salary DESC;


-- =========================================================
-- 6. Employees without a department
-- 6. Heç bir departamentə təyin olunmayan işçiləri tap
-- =========================================================
SELECT first_name, last_name, department_id
FROM hr.employees
WHERE department_id IS NULL;


-- =========================================================
-- 7. Employee count by job title
-- 7. Vəzifələr üzrə işçi sayını hesabla
-- =========================================================
SELECT j.job_title,
       e.job_id,
       COUNT(*) AS employee_count
FROM hr.employees e
JOIN hr.jobs j
    ON j.job_id = e.job_id
GROUP BY j.job_title, e.job_id
ORDER BY employee_count DESC;


-- =========================================================
-- 8. Employee count by city
-- 8. Şəhərlər üzrə işçi sayını hesabla
-- =========================================================
SELECT l.city,
       COUNT(*) AS employee_count
FROM hr.employees e
JOIN hr.departments d
    ON d.department_id = e.department_id
JOIN hr.locations l
    ON l.location_id = d.location_id
GROUP BY l.city
ORDER BY employee_count DESC;


-- =========================================================
-- 9. Highest-paid employee(s) in each department
-- 9. Hər departamentdə ən yüksək maaş alan işçini və ya işçiləri tap
-- Eyni ən yüksək maaşı alan bir neçə nəfər varsa, hamısı nəticədə qalır.
-- =========================================================
SELECT e.first_name,
       e.last_name,
       e.department_id,
       e.salary
FROM hr.employees e
JOIN (
    SELECT department_id,
           MAX(salary) AS max_salary
    FROM hr.employees
    GROUP BY department_id
) x
    ON x.department_id = e.department_id
   AND x.max_salary = e.salary
ORDER BY e.department_id;


-- =========================================================
-- 10. Top 3 highest-paid employees in each department
-- 10. Hər departamentdə ən yüksək maaş alan ilk 3 işçini göstər
-- ROW_NUMBER hər departament daxilində işçilərə maaşa görə sıra verir.
-- =========================================================
SELECT *
FROM (
    SELECT e.first_name,
           e.last_name,
           e.department_id,
           e.salary,
           ROW_NUMBER() OVER (
               PARTITION BY e.department_id
               ORDER BY e.salary DESC
           ) AS sira
    FROM hr.employees e
)
WHERE sira <= 3
ORDER BY department_id, sira;


-- =========================================================
-- BONUS 1. Highest-paid employee(s) in each job
-- ƏLAVƏ 1. Hər vəzifə üzrə ən yüksək maaş alan işçini və ya işçiləri tap
-- =========================================================
SELECT e.first_name,
       e.last_name,
       e.job_id,
       e.salary
FROM hr.employees e
JOIN (
    SELECT job_id,
           MAX(salary) AS max_salary
    FROM hr.employees
    GROUP BY job_id
) x
    ON x.job_id = e.job_id
   AND x.max_salary = e.salary
ORDER BY e.job_id;


-- =========================================================
-- BONUS 2. Employees earning above their department average
-- ƏLAVƏ 2. Öz departamentinin orta maaşından çox qazanan işçiləri tap
-- =========================================================
SELECT e.first_name,
       e.last_name,
       e.department_id,
       e.salary
FROM hr.employees e
JOIN (
    SELECT department_id,
           AVG(salary) AS avg_salary
    FROM hr.employees
    GROUP BY department_id
) x
    ON x.department_id = e.department_id
WHERE e.salary > x.avg_salary
ORDER BY e.salary DESC;


-- =========================================================
-- BONUS 3. Salary ranking within each department using DENSE_RANK
-- ƏLAVƏ 3. DENSE_RANK ilə hər departamentdə maaş sıralaması yarat
-- Eyni maaş alanlar eyni yeri tutur, növbəti sıra isə boşluq buraxmadan davam edir.
-- =========================================================
SELECT first_name,
       last_name,
       department_id,
       salary,
       DENSE_RANK() OVER (
           PARTITION BY department_id
           ORDER BY salary DESC
       ) AS salary_rank
FROM hr.employees
ORDER BY department_id, salary_rank;
