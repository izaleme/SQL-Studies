/* ********************************************
************** SQL INTERMEDIÁRIO **************
******************************************** */

use AdventureWorks2017;
use Northwind;

-- Tabelas usadas nos estudos
select top 10 * from Production.Product 
select top 10 * from Production.ProductSubcategory
select top 10 * from Person.Person
select top 10 * from Person.EmailAddress
select top 10 * from Person.PersonPhone
select top 10 * from Person.PhoneNumberType
select top 10 * from Person.Address
select top 10 * from Person.StateProvince
select top 10 * from Sales.SalesOrderHeader

-----------------------------------------------
-- INNER JOIN ---------------------------------

-- Dados do cliente e email
select p.BusinessEntityID, p.FirstName, p.LastName, pe.EmailAddress
from Person.Person as p
inner join Person.EmailAddress pe on p.BusinessEntityID = pe.BusinessEntityID

-- Nomes dos produtos e informações de suas subcategorias
select p.ListPrice, p.Name, s.Name
from Production.Product p
inner join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID

-----------------------------------------------
-- OUTER JOINS --------------------------------

-- Left Join
select * from Person.Person pp
left join Sales.PersonCreditCard pc
on pp.BusinessEntityID = pc.BusinessEntityID
where pc.BusinessEntityID is null

-----------------------------------------------
-- UNION --------------------------------------

-- Union exclui dados duplicados, Union all seleciona todos (incluindo os duplicados)
select FirstName, MiddleName, Title
from Person.Person
where Title = 'Mr.'
UNION
select FirstName, MiddleName, Title
from Person.Person
where MiddleName = 'A'

-----------------------------------------------
-- SELF JOIN ----------------------------------
-- Agrupa dados dentro de uma mesma tabela (obrigatório o uso de as)
use Northwind;

-- Trás os contatos que estão na mesma região
select a.ContactName, a.Region, b.ContactName, b.Region
from Customers a, Customers b
where a.Region = b.Region

-- Trás o nome e a dt de contratação dos funcionários que foram contratados no mesmo ano
select a.FirstName, a.HireDate, b.FirstName, b.HireDate
from Employees a, Employees b
where datepart(year, a.HireDate) = DATEPART(year, b.HireDate)

-----------------------------------------------
-- SUBQUERY/SUBSELECT -------------------------

-- Seleciona os produtos cujo preço é maior que a média
select *
from Production.Product 
where ListPrice > (select AVG(ListPrice) from Production.Product)

-----------------------------------------------
-- DATEPART -----------------------------------

-- Média de vendas por ano
select avg(TotalDue) Media, datepart(year, OrderDate) as Ano
from Sales.SalesOrderHeader
group by DATEPART(year, OrderDate)
order by ano

-----------------------------------------------
-- OPERAÇÕES COM STRING -----------------------

-- Concatena o nome e sobrenome
select CONCAT(FirstName, ' ', LastName)
from Person.Person

-- Conta quantos caracteres o firstname tem
select FirstName, len(FirstName)
from Person.Person

-- Substring corta strings
select FirstName, SUBSTRING(FirstName, 1, 3) -- tira 3 letras a partir da primeira letra
from Person.Person

-- Replace substitui caracteres
select ProductNumber, REPLACE(ProductNumber, '-', '##')
from Production.Product

-----------------------------------------------
-- OPERAÇÕES MATEMÁTICAS ----------------------

-- Round arredonda em até x casas decimais
select ROUND(LineTotal, 2)
from Sales.SalesOrderDetail

-- SQRT é raiz quadrada
select SQRT(LineTotal)
from Sales.SalesOrderDetail



/* ********************************************
*************** Exercícios ********************
******************************************** */

-- Inner join para trazer os dados de telefone da pessoa
select pe.BusinessEntityID, ph.Name, ph.PhoneNumberTypeID, pe.PhoneNumber
from Person.PersonPhone pe
inner join person.PhoneNumberType ph on pe.PhoneNumberTypeID = ph.PhoneNumberTypeID

-- Inner join para trazer os dados de endereço da pessoa
select a.AddressID, a.City, a.StateProvinceID, p.Name
from Person.StateProvince  p 
inner join person.Address a on p.StateProvinceID = a.StateProvinceID

