-- remocao

DELIMITER $$

CREATE TRIGGER before_user_delete
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    INSERT INTO user_removals_log (user_id, name, email, removed_at)
    VALUES (OLD.user_id, OLD.name, OLD.email, NOW());
END$$

DELIMITER ;


-- atualizacao

DELIMITER $$

CREATE TRIGGER before_salary_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.base_salary != NEW.base_salary THEN
        INSERT INTO salary_updates_log (employee_id, old_salary, new_salary, updated_at)
        VALUES (OLD.employee_id, OLD.base_salary, NEW.base_salary, NOW());
    END IF;
END$$

DELIMITER ;
