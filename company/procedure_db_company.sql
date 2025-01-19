USE company;

-- criação da procedure de manipulação de dados ------------------------------------------------------------------------
DELIMITER $$

CREATE PROCEDURE manage_data(
    IN operation INT,          -- Variável de controle: 1 (insert), 2 (update), 3 (delete)
    IN table_name VARCHAR(20), -- Nome da tabela
    IN emp_ssn CHAR(9),        -- SSN do empregado (usado para identificação)
    IN emp_fname VARCHAR(15),  -- Primeiro nome do empregado (opcional para inserção/atualização)
    IN emp_lname VARCHAR(15),  -- Sobrenome do empregado (opcional para inserção/atualização)
    IN emp_salary DECIMAL(10, 2) -- Salário do empregado (opcional para inserção/atualização)
)
BEGIN
    -- Controle de ações baseado no parâmetro "operation"
    CASE 
        -- Inserção de dados
        WHEN operation = 1 THEN
            IF table_name = 'employee' THEN
                INSERT INTO employee (f_name, l_name, ssn, salary, d_no)
                VALUES (emp_fname, emp_lname, emp_ssn, emp_salary, 5); -- 5 é um exemplo de d_no
            END IF;

        -- Atualização de dados
        WHEN operation = 2 THEN
            IF table_name = 'employee' THEN
                UPDATE employee
                SET f_name = emp_fname, l_name = emp_lname, salary = emp_salary
                WHERE ssn = emp_ssn;
            END IF;

        -- Remoção de dados
        WHEN operation = 3 THEN
            IF table_name = 'employee' THEN
                DELETE FROM employee
                WHERE ssn = emp_ssn;
            END IF;

        -- Caso operação não seja válida
        ELSE
            SIGNAL SQLSTATE '45000' 
                SET MESSAGE_TEXT = 'Operação inválida. Use 1 (insert), 2 (update) ou 3 (delete).';
    END CASE;
END$$

DELIMITER ;

-- Testando a procedure ------------------------------------------------------------------------

-- 1. Inserir um novo empregado
CALL manage_data(1, 'employee', '123123123', 'Carlos', 'Silva', 45000);

-- 2. Atualizar dados de um empregado existente
CALL manage_data(2, 'employee', '123123123', 'Carlos', 'Ferreira', 48000);

-- 3. Remover um empregado
CALL manage_data(3, 'employee', '123123123', NULL, NULL, NULL);
