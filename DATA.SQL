create table company(
userid varchar2(20) primary key,
pswrd varchar2(12) not null,
c_role varchar2(10));


create table branch(
branchid varchar2(8) primary key,
loc varchar2(10),
c_nos number(2));

create table discount(
dno number(2) primary key,
dname varchar2(15) not null,
drate number(5,2) not null);

create table membership(
mem_id number(3) primary key,
mem_name varchar2(20) not null,
mem_add varchar2(20) not null,
mem_city varchar2(10) not null,
start_date date,
mem_contact number(12) unique,
mem_type number(2) references discount(dno));


create table counter(
branchid varchar2(8) references branch(branchid),
c_id varchar2(8));


create table loged(
userid varchar2(10) references company(userid),
b_id varchar2(8) references branch(branchid),
c_id varchar2(8),
ldate date);




create table product(
pid number(3) primary key,
pname varchar2(20) not null,
artist varchar2(20),
genre varchar2(10),
lang varchar2(10),
price number(6,2),
format varchar2(6),
typ varchar2(4));

create table available_in(
pid number(3) references product(pid),
bid varchar2(8) references branch(branchid),
stock number(4),
s_u_date date);


create table trans(
tid number(3) unique,
cust_id number(4),
cid varchar2(8),
bid varchar2(8),
pid number(3) references product(pid),
amount number(6,2),
tdate date,
qty number(3) not null);

create table customer(
cust_id number(4) primary key,
cust_name varchar2(20) not null,
phn number(12),
loc varchar2(12),
mid number(3));

insert into trans(tid,qty) values (1,0);
insert into customer(cust_id,cust_name) values (1,'Admin');


create or replace trigger trigstock after insert on trans
for each row
begin
 update available_in set stock=stock-:new.qty where pid=:new.pid;
end;
/


insert into company values ('dhoni','captain','admin');
insert into company values ('yuvraj','durban','admin');
insert into company values ('sachin','tendulkar','bop');
insert into company values ('jadeja','sir','bop');
insert into company values ('ishant','sharma','cop');
insert into company values ('virat','kohli','cop');

insert into product values(1,'Complicated','Avril','Pop','English',330,'Video','CD');

create sequence a
start with 1
increment by 1;

select a.nextval from dual;
commit;


create or replace trigger bid before insert on branch
for each row
declare
x varchar2(8);
begin
select concat('B',to_char(a.nextval)) into x from dual;
:new.branchid:=x;
end;
/

insert into discount values(1,'VIP',8);
insert into discount values(2,'GOVT. EMPLOYEE',7.2);
insert into discount values(3,'CORPORATE',5);



insert into membership values (1,'Abhishek','57,Garfa Main Road','Kolkata','11-jan-2011',7501369576,1);
insert into membership values (2,'Jiwan','56,South City','Kolkata','15-feb-2010',123456789,1);
insert into membership values (3,'Anirudha','Flat No 6,Hirapur','Dhanbad','4-june-2013',6758940743,2);
insert into membership values (4,'Some','H.No506,Palbazar','Bankura','19-aug-2008',8239208476,2);
insert into membership values (5,'Preeti','36B,Station Road','Sonarpur','21-dec-2009',6487598591,3);
insert into membership values (6,'Shweta','8B,Jadavpur','Kolkata','12-feb-2013',2788299283,3);
insert into membership values (7,'Harsh','Hno 36,Din Bazar','Jalpaiguri','19-sep-2013',7501369571,3);


commit;