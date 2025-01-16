-- Criacao do banco de dados para o cenário oficina
CREATE DATABASE IF NOT EXISTS oficina;
USE oficina;

-- Criar tabela veiculo ------------------------------------------------------------------------
CREATE TABLE vehicles (
    id_vehicle INT AUTO_INCREMENT PRIMARY KEY,
    id_revision INT,
    license_plate CHAR(7) NOT NULL,
    CONSTRAINT unique_license_plate_vehicle UNIQUE (id_vehicle, license_plate)
);

ALTER TABLE vehicles
ADD CONSTRAINT fk_vehicle_mechanics FOREIGN KEY (id_vehicle) REFERENCES mechanic_teams(id_mechanic_team),
ADD CONSTRAINT fk_vehicle_repair FOREIGN KEY (id_vehicle) REFERENCES repairs(id_repair),
ADD CONSTRAINT fk_vehicle_revision FOREIGN KEY (id_revision) REFERENCES revisions(id_revision);


-- Criar tabela cliente ------------------------------------------------------------------------
CREATE TABLE clients (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    id_vehicle INT,
    CONSTRAINT fk_client_vehicle FOREIGN KEY (id_vehicle) REFERENCES vehicles(id_vehicle)
);

-- Criar tabela pessoa fisica -------------------------------------------------------------------
CREATE TABLE individuals (
    id_individual INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL,
    address VARCHAR(255),
    contact CHAR(11),
    CONSTRAINT unique_cpf_individual UNIQUE (cpf)
);

ALTER TABLE individuals
ADD CONSTRAINT fk_individual_client FOREIGN KEY (id_individual) REFERENCES clients(id_client);


-- Criar tabela pessoa juridica -----------------------------------------------------------------
CREATE TABLE companies (
    id_company INT AUTO_INCREMENT PRIMARY KEY,
    corporate_name VARCHAR(255) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    address VARCHAR(255),
    contact CHAR(11),
    CONSTRAINT unique_cnpj_company UNIQUE (cnpj)
);

ALTER TABLE companies
ADD CONSTRAINT fk_company_client FOREIGN KEY (id_company) REFERENCES clients(id_client);

-- Criar tabela conserto ------------------------------------------------------------------------
CREATE TABLE repairs (
    id_repair INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Criar tabela revisao ------------------------------------------------------------------------
CREATE TABLE inspection (
    id_revision INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Criar tabela mecanico ------------------------------------------------------------------------
CREATE TABLE mechanics (
    id_mechanic INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    specialty VARCHAR(100) NOT NULL
);

-- Criar tabela equipe de mecanicos ------------------------------------------------------------
CREATE TABLE mechanic_teams (
    id_mechanic_team INT AUTO_INCREMENT PRIMARY KEY
);

ALTER TABLE mechanic_teams
ADD CONSTRAINT fk_team_mechanic FOREIGN KEY (id_mechanic_team) REFERENCES mechanics(id_mechanic);

-- Criar tabela ordem de serviço ----------------------------------------------------------------
CREATE TABLE service_orders (
    id_service_order INT AUTO_INCREMENT PRIMARY KEY,
    issue_date DATE,
    service_cost FLOAT NOT NULL,
    parts_cost FLOAT NOT NULL,
    total_cost FLOAT NOT NULL,
    status ENUM('AGUARDANDO', 'EM ANDAMENTO', 'CONCLUIDO', 'CANCELADO'),
    conclusion_date DATE
);

-- Criar tabela referencia de preços ------------------------------------------------------------
CREATE TABLE price_references (
    id_price_reference INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_price_reference_service_order FOREIGN KEY (id_price_reference) REFERENCES service_orders(id_service_order)
);

-- Criar tabela autorizacao cliente -------------------------------------------------------------
CREATE TABLE client_authorizations (
    id_authorization INT AUTO_INCREMENT PRIMARY KEY,
    authorized BOOL DEFAULT FALSE,
    CONSTRAINT fk_authorization_client FOREIGN KEY (id_authorization) REFERENCES clients(id_client),
    CONSTRAINT fk_authorization_vehicle FOREIGN KEY (id_authorization) REFERENCES vehicles(id_vehicle),
    CONSTRAINT fk_authorization_service_order FOREIGN KEY (id_authorization) REFERENCES service_orders(id_service_order)
);

-- Criar tabela peças ----------------------------------------------------------------------------
CREATE TABLE parts (
    id_part INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    cost FLOAT NOT NULL
);

-- Criar tabela ordem de serviço peças ----------------------------------------------------------
CREATE TABLE service_order_parts (
    id_service_order_part INT AUTO_INCREMENT PRIMARY KEY,
    CONSTRAINT fk_part FOREIGN KEY (id_service_order_part) REFERENCES parts(id_part),
    CONSTRAINT fk_service_order_part FOREIGN KEY (id_service_order_part) REFERENCES service_orders(id_service_order)
);

-- Criar tabela serviços ------------------------------------------------------------------------
CREATE TABLE services (
    id_service INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    cost FLOAT NOT NULL
);

-- Relação serviços e ordens de serviço ---------------------------------------------------------
ALTER TABLE service_orders
ADD CONSTRAINT fk_service_order_service FOREIGN KEY (id_service_order) REFERENCES services(id_service);
