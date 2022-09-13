--Filtrar dependentes
select 
c.nome as "Nome do Colaborador", 
d.nome as "Nome do Dependente", 
to_char(to_date(d.data_nascimento,'dd-mm-yy'),'mm') as "Data do nascimento" from brh.dependente d
inner join brh.colaborador c
on c.matricula = d.colaborador
where lower(d.nome) like '%h%' or
to_char(d.data_nascimento, 'MM') IN ( '04', '05', '06' )
order by c.nome, d.nome;

-- Listar colaborador com maior sal�rio
select 
nome as "Nome do Funcionario",
salario as "Salario"
from brh.colaborador 
where salario = ( select max(salario) from brh.colaborador ); 

-- Relat�rio de senioridade
select 
matricula as "Matricula",
nome as "Nome do Colaborador",
salario as "Salario",
(case when salario <= 3000 then 'J�nior'
    when salario > 3000 and salario <= 6000 then 'Pleno'
    when salario > 6000 and salario <= 20000 then 'S�nior'
    else 'Corpo diretor'
    end
) as "senioridade"
from brh.colaborador
order by nome,salario
;
-- Listar colaboradores em projetos
select 
dp.nome as "Nome do Departamento",
pr.nome as "Nome do projeto",
count(*) as "Numero dos Colaboradores"
from brh.atribuicao at
inner join brh.projeto pr
on at.projeto = pr.id
inner join brh.colaborador c
on c.matricula = at.colaborador
inner join brh.departamento dp
on dp.sigla = c.departamento
group by (at.projeto,pr.nome,dp.nome)
order by dp.nome,pr.nome
;

--Listar colaboradores com mais dependentes
select 
c.nome "Nome do Colaborador",
count(*) as "Numero de Dependentes"
from brh.dependente dp
inner join brh.colaborador c
on c.matricula = dp.colaborador
group by c.nome
having count(*) > 1
order by c.nome asc, count(*) desc
;

--Listar faixa et�ria dos dependentes
select
colaborador as "Matricula do Colaborador",
nome as "Nome do Dependete",
cpf as CPF,
data_nascimento as "Data de Nascimento",
parentesco as Parentesco ,
trunc((sysdate-data_nascimento)/365) as "Idade",
(case when trunc((sysdate-data_nascimento)/365) < 18 then 'Menor de idade'
   else 'Maior de idade'
   end
) as "Faixa Et�ria"
from brh.dependente
order by colaborador,nome
;
