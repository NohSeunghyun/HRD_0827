create table equipment_list_14 (
equipment_no char(6) not null primary key,
equipment_name varchar2(50),
equipment_group char(1),
equipment_price number,
reg_date date,
equipment_status char(1),
equipment_unit varchar2(20)
);

desc equipment_list_14; -- Run SQL에서 구조확인

insert into equipment_list_14 values ('170001', '의자', '2', 50000, '17/04/06', 'Y', '개');
insert into equipment_list_14 values ('170002', '책상', '2', 60000, '17/04/09', 'Y', '개');
insert into equipment_list_14 values ('170003', '사무PC', '1', 250000, '17/04/09', 'Y', '대');
insert into equipment_list_14 values ('170004', '복합기', '1', 200000, '17/04/09', 'Y', '대');
insert into equipment_list_14 values ('170005', '서랍장', '2', 35000, '17/05/06', 'N', '개');
insert into equipment_list_14 values ('170006', 'A4용지', '1', 25000, '18/01/03', 'Y', 'BOX');
insert into equipment_list_14 values ('170007', 'B5용지', '1', 20000, '18/01/06', 'Y', 'BOX');

select * from equipment_list_14; -- insert확인

--insert 번호 자동입력
select nvl(max(equipment_no), 0)+1 as equipment_no from equipment_list_14;

delete equipment_list_14 where equipment_no='170008';

create table equipment_postulat_14 (
req_no number not null primary key,
equipment_no char(6) not null,
req_date date,
req_qty number,
req_dept char(2)
);

desc equipment_postulat_14; -- Run SQL에서 구조확인

insert into equipment_postulat_14 values (10001, '170001', '17/12/01', 10, 'A1');
insert into equipment_postulat_14 values (10002, '170002', '17/12/01', 10, 'A1');
insert into equipment_postulat_14 values (10003, '170001', '18/02/12', 5, 'A2');
insert into equipment_postulat_14 values (10004, '170002', '18/02/12', 5, 'A2');
insert into equipment_postulat_14 values (10005, '170006', '18/02/14', 10, 'A2');
insert into equipment_postulat_14 values (10006, '170007', '18/03/03', 2, 'A2');
insert into equipment_postulat_14 values (10007, '170007', '18/03/04', 2, 'B2');
insert into equipment_postulat_14 values (10008, '170006', '18/03/10', 4, 'A1');
insert into equipment_postulat_14 values (10009, '170006', '18/04/01', 4, 'B1');
insert into equipment_postulat_14 values (10010, '170006', '18/04/06', 2, 'B2');
insert into equipment_postulat_14 values (10011, '170007', '18/05/01', 10, 'A2');
insert into equipment_postulat_14 values (10012, '170005', '18/05/01', 1, 'B1');
insert into equipment_postulat_14 values (10013, '170007', '18/05/11', 5, 'A1');
insert into equipment_postulat_14 values (10014, '170007', '18/05/12', 5, 'A2');
insert into equipment_postulat_14 values (10015, '170004', '18/06/14', 2, 'B1');

select * from equipment_postulat_14; -- insert확인

create table equipment_dept_14(
req_dept char(2) not null primary key,
dname varchar2(20) not null,
loc varchar2(20)
);

desc equipment_dept_14; -- Run SQL에서 구조확인

insert into equipment_dept_14 values ('A1', '총무', '세종');
insert into equipment_dept_14 values ('A2', '회계', '세종');
insert into equipment_dept_14 values ('B1', '경영', '서울');
insert into equipment_dept_14 values ('B2', '인사', '대전');

select * from equipment_dept_14; -- insert 확인

--select.jsp
select equipment_no, equipment_name, 
decode(equipment_group, '1', '기계가구', '2', '집기비품') as equipment_group, 
to_char(reg_date, 'yyyy-mm-dd') as reg_date, 
decode(equipment_status, 'Y', '사용', 'N', '미사용') as equipment_status, 
equipment_unit
from equipment_list_14
order by 1 desc;

--update.jsp
select equipment_no, equipment_price, 
to_char(reg_date, 'yyyy-mm-dd') as reg_date,
equipment_unit
from equipment_list_14 
where equipment_name = '의자';

--select2.jsp
select decode(req_dept, 'A1', '총무', 'A2', '회계', 'B1', '경영', 'B2', '인사') as req_dept, 
count(equipment_no) as equipment_no, 
sum(req_qty) as req_qty,
to_char(sum(price), '999,999,999') as price
from equipment_dept_14 natural join (select req_dept, equipment_no, req_qty, equipment_price*req_qty as price
									from equipment_list_14 natural join equipment_postulat_14)
group by req_dept
order by price desc;

--다른사람들것--
select  decode(req_dept,'A1','총무','A2','회계','B1','경영','B2','인사',''),count(req_qty), sum(req_qty), sum(req_qty*EQUIPMENT_PRICE)
from equipment_list_14 natural join equipment_postulat_14
group by req_dept order by 4 desc;

select count(req_no) as req_no, dname, sum(req_qty) as req_qty,to_char(sum(equipment_price*req_qty),'9,999,999') as equipment_price
from equipment_postulat_14 natural join EQUIPMENT_DEPT_14 natural join equipment_list_14
group by dname	
order by 4 desc;

SELECT dname,count(req_dept),sum(req_qty), (sum(equipment_price*req_qty))
FROM equipment_list_14 natural join equipment_postulat_14 natural join equipment_dept_14
GROUP BY req_dept,dname;

select decode(REQ_DEPT,'A1','총무','A2','회계','B1','경영','B2','인사') as REQ_DEPT,
EQUIPMENT_NO,
REQ_QTY, to_char(EQUIPMENT_PRICE,'999,999,999') as EQUIPMENT_PRICE
from equipment_dept_14 natural join (select REQ_DEPT, count(EQUIPMENT_NO) as EQUIPMENT_NO, sum(REQ_QTY) as REQ_QTY,sum(REQ_QTY*EQUIPMENT_PRICE) as EQUIPMENT_PRICE
								 	 from equipment_postulat_14 natural join equipment_list_14
									 group by REQ_DEPT)
									 order by 4 desc;