-- Estudo realizado em Oracle

---------------------------------------------------

create table testes_exy(
         cod       number(4),
         nome      varchar(20),
         dtentrada date,
         dtsaida   date,
         salario   decimal(8,2),
         posicao   number(1)
);

select * from testes_exy order by cod;

---------------------------------------------------

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (1, 'Riko', '01/05/2010', '25/12/2023', 10000.00, 1);

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (2, 'Kevin', '01/05/2013', '25/12/2017', 10000.00, 1);

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (3, 'Jean', '01/05/2014', '25/12/2024', 1000.80, 2);

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (4, 'Neil', '16/12/2020', '29/12/2020', 100.00, 1);

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (5, 'Andrew', '01/10/2021', '09/10/2021', 50.00, 4);

insert into testes_exy (cod, nome, dtentrada, dtsaida, salario, posicao)
values (6, 'Iza', '01/01/2023', '01/01/2025', 10.00, 3);

commit;

---------------------------------------------------

select i.nome, i.dtentrada, i.dtsaida, i.dtsaida - i.dtentrada diff_dias
from testes_exy i order by i.dtentrada;

select count(cod) atletas from testes_exy;
select avg(salario) media_salario from testes_exy;
select min(salario) menor_salario from testes_exy;
select max(salario) maior_salario from testes_exy;
select sum(salario) soma_salarios from testes_exy;

select cod, nome, sum(salario) from testes_exy
group by cod, nome
having sum(salario) > 100
order by cod, nome;

---------------------------------------------------

select nome,
       decode(posicao, 1, 'ATACANTE',
                       2, 'MEIA',
                       3, 'DEFESA',
                       4, 'GOLEIRO',
                          'INDEFINIDO') as posicao
  from testes_exy;

---------------------------------------------------

update testes_exy set salario = 8000.0 where cod = 2; -- commit;

delete from testes_exy where cod = 6; -- commit;

-- drop table testes_exy;

