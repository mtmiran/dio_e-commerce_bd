use company;

-- número de empregados por departamento e localidade ------------------------------------------------------------------------

CREATE VIEW employees_per_dept_location AS
SELECT 
    d.d_name AS department_name,
    dl.d_location AS location,
    COUNT(e.ssn) AS employee_count
FROM 
    department d
JOIN 
    dept_location dl ON d.d_number = dl.d_number
LEFT JOIN 
    employee e ON e.d_no = d.d_number
GROUP BY 
    d.d_name, dl.d_location;

-- lista de departamentos e seus gerentes ------------------------------------------------------------------------
CREATE VIEW departments_and_managers AS
SELECT 
    d.d_name AS department_name,
    e.f_name AS manager_first_name,
    e.l_name AS manager_last_name
FROM 
    department d
LEFT JOIN 
    employee e ON d.mgr_ssn = e.ssn;

-- Projetos com maior número de empregados ------------------------------------------------------------------------
CREATE VIEW projects_by_employee_count AS
SELECT 
    p.p_name AS project_name,
    COUNT(w.essn) AS employee_count
FROM 
    project p
LEFT JOIN 
    works_on w ON p.p_number = w.p_no
GROUP BY 
    p.p_name
ORDER BY 
    employee_count DESC;


-- Lista de projetos, departamentos e gerentes ------------------------------------------------------------------------
CREATE VIEW projects_departments_managers AS
SELECT 
    p.p_name AS project_name,
    d.d_name AS department_name,
    e.f_name AS manager_first_name,
    e.l_name AS manager_last_name
FROM 
    project p
JOIN 
    department d ON p.d_num = d.d_number
LEFT JOIN 
    employee e ON d.mgr_ssn = e.ssn;

-- Quais empregados possuem dependentes e se são gerentes ------------------------------------------------------------------------
CREATE VIEW employees_with_dependents_and_roles AS
SELECT 
    e.f_name AS employee_first_name,
    e.l_name AS employee_last_name,
    d.dependent_name AS dependent_name,
    CASE 
        WHEN e.ssn IN (SELECT mgr_ssn FROM department) THEN 'Manager'
        ELSE 'Employee'
    END AS role
FROM 
    employee e
LEFT JOIN 
    dependent d ON e.ssn = d.essn;

-- 2. Definição de Permissões de Acesso ------------------------------------------------------------------------

-- criando usuarios
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager_password';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee_password';

-- permissoes
GRANT SELECT ON company.employee TO 'manager'@'localhost';
GRANT SELECT ON company.department TO 'manager'@'localhost';
GRANT SELECT ON company.employees_per_dept_location TO 'manager'@'localhost';
GRANT SELECT ON company.departments_and_managers TO 'manager'@'localhost';
GRANT SELECT ON company.projects_by_employee_count TO 'manager'@'localhost';
GRANT SELECT ON company.projects_departments_managers TO 'manager'@'localhost';
GRANT SELECT ON company.employees_with_dependents_and_roles TO 'manager'@'localhost';

