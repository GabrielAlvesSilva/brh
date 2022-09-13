UPDATE brh.projeto
   SET id = id - 4
 WHERE nome != 'BI';

COMMIT;
--Relat�rio de departamentos

select sigla, nome from brh.departamento order by nome; 

-- Relat�rio de dependentes
select 
	c.nome as "Nome do Colaborador",
	d.nome as "Nome do Dependente",
    d.data_nascimento as "Nascimento do Dependente",
    d.parentesco as "Parentesco do Dependente"
from brh.dependente d
left join brh.colaborador c
on d.colaborador = c.matricula
order by c.nome,d.nome;

-- Inserir novo colaborador em projeto.

insert into brh.endereco values (
'80420-070',
'PR',
'Curitiba',
'Centro',
'Rua Coronel Menna Barreto Monclaro'
);

select * from brh.endereco where cep = '80420-070';

insert into brh.colaborador values (
'F187',
'412.663.110-09',
'Fulano de Tal',
'FulanoProjetista@gmail.com',
'Fulado.Tal@brh.com',
10000.00,
'DIR',
'80420-070',
'Cobertura'
);
select * from brh.colaborador where matricula = 'F187';

insert into brh.telefone_colaborador values(
'(61) 9 9999-9999',
'F187',
'M'
);
select * from brh.telefone_colaborador where colaborador = 'F187';

insert into brh.projeto
(nome, responsavel, inicio, fim) 
values (
'BL',
'G123',
TO_DATE('08/23/2022','MM/DD/YYYY'),
TO_DATE('12/30/2022','MM/DD/YYYY')
);
select * from brh.projeto;

insert into brh.papel
(nome) 
values (
'Especialista de Neg�cios'
);
select * from brh.papel
order by id;

insert into brh.atribuicao values(
'F187',
9,
8
);
select 
c.matricula as "Matricula Colaborador",
c.nome as "Nome Colaborador",
pr.nome as "Nome do Projeto",
pa.nome as "Papel"
from brh.atribuicao a
left join brh.colaborador c
on a.colaborador = c.matricula
left join brh.papel pa
on a.papel = pa.id
left join brh.projeto pr
on a.projeto = pr.id
where colaborador = 'F187';

--Excluir departamento SECAP

select * from brh.dependente dp where dp.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

delete from brh.dependente dp where dp.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

select * from brh.atribuicao a where a.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

delete from brh.atribuicao a where a.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

select * from brh.telefone_colaborador tc where tc.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

delete from brh.telefone_colaborador tc where tc.colaborador in(
	select c.matricula from brh.colaborador c where c.departamento = 'SECAP'
);

select * from brh.departamento where sigla = 'SECAP';
 
update brh.departamento 
   set chefe = 'A123'
 where sigla = 'SECAP';
 
select * from brh.colaborador
where departamento = 'SECAP'; 

delete from brh.colaborador
where departamento = 'SECAP'; 

select * from brh.departamento 
where sigla = 'SECAP';

delete from  brh.departamento
where sigla = 'SECAP';

-- Relat�rio de contatos
select 
c.nome as "Nome Colaborador",
c.email_corporativo as "Email Corporativo",
tl.numero as "Telefone Celular"
from brh.colaborador c
inner join brh.telefone_colaborador tl
on tl.colaborador = c.matricula;

-- Relat�rio anal�tico de equipes
select 
d.nome as "Departamento",
co.nome as "Colaborador Nome",
pa.nome as "Papel",
pr.nome as "Nome do Projeto",
tl.numero as "Telefone do Colaborador",
c.nome as "Chefe do Departamento",
dp.nome as "Dependente do Colaborador"
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
on d.chefe = c.matricula;

