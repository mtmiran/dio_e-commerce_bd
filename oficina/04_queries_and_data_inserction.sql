USE workshop;

-- Pessoas físicas ---------------------------------------------------------------------------
SELECT * FROM individuals;
INSERT INTO individuals (id_individual, name, cpf, address, contact) VALUES
    (1, 'Carlos', '32165498701', 'Rua das Flores, 101', '11982345678'),
    (2, 'Mariana', '98712365408', 'Av. Paulista, 300', '11991234567'),
    (3, 'João', '74185296314', 'Rua Alegre, 58', '11985674239'),
    (4, 'Fernanda', '15975345685', 'Travessa Esperança, 77', '11976543218'),
    (5, 'Gabriela', '96385274102', 'Beco da Amizade, 11', '11999876543'),
    (6, 'Lucas', '85236974150', 'Av. Central, 205', '11988765432');

-- Veículos ---------------------------------------------------------------------------
SELECT * FROM vehicles;
INSERT INTO vehicles (id_vehicle, id_revision, license_plate) VALUES
    (1, NULL, 'ABC1234'),
    (2, NULL, 'XYZ5678'),
    (3, NULL, 'LMN1239'),
    (4, NULL, 'OPQ4567'),
    (5, NULL, 'RST9876'),
    (6, NULL, 'UVW3456');

-- Consertos ---------------------------------------------------------------------------
SELECT * FROM repairs;
INSERT INTO repairs (id_repair, description) VALUES
    (1, 'Motor não liga'),
    (2, 'Suspensão danificada'),
    (3, 'Barulho na direção'),
    (4, 'Freio não funciona'),
    (5, 'Troca de óleo necessária'),
    (6, 'Farol queimado');

-- Mecânicos ---------------------------------------------------------------------------
SELECT * FROM mechanics;
INSERT INTO mechanics (id_mechanic, name, address, specialty) VALUES
    (1, 'João da Silva', 'Rua de Trás, 45', 'Borracharia'),
    (2, 'Carlos Alemão', 'Esquina do Mercado, 2', 'Eletricista'),
    (3, 'Pedro Santos', 'Virtude, 555', 'Reparos Gerais'),
    (4, 'José Caolho', 'Rua dos Espertos, 1', 'Funilaria'),
    (5, 'Ricardo Mendes', 'Plenitude, 54', 'Eletricista'),
    (6, 'Maurício Costa', 'Av. Ambrosia, 300', 'Mecânica de Motor');

-- Ordens de Serviço ---------------------------------------------------------------------------
SELECT * FROM service_orders;
INSERT INTO service_orders (id_service_order, issue_date, service_cost, parts_cost, total_cost, status, conclusion_date) VALUES
    (1, '2023-01-10', 150.75, 50.25, 201.00, 'AGUARDANDO', NULL),
    (2, '2023-01-15', 200.80, 75.40, 276.20, 'CONCLUIDO', '2023-01-18'),
    (3, '2023-02-05', 950.90, 400.50, 1351.40, 'CONCLUIDO', '2023-02-10'),
    (4, '2023-03-01', 300.00, 125.00, 425.00, 'EM ANDAMENTO', NULL),
    (5, '2023-03-15', 500.00, 20.00, 520.00, 'CANCELADO', NULL),
    (6, '2023-03-20', 750.00, 10.00, 760.00, 'EM ANDAMENTO', NULL);

-- Autorizações dos Clientes ---------------------------------------------------------------------------
SELECT * FROM client_authorizations;
INSERT INTO client_authorizations (id_authorization, authorized) VALUES
    (1, FALSE),
    (2, TRUE),
    (3, TRUE),
    (4, TRUE),
    (5, FALSE),
    (6, TRUE);

-- Peças ---------------------------------------------------------------------------
SELECT * FROM parts;
INSERT INTO parts (id_part, description, cost) VALUES
    (1, 'Volante', 50.25),
    (2, 'Pistão', 75.40),
    (3, 'Cambio', 400.50),
    (4, 'Caixa Elétrica', 125.00),
    (5, 'Pneu', 20.00),
    (6, 'Ar Condicionado', 10.00);

-- Serviços ---------------------------------------------------------------------------
SELECT * FROM services;
INSERT INTO services (id_service, description, cost) VALUES
    (1, 'Manutenção elétrica', 150.75),
    (2, 'Troca de câmbio', 200.80),
    (3, 'Problemas no motor', 950.90),
    (4, 'Troca de peças elétricas', 300.00),
    (5, 'Troca de pneus', 500.00),
    (6, 'Conserto do ar condicionado', 750.00);


-- Consultas SQL -----------------------------------------------------------------------------------------------------------

-- Recuperações simples com SELECT Statement
-- Quais são os dados de todos os clientes cadastrados?
SELECT * FROM clients;

-- Quais são os veículos cadastrados no sistema?
SELECT id_vehicle, license_plate FROM vehicles;

-- Filtros com WHERE Statement
-- Quais ordens de serviço estão atualmente em andamento?
SELECT * 
FROM service_orders
WHERE status = 'EM ANDAMENTO';

-- Quais serviços possuem custo maior que R$ 500,00?
SELECT * 
FROM services
WHERE cost > 500.00;

-- Criação de atributos derivados
-- Qual é o custo total dos serviços (peças + serviços) para cada ordem de serviço?
SELECT id_service_order, 
       service_cost + parts_cost AS total_cost_calculated
FROM service_orders;

-- Quais são os veículos cuja placa tem mais de 3 letras? (Apenas como exercício de manipulação de strings)
SELECT id_vehicle, license_plate, 
       LEFT(license_plate, 3) AS first_three_chars
FROM vehicles;

-- Ordenações dos dados com ORDER BY
-- Liste os mecânicos ordenados por especialidade em ordem alfabética.
SELECT * 
FROM mechanics
ORDER BY specialty ASC;

-- Quais são as peças cadastradas, ordenadas pelo custo da mais cara para a mais barata?
SELECT * 
FROM parts
ORDER BY cost DESC;

-- Condições de filtros aos grupos – HAVING Statement
-- Qual é o custo total médio dos serviços concluídos?
SELECT status, AVG(total_cost) AS average_cost
FROM service_orders
GROUP BY status
HAVING status = 'CONCLUIDO';

-- Quais ordens de serviço têm custo médio de peças superior a R$ 50,00?
SELECT id_service_order, AVG(parts_cost) AS avg_parts_cost
FROM service_orders
GROUP BY id_service_order
HAVING avg_parts_cost > 50.00;

-- Junções entre tabelas para perspectiva mais complexa
-- Quais são os clientes e os veículos que estão associados?
SELECT c.id_client, i.name AS client_name, v.license_plate
FROM clients c
JOIN individuals i ON c.id_client = i.id_individual
JOIN vehicles v ON c.id_vehicle = v.id_vehicle;

-- Quais mecânicos trabalharam em quais serviços?
SELECT m.name AS mechanic_name, s.description AS service_description
FROM mechanic_teams mt
JOIN mechanics m ON mt.id_mechanic_team = m.id_mechanic
JOIN service_orders so ON mt.id_mechanic_team = so.id_service_order
JOIN services s ON so.id_service_order = s.id_service;

-- Qual é o custo total das ordens de serviço associadas a cada cliente?
SELECT i.name AS client_name, SUM(so.total_cost) AS total_spent
FROM clients c
JOIN individuals i ON c.id_client = i.id_individual
JOIN service_orders so ON c.id_client = so.id_service_order
GROUP BY i.name;

-- Quais peças foram utilizadas em quais ordens de serviço?
SELECT so.id_service_order, p.description AS part_description, p.cost AS part_cost
FROM service_order_parts sop
JOIN parts p ON sop.id_service_order_part = p.id_part
JOIN service_orders so ON sop.id_service_order_part = so.id_service_order;
