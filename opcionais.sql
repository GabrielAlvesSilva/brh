---- criaçao da view
drop view brh.colaborador_dependete;
create view brh.colaborador_dependete as select 
co.nome as nome_colaborador,
co.salario as salario_colaborador,
(case when co.salario <= 3000 then 'Júnior'
    when co.salario > 3000 and co.salario <= 6000 then 'Pleno'
    when co.salario > 6000 and co.salario <= 20000 then 'Sênior'
    else 'Corpo diretor'
    end
) as senioridade,
dp.nome as nome_dependente,
(case when trunc((sysdate-dp.data_nascimento)/365) < 18 then 'Menor de idade'
   else 'Maior de idade'
   end
) as faixa_etaria_dependete,
dp.parentesco as parentesco,
(case when dp.parentesco = 'Cônjuge' then 100
        else 
        (case   when trunc((sysdate-dp.data_nascimento)/365) < 18 then (25)
                else (50)
        end
        )
end) as taxa_dependete
from brh.colaborador co
left join brh.dependente dp
on co.matricula = dp.colaborador
;
---- Relatório de plano de saúde
select 
nome_colaborador,
salario_colaborador,
senioridade,
(case   when senioridade = 'Júnior' then (salario_colaborador*0.01)
        when senioridade = 'Pleno' then (salario_colaborador*0.02)
        when senioridade = 'Sênior' then (salario_colaborador*0.03)
        else (salario_colaborador*0.05)
end
)+ Sum (taxa_dependete) as taxa_plano_saude
from brh.colaborador_dependete
group by (nome_colaborador,salario_colaborador,senioridade)
order by nome_colaborador;

----Listar colaboradores que participaram de todos os projetos
create or replace view brh.colaboradores_projeto_brh as select 
co.matricula as matricula_colaborador,
d.nome as nome_departamento,
co.nome as nome_colaborador,
pa.nome as papel,
co.salario as salario_colaborador,
pr.nome as nome_projeto,
tl.numero as telefone_colaborador,
c.nome as chefe_departamento
from brh.atribuicao at
left join brh.projeto pr
on at.projeto = pr.id
left join brh.colaborador co
on at.colaborador = co.matricula
left join brh.papel pa
on at.papel = pa.id
left join brh.projeto pr
on at.projeto = pr.id
inner join brh.telefone_colaborador tl
on tl.colaborador = co.matricula
left join brh.dependente dp
on co.matricula = dp.colaborador
inner join brh.departamento d
on d.sigla = co.departamento
left join brh.colaborador c
on d.chefe = c.matricula
where pr.nome = 'BRH';

create or replace view brh.colaboradores_projeto_dimenx as select 
co.matricula as matricula_colaborador,
d.nome as nome_departamento,
co.nome as nome_colaborador,
pa.nome as papel,
co.salario as salario_colaborador,
pr.nome as nome_projeto,
tl.numero as telefone_colaborador,
c.nome as chefe_departamento
from brh.atribuicao at
left join brh.projeto pr
on at.projeto = pr.id
left join brh.colaborador co
on at.colaborador = co.matricula
left join brh.papel pa
on at.papel = pa.id
left join brh.projeto pr
on at.projeto = pr.id
inner join brh.telefone_colaborador tl
on tl.colaborador = co.matricula
left join brh.dependente dp
on co.matricula = dp.colaborador
inner join brh.departamento d
on d.sigla = co.departamento
left join brh.colaborador c
on d.chefe = c.matricula
where pr.nome = 'Dimenx';

create or replace view brh.colaboradores_projeto_oracle_exadata as select 
co.matricula as matricula_colaborador,
d.nome as nome_departamento,
co.nome as nome_colaborador,
pa.nome as papel,
co.salario as salario_colaborador,
pr.nome as nome_projeto,
tl.numero as telefone_colaborador,
c.nome as chefe_departamento
from brh.atribuicao at
left join brh.projeto pr
on at.projeto = pr.id
left join brh.colaborador co
on at.colaborador = co.matricula
left join brh.papel pa
on at.papel = pa.id
left join brh.projeto pr
on at.projeto = pr.id
inner join brh.telefone_colaborador tl
on tl.colaborador = co.matricula
left join brh.dependente dp
on co.matricula = dp.colaborador
inner join brh.departamento d
on d.sigla = co.departamento
left join brh.colaborador c
on d.chefe = c.matricula
where pr.nome = 'Oracle Exadata';

create or replace view brh.colaboradores_projeto_comex as select 
co.matricula as matricula_colaborador,
d.nome as nome_departamento,
co.nome as nome_colaborador,
pa.nome as papel,
co.salario as salario_colaborador,
pr.nome as nome_projeto,
tl.numero as telefone_colaborador,
c.nome as chefe_departamento
from brh.atribuicao at
left join brh.projeto pr
on at.projeto = pr.id
left join brh.colaborador co
on at.colaborador = co.matricula
left join brh.papel pa
on at.papel = pa.id
left join brh.projeto pr
on at.projeto = pr.id
inner join brh.telefone_colaborador tl
on tl.colaborador = co.matricula
left join brh.dependente dp
on co.matricula = dp.colaborador
inner join brh.departamento d
on d.sigla = co.departamento
left join brh.colaborador c
on d.chefe = c.matricula
where pr.nome = 'Comex';

select distinct 
pc.matricula_colaborador,
pc.nome_colaborador,
pc.salario_colaborador,
pc.nome_projeto,
poe.nome_projeto,
pd.nome_projeto,
pb.nome_projeto
from brh.colaboradores_projeto_comex pc
inner join brh.colaboradores_projeto_oracle_exadata poe
on pc.matricula_colaborador = poe.matricula_colaborador
inner join brh.colaboradores_projeto_dimenx pd
on pc.matricula_colaborador = pd.matricula_colaborador
inner join brh.colaboradores_projeto_brh pb
on pc.matricula_colaborador = pd.matricula_colaborador
;


--Paginar listagem de colaboradores
SELECT * FROM (
    SELECT rownum as linha, t.*
      FROM brh.colaborador t
) consulta_paginada
WHERE linha >= 11 AND linha <= 20;
