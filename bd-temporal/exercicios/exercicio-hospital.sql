create database hospital;

create table pacientes(
    cpf varchar(14) primary key,
    nome varchar(100) not null,
    endereco varchar(200),
    data_nascimento date,
    SysStartTime datetime2 generated always as row start not null,
    SysEndTime datetime2 generated always as row end not null,
    period for system_time (SysStartTime, SysEndTime)
)  
with (SYSTEM_VERSIONING = on (history_table = dbo.pacientesHistory))

create table medicos(
    cpf varchar(14) primary key,
    nome varchar(100) not null,
    endereco varchar(200),
    data_nascimento date,
    crm varchar(20) not null,
    especialidade varchar(100),
    cargo varchar(50),
    salario decimal(10,2),
    SysStartTime datetime2 generated always as row start not null,
    SysEndTime datetime2 generated always as row end not null,
    period for system_time (SysStartTime, SysEndTime)
)  
with (SYSTEM_VERSIONING = on (history_table = dbo.medicosHistory));

create table exames(
    cod_exame int primary key,
    nome varchar(20) not null,
    tipo varchar(20),
)

create table consulta(
    id int primary key identity,
    FK_pacienteCPF varchar(14),
    foreign key (FK_pacienteCPF) references pacientes(cpf),
    FK_medicoCPF varchar(14),
    foreign key (FK_medicoCPF) references medicos(cpf),
    exames_solicitados datetime2,
    SysStartTime datetime2 generated always as row start not null,
    SysEndTime datetime2 generated always as row end not null,
    period for system_time (SysStartTime, SysEndTime)
)  
with (SYSTEM_VERSIONING = on (history_table = dbo.consultaHistory));

-- alimenta o banco de dados
insert into pacientes (cpf, nome, endereco, data_nascimento)
values
('12345678901', 'Ana Silva', 'Rua das Flores, 100', '1985-03-15'),
('23456789012', 'Bruno Souza', 'Av. Brasil, 200', '1990-07-22'),
('34567890123', 'Carla Mendes', 'Rua do Sol, 300', '1978-11-05'),
('45678901234', 'Daniel Lima', 'Praça Central, 400', '2000-01-30'),
('56789012345', 'Elisa Rocha', 'Rua Verde, 500', '1995-09-12');

insert into medicos (cpf, nome, endereco, data_nascimento, crm, especialidade, cargo, salario)
values
('11111111111', 'Dr. João Pereira', 'Rua Azul, 10', '1970-05-20', 'CRM12345', 'Cardiologia', 'Chefe', 15000.00),
('22222222222', 'Dra. Maria Oliveira', 'Av. das Palmeiras, 50', '1982-08-14', 'CRM23456', 'Pediatria', 'Médica', 12000.00),
('33333333333', 'Dr. Pedro Santos', 'Rua das Laranjeiras, 80', '1975-12-01', 'CRM34567', 'Ortopedia', 'Médico', 11000.00),
('44444444444', 'Dra. Fernanda Costa', 'Av. Central, 120', '1988-03-09', 'CRM45678', 'Dermatologia', 'Médica', 13000.00),
('55555555555', 'Dr. Lucas Almeida', 'Rua Nova, 200', '1992-06-25', 'CRM56789', 'Neurologia', 'Médico', 14000.00);

insert into exames (cod_exame, nome, tipo)
values
(1, 'Hemograma', 'Sangue'),
(2, 'Raio-X', 'Imagem'),
(3, 'Ultrassom', 'Imagem'),
(4, 'Eletrocardiograma', 'Cardíaco'),
(5, 'Urina', 'Laboratorial');

insert into consulta (FK_pacienteCPF, FK_medicoCPF, exames_solicitados)
values
('12345678901', '11111111111', '2024-06-01 09:00:00'),
('23456789012', '22222222222', '2024-06-02 10:30:00'),
('34567890123', '33333333333', '2024-06-03 14:00:00'),
('45678901234', '44444444444', '2024-06-04 11:15:00'),
('56789012345', '55555555555', '2024-06-05 16:45:00');