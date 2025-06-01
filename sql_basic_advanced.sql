-- PARA QUE SERVE
-- Serve para remover linhas duplicadas e mostrar apenas linhas distintas
-- Muito usado na etapa de exploração das bases 
-- SINTAXE 
select distinct coluna_1, coluna_2, coluna_3
from schema_1.tabela_1


-- EXEMPLOS 

-- (Exemplo 1) Seleção de uma coluna sem DISTINCT
-- Liste as marcas de carro que constam na tabela products

select brand from sales.products


-- (Exemplo 2) Seleção de uma coluna com DISTINCT
-- Liste as marcas de carro distintas que constam na tabela products
select distinct brand from sales.products

-- (Exemplo 3) Seleção de mais de uma coluna com DISTINCT
-- Liste as marcas e anos de modelo distintos que constam na tabela products
select distinct brand, model_year from sales.products

-- (1) Comando usado para remover linhas duplicadas e mostrar apenas linhas distintas
-- (2) Muito utilizado na etapa de exploração dos dados
-- (3) Caso mais de uma coluna seja selecionada, o comando SELECT DISTINCT irá 
-- retornar todas as combinações distintas.


-- Where
select distinct state from sales.customers

Select first_name, state, birth_date
from sales.customers where (state = 'SC' or state= 'MS')
and birth_date < '1991-12-28'
-- a data de nascimento é mais antiga que a data de 34 anos atras

select distinct birth_date from sales.customers

select * from sales.products 
order by price asc

--Order by
select distinct state from sales.customers
order by state asc

select * from sales.products order by 
price desc 
limit 10 

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)

select * from sales.customers limit 10



select distinct city from sales.customers where state = 'MG' 
order by city asc



-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)

select visit_id, paid_date from sales.funnel
where paid_date is not null
order by paid_date desc
limit 10

-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)

select * from sales.customers where birth_date >= '2000-01-01' 
order by score desc 
limit 10



-- Operadores

 Select * from sales.customers
 limit 10

 --Calular idade cliente hoje

select email,
birth_date,
(current_date - birth_date) / 365  as "age cliente"
 from sales.customers

 
select email,
birth_date,
(current_date - birth_date) / 365  as "age cliente"
 from sales.customers order by "age cliente" asc

-- soma de string
select first_name || ' ' || last_name as nome_completo from sales.customers

-- Operadores de comparação
select first_name, professional_status,
(professional_status = 'clt') as cliente_clt,
case when professional_status = 'clt' then 1 else 0 end as flag_clt
from sales.customers


-- Operadores
-- AND
-- OR
-- NOT
-- BETWEEN
-- IN
-- LIKE
-- ILIKE
-- IS NULL


-- EXEMPLOS ########################################################################

-- (Exemplo 1) Uso do comando BETWEEN 
-- Selecione veículos que custam entre 100k e 200k na tabela products
select *
from sales.products
where price >= 100000 and price <= 200000

select * from  sales.products
where price between 100000 and 200000




-- (Exemplo 2)  Uso do comando NOT
-- Selecione veículos que custam abaixo de 100k ou acima 200k 
select *
from sales.products
where price < 100000 or price > 200000

select * from sales.products
where price not between 100000 and 200000

-- (Exemplo 3) Uso do comando IN
-- Selecionar produtos que sejam da marca HONDA, TOYOTA ou RENAULT
select *
from sales.products
where brand = 'HONDA' or brand = 'TOYOTA' or brand = 'RENAULT'


select *
from sales.products
where brand not in('HONDA','TOYOTA','RENAULT')




-- (Exemplo 4) Uso do comando LIKE (matchs imperfeitos)
-- Selecione os primeiros nomes distintos da tabela customers que começam
-- com as iniciais ANA
select distinct first_name
from sales.customers
where first_name = 'ANA'

select distinct first_name
from sales.customers
where first_name like 'ANA%'

select distinct first_name
from sales.customers
where first_name like '%ANA'

-- (Exemplo 5) Uso do comando ILIKE (ignora letras maiúsculas e minúsculas)
-- Selecione os primeiros nomes distintos com iniciais 'ana'
select distinct first_name
from sales.customers
where first_name ilike 'ana%'


-- (Exemplo 6) Uso do comando IS NULL
-- Selecionar apenas as linhas que contém nulo no campo "population" na tabela
-- temp_tables.regions
select *
from temp_tables.regions
where population = null

select *
from temp_tables.regions
where population is null

-- RESUMO ##########################################################################
-- (1) Usados para unir expressões simples em uma composta
-- (2) AND: Verifica se duas comparações são simultaneamente verdadeiras
-- (3) OR: Verifica se uma ou outra comparação é verdadeiras
-- (4) BETWEEN: Verifica quais valores estão dentro do range definido
-- (5) IN: Funciona como multiplos ORs
-- (6) LIKE e ILIKE: Comparam textos e são sempre utilizados em conjunto com o 
-- operador %, que funciona como um coringa, indicando que qualquer texto pode 
-- aparecer no lugar do campo
-- (7) ILIKE ignora se o campo tem letras maiúsculas ou minúsculas na comparação
-- (8) IS NULL: Verifica se o campo é nulo
-- (9) Utilize o Guia de comandos para consultar os operadores utilizados no SQL

-- (Exercício 1) Calcule quantos salários mínimos ganha cada cliente da tabela 
-- sales.customers. Selecione as colunas de: email, income e a coluna calculada "salários mínimos"
-- Considere o salário mínimo igual à R$1200

select * from sales.customers

select email, income, 
(income / 1200) as qtd_salario_minimo
from sales.customers

-- (Exercício 2) Na query anterior acrescente uma coluna informando TRUE se o cliente
-- ganha acima de 5 salários mínimos e FALSE se ganha 4 salários ou menos.
-- Chame a nova coluna de "acima de 4 salários"

select email, income, 
(income / 1200) as qtd_salario_minimo,
(income / 1200) >= 5 as acima_4_salarios
from sales.customers

select email, income, 
(income / 1200) as qtd_salario_minimo,
case when (income / 1200) >= 5 then 1 else 0 end as acima_4_salarios
from sales.customers


-- (Exercício 3) Na query anterior filtre apenas os clientes que ganham entre
-- 4 e 5 salários mínimos. Utilize o comando BETWEEN

select email, income, 
(income / 1200) as qtd_salario_minimo,
from sales.customers
where (income / 1200) between 4 and 5 

-- (Exercício 4) Selecine o email, cidade e estado dos clientes que moram no estado de 
-- Minas Gerais e Mato Grosso. 

select email, city, state from sales.customers where state in('MG', 'MT')

-- (Exercício 5) Selecine o email, cidade e estado dos clientes que não 
-- moram no estado de São Paulo.


select email, city, state from sales.customers where state not in('SP')

-- (Exercício 6) Selecine os nomes das cidade que começam com a letra Z.
-- Dados da tabela temp_table.regions

select city from temp_tables.regions where city ilike 'z%'

select count(*) from sales.funnel -- visitas ao nosso site 30580

select * from sales.funnel 

select count(paid_date) from sales.funnel 3788 --ignora os nulos

-- quantos produtos distintos foram visitados no mes de janeiro
select count( distinct product_id) from sales.funnel 
where visit_page_date between '2021-01-01' and '2021-01-31'


select * from sales.product

select max(price), min(price), avg(price) from sales.products

select max(price) from sales.products

select * from sales.products
where price = (select max(price) from sales.products)


-- comando group by

select state, count(*) as vol from sales.customers 
group by state order by vol desc


select state, professional_status, 
count(*) as vol from sales.customers 
group by state, professional_status 
order by state, vol desc

select distinct state
from sales.customers
group by state
-- gorup by sozinho e igual um distinct, elimina linhas duplicadas

- (Exemplo 1) seleção com filtro no HAVING 
-- Calcule o nº de clientes por estado filtrando apenas
--estados acima de 100 clientes exceto MG
select 
    state, 
    count(*) as vol
from sales.customers
where state <> 'MG'
group by state
having count(*) > 100

-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados 
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas

 --(Exercício 1) Conte quantos clientes da tabela sales.customers 
--tem menos de 30 anos

select count(*) as vol from sales.customers 
where (current_date - birth_date) / 365 <= 30


-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers
select birth_date, (current_date - birth_date) / 365 as age from sales.customers
where birth_date = (select max(birth_date) from sales.customers)

select max(current_date - birth_date) / 365 as old,
min(current_date - birth_date) / 365 as young from sales.customers


-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)

select * from sales.customers

select * from sales.customers where income = (select max(income) from sales.customers)

-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca

select * from sales.products

select distinct brand, count(*) as vol
from sales.products
group by brand
order by brand asc

-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pela nome da marca e pelo ano do veículo

select distinct brand, model_year, count(*) as vol
from sales.products
group by brand, model_year
order by brand, model_year asc

-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados

select distinct brand, count(*) as vol
from sales.products
group by brand
having count(*) > 10



-- SINTAXE #########################################################################
select t1.coluna_1, t1.coluna_1, t2.coluna_1, t2.coluna_2
from schema.tabela_1 as t1
ALGUM join schema.tabela_2 as t2
    on condição_de_join


-- EXEMPLOS

-- (Exemplo 1) Utilize o LEFT JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select a.cpf, a.name, b.state
from temp_tables.tabela_1 as a 
left join  temp_tables.tabela_2 as b
on a.cpf = b.cpf

-- (Exemplo 2) Utilize o INNER JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2

select a.cpf, a.name, b.state
from temp_tables.tabela_1 as a 
inner join  temp_tables.tabela_2 as b
on a.cpf = b.cpf

-- (Exemplo 3) Utilize o RIGHT JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2

select b.cpf, a.name, b.state
from temp_tables.tabela_1 as a 
right join  temp_tables.tabela_2 as b
on a.cpf = b.cpf

-- (Exemplo 4) Utilize o FULL JOIN para fazer join entre as tabelas
-- temp_tables.tabela_1 e temp_tables.tabela_2
select a.cpf, a.name, b.state
from temp_tables.tabela_1 as a 
full join  temp_tables.tabela_2 as b
on a.cpf = b.cpf

-- RESUMO
-- (1) Servem para combinar colunas de uma ou mais tabelas
-- (2) Pode-se chamar todas as colunas com o asterisco (*), mas não é recomendado
-- (3) É uma boa prática criar aliases para nomear as tabelas utilizadas 
-- (4) O JOIN sozinho funciona como INNER JOIN


-- EXERCÍCIOS
-- (Exemplo 1) Identifique qual é o status profissional
--mais frequente nos clientes 
-- que compraram automóveis no site

select a.professional_status ,count(b.paid_date) as vol_pg
from sales.customers as a
left join sales.funnel as b 
on a.customer_id = b.customer_id
group by 1
order by vol_pg desc


-- (Exemplo 2) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
select * from temp_tables.ibge_genders limit 10
select * from sales.customers

select c.gender,count(a.paid_date) as vol_pg
from  sales.funnel as a
 left join sales.customers as b
on a.customer_id = b.customer_id
left join temp_tables.ibge_genders as c
on lower(b.first_name) = c.first_name
group by  c.gender


-- (Exemplo 3) Identifique de quais regiões 
--são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
select * from sales.customers limit 10
select * from temp_tables.regions limit 10


select r.region, count(a.visit_page_date) as visitas
from sales.funnel as a
left join sales.customers as c
on a.customer_id = c.customer_id
left join temp_tables.regions as r
on upper(c.city) = upper(r.city) and upper(c.state) = upper(r.state)
group by r.region
order by visitas desc

-- deixei maiusculo os dados - 

-- Ientifique as marcas de veiculos mais visitadas
--na tabela sales.funnel

select * from sales.funnel

select * from sales.products

select brand, count(visit_page_date) as visitas
from sales.funnel as a
left join sales.products as b
on a.product_id = b.product_id
group by brand
order by visitas desc

--- identifique as lojas de veiculos mais visitas na tabela sales.funnel

select store_name, count(visit_page_date) as visitas
from sales.funnel as a
left join sales.stores as b
on a.store_id = b.store_id
group by store_name
order by visitas desc
limit 10 

-- Identifique quantos clientes moram em cada tamanho 
--de cidade 
--o porte da tabela consta na coluna size da
--temp_tables.regions

select b.size, count(*) as qtd_clientes
from sales.customers as a
left join temp_tables.regions as b
on lower(a.city) = lower(b.city) and
lower(a.state) = lower(b.state) 
group by b.size
order by qtd_clientes desc 


-- Comando union
--- colar uma tabela na outra
-- entre tabelas com mesma qtd de coluna e mesmo tipo de unidade


-- union all não remove linhas duplicadas
-- union - remove duplicadas

select * from sales.products 
union all
select * from temp_tables.products_2


--Subquery
-- TIPOS 
-- Subquery no WHERE
-- Subquery com WITH
-- Subquery no FROM
-- Subquery no SELECT
-- Usar o resultado de uma query dentro de outra query 
-- EXEMPLOS 

-- (Exemplo 1) Subquery no WHERE
-- Informe qual é o veículo mais barato da tabela products

select * from sales.products 
where price = (select min(price) from sales.products)

-- subquery so funciona com um valor, apenas minimo preço

-- (Exemplo 2) Subquery com WITH
-- Calcule a idade média dos clientes por status profissional

with tabela1 as(
select professional_status, 
(current_date - birth_date)/365 as idade
from sales.customers
)
-- usaremos o resultado da subquery, na próxima query

select professional_status, 
avg(idade)as idade_media
from tabela1
group by professional_status;

-- (Exemplo 3) Subquery no FROM
-- Calcule a média de idades dos clientes por status profissional

select professional_status, 
avg(idade) as idade_media
from (
select professional_status, 
(current_date - birth_date)/365 as idade
from sales.customers) as tabela1
group by professional_status;


-- (Exemplo 4) Subquery no SELECT
-- Na tabela sales.funnel crie uma coluna que informe o nº de visitas acumuladas 
-- que a loja visitada recebeu até o momento


select 
a.visit_id,
a.visit_page_date,
b.store_name,
(
select count(*)
from sales.funnel as z
where z.visit_page_date <= a.visit_page_date
and z.store_id = a.store_id
)
from sales.funnel as a
left join sales.stores as b
on a.store_id = b.store_id
order by b.store_name, a.visit_page_date

-- (1) Servem para consultar dados de outras consultas.
-- (2) Para que as subqueries no WHERE e no SELECT funcionem, elas devem retornar 
-- apenas um único valor
-- (3) Não é recomendado utilizar subqueries diretamente dentro do FROM pois isso 
-- dificulta a legibilidade da query. 

-- EXEMPLOS 

-- (Exemplo 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1ª visita e demais visitas



with first_visit as(
select customer_id, min(visit_page_date) as visita_1
from sales.funnel
group by customer_id -- informaçao da primeira visita de cada cliente
)

select a.visit_page_date,
(a.visit_page_date <> first_visit.visita_1) as lead_recorrente,
count (*) as qtd
from sales.funnel as a
left join first_visit
on a.customer_id = first_visit.customer_id
group by 1,2
order by a.visit_page_date desc

-- (Exemplo 2) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou abaixo do preço médio dos veículos daquela marca 
-- (levar em consideração o desconto dado no veículo)

with precomedio as(
 select brand, avg(price) as preco_medio_brand
from sales.products
group by brand --preço medio dos veiculos da marca
)

select a.visit_id,
a.visit_page_date,
b.brand,
(b.price *(1+a.discount)) as price_final, --desconto aplicado
c.preco_medio_brand,
((b.price *(1+a.discount)) - c.preco_medio_brand) as preco_vs_media
from sales.funnel as a
left join sales.products as b
on a.product_id = b.product_id
left join precomedio as c
on b.brand = c.brand

-- (Exercício 1) Crie uma coluna calculada com o número de visitas realizadas por cada
-- cliente da tabela sales.customers

with qtdvisits as(
select customer_id, count(visit_page_date) as visita_qtd
from sales.funnel
group by customer_id -- informaçao da primeira visita de cada cliente
)

select 
a.*, 
(a.first_name || ' ' ||  a.last_name) as nomecompleto,
b.visita_qtd
from sales.customers as a
left join qtdvisits as b
on a.customer_id = b.customer_id
order by b.visita_qtd desc



-- TIPOS DE CONVERSÃO
-- Operador ::
-- CAST

-- EXEMPLOS

-- (Exemplo 1) Conversão de texto em data
-- Corrija a query abaixo utilizando o operador ::


select '2021-10-01'::date - '2021-02-01':: date

select  nomecoluna::date
from tbl



-- (Exemplo 2) Conversão de texto em número
-- Corrija a query abaixo utilizando o operador ::
select '100'::numeric - '10'::numeric


-- (Exemplo 3) Conversão de número em texto
-- Corrija a query abaixo utilizando o operador ::
select replace(112122::text,'1','A')


-- (Exemplo 4) Conversão de texto em data
-- Corrija a query abaixo utilizando a função CAST
select cast('2021-10-01' as date) - cast('2021-02-01' as date)


-- RESUMO 
-- (1) O operador :: e o CAST() são funções utilizadas para converter um dado para 
-- a unidade desejada. 
-- (2) O operador :: é mais "clean", porém, em algumas ocasiões não funciona, sendo
-- necessário utilizar a função CAST()
-- (3) Use o Guia de comandos para consultar a lista de unidades mais utilizadas

-- TIPOS
-- CASE WHEN
-- COALESCE()


-- EXEMPLOS

-- (Exemplo 1) Agrupamento de dados com CASE WHEN
-- Calcule o nº de clientes que ganham abaixo de 5k, entre 5k e 10k, entre 10k e 
-- 15k e acima de 15k

select * from sales.customers


with faixa_renda as(
select income, 
case when income < 5000 then '-5k'
 when income >= 5000 and income < 10000 then '5 a 10k'
  when income >= 10000 and income < 15000 then '10 a 15k'
  else '+15k'
  end as faixarend
  from sales.customers 
)

select count(*) as qtd, faixarend
from faixa_renda
group by faixarend
order by qtd desc


-- (Exemplo 2) Tratamento de dados nulos com COALESCE
-- Crie uma coluna chamada populacao_ajustada na tabela temp_tables.regions e
-- preencha com os dados da coluna population, mas caso esse campo estiver nulo, 
-- preencha com a população média (geral) das cidades do Brasil



select *,
case when population is not null then population
else (select avg(population) from temp_tables.regions)
end as population_ajustada
from temp_tables.regions 

-- usando coalesce
select *,
coalesce(population, (select avg(population) from temp_tables.regions)) as population_ajustada
from temp_tables.regions
where population is null


-- (1) CASE WHEN é o comando utilizado para criar respostas específicas para 
-- diferentes condições e é muito utilizado para fazer agrupamento de dados
-- (2) COALESCE é o comando utilizado para preencher campos nulos com o primeiro
-- valor não nulo de uma sequência de valores.


-- LOWER()
-- UPPER()
-- TRIM()
-- REPLACE()

-- EXEMPLOS

-- (Exemplo 1) Corrija o primeiro elemento das queries abaixo utilizando os comandos 
-- de tratamento de texto para que o resultado seja sempre TRUE 

select upper('São Paulo') = 'SÃO PAULO'


select lower('São Paulo') = 'são paulo'


select trim('SÃO PAULO     ') = 'SÃO PAULO'


select replace('SAO PAULO', 'AO', 'ÃO') = 'SÃO PAULO'



-- Tratamento de Datas 


-- (Exemplo 1) Soma de datas utilizando INTERVAL
-- Calcule a data de hoje mais 10 unidades (dias, semanas, meses, horas)
--utilizado para somar datas na unidade desejada, default é dias

select current_date + 10

select (current_date + INTERVAL'10 WEEKS')::DATE

select (current_date + INTERVAL'22 MONTHS')::DATE

select (current_date + INTERVAL'22 HOURS')

-- (Exemplo 2) Truncagem de datas utilizando DATE_TRUNC
-- Calcule quantas visitas ocorreram por mês no site da empresa

select visit_page_date, count(*)
from sales.funnel
group by visit_page_date
order by visit_page_date desc

select DATE_TRUNC('month', VISIT_PAGE_DATE)::DATE AS VISIT_PAGE_MONTH,
COUNT(*) AS QTD
from sales.funnel
GROUP BY VISIT_PAGE_MONTH

select DATE_TRUNC('year', VISIT_PAGE_DATE)::DATE AS VISIT_PAGE_year,
COUNT(*) AS QTD
from sales.funnel
GROUP BY VISIT_PAGE_year
-- AS DATAS SERÃO CONVERTIDAS PARA O PRIMEIRO DIA DE CADA MES


-- (Exemplo 3) Extração de unidades de uma data utilizando EXTRACT
-- Calcule qual é o dia da semana que mais recebe visitas ao site

select
	current_date::date,
	extract('dow' from current_date::date)


select extract('dow' from visit_page_date) as dayweek,
count(*) as qtd
from sales.funnel 
group  by dayweek
order by dayweek
-- dow significa day of the week
	

-- (Exemplo 4) Diferença entre datas com operador de subtração (-) 
-- Calcule a diferença entre hoje e '2018-06-01', em dias, semanas, meses e anos.

select (current_date - '2003-11-04')

select (current_date - '2003-11-04')/7

select (current_date - '2003-11-04')/30

select (current_date - '2003-11-04')/365


select datediff('weeks', current_date, '2025-11-04')


-- RESUMO
-- (1) O comando INTERVAL é utilizado para somar datas na unidade desejada. Caso a 
-- unidade não seja informada, o SQL irá entender que a soma foi feita em dias.
-- (2) O comando DATE_TRUNC é utilizado para truncar uma data no início do período
-- (3) O comando EXTRACT é utilizado para extrair unidades de uma data/timestamp
-- (4) O cálculo da diferença entre datas com o operador de subtração (-) retorna  
-- valores em dias. Para calcular a diferença entre datas em outra unidade é necessário
-- fazer uma transformação de unidades (ou criar uma função para isso)
-- (5) Utilize o Guia de comandos para consultar as unidades de data e hora utilizadas 
-- no SQL


-- Funcoes
-- PARA QUE SERVEM
-- Servem para criar comandos personalizados de scripts usados recorrentemente.


-- EXEMPLOS 
-- (Exemplo 1) Crie uma função chamada DATEDIFF para calcular a diferença entre
-- duas datas em dias, semanas, meses, anos

create function datediff(unidade varchar, data_inicial date, data_final date)
returns integer 
language sql 
as
$$ 
select 
case when unidade in('day', 'days', 'd') then
 (data_final - data_inicial)
when unidade in('week', 'weeks', 'w') then 
(data_final - data_inicial)/7
when unidade in('month', 'months', 'm') then 
(data_final - data_inicial)/30
when unidade in('year', 'years', 'y') then 
(data_final - data_inicial)/365
end as diferenca
$$

select datediff('d', '2024-11-04', current_date)



-- (Exemplo 2) Delete a função DATEDIFF criada no exercício anterior

drop function datediff


-- RESUMO
-- (1) Para criar funções, utiliza-se o comando CREATE FUNCTION
-- (2) Para que o comando funcione é obrigatório informar (a) quais as unidades dos 
-- INPUTS (b) quais as unidades dos OUTPUTS e (c) em qual linguagem a função será escrita
-- (3) O script da função deve estar delimitado por $$
-- (4) Para deletar uma função utiliza-se o comando DROP FUNCTION





-- Criação de tabela a partir de uma query
-- Criação de tabela a partir do zero
-- Deleção de tabelas
-- (Exemplo 1) Criação de tabela a partir de uma query
-- Crie uma tabela chamada customers_age com o id e a idade dos clientes. 
-- Chame-a de temp_tables.customers_age

select customer_id, datediff('y', birth_date, current_date) as age_customer
into temp_tables.customers_age
from sales.customers

select * from temp_tables.customers_age

-- (Exemplo 2) Criação de tabela a partir do zero
-- Crie uma tabela com a tradução dos status profissionais dos clientes. 
-- Chame-a de temp_tables.profissoes

select distinct professional_status
from sales.customers 

create table temp_tables.occupations (
professional_status VARCHAR(20), status_profissional VARCHAR(20)
)

select * from temp_tables.occupations

--add rows

INSERT INTO temp_tables.occupations 
(professional_status, status_profissional) 
VALUES 
('businessman', 'empresario'),
('freelancer', 'freelancer'),
('clt', 'clt'),
('retired', 'aposentado')


delete professional_status from
temp_tables.occupations where professional_status = 'freelancer'

-- (Exemplo 3) Deleção de tabelas
-- Delete a tabela temp_tables.profissoes

drop table temp_tables.occupations 



-- RESUMO 
-- (1) Para criar tabelas a partir de uma query basta escrever a query normalmente e
-- colocar o comando INTO antes do FROM informando o schema e o nome da tabela 
-- a ser criada
-- (2) Para criar tabelas a partir do zero é necessário (a) criar uma tabela vazia 
-- com o comando CREATE TABLE (b) Informar que valores serão inseridos com o comando
-- INSERT INTO seguido do nome das colunas (c) Inserir os valores manualmente em forma 
-- de lista após o comando VALUES
-- (3) Para deletar uma tabela utiliza-se o comando DROP TABLE


create table temp_tables.occupations (
professional_status VARCHAR(20), status_profissional VARCHAR(20)
)
select * from temp_tables.occupations

INSERT INTO temp_tables.occupations 
(professional_status, status_profissional) 
VALUES 
('unemployed', 'desempregado'),
('trainee', 'estag')

update temp_tables.occupations
set status_profissional = 'estagiario' where status_profissional = 'estag'

update temp_tables.occupations
set professional_status = 'intern' where professional_status = 'trainee'

delete from temp_tables.occupations 
where professional_status ='unemployed'

-- CONTEÚDO 
-- Inserção de colunas
-- Alteração de colunas
-- Deleção de colunas

-- (Exemplo 1) Inserção de Colunas
-- Insira uma coluna na tabela sales.customers com a idade do cliente

alter table sales.customers 
add customer_age int

select * from sales.customers

update sales.customers 
set customer_age=datediff('y', birth_date, current_date)
where true

-- (Exemplo 2) Alteração do tipo da coluna
-- Altere o tipo da coluna customer_age de inteiro para varchar

alter table sales.customers 
alter column customer_age type varchar

-- (Exemplo 3) Alteração do nome da coluna
-- Renomeie o nome da coluna "customer_age" para "age"

alter table sales.customers 
rename column customer_age to age

-- (Exemplo 4) Deleção de coluna
-- Delete a coluna "age"

alter table sales.customers 
drop column age


-- RESUMO
-- (1) Para fazer qualquer modificação nas colunas de uma tabela utiliza-se o comando 
-- ALTER TABLE seguido do nome da tabela
-- (2) Para adicionar colunas utiliza-se o comando ADD seguido do nome da coluna e da
-- unidade da nova coluna
-- (3) Para mudar o tipo de unidade de uma coluna utiliza-se o comando ALTER COLUMN 
-- (4) Para renomear uma coluna utiliza-se o comando RENAME COLUMN
-- (5) Para deletar uma coluna utiliza-se o comando DROP COLUMN







