create database oficina;
use oficina;

create table veiculo(
	idVeiculo int auto_increment primary key,
    Placa varchar(45) not null,
    Proprietário varchar(45) not null,
    idCliente_veiculo int,
    constraint fk_idCliente_veiculo foreign key (idCliente_veiculo) references cliente(idCliente)
    );
    
create table cliente(
	idCliente int auto_increment primary key,
    Nome varchar(45) not null,
	CPF int not null,
    Endereço varchar(45)
    );
    
create table pedido(
	idPedido int auto_increment primary key,
    Descrição varchar(45),
    Data_de_Solicitação date,
    Liberação bool,
    idCliente_pedido int,
    idOrdem_de_Serviço_pedido int,
    constraint fk_idCliente_pedido foreign key(idCliente_pedido) references cliente(idCliente),
    constraint fk_idOrdem_de_Serviço_pedido foreign key(idOrdem_de_Serviço_pedido) references ordem_de_serviço(idOrdem_de_Serviço)
    );
    
create table ordem_de_serviço(
	idOrdem_de_Serviço int auto_increment primary key,
    Número int,
    Data_de_Emissão date,
    Status_OS ENUM('Em progresso', 'Finalizado', 'Cancelado') default 'Em progresso',
    Data_de_Conclusão date,
    Valor_Total float not null,
    idEntrega_OS int,
    constraint fk_idEntrega_OS foreign key(idEntrega_OS) references entrega(idEntrega)
    );
    
    select * from ordem_de_serviço;
    
create table entrega(
	idEntrega int auto_increment primary key,
    Status_entrega ENUM('Em serviço', 'Cancelado', 'Feito') default 'Em Serviço',
    Liberação bool not null
    );
    
create table mecanico(
	idMecanico int auto_increment primary key,
    Código_ident int not null,
    Nome varchar(45) not null,
    Status_entrega ENUM('Em serviço', 'Cancelado', 'Feito') default 'Em Serviço',
    Liberação bool not null,
    Especialidade varchar(45) not null,
    Endereço varchar(40),
    idMão_de_Obra_Serviço_mecanico int,
    constraint fk_idMão_de_Obra_Serviço_mecanico foreign key (idMão_de_Obra_Serviço_mecanico) references mao_de_obra_serviço(idMao_de_Obra_Serviço),
    idOrdem_de_Serviço_mecanico int,
    constraint fk_idOrdem_de_Serviço_mecanico foreign key (idOrdem_de_Serviço_mecanico) references ordem_de_serviço(idOrdem_de_Serviço)
    );
    
create table peça(
	idPeça int auto_increment primary key,
    Valor_Peça float not null,
    idOrdem_de_Serviço_peça int,
    constraint fk_idOrdem_de_Serviço_peça foreign key (idOrdem_de_Serviço_peça) references ordem_de_serviço(idOrdem_de_Serviço)
    );
    
create table mao_de_obra_serviço(
	idMao_de_Obra_Serviço int auto_increment primary key,
    Descrição varchar(45),
    Valor_Peça float not null,
    idOrdem_de_Serviço_mos int,
    constraint fk_idOrdem_de_Serviço_mos foreign key (idOrdem_de_Serviço_mos) references ordem_de_serviço(idOrdem_de_Serviço)
    );
    
    ALTER TABLE mao_de_obra_serviço add COLUMN Valor_Mao_Obra float not null;
    
    select * from mao_de_obra_serviço;
    
create table estoque(
	idEstoque int auto_increment primary key,
    Local_Estoque varchar(20)
    );
    
create table revisão(
	idRevisão int auto_increment primary key,
    Status_revisão ENUM('Liberado', 'Em revisão') default 'Em revisão',
    idMao_de_Obra_Serviço_revisão int,
    constraint fk_idMao_de_Obra_Serviço_revisão foreign key (idMao_de_Obra_Serviço_revisão) references mao_de_obra_serviço(idMao_de_Obra_Serviço)
    );
    
create table concerto(
	idConcerto int auto_increment primary key,
    Status_concerto ENUM('Liberado', 'Em concerto') default 'Em concerto',
    idMao_de_Obra_Serviço_concerto int,
    constraint fk_idMao_de_Obra_Serviço_concerto foreign key (idMao_de_Obra_Serviço_concerto) references mao_de_obra_serviço(idMao_de_Obra_Serviço)
    );
    
create table peça_estoque(
	idEstoque_pest int,
    idPeça_pest int,
    idOrdem_de_Serviço_pest int,
    primary key (idEstoque_pest,idPeça_pest,idOrdem_de_Serviço_pest),
    constraint foreign key fk_idEstoque_pest(idEstoque_pest) references estoque(idEstoque),
    constraint foreign key fk_idPeça_pest(idPeça_pest) references peça(idPeça),
    constraint foreign key fk_idOrdem_de_Serviço_pest(idOrdem_de_Serviço_pest) references ordem_de_serviço(idOrdem_de_Serviço)
    );

insert into veiculo (idVeiculo, Placa, Proprietário, idCliente_veiculo) values 
	(1,'cmg5896','Mateus',1),
    (2,'jpg1234','Eudete',1);
    
select * from veiculo;

insert into cliente (idCliente, Nome, CPF, Endereço) values 
	(1,'Claudio','54253658','Rua Avilar'),
    (2,'Mario','58475663','Rua Pilar');
    
select * from cliente;

insert into pedido (idPedido, Descrição, Data_de_Solicitação, Liberação,idCliente_pedido,idOrdem_de_Serviço) values 
	(1,'revisão veiculo x','2022-09-10',False,1,1),
    (2,'concerto veiculo y','2022-08-02',True,2,2);
    
select * from pedido;

insert into ordem_de_serviço (idOrdem_de_Serviço, Número, Data_de_Emissão, Status_OS, Data_de_Conclusão, Valor_Total, idEntregaOS) values 
	(1,'1524','2022-02-10','Finalizado','2022-03-08',1000, 1),
    (2,'5687','2022-09-03','Em progresso','2022-09-18',3000, 2);
    
DELETE FROM ordem_de_serviço;

select * from ordem_de_serviço;

insert into entrega (idEntrega, Status_entrega, Liberação) values
	(1,default,False),
    (2,'Cancelado',True);

select * from entrega;

insert into mecanico (idMecanico, Código_ident, Nome, Status_entrega, Liberação, Especialidade, Endereço,idMão_de_Obra_Serviço_mecanico, idOrdem_de_Serviço_mecanico) values
	(1,'15242262','Jaime',default,False,'motor','rua Roxa',1,1),
    (2,'63582554','Marcos','Feito',True,'Pintura','rua Preta',2,2);

select * from mecanico;

insert into peça (idPeça, Valor_Peça, idOrdem_de_Serviço_peça) values
	(1,500, 1),
    (2,600, 2),
    (3,80, 3),
    (4,100, 4),
    (5,750, 5);
    
select * from peça;

insert into mao_de_obra_serviço (idMao_de_Obra_Serviço, Descrição, Valor_Mao_Obra, idOrdem_de_Serviço_mos) values
	(1,'troca de peças',1000,1),
    (2,'revisão de peça do motor',500,2);
    
select * from mao_de_obra_serviço;

insert into estoque (idEstoque, Local_Estoque) values 
	(1, "Endereço C4"),
	(2, "Endereço H6"),
    (3, "Endereço D7");
    
select * from estoque;

insert into revisão (idRevisão, Status_revisão) values 
	(1, 'Liberado'),
	(2, 'Em revisão'),
    (3, default);

select * from revisão;
 
insert into concerto (idConcerto, Status_concerto, idMao_de_Obra_Serviço_concerto) values 
	(1, default,1),
	(2, 'Liberado',2);
    
select * from concerto;
    
insert into peça_estoque (idEstoque_pest, idPeça_pest, idOrdem_de_Serviço_pest) values 
	(1, 1, 1),
	(2, 2 ,2);
    
select * from peça_estoque;

select a1.proprietário, a1.placa, a2.Nome, a2.CPF
	from veiculo AS a1
	join cliente AS a2
    