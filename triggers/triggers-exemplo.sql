-- Cria o banco de dados
CREATE DATABASE exemplo_triggers;
GO

-- Altera o contexto para o banco de dados recém-criado
USE exemplo_triggers;
GO

-- Cria as tabelas
CREATE TABLE Produtos(
    ProdutoID INT PRIMARY KEY IDENTITY,
    NomeProduto VARCHAR(100),
    Preco DECIMAL(10, 2)
);
GO

CREATE TABLE RegistroProdutos(
    RegistroID INT PRIMARY KEY IDENTITY,
    ProdutoAdicionadoID INT,
    Descricao VARCHAR(200),
    DataHora DATETIME
);
GO

-- Cria o trigger
CREATE TRIGGER trg_RegistrarNovoProduto  -- Define o nome do Trigger
ON Produtos                              -- Define a tabela onde o Trigger atua
AFTER INSERT                             -- Define o Momento (AFTER) e o Evento (INSERT)
AS
BEGIN -- Inicia a ação do Trigger

    INSERT INTO RegistroProdutos (ProdutoAdicionadoID, Descricao, DataHora)
    SELECT
        ProdutoID,                          -- Obtém o ID da tabela temporária 'inserted'
        'Novo produto adicionado',          -- Texto fixo para o log
        GETDATE()                           -- Função do SQL Server que retorna a data e hora atuais
    FROM
        inserted;

END; -- Finaliza a ação do Trigger
GO

-- Verifica as tabelas vazias
SELECT * FROM Produtos;
SELECT * FROM RegistroProdutos;
GO

-- Popula a tabela Produtos
INSERT INTO Produtos (NomeProduto, Preco) VALUES ('Notebook', 3500.00);
INSERT INTO Produtos (NomeProduto, Preco) VALUES ('Smartphone', 2200.00);
INSERT INTO Produtos (NomeProduto, Preco) VALUES ('Fones de Ouvido', 150.00);
GO

-- Verifica se a tabela RegistroProdutos foi automaticamente populada pelo trigger
SELECT * FROM Produtos;
SELECT * FROM RegistroProdutos;
GO
