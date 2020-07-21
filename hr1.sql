CREATE TABLE t_student(
 i_student number,
 nm varchar2(15)not null,  --var은 주민등록번호나 번호를 문자열로 저장하는 이유는 00이라는 변수가 있기 때문
 age number(3)not null,
 primary key(i_student) --primary key를 주면 중복된 값을 넣을 수 없다/ 왠만하면 안건드리는게 낫다
);

INSERT INTO t_student
(i_student,nm ,age)
VALUES
(11,'유영혁',20); --데이터베이스에선 문자열은 홑따옴표 ''

INSERT INTO t_student
(i_student,nm ,age)
SELECT 15, first_name, employee_id from employees where employee_id =100;

select * from t_student;

UPDATE t_student
SET nm = (select nm from employees where employee_id = 100)
,age = (select employee_id from employees where employee_id = 100) --한 레코드에 한 값이 바로 스칼라 값이다
WHERE i_student = 4; --항상 update문과 where문은 거의 같이 따라다닌다

commit;

DELETE FROM t_student
--WHERE i_student = 3;
where i_student = 1 or i_student = 2 or i_student = 3; --(여러개하려면 i_student <= 3 , i_student in(1,2,3),
--i_student >= 4 and i_student <= 7 / i_student between 4 and 7

--SELECT * FROM t_student
--where nm LIKE '김시'  --' '안에 들어있는 것이 나오게 하려면 LIKE ' ' / ' '안에 '%운%'요렇게 쓰면 들어있는 사람 다 나옴
--ORDER BY age DESC, nm DESC;

SELECT * FROM t_student
where i_student in (select i_student
                    from t_student
                    where i_student <= 4); --select 복습 또 복습

-- employees 테이블에서 전화번호(423이 포함된 사람들 모두 나오도록 해주세요)

SELECT 
    UPPER(first_name) as first_name 
FROM employees
WHERE PHONE_NUMBER LIKE '%.423.%';

--select first_name, substr(first_name, 4,2) --4번째 자리부터 2개의 숫자가 나옴
--from employees;

select first_name, instr(first_name, 'a', -1)
from employees;

select concat(concat(concat('a','b','c','d'),'c'),'d')from dual; --문자열 함수 참고 사이트 (https://kimazfactory.tistory.com/42)


--디비 시작할 때는 백업부터 시작하고 한다.