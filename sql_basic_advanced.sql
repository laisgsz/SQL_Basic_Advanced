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






