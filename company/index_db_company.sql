USE company;

-- 1. Criar índice no atributo `d_no` da tabela `employee` para facilitar a contagem de empregados por departamento.
CREATE INDEX idx_employee_dno ON employee(d_no);

-- 2. Criar índice no atributo `d_number` da tabela `dept_location` para consultas de departamentos por cidade.
CREATE INDEX idx_dept_location_dnumber ON dept_location(d_number);

-- 3. Criar índice no atributo `d_number` da tabela `department` para suportar junções frequentes entre `department` e outras tabelas.
CREATE INDEX idx_department_dnumber ON department(d_number);

-- Perguntas e consultas otimizadas: ------------------------------------------------------------------------

-- 1. Qual o departamento com maior número de pessoas? 
SELECT 
    d_no AS department_number, 
    COUNT(*) AS employee_count 
FROM 
    employee 
GROUP BY 
    d_no 
ORDER BY 
    employee_count DESC 
LIMIT 1;

-- 2. Quais são os departamentos por cidade? 
SELECT 
    d.d_name AS department_name, 
    dl.d_location AS city 
FROM 
    department d 
JOIN 
    dept_location dl 
ON 
    d.d_number = dl.d_number 
ORDER BY 
    dl.d_location;

-- 3. Relação de empregados por departamento. 
SELECT 
    d.d_name AS department_name, 
    e.f_name AS employee_first_name, 
    e.l_name AS employee_last_name 
FROM 
    department d 
JOIN 
    employee e 
ON 
    d.d_number = e.d_no 
ORDER BY 
    d.d_name, e.l_name;

