USE ecommerce;

-- Inserindo dados no banco de dados --------------------------------------------------------------------------------------

SHOW TABLES;

-- Inserindo dados na tabela clients --------------------------------------------------------------------------------------
INSERT INTO clients (f_name, m_init, l_name, cpf, address) 
VALUES 
    ('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - SP'),
    ('Matheus', 'O', 'Pimentel', 987654321, 'rua alemeda 289, Centro - SP'),
    ('Ricardo', 'F', 'Silva', 45678913, 'avenida alemeda vinha 1009, Centro - RJ'),
    ('Julia', 'S', 'França', 789123456, 'rua lareijras 861, Centro - SP'),
    ('Roberta', 'G', 'Assis', 98745631, 'avenidade koller 19, Centro - SP'),
    ('Isabela', 'M', 'Cruz', 654789123, 'rua alemeda das flores 28, Centro - SP');

-- Inserindo dados na tabela product --------------------------------------------------------------------------------------
INSERT INTO product (p_name, classification_kids, category, feedback, size) 
VALUES 
    ('Fone de ouvido', FALSE, 'Eletrônico', '4', NULL),
    ('Barbie Elsa', TRUE, 'Brinquedos', '3', NULL),
    ('Body Carters', TRUE, 'Vestimenta', '5', NULL),
    ('Microfone Vedo', FALSE, 'Eletrônico', '4', NULL),
    ('Sofá retrátil', FALSE, 'Brinquedos', '3', '3x57x80'),
    ('Farinha', FALSE, 'Alimentos', '2', NULL),
    ('Fire Stick', FALSE, 'Eletrônico', '3', NULL);

-- Inserindo dados na tabela orders --------------------------------------------------------------------------------------
INSERT INTO orders (id_order_client, order_status, order_description, shipping_cost) 
VALUES 
    (1, DEFAULT, 'compra via aplicativo', NULL),
    (2, DEFAULT, 'compra via aplicativo', 50),
    (3, 'Confirmado', NULL, NULL),
    (4, DEFAULT, 'compra via web site', 150);

-- Inserindo dados na tabela product_order --------------------------------------------------------------------------------------
INSERT INTO product_order (id_po_product, id_po_order, po_quantity, po_status) 
VALUES 
    (22, 1, 2, NULL),
    (23, 2, 1, NULL),
    (25, 3, 1, NULL);

-- Inserindo dados na tabela product_storage --------------------------------------------------------------------------------------
INSERT INTO product_storage (storage_location, quantity) 
VALUES 
    ('Rio de Janeiro', 1000),
    ('Rio de Janeiro', 500),
    ('São Paulo', 10),
    ('São Paulo', 100),
    ('São Paulo', 10),
    ('Brasília', 60);

-- Inserindo dados na tabela storeage_location --------------------------------------------------------------------------------------
INSERT INTO storeage_location (id_l_product, id_l_storage, location) 
VALUES 
    (1, 2, 'RJ'),
    (2, 6, 'GO');

-- Inserindo dados na tabela supplier --------------------------------------------------------------------------------------
INSERT INTO supplier (social_name, cnpj, contact) 
VALUES 
    ('Almeida e filhos', 123456789123456, '21985474'),
    ('Eletrônicos Silva', 854519649143457, '21985484'),
    ('Eletrônicos Valma', 934567893934695, '21975474');

-- Inserindo dados na tabela seller --------------------------------------------------------------------------------------
INSERT INTO seller (social_name, abst_name, cnpj, cpf, location, contact) 
VALUES 
    ('Tech eletronics', NULL, 123456789456321, NULL, 'Rio de Janeiro', 219946287),
    ('Botique Durgas', NULL, NULL, 123456783, 'Rio de Janeiro', 219567895),
    ('Kids World', NULL, 456789123654485, NULL, 'São Paulo', 1198657484);

-- Inserindo dados na tabela product_seller --------------------------------------------------------------------------------------
INSERT INTO product_seller (id_p_seller, id_p_product, prod_quantity) 
VALUES 
    (1, 23, 80),
    (2, 24, 10);

-- Consultas SQL -----------------------------------------------------------------------------------------------------------

-- Selecionando todas as tabelas
SELECT * FROM clients;

-- Contagem de clientes na tabela
SELECT COUNT(*) FROM clients;

-- Recuperar quantos pedidos foram realizados pelos clientes
SELECT 
    c.id_client, 
    f_name AS client_name, 
    COUNT(*) AS num_orders
FROM 
    clients c
INNER JOIN 
    orders o ON c.id_client = o.id_order_client
GROUP BY 
    c.id_client;
