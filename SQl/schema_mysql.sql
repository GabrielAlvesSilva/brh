DROP SCHEMA IF EXISTS brh;
create schema brh;
use brh;

create table COLABORADOR(
id_colaborador int auto_increment not null,
nome varchar(50) not null,
cpf int not null,
email varchar(50) not null,
bairro varchar(30) not null,
cidade varchar(30) not null,
estado varchar(30) not null,
telefone_1 varchar(15) not null,
telefone_2 varchar(15),
atribuicao VARCHAR(100) not null,
nascimento date not null,
salario DECIMAL(10,2) not null,
PRIMARY KEY(id_colaborador)
);

create table ATRIBUICAO(
id_atribuicao int auto_increment not null,
atribuicao varchar(100) not null,
fk_colaborador_atribuicao int not null,
PRIMARY KEY(id_atribuicao)
);
alter table ATRIBUICAO
add constraint fk_colaborador_atribuicao
foreign key (fk_colaborador_atribuicao) references colaborador(id_colaborador);

create table DEPENDENTE(
dependente_nome varchar(50) not null,
parentesco int not null,
nascimento date not null,
fk_colaborador_dependete int not null,
PRIMARY KEY(dependente_nome,fk_colaborador_dependete)
);
alter table DEPENDENTE
add constraint fk_colaborador_dependete
foreign key (fk_colaborador_dependete) references colaborador(id_colaborador);

create table DEPARTAMENTO(
id_departamento int auto_increment not null,
departamento_nome varchar(50) not null,
gerente varchar(50) not null,
fk_colaborador_departamento int not null,
PRIMARY KEY(id_departamento)
);
alter table DEPARTAMENTO
add constraint fk_colaborador_departamento
foreign key (fk_colaborador_departamento) references colaborador(id_colaborador);

create table PROJETO(
id_projeto int auto_increment not null,
projeto_nome varchar(50) not null,
responsavel varchar(50) not null,
data_inicio date not null,
data_final date not null,
PRIMARY KEY(id_projeto)
);

create table PAPEL(
papel varchar(30) not null,
fk_colaborador_papel int not null,
fk_projeto_papel int not null,
PRIMARY KEY(fk_projeto_papel,fk_colaborador_papel)PRIMARY
);
alter table PAPEL
add constraint fk_colaborador_papel
foreign key (fk_colaborador_papel) references colaborador(id_colaborador);
alter table PAPEL
add constraint fk_projeto_papel
foreign key (fk_projeto_papel) references projeto(id_projeto);

