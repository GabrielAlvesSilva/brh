use brh;
SET FOREIGN_KEY_CHECKS = 1;

#Relatório de departamentos

select sigla, nome from departamento order by nome; 

# Relatório de dependentes

select 
	c.nome as "Nome do Colaborador",
	d.nome as "Nome do Dependente",
    d.data_nascimento as "Nascimento do Dependente",
    d.parentesco as "Parentesco do Dependente"
from dependente as d
left join colaborador as c
on d.colaborador = c.matricula
order by c.nome,d.nome;


#Inserir novo colaborador em projeto.

insert into endereco values (
'80420-070',
'PR',
'Curitiba',
'Centro',
'Rua Coronel Menna Barreto Monclaro'
);
select * from endereco where cep = '80420-070';

insert into colaborador values (
'F187',
'412.663.110-09',
'Fulano de Tal',
'FulanoProjetista@gmail.com',
'Fulado.Tal@com',
10000.00,
'DIR',
'80420-070',
'Cobertura'
);
select * from colaborador where matricula = 'F187';

insert into telefone_colaborador values(
'(61) 9 9999-9999',
'F187',
'M'
);
select * from telefone_colaborador where colaborador = 'F187';

insert into projeto
(nome, responsavel, inicio, fim) 
values (
'BL',
'G123',
'2022-08-23',
'2022-12-30'
);
select * from projeto;

insert into papel
(nome) 
values (
'Especialista de Negócios'
);
select * from papel
order by id;

insert into atribuicao values(
'F187',
5,
8
);
select 
c.matricula as "Matricula Colaborador",
c.nome as "Nome Colaborador",
pr.nome as "Nome do Projeto",
pa.nome as "Papel"
from atribuicao a
left join colaborador c
on a.colaborador = c.matricula
left join papel pa
on a.papel = pa.id
left join projeto pr
on a.projeto = pr.id
where colaborador = 'F187';

#Excluir departamento SECAP

SET SQL_SAFE_UPDATES=0;
select * from dependente where dependente.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

delete from dependente where dependente.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

select * from  atribuicao where atribuicao.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

delete from atribuicao where atribuicao.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

select * from telefone_colaborador where telefone_colaborador.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

delete from telefone_colaborador where telefone_colaborador.colaborador in(
	select colaborador.matricula from colaborador where departamento = 'SECAP'
);

 select * from departamento where sigla = 'SECAP';
 
update departamento 
   set chefe = 'A123'
 where sigla = 'SECAP';
 
select * from colaborador
where departamento = 'SECAP'; 

delete from colaborador
where departamento = 'SECAP'; 

select * from  departamento
where sigla = "SECAP";

delete from  departamento
where sigla = "SECAP";




