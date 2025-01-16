-- Criacao do banco de dados para o cenário e-commerce
CREATE DATABASE ecommerce;
USE ecommerce;

-- Criar tabela cliente ------------------------------------------------------------------------
CREATE TABLE clients (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(100),
    m_init CHAR(2),
    l_name VARCHAR(100),
    cpf CHAR(11) NOT NULL,
    address VARCHAR(255),
    CONSTRAINT unique_cpf_client UNIQUE (cpf)
);

ALTER TABLE clients auto_increment;

DESC clients;

-- Criar tabela produto ------------------------------------------------------------------------
CREATE TABLE product (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    p_name VARCHAR(100) NOT NULL,
    classification_kids BOOL,
    category ENUM('eletronico', 'vestimenta', 'brinquedos', 'alimentos') NOT NULL,
    feedback FLOAT DEFAULT 0,
    size VARCHAR(20)
);

DESC product;

-- Criar tabela pagamento ------------------------------------------------------------------------
CREATE TABLE payments (
    id_payment INT AUTO_INCREMENT PRIMARY KEY, -- Correção: id_payment ao invés de id_pament
    id_client INT,
    type_payment ENUM('dinheiro', 'cartao', 'dois cartoes') NOT NULL,
    limit_available FLOAT DEFAULT 0, -- Adicionando um valor de limite para o pagamento
    CONSTRAINT fk_payment_client FOREIGN KEY (id_client) REFERENCES clients(id_client)
);

DESC payments;

-- Criar tabela pedido ------------------------------------------------------------------------
CREATE TABLE orders (
    id_order INT AUTO_INCREMENT PRIMARY KEY,
    id_order_client INT, 
    order_status ENUM('cancelado', 'confirmado', 'em processamento') DEFAULT 'em processamento',
    order_description VARCHAR(255),
    shipping_cost FLOAT DEFAULT 10,
    payment_cash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (client_id) REFERENCES clients(id_client)
);

DESC orders;

-- Criar tabela estoque ------------------------------------------------------------------------
CREATE TABLE product_storage (
    id_prod_storage INT AUTO_INCREMENT PRIMARY KEY,
    storage_location VARCHAR(255),
    quantity INT DEFAULT 0
);

DESC product_storage;

-- Criar tabela fornecedor ------------------------------------------------------------------------
CREATE TABLE supplier (
    id_supplier INT AUTO_INCREMENT PRIMARY KEY,
    social_name VARCHAR(255) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (cnpj)
);

DESC supplier;

-- Criar tabela vendedor ------------------------------------------------------------------------
CREATE TABLE seller (
    id_seller INT AUTO_INCREMENT PRIMARY KEY,
    social_name VARCHAR(255) NOT NULL,
    abst_name VARCHAR(255),
    cnpj CHAR(15),
    cpf CHAR(11), -- Ajustado para 11 caracteres (CPF com 11 números)
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (cnpj),
    CONSTRAINT unique_cpf_seller UNIQUE (cpf)
);

DESC seller;

-- Criar tabela produto vendedor - relação M:N ------------------------------------------------------------------------
CREATE TABLE product_seller (
    id_p_seller INT,
    id_p_product INT, -- Ajustado para id_product
    prod_quantity INT DEFAULT 1,
    PRIMARY KEY (id_seller, id_product),
    CONSTRAINT fk_product_seller FOREIGN KEY (id_p_seller) REFERENCES seller(id_seller),
    CONSTRAINT fk_product_product FOREIGN KEY (id_p_product) REFERENCES product(id_product)
);

DESC product_seller;

-- Criar tabela produto pedido ------------------------------------------------------------------
CREATE TABLE product_order (
    id_po_product INT,
    id_po_order INT,
    po_quantity INT DEFAULT 1,
    po_status ENUM('disponivel', 'sem estoque') DEFAULT 'disponivel',
    PRIMARY KEY (id_po_product , id_po_order),
    CONSTRAINT fk_productorder_seller FOREIGN KEY (id_po_product)
        REFERENCES product (id_product),
    CONSTRAINT fk_productorder_product FOREIGN KEY (id_po_order)
        REFERENCES orders (id_order)
);

-- Criar tabela estoque localizacao ------------------------------------------------------------------
CREATE TABLE storage_location (
    id_l_product INT,
    id_l_storage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_l_product , id_l_storage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (id_l_product)
        REFERENCES product (id_product),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (id_l_storage)
        REFERENCES product_storage (id_prod_storage)
);

-- Criar tabela produto fornecedor ------------------------------------------------------------------
CREATE TABLE product_supplier (
    id_ps_suppluier INT,
    id_ps_product INT,
    quantity INT NOT NULL,
    PRIMARY KEY (id_ps_suppluier , id_ps_product),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (id_ps_suppluier)
        REFERENCES supplier (id_supplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (id_ps_product)
        REFERENCES product (id_product)
);

DESC product_supplier;

-- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- = -- =

SHOW DATABASES;

USE information_schema;

SHOW TABLES;

DESC referential_constraints;

SELECT 
    *
FROM
    referential_constraints
WHERE
    CONSTRAINT_SCHEMA = 'ecommerce';
show tables; 