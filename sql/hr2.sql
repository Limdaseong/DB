CREATE TABLE t_student_hobby(
    i_student number,
    i_hobby number,
    r_dt date default sysdate,
    primary key(i_student, i_hobby),
    foreign key(i_student) references t_student(i_student) on delete cascade,
    CONSTRAINT fk_ihobby foreign key(i_hobby) references t_hobby(i_hobby)
);

INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(1,2);
INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(1,4);
INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(2,1);
INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(3,5);
INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(3,3);
INSERT INTO t_student_hobby (i_student, i_hobby) VALUES(3,1);
select * from t_student_hobby;

select
    B.i_student, B.nm as student_nm --무결성이 중요하다면 정규화를 많이 해야한다
    , A.i_hobby, C.nm as hobby_nm  --inner는 교집합이다 left는 묶이지 않는다면 null로 처리한다
from t_student_hobby A  -- 내가 쓴 글만 보고 싶다면 inner를 쓴다 (교집합)
INNER JOIN t_student B  -- left는 하나의 전체를 
ON A.i_student = B.i_student
INNER JOIN t_hobby C
ON A.i_hobby = C.i_hobby;



SELECT
B.*, A.*, C.*
from t_student_hobby A
left join t_student B
on A.i_student = B.i_student
LEFT JOIN t_hobby C
ON A.i_hobby = C.i_hobby;



SELECT
B.nm, C.nm
from t_student_hobby A
left join t_student B
on A.i_student = B.i_student
LEFT JOIN t_hobby C
ON A.i_hobby = C.i_hobby;

INSERT INTO t_board_like (i_board, i_student) values (1,1);
INSERT INTO t_board_like (i_board, i_student) values (1,2);
INSERT INTO t_board_like (i_board, i_student) values (1,3);
INSERT INTO t_board_like (i_board, i_student) values (2,1);

select * from t_board_like;

commit;

select 
A.*, B.*, nvl(B.like_cnt,0) as like_cnt ,C.nm
from t_board A
LEFT JOIN(
    select i_board, count(i_board) as like_cnt
    from t_board_like
    group by i_board
)B
ON A.i_board = B.i_board
INNER JOIN t_student C
ON A.i_student = C.i_student
-- WHERE B.i_board is not null
ORDER BY nvl(B.like_cnt, 0) asc;

--select * from t_student where age > 40;


CREATE TABLE t_student2 (
    i_student number,
    nm varchar2(15) unique not null,
    age number (3) not null,
    primary key(i_student)
);

commit;

insert into t_student2 (i_student,nm, age) values(1,1,10);
insert into t_student2 (i_student,nm, age) values(1,2,10);

SELECT * FROM USER_TABLES;

CREATE INDEX idx_student_age
ON T_STUDENT(age);

drop index idx_student_age
ON T_STUDENT(age);

drop view view_boardlike_cnt;

CREATE VIEW view_boardlike_cnt
AS 
select i_board, count(i_board) as like_cnt
    FROM t_board_like
    group by i_board;


select * from view_boardlike_cnt;

select * from USER_TABLES;
SELECT * FROM USER_INDEXS;
SELECT * FROM USER_VIEWS;

