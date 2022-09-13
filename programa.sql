-- 1. Criar procedure insere_projeto
create or replace procedure  brh.insere_projeto
(p_id in brh.projeto.id%type,p_nome in brh.projeto.nome%type, p_responsavel in brh.projeto.responsavel%type, p_inicio in brh.projeto.inicio%type,p_fim in brh.projeto.fim%type)
IS
BEGIN
 INSERT INTO brh.projeto(id,nome,responsavel,inicio,fim) VALUES (p_id,p_nome, p_responsavel, p_inicio,p_fim);
END;

delete from brh.projeto where id = 5;

execute brh.insere_projeto(5,'teste','T123',to_date('2022-01-01', 'yyyy-mm-dd'),'');
select * from brh.projeto;

-- 2. Criar função calcula_idade
create or replace function brh.calcula_idade
    (f_dat_nasciment in date)
    return float
is
    f_idade float;
begin
    f_idade := trunc((sysdate-f_dat_nasciment)/365);
    return f_idade;
end;

select brh.calcula_idade(to_date('2020-01-01', 'yyyy-mm-dd')) from dual;