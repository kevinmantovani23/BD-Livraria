CREATE DATABASE Livraria

CREATE TABLE livro(
codigo		INT				NOT NULL	IDENTITY(2351, 1),
nome		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)	 	DEFAULT('PT-BR'),
ano			DATETIME		NOT NULL	CHECK(ano >= 1990)
PRIMARY KEY(codigo)
)


CREATE TABLE autor(
id_autor		INT				NOT NULL	IDENTITY(100001, 100),
nome			VARCHAR(100)	NOT NULL	UNIQUE,
data_nasc		DATETIME		NOT NULL,
pais_nasc		VARCHAR(50)		NOT NULL	
					CHECK(pais_nasc = 'Brasil' OR pais_nasc = 'Estados Unidos' OR 
						pais_nasc = 'Inglaterra' OR pais_nasc = 'Alemanha'),
biografia		VARCHAR(255)	NOT NULL
PRIMARY KEY(id_autor)
)

CREATE TABLE editora(
id_editora				INT				NOT NULL	IDENTITY(491, 16),
nome					VARCHAR(70)		NOT NULL	UNIQUE,
telefone				VARCHAR(11)		NOT NULL	CHECK(LEN(telefone) = 10),
logradouro_endereco		VARCHAR(200)	NOT NULL,
numero_endereco			INT				NOT NULL	CHECK(numero_endereco >= 0),
cep_endereco			CHAR(8)			NOT NULL	CHECK(LEN(cep_endereco) = 8),
complemento_endereco	VARCHAR(255)
PRIMARY KEY(id_editora)
)


CREATE TABLE edicao(
isbn			CHAR(13)		NOT NULL    CHECK(LEN(isbn) = 13),
preco			DECIMAL(4,2)	NOT NULL	CHECK(preco >= 0),
ano				INT				NOT NULL	CHECK(ano >= 1993),
numero_paginas	INT				NOT NULL	CHECK(numero_paginas >= 15),
qtd_estoque		INT				NOT NULL,
PRIMARY KEY(isbn)
)

CREATE TABLE livro_autor(
livroCodigo		INT		NOT NULL,
autorID_autor	INT		NOT NULL,
FOREIGN KEY (livroCodigo) REFERENCES livro(codigo),
FOREIGN KEY(autorID_autor) REFERENCES autor(id_autor),
PRIMARY KEY(livroCodigo, autorID_autor)
)

CREATE TABLE editora_edicao_livro(
editoraID_editora		INT			NOT NULL,
edicaoISBN				CHAR(13)	NOT NULL,
livroCodigo				INT			NOT NULL,
	
FOREIGN KEY (editoraID_editora) REFERENCES editora(id_editora),
FOREIGN KEY(edicaoISBN) REFERENCES edicao(isbn),
FOREIGN KEY(livroCodigo) REFERENCES	livro(codigo),
PRIMARY KEY(livroCodigo, editoraID_editora, edicaoISBN)
)

EXEC sp_help livro
EXEC sp_help autor
EXEC sp_help editora
EXEC sp_help edicao
EXEC sp_help livro_autor
EXEC sp_help editora_edicao_livro