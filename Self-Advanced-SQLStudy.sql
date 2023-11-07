-------------------------------------------------------------
----------------------- SQL Avançado ------------------------

-- FUNÇÕES --------------------------------------------------

-- NVL : substitui o retorno de um campo quando este for nulo
select nvl(punit, 0) from pcmov;

-- NVL2 : substitui o retorno de um campo, sendo ele nulo ou não
select nvl2(vpago, 0, 2) from pcprest; -- atribui 0 se NÃO for nulo, e 2 se for nulo

-- COALESCE : verifica os valores da expressão e retorna o primeiro valor não nulo
select coalesce(vldesconto, vpago, valor) from pcprest;

-- DECODE : atribui um valor resposta para cada valor de condição estipulado
select numnota, decode(numnota, 100, 'CEM', 200, 'DUZENTOS', 300, 'TREZENTOS', 'NENHUM' resultado from pcmov;

-- CASE : determina a exibição do resultado a partir de condições especificadas dentro da função
select numnota,
       case
         when numnota < 100 then 'MENOR QUE 100'
         when numnota between 101 and 200 then 'ENTRE 101 E 200'
         else 'MAIOR QUE 200'
       end "RESULTADO"
from pcmov;

-- LOWER : converte o resultado do campo em caracteres minúsculos
select matricula, lower(nome) from pcempr;

-- UPPER : converte o resultado do campo em caracteres maiúsculos
select matricula, upper(nome) from pcempr;

-- INITCAP : converte o resultado do campo para que as iniciais estejam em caracteres maiúsculos
select matricula, initcap(nome) from pcempr;

-- SUBSTR : extrai parte do conteúdo do campo de acordo com os parâmetros informados na função, independente do tipo do campo (numérico, texto ou data)
select matricula, substr(nome, 1, 5) from pcempr; -- exibe 5 caracteres, a partir do primeiro caractere

-- LENGTH : exibe o tamanho do valor que está gravado no campo selecionado
select matricula, nome, length(nome) from pcempr;

-- REPLACE : substitui caracteres específicos por outros
select matricula, nome, replace(nome, 'A', '*') from pcempr;

-- ROUND : arredonda números para a quantidade de casas decimais determinada na função
select codprod, numregiao, ptabela, round(otabela, 2) from pctabpr;

-- TRUNC : corta os números para a quantidade de casas decimais determinada na função
select codprod, numregiao, ptabela, trunc(ptabela, 2) from pctabpr;

-- MOD : exibe o resto da deivisão de um valor por outro
select mod(valor, 2) from pcprest;


-- TRABALHANDO COM DATAS ------------------------------------

-- SYSDATE : retorna a data do sistema
select sysdate from dual;

-- Adicionando dias no sydate:
select sysdate + 2 from dual;

-- Substraindo dias no sysdate:
select sysdate - 2 from dual;

-- Diferença entre datas (em dias)
select numnota, dtsaida, dtentrega, dtentrega-dtsaida diferenca from pcnfsaid;

-- FUNÇÕES DE CONVERSÃO -------------------------------------

-- NUMBER to VARCHAR
select dtmov, numnota, to_char(numnota, '000000') from pcmov;

-- DATE to VARCHAR
select dtmov, numnota, to_char(dtmov, 'dd/mm') from pcmov;

-- Elementos para formatação de data:
   -- YYYY é ano completo em números
   -- YEAR é ano escrito por extenso
   -- MM é mês em dois dígitos
   -- MONTH é mês escrito por extenso
   -- MON é mês escrito com as 3 primeiras letras iniciais
   -- DY é dia escrito com a abreviação em 3 letras
   -- DAY é dia escrito por extenso
   -- DD é dia em dois dígitos
   -- D é dia da semana O código abaixo de 1 a 7.
   -- DDD é dia do ano O código abaixo de 1 a 356.
   -- WW é número da semana dentro do ano
   -- W é número da semana dentro do mês
   

-- FUNÇÕES DE AGRUPAMENTO -----------------------------------

-- AVG : efetua o cálculo de média simples do campo informado
select avg(vltotal) from pcnfsaid;

-- COUNT : efetua a contagem do campo informado
select count(numnota) from pcnfsaid;

-- MAX : exibe o maior valor encontrado no campo informado
select max(vltotal) from pcnfsaid;

-- MIN : exibe o menor valor encontrado no campo informado
select min(vltotal) from pcnfsaid;

-- SUM : efetua a soma dos valores do campo informado
select sum(vltotal) from pcnfsaid;

-- GROUP BY : necessária sempre que dados "puros" forem usados junto de funções de agrupamento
select dtmov, codprod, sum(qt) from pcmov where codprod in (0,1)
group by codprod, dtmov;

-- HAVING : restringe as informações dos resultados de agrupamentos (como um where)
select codcli, sum(vltotal) from pcnfsaid
group by codcli having sum(vltotal) > 10000;


-------------------------------------------------------------
-- OUTROS: SUBSELECT
select * from pcprodut
where codprod not in (select distinct(codprod) from pcmov);









