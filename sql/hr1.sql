CREATE TABLE t_student(
 i_student number,
 nm varchar2(15)not null,  --var�� �ֹε�Ϲ�ȣ�� ��ȣ�� ���ڿ��� �����ϴ� ������ 00�̶�� ������ �ֱ� ����
 age number(3)not null,
 primary key(i_student) --primary key�� �ָ� �ߺ��� ���� ���� �� ����/ �ظ��ϸ� �Ȱǵ帮�°� ����
);

INSERT INTO t_student
(i_student,nm ,age)
VALUES
(11,'������',20); --�����ͺ��̽����� ���ڿ��� Ȭ����ǥ ''

INSERT INTO t_student
(i_student,nm ,age)
SELECT 15, first_name, employee_id from employees where employee_id =100;

select * from t_student;

UPDATE t_student
SET nm = (select nm from employees where employee_id = 100)
,age = (select employee_id from employees where employee_id = 100) --�� ���ڵ忡 �� ���� �ٷ� ��Į�� ���̴�
WHERE i_student = 4; --�׻� update���� where���� ���� ���� ����ٴѴ�

commit;

DELETE FROM t_student
--WHERE i_student = 3;
where i_student = 1 or i_student = 2 or i_student = 3; --(�������Ϸ��� i_student <= 3 , i_student in(1,2,3),
--i_student >= 4 and i_student <= 7 / i_student between 4 and 7

--SELECT * FROM t_student
--where nm LIKE '���'  --' '�ȿ� ����ִ� ���� ������ �Ϸ��� LIKE ' ' / ' '�ȿ� '%��%'�䷸�� ���� ����ִ� ��� �� ����
--ORDER BY age DESC, nm DESC;

SELECT * FROM t_student
where i_student in (select i_student
                    from t_student
                    where i_student <= 4); --select ���� �� ����

-- employees ���̺��� ��ȭ��ȣ(423�� ���Ե� ����� ��� �������� ���ּ���)

SELECT 
    UPPER(first_name) as first_name 
FROM employees
WHERE PHONE_NUMBER LIKE '%.423.%';

--select first_name, substr(first_name, 4,2) --4��° �ڸ����� 2���� ���ڰ� ����
--from employees;

select first_name, instr(first_name, 'a', -1)
from employees;

select concat(concat(concat('a','b','c','d'),'c'),'d')from dual; --���ڿ� �Լ� ���� ����Ʈ (https://kimazfactory.tistory.com/42)


--��� ������ ���� ������� �����ϰ� �Ѵ�.