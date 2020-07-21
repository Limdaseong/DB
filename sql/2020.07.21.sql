create table t_board(
    i_board number primary key,
    title varchar2(100) not null,
    ctnt varchar2(2000) not null,
    i_student number not null,
    foreign key (i_student)references t_student(i_student)
);
comment on column t_board.i_student IS'�ۼ���';

INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (1,'�ȳ�', '112122',3);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (2,'�ϼ���', '��������',3);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (3,'����', '��������',1);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (4,'���ƿ�', '������������',2);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (5,'ũũ','DFDF',3);

commit;
select * from t_board;

DROP TABLE t_student;

SELECT * FROm t_student;
