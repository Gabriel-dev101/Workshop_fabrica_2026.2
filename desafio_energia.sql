CREATE DATABASE desafio_energia;
USE desafio_energia;



CREATE TABLE regiao (
    id_regiao INT NOT NULL PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    estado VARCHAR(30) NOT NULL,
    descricao VARCHAR(200) NULL
);

CREATE TABLE usina (
    id_usina INT NOT NULL PRIMARY KEY,
    id_regiao INT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    status_usina VARCHAR(20) CHECK (
        status_usina IN ('Ativada', 'Desativada', 'Em manutencao')
    ),
    tipo_fonte VARCHAR(20),
    capacidade_mw INT,
    FOREIGN KEY (id_regiao) REFERENCES regiao(id_regiao)
);

CREATE TABLE geracao (
    id_geracao INT NOT NULL PRIMARY KEY,
    id_usina INT NOT NULL,
    quantidade_energia_mwh DECIMAL(10,2),
    data_geracao DATE,
    potencia_mw DECIMAL(10,2),
    FOREIGN KEY (id_usina) REFERENCES usina(id_usina)
);

INSERT INTO regiao (id_regiao, nome, estado, descricao) VALUES
(1, 'Norte', 'Pará', 'Região com grande potencial hidrelétrico e disponibilidade de recursos hídricos'),
(2, 'Nordeste', 'Bahia', 'Região com elevado potencial para geração solar e eólica'),
(3, 'Sul', 'Paraná', 'Região com forte presença de usinas hidrelétricas'),
(4, 'Sudeste', 'Minas Gerais', 'Região com geração hidrelétrica e solar diversificada'),
(5, 'Centro-Oeste', 'Goiás', 'Região com potencial hidrelétrico e solar'),
(6, 'Norte', 'Amazonas', 'Região com geração predominantemente térmica e potencial renovável'),
(7, 'Nordeste', 'Ceará', 'Região com forte potencial de geração eólica'),
(8, 'Sudeste', 'São Paulo', 'Região com geração hidrelétrica, solar e biomassa'),
(9, 'Sul', 'Rio Grande do Sul', 'Região com destaque para geração eólica e hidrelétrica'),
(10, 'Centro-Oeste', 'Mato Grosso', 'Região com potencial hidrelétrico e de biomassa');

INSERT INTO usina 
(id_usina, id_regiao, nome, status_usina, tipo_fonte, capacidade_mwh) VALUES
(1, 1, 'Usina Tapajos', 'Ativada', 'Hidreletrica', 4000),
(2, 2, 'Usina Sol Bahia', 'Ativada', 'Solar', 2500),
(3, 3, 'Usina Parana Sul', 'Ativada', 'Hidreletrica', 3500),
(4, 4, 'Usina Minas Solar', 'Ativada', 'Solar', 1800),
(5, 5, 'Usina Goias Verde', 'Ativada', 'Hidreletrica', 2200),
(6, 6, 'Usina Amazonas Norte', 'Em manutencao', 'Termica', 1500),
(7, 7, 'Usina Ventos Ceara', 'Ativada', 'Eolica', 3000),
(8, 8, 'Usina Biomassa SP', 'Ativada', 'Biomassa', 1200),
(9, 9, 'Usina Ventos Sul', 'Ativada', 'Eolica', 2800),
(10, 10, 'Usina BioMato', 'Desativada', 'Biomassa', 1000);

INSERT INTO geracao
(id_geracao, id_usina, quantidade_energia_mwh, data_geracao, potencia_mw) VALUES
(1, 1, 3250.50, '2026-08-01', 3800.00),
(2, 2, 1980.75, '2026-08-02', 2300.00),
(3, 3, 2945.30, '2026-08-03', 3200.00),
(4, 4, 1450.80, '2026-08-04', 1650.00),
(5, 5, 1875.40, '2026-08-05', 2050.00),
(6, 6, 850.25, '2026-08-06', 900.00),
(7, 7, 2560.90, '2026-08-07', 2700.00),
(8, 8, 980.60, '2026-08-08', 1050.00),
(9, 9, 2340.45, '2026-08-09', 2500.00),
(10, 10, 0.00, '2026-08-10', 0.00);

delete from geracao where id_usina = 8;

select nome, status_usina from usina where id_usina in (3,4);

select count(id_usina) as total_usinas from usina;
select min(quantidade_energia_mwh) as quantidade_minina_energia from geracao;
select max(quantidade_energia_mwh) as quantidade_maxima_energia from geracao;

select data_geracao, sum(quantidade_energia_mwh) as total_energia from geracao group by data_geracao;
select data_geracao, sum(quantidade_energia_mwh) as total_energia from geracao group by data_geracao having sum(quantidade_energia_mwh) > 2000;

select 
    u.nome,
    avg(g.quantidade_energia_mwh) as media_energia
from geracao g
join usina u on g.id_usina = u.id_usina
where u.status_usina = 'Ativada'
group by u.nome;

select r.nome, sum(g.quantidade_energia_mwh) as total_geracao
from regiao r
join usina u on r.id_regiao = u.id_regiao
join geracao g on u.id_usina = g.id_usina
group by r.id_regiao, r.nome
order by total_geracao desc
limit 1;





