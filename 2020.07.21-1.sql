    create table t_board(
    i_board number primary key,
    title varchar2(100) not null,
    ctnt varchar2(2000) not null,
    i_student number not null,
    foreign key (i_student)references t_student(i_student)
);
comment on column t_board.i_student IS'작성자';

INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (1,'안녕', '112122',3);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (2,'하세요', 'ㅋㅋㅋㅋ',3);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (3,'하하', 'ㅇㅇㅇㅇ',1);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (4,'좋아요', 'ㅇㄹㅇㄹㅇㄹ',2);
INSERT INTO t_board (i_board, title, ctnt, i_student)VALUES (5,'크크','DFDF',3);

commit;
select * from t_board;

drop table t_student_hobby;