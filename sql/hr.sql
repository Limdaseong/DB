select * from i_student order by i_student desc;

commit;


delete from i_student
where i_student = 10;


rollback;