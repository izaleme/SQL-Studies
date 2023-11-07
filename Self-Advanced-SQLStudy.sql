-------------------------------------------------------------
----------------------- SQL Avan�ado ------------------------

-- FUN��ES --------------------------------------------------

-- NVL : substitui o retorno de um campo quando este for nulo
select nvl(punit, 0) from pcmov;

-- NVL2 : substitui o retorno de um campo, sendo ele nulo ou n�o
select nvl2(vpago, 0, 2) from pcprest; -- atribui 0 se N�O for nulo, e 2 se for nulo

-- COALESCE : verifica os valores da express�o e retorna o primeiro valor n�o nulo
select coalesce(vldesconto, vpago, valor) from pcprest;

-- DECODE : atribui um valor resposta para cada valor de condi��o estipulado
select numnota, decode(numnota, 100, 'CEM', 200, 'DUZENTOS', 300, 'TREZENTOS', 'NENHUM' resultado from pcmov;

-- CASE : determina a exibi��o do resultado a partir de condi��es especificadas dentro da fun��o
select numnota,
       case
         when numnota < 100 then 'MENOR QUE 100'
         when numnota between 101 and 200 then 'ENTRE 101 E 200'
         else 'MAIOR QUE 200'
       end "RESULTADO"
from pcmov;

-- LOWER : converte o resultado do campo em caracteres min�sculos
select matricula, lower(nome) from pcempr;

-- UPPER : converte o resultado do campo em caracteres mai�sculos
select matricula, upper(nome) from pcempr;

-- INITCAP : converte o resultado do campo para que as iniciais estejam em caracteres mai�sculos
select matricula, initcap(nome) from pcempr;

-- SUBSTR : extrai parte do conte�do do campo de acordo com os par�metros informados na fun��o, independente do tipo do campo (num�rico, texto ou data)
select matricula, substr(nome, 1, 5) from pcempr; -- exibe 5 caracteres, a partir do primeiro caractere

-- LENGTH : exibe o tamanho do valor que est� gravado no campo selecionado
select matricula, nome, length(nome) from pcempr;

-- REPLACE : substitui caracteres espec�ficos por outros
select matricula, nome, replace(nome, 'A', '*') from pcempr;

-- ROUND : arredonda n�meros para a quantidade de casas decimais determinada na fun��o
select codprod, numregiao, ptabela, round(otabela, 2) from pctabpr;

-- TRUNC : corta os n�meros para a quantidade de casas decimais determinada na fun��o
select codprod, numregiao, ptabela, trunc(ptabela, 2) from pctabpr;

-- MOD : exibe o resto da deivis�o de um valor por outro
select mod(valor, 2) from pcprest;


-- TRABALHANDO COM DATAS ------------------------------------

-- SYSDATE : retorna a data do sistema
select sysdate from dual;

-- Adicionando dias no sydate:
select sysdate + 2 from dual;

-- Substraindo dias no sysdate:
select sysdate - 2 from dual;

-- Diferen�a entre datas (em dias)
select numnota, dtsaida, dtentrega, dtentrega-dtsaida diferenca from pcnfsaid;

-- FUN��ES DE CONVERS�O -------------------------------------

-- NUMBER to VARCHAR
select dtmov, numnota, to_char(numnota, '000000') from pcmov;

-- DATE to VARCHAR
select dtmov, numnota, to_char(dtmov, 'dd/mm') from pcmov;

-- Elementos para formata��o de data:
   -- YYYY � ano completo em n�meros
   -- YEAR � ano escrito por extenso
   -- MM � m�s em dois d�gitos
   -- MONTH � m�s escrito por extenso
   -- MON � m�s escrito com as 3 primeiras letras iniciais
   -- DY � dia escrito com a abrevia��o em 3 letras
   -- DAY � dia escrito por extenso
   -- DD � dia em dois d�gitos
   -- D � dia da semana O c�digo abaixo de 1 a 7.
   -- DDD � dia do ano O c�digo abaixo de 1 a 356.
   -- WW � n�mero da semana dentro do ano
   -- W � n�mero da semana dentro do m�s
   

-- FUN��ES DE AGRUPAMENTO -----------------------------------

-- AVG : efetua o c�lculo de m�dia simples do campo informado
select avg(vltotal) from pcnfsaid;

-- COUNT : efetua a contagem do campo informado
select count(numnota) from pcnfsaid;

-- MAX : exibe o maior valor encontrado no campo informado
select max(vltotal) from pcnfsaid;

-- MIN : exibe o menor valor encontrado no campo informado
select min(vltotal) from pcnfsaid;

-- SUM : efetua a soma dos valores do campo informado
select sum(vltotal) from pcnfsaid;

-- GROUP BY : necess�ria sempre que dados "puros" forem usados junto de fun��es de agrupamento
select dtmov, codprod, sum(qt) from pcmov where codprod in (0,1)
group by codprod, dtmov;

-- HAVING : restringe as informa��es dos resultados de agrupamentos (como um where)
select codcli, sum(vltotal) from pcnfsaid
group by codcli having sum(vltotal) > 10000;


-------------------------------------------------------------
-- OUTROS: SUBSELECT
select * from pcprodut
where codprod not in (select distinct(codprod) from pcmov);









