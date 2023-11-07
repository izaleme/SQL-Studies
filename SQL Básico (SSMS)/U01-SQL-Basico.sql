/* ********************************************
***************** SQL BÁSICO ******************
******************************************** */

-- Tabelas usadas nos estudos
select * from Person.Person
select * from Person.EmailAddress
select * from Production.Product
select * from HumanResources.Employee
select * from Person.Address
select * from Production.WorkOrder
select * from Sales.SalesOrderDetail


-----------------------------------------------
-- Consultas simples  -------------------------

-- Nome e sobrenome dos clientes
select FirstName, LastName from person.person

-- Sobrenomes únicos dos clientes
select distinct LastName from person.Person


-----------------------------------------------
-- Consultas com COUNT ------------------------

-- Retorna somente as pessoas com title
select count(title) from Person.Person

-- Retorna somente as pessoas com title diferene
select count(distinct title) from Person.Person

-- Quantos produtos estão cadastrados no sistema?
select count(*) from Production.Product

-- Quantos tamanhos de produtos estão cadastrados no sistema?
select count(size) from Production.Product


-----------------------------------------------
-- BETWEEN, IN e LIKE -------------------------

select * from Production.Product
where ListPrice between 1000 and 1500

select * from Production.Product
where ListPrice not between 1000 and 1500

select * from HumanResources.Employee
where HireDate between '2009/01/01' and '2010/01/01'
order by HireDate

select * from Person.Person
where BusinessEntityID in (2,7,13)

select * from Person.Person
where BusinessEntityID not in (2,7,13)

select * from Person.Person
where FirstName like 'ovi%'	-- casos onde o nome começa com "ovi"

select * from Person.Person
where FirstName like '%to'	-- casos onde o nome termina com "to"

select * from Person.Person
where FirstName like '%essa%'	-- casos com "essa" no meio do nome

select * from Person.Person
where FirstName like '%ro_'		-- casos com apenas 1 caractere coringa após o "ro"


-----------------------------------------------
-- Funções de agregação: min, max, sum, avg ---
-- Combinam os dados de uma tabela em um único resultado

select top 10 * from Sales.SalesOrderDetail

select sum(linetotal) as Total
from Sales.SalesOrderDetail

select min(linetotal) as Minimo
from Sales.SalesOrderDetail

select max(linetotal) as Maximo
from Sales.SalesOrderDetail

select avg(linetotal) as Media
from Sales.SalesOrderDetail


------------------------------------------------
-- GROUP BY ------------------------------------
-- Divide o resultado da sua pesquisa em grupos
-- Para cada grupo é possível aplicar uma função de agregação, ex.: calcular a soma de itens

select * from Sales.SalesOrderDetail

select SpecialOfferID, sum(UnitPrice) as Soma
from Sales.SalesOrderDetail group by SpecialOfferID

select ProductID, count(ProductID) as contagem
from Sales.SalesOrderDetail
group by ProductID


------------------------------------------------
-- HAVING --------------------------------------
-- Usado para filtrar resultados de agrupamentos
select ProductID, sum(LineTotal) as Total
from sales.SalesOrderDetail
group by ProductID
having sum(LineTotal) between 162000 and 500000

select FirstName, count(FirstName) as qntde
from Person.Person
where Title = 'Mr.'
group by FirstName
having count(FirstName) > 10



/* ********************************************
*************** Exercícios ********************
******************************************** */

-- A equipe de produção precisa do nome de todas as peças que pesam mais que 500kg mas não mais que 700kg para inspeção
select Name from Production.Product
where Weight > 500 and Weight <= 700

-- Foi pedido pelo marketing uma relação de todos os empregados que são casados e assalariados
select * from HumanResources.Employee
where MaritalStatus = 'M'	-- M = married / S = single
and SalariedFlag = '1'	-- 1 = yes

-- Um usuário chamado Peter Krebs está devendo um pagamento, consiga o email dele para que possamos enviar uma cobrança!
select e.EmailAddress from person.Person p, person.EmailAddress e
where p.BusinessEntityID = e.BusinessEntityID
and p.FirstName = 'Peter'
and p.LastName = 'Krebs'

-- Obter o productID dos 10 produtos mais caros cadastrados no sistema, listando do mais caro para o mais barato
select top 10 ProductID from Production.Product		-- retorna os 10 primeiros registros da tabela
order by ListPrice desc

-- Quantos produtos temos cadastrados no sistema, que custam mais que 1500 dolares?
select count(*) from Production.Product
where ListPrice > 1500

-- Quantas pessoas temos com o sobrenome que inicia com a letra P?
select count(LastName) from Person.Person
where LastName like 'P%'

-- Em quantas cidades únicas estão cadastrados nossos clientes?
select count(distinct City) from Person.Address

-- Quais são as cidades únicas que temos cadastradas em nosso sistema?
select distinct City from Person.Address

-- Quantos produtos vermelhos tem preço entre 500 a 1000 dolares?
select count(*) from Production.Product
where color = 'red'
and ListPrice between 500 and 1000

-- Quantos produtos cadastrados tem a palavra 'road' no nome?
select count(*) from Production.Product
where Name like '%road%'

-- Quantos nomes de cada nome estão cadastrados no banco?
select FirstName, count(FirstName)
from Person.Person
group by FirstName

-- Quantas pessoas tem o mesmo middle name agrupadas pelo middle name?
select count(MiddleName) Quantidade, MiddleName
from Person.Person
group by MiddleName

-- Em média, qual é a quantidade de vendas de cada produto ?
select ProductID, avg(OrderQty) "Media de Vendas"
from sales.SalesOrderDetail
group by ProductID

-- Qual foram as 10 vendas que tiveram maior valor de venda por produto?
select top 10 ProductID, sum(LineTotal) from sales.SalesOrderDetail
group by ProductID
order by sum(LineTotal) desc

-- Quantos produtos e qual a quantidade media de produtos temos cadastrados na ordem de serviço?
select ProductId, count(ProductID) contagem, avg(StockedQty) media
from Production.WorkOrder
group by ProductID

-- Quais nomes no sistema tem uma ocorrência maior que 10 vezes?
select FirstName, count(FirstName) as qntde
from Person.Person
group by FirstName
having count(FirstName) > 10

-- Queremos identificar as provincias com o maior nº de cadastros no sistema, encontre as registradas no banco mais de 1000 vezes
select StateProvinceID, COUNT(StateProvinceID) Quantidade
from Person.Address
group by StateProvinceID
having count(StateProvinceID) > 1000

-- Os gerentes de uma multinacional querem saber quais produtos não estão trazendo em média no mínimo 1 milhão no total de vendas
select ProductID, avg(LineTotal) 'Média de Vendas'
from Sales.SalesOrderDetail
group by ProductID
having avg(LineTotal) < 1000000

