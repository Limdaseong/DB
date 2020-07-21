CREATE TABLE t_hobby(
    i_hobby number primary key,
    nm varchar2(30) not null
);
commit;
select * from t_hobby;
INSERT INTO t_hobby(i_hobby, nm) VALUES (1, '독서');
INSERT INTO t_hobby(i_hobby, nm) VALUES (2, '음악감상');
INSERT INTO t_hobby(i_hobby, nm) VALUES (3, '영화감상');
INSERT INTO t_hobby(i_hobby, nm) VALUES (4, '게임');
INSERT INTO t_hobby(i_hobby, nm) VALUES (5, '산책');
INSERT INTO t_hobby(i_hobby, nm) VALUES (6, '프로그래밍');

drop table t_student;



commit;

CREATE TABLE t_student(
    nm varchar2(30) not null,
    i_student number primary key
);

INSERT INTO t_student(nm, i_student) VALUES (1, 권하균);
INSERT INTO t_student(nm, i_student) VALUES (2, 김도빈);
INSERT INTO t_student(nm, i_student) VALUES (3, 김수인);

--참조하고 있으면 지울 수 없음 기본이 restrict이다 
--지우고 싶다면 참조하고 있는 것을 다 지워야 함 
--on cascade




CREATE TABLE t_student_hobby(
    i_student number,
    i_hobby number,
    r_dt date default sysdate,
    primary key(i_student,i_hobby),
    foreign key(i_student)references t_student(i_student)on delete cascade,
    --delete할 때 cascade하겠다는 의미이다
    foreign key(i_hobby)references t_hobby(i_hobby)
);

INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (1, 2);
INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (1, 4);
INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (2, 1);
INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (3, 5);
INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (3, 3);
INSERT INTO t_student_hobby(i_student, i_hobby) VALUES (3, 1);

select
    B.i_student, B.nm as student_nm --무결성이 중요하다면 정규화를 많이 해야한다
    , A.i_hobby, C.nm as hobby_nm  --inner는 교집합이다 left는 묶이지 않는다면 null로 처리한다
from t_student_hobby A  -- 내가 쓴 글만 보고 싶다면 inner를 쓴다 (교집합)
INNER JOIN t_student B  -- left는 하나의 전체를 
ON A.i_student = B.i_student
INNER JOIN t_hobby C
ON A.i_hobby = C.i_hobby;

