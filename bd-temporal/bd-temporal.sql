create database temporal

create table inventarioCarros
(
    id integer primary key identity,
    ano integer,
    marca varchar(40),
    modelo varchar(40),
    cor varchar(12),
    kilometragem integer,
    emEstoque bit not null default 1,
    -- torna o banco temporário
    SysStartTime datetime2 generated always as row start not null, -- Cria uma coluna com nome SysStartTime que grava automaticamente o início da validade do registro
    SysEndTime datetime2 generated always as row end not null, -- Faz algo semelhante, mas para o fim da validade
    period for system_time (SysStartTime, SysEndTime) -- Informa ao SGBD para rastrear o tempo
)  
with( -- faz com que o SGBD use um bd temporário para maior eficiência
    SYSTEM_VERSIONING = ON (history_table = dbo.inventarioCarrosHistory)
);

-- Alimenta o banco

insert into inventarioCarros (ano, marca, modelo, cor, kilometragem)
values (2020, 'GM', 'Corvette', 'Amarelo', 5559);

insert into inventarioCarros (ano, marca, modelo, cor, kilometragem)
values (1986, 'Shelby', 'Cobra', 'Azul', 75559);

insert into inventarioCarros (ano, marca, modelo, cor, kilometragem)
values (2012, 'Ford', 'Ka', 'Amarelo', 34256);

insert into inventarioCarros (ano, marca, modelo, cor, kilometragem)
values (2004, 'Fiat', 'Uno com escada', 'Branco', 98878);

select * from inventarioCarros

-- atualiza um valor
update inventarioCarros set kilometragem = 20000 where id = 3

select * from inventarioCarros

-- mostra a tabela com todas as versões
select * from inventarioCarros for system_time all

-- apaga um valor e mostra o histórico dos registros de id 3
delete from inventarioCarros where id = 1
select * from inventarioCarros
for system_time all
where id = 3

-- para comparar os selects
select * from inventarioCarros
select * from dbo.inventarioCarrosHistory

-- permite apagar a tabela, quando versionada
alter table inventarioCarros set (SYSTEM_VERSIONING = off);
drop table inventarioCarros;
