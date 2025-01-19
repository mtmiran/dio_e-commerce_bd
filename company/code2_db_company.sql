CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tabela para armazenar informações de usuários
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para armazenar logs de usuários removidos
CREATE TABLE user_removals_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(50),
    email VARCHAR(100),
    removed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para colaboradores
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    base_salary DECIMAL(10, 2) NOT NULL,
    hired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela para log de atualizações de salários
CREATE TABLE salary_updates_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
