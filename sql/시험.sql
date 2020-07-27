CREATE TABLE t_order(
    o_no number(10) primary key,
    cus_no number(10),
    o_date date not null,
    o_price number(8,1) default 0,
    FOREIGN key (cus_no) REFERENCES t_customer(cus_no)
);

CREATE TABLE t_customer(
    cus_no number(10) PRIMARY KEY,
    nm varchar(10) NULL
);
commit;

drop table t_order;

INSERT INTO t_customer(cus_no, nm) values(3, '홍길동');
INSERT INTO t_customer(cus_no, nm) values(5, '이순신');
INSERT INTO T_ORDER(o_no, cus_no, o_date, o_price) values(1, 3, TO_DATE('20200704','YYYYMMDD') , 55000);
INSERT INTO T_ORDER(o_no, cus_no, o_date, o_price) values(2, 5, TO_DATE('20200801','YYYYMMDD') , 70000);
INSERT INTO T_ORDER(o_no, cus_no, o_date, o_price) values(3, 3, TO_DATE('20200706','YYYYMMDD') , 60000);

update t_customer set nm = '장보고' where cus_no = 5;
select o_no, o_price from t_order where cus_no = 3;
delete from t_order where o_no = 2;

select * from user_tables;
select * from user_indexes;
select * from user_views;

create index idx_customer_nm on t_customer(nm);

drop index idx_customer_nm;



create view view_order_info 
as
select o_no,o_date,o_price,B.nm 
from t_order A
left join t_customer B
on A.cus_no = B.cus_no;



drop view view_order_info;