-- inserindo usuarios
INSERT INTO users (name, email) VALUES ('John Doe', 'john.doe@example.com');
INSERT INTO users (name, email) VALUES ('Jane Smith', 'jane.smith@example.com');

-- removendo um usuario
DELETE FROM users WHERE user_id = 1;

-- log de remoção
SELECT * FROM user_removals_log;

-- Inserindo colaboradores
INSERT INTO employees (name, role, base_salary) VALUES ('Alice', 'Manager', 5000.00);
INSERT INTO employees (name, role, base_salary) VALUES ('Bob', 'Developer', 3000.00);

-- atualizando salario
UPDATE employees SET base_salary = 5500.00 WHERE employee_id = 1;

-- log de atualizações de salario
SELECT * FROM salary_updates_log;

