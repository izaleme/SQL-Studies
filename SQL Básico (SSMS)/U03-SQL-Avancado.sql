/* ********************************************
**************** SQL AVANÇADO *****************
******************************************** */

use Youtube;

-----------------------------------------------
-- MANIPULAÇÃOO DE TABELAS --------------------

/* ** TIPOS DE DADOS **
1. Booleanos (0 ou 1) --> bit
2. Caractere --> char para tamanhos fixos, varchar para tamanhos variáveis
3. Números --> numeric ou decimal são fixos porem permitem ser fracionados
4. Temporais --> date, datetime ou datetime2 (esse último vai até os milisegundos)
*/

/* ** CREATE TABLE **
* NOT NULL - Não permite nulos
* UNIQUE - Força que todos os valores em uma coluna sejam diferentes
* PRIMARY KEY - uma junção de not null e unique
* FOREIGN KEY - identifica unicamente uma linha em outra tabela
* CHECK - força uma condição específica em uma coluna
* DEFAULT - força um valor padrão quando nenhum valor é passado
*/

create table canal(
	canalID				int				primary key,
	nome				varchar(150)	not null,
	contagemInscritos	int				default 0,
	dataCriacao			datetime		not null
);

create table video(
	videoID			int				primary key,
	nome			varchar(150)	not null,
	visualizacoes	int				default 0,
	likes			int				default 0,
	dislikes		int				default 0,
	duracao			int				not null,
	canalID			int				foreign key references canal(canalID)
);

select * from canal;
select * from video;


/* ** INSERT, UPDATE, DELETE, ALTER TABLE

insert into nome_da_tabela (coluna1, coluna2, coluna3)
values (valor1, valor2, valor3);

update nome_da_tabela
set coluna1 = valor1,
	coluna2 = valor2
where condição;

alter table nome_da_tabela
acao

*/

create table aula(
id		int				primary key,
nome	varchar(200)
);

select * from aula;

-- insert com várias linhas
insert into aula(id, nome) values
(2, 'Aula 2'),
(3, 'Aula 3'),
(4, 'Aula 4');

-- cria uma tabela nova já setando os valores da tabela aula
select * into tabelaNova from aula;
select * from tabelaNova;

drop table aula;


/* **************** */
/* *** DESAFIOS *** */

create table exy(
id			int				primary key,
jogador		varchar(80)		not null,
posicao		varchar(50)		not null,
dtAdmissao	datetime		null
);

select * from exy;

insert into exy
values (2, 'Kevin', 'atacante', null);

insert into exy values
(3, 'Andrew', 'goleiro', '2019'),
(1, 'Dan', 'defesa', null),
(10, 'Neil', 'atacante', '2020');

create table jogadores(
id			int				primary key,
nome		varchar(80)		not null
);

select * from jogadores;

insert into jogadores values (8, 'Matt');

insert into exy (id, jogador, posicao)
select id, nome, 'defesa' from jogadores;

update exy set posicao = 'capitã'
where id = 1;

delete from exy where id = 8;

alter table exy
alter column posicao varchar(30) null;

insert into exy (id, jogador)
select id, nome from jogadores;

exec sp_rename 'exy.jogador', 'nomeJogador', 'column';	-- renomeia o nome da coluna

exec sp_rename 'jogadores', 'players'; -- renomeia o nome da tabela
select * from players;


---------------------------------------------------------------------------------------------------
-- CHECK CONSTRAINT só permite inserir dados que cumpram à norma da coluna

create table CarteiraMotorista(
	id			int				not null,
	nome		varchar(255)	not null,
	idade		int check (idade >= 18),
	codCNH		int not null unique		-- UNIQUE não permite dados duplicados na coluna
);

select * from CarteiraMotorista;

insert into CarteiraMotorista (id, nome, idade, codCNH) values (1, 'Iza', 15, 1) -- não insere pq idade < 18
insert into CarteiraMotorista (id, nome, idade, codCNH) values (1, 'Iza', 23, 1) -- insere pq idade > 18

insert into CarteiraMotorista (id, nome, idade, codCNH) values (1, 'Júlia', 27, 1) -- não insere pq já existe codCNH = 1


---------------------------------------------------------------------------------------------------
-- VIEWS extraem informações específicas de tabelas já existentes

use AdventureWorks2017

create view [Pessoas Simplificado] as
select FirstName, MiddleName, LastName
from Person.Person
where Title = 'Ms.'

select * from [Pessoas Simplificado]

