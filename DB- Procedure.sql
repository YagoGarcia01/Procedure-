create database DbFacul;
use DbFacul;
create table instrutores(id int(11) primary key auto_increment not null, nome varchar(50), email varchar(50), valor_hora int(10), certificados varchar(255));
create table cursos(id int(10) primary key auto_increment not null, nome varchar(50), requisito varchar(255), carga_horaria smallint(5), preco double);
create table turmas(id int(10) primary key auto_increment not null, data_inicio date, data_final date, carga_horaria smallint(5));
create table matriculas(id int(10) primary key auto_increment not null, data_matricula date);
create table alunos(id int(11) primary key auto_increment not null, cpf char(11), nome varchar(50), email varchar(50), fone char(14), data_nascimento date);
alter table turmas add column instrutores_id int(11); 
alter table turmas add constraint turmas_FKIndex1 foreign key (instrutores_id) references instrutores(id);
alter table turmas add column cursos_id int(10);
alter table turmas add constraint turmas_FKIndex2 foreign key (cursos_id) references cursos(id);
alter table matriculas add column turmas_id int(10); 
alter table matriculas add constraint matriculas_FKIndex1 foreign key (turmas_id) references turmas(id);
alter table matriculas add column alunos_id int(11);
alter table matriculas add constraint matriculas_FKIndex2 foreign key (alunos_id) references alunos(id);
INSERT INTO instrutores(nome,email,valor_hora,certificados) VALUES("Gabriel", "Gabriel@gmail.com", 2, "SAP Inglês");
INSERT INTO instrutores(nome,email,valor_hora,certificados) VALUES("Oswaldo", "Oswaldo_@outlook.com.com", 3, "Engenharia da computação");
INSERT INTO cursos(nome,requisito,carga_horaria,preco) VALUES("Ciencias", "ENSINO MÉDIO COMPLETO", 50, 10000);
INSERT INTO cursos(nome,requisito,carga_horaria,preco) VALUES("Filosofia", "ENSINO MÉDIO COMPLETO", 40, 1000);
INSERT INTO turmas(instrutores_id,cursos_id,data_inicio,data_final, carga_horaria) VALUES(5, 1, 10/06/2022, 31/12/2025 , 50);
INSERT INTO turmas(instrutores_id,cursos_id,data_inicio,data_final, carga_horaria) VALUES(7, 3, 11/02/2020, 31/12/2023 , 70);
INSERT INTO alunos(cpf,nome,email,fone,data_nascimento) VALUES(46688952254, "Otavio", "Otavio@gmail.com", 35568985 , 23/09/1994 );
INSERT INTO alunos(cpf,nome,email,fone,data_nascimento) VALUES(98837362958, "Valeria", "Valeria@gmail.com", 400235688 , 10/11/1997 );
INSERT INTO matriculas(turmas_id,alunos_id,data_matricula) VALUES(3, 2, 11/10/2019);
INSERT INTO matriculas(turmas_id,alunos_id,data_matricula) VALUES(2, 2, 11/01/2019);

SELECT b.nome, c.nome FROM instrutores as b INNER JOIN alunos as c on b.nome = c.nome;
SELECT b.nome, c.nome FROM instrutores as b LEFT JOIN alunos as c on b.nome = c.nome;
SELECT b.nome, c.nome FROM instrutores as b RIGHT JOIN alunos as c on b.nome = c.nome;
select * from matriculas;

/* PROCEDURE ALUNOS */
DELIMITER $$
CREATE PROCEDURE selecionar_alunos (IN quantidade int)
BEGIN
SELECT * FROM alunos LIMIT quantidade;
END $$
DELIMITER ; 

CALL selecionar_alunos(2); 

DELIMITER $$
CREATE PROCEDURE Verificar_Quantidade_Alunos(OUT quantidade INT)
BEGIN
	SELECT COUNT(*) INTO quantidade FROM alunos;
END $$
DELIMITER ; 

CALL Verificar_Quantidade_Alunos(@total);
SELECT @total;

/* PROCEDURE INTRUTORES */
DELIMITER $$
CREATE PROCEDURE incluir_instrutor (IN snome varchar(50), semail varchar(50), svalor_hora int(10), scertificados varchar(255))
BEGIN
INSERT INTO instrutores(nome, email, valor_hora, certificados) VALUES (snome, semail, svalor_hora, scertificados);
END $$
DELIMITER ; 

CALL incluir_instrutor("Yago Urias", "YagoUrias@hotmail.com", 15, "São bernardo"); 


/* PROCEDURE MATRICULAS */
DELIMITER $$
CREATE PROCEDURE alterar_matricula (IN sid int, sdata_matricula date)
BEGIN
update matriculas
set 
data_matricula = sdata_matricula where id= sid;
END $$
DELIMITER ; 

CALL alterar_matricula(2, 56987564); 


/* PROCEDURE TURMAS */
DELIMITER $$
CREATE PROCEDURE selecionar_turmas (IN quantidade int)
BEGIN
SELECT * FROM turmas LIMIT quantidade;
END $$
DELIMITER ; 

CALL selecionar_turmas(2); 

DELIMITER $$
CREATE PROCEDURE Verificar_Quantidade_turmas(OUT quantidade INT)
BEGIN
	SELECT COUNT(*) INTO quantidade FROM turmas;
END $$
DELIMITER ; 

CALL Verificar_Quantidade_turmas(@total);
SELECT @total;

/* PROCEDURE CURSOS */
DELIMITER $$
CREATE PROCEDURE incluir_cursos (IN snome varchar(50), srequisito varchar(255), scarga_horaria smallint(5), spreco double)
BEGIN
INSERT INTO cursos(nome, requisito , carga_horaria ,preco) VALUES (snome, srequisito, scarga_horaria, spreco);
END $$
DELIMITER ; 

CALL incluir_cursos("Matematica", "ENSINO MÉDIO", 40, 600); 

