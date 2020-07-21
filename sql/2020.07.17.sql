SELECT job_id, manager_id, max(salary), min(salary), trunc(avg(salary)),count(*) 
--min():���ڰ� ���� ���� ��� , avg
FROM employees
GROUP BY job_id, manager_id
having count(*) >=5
ORDER BY job_id, manager_id;
---------------------------------------------

select lpad(salary, 8,0) from employees;
select distinct lpad(phone_number, 3) from employees;

SELECT distinct Ipad(phone_number, 3) from employees;
SELECT lpad(phone_number, 3), max(salary), min(salary)
from employees
GROUP BY lpad(phone_number, 3)
having max(salary) >= 10000;

--ceil, floor, round
SELECT job_id, max(salary), min(salary), trunc(avg(salary)),count(*), sum(salary)/count(salary) 
--group by�� �׷� �ȿ��� �����ڴٴ°��� , having�� group by�� �Բ� ����
FROM employees;

SELECT   --null���� ������ ���� ����ؼ� ���� �ʹٸ� ���ڵ� �տ� nvl�� ���̰� ,
--''�ȿ� �����ְ� ���� �� ���� ,NVL(null,'����') ���� �ִ� �ּ� ���� ���� ���� ���� �� ���� ���
DECODE(JOB_ID,'IT_PROG','���α׷���'
                ,'FI_ACCOUNT','������'
                ,'AD_VP','���̵� ������'
                ,'fff')
,CASE job_id WHEN'IT_PROG' THEN'���α׷���'
            WHEN 'FI_ACCOUNT' THEN'������'
            WHEN 'AD_VP' THEN '���̵� ������'
            ELSE 'fffff' END --else ���� ����
FROM employees;

--select nvl(�÷���,'(����)')as �÷��� from dual; �ȿ� ���� �ؾ��� �ȱ׷��� null�� �� (oracle)
--select ifnull(�÷���,'')
------------------------------------------
SELECT to_char(sysdate, 'mm-dd/yyyy')FROM dual; 

SELECT
salary, 
CASE WHEN SALARY >= 10000 THEN SALARY*3
    WHEN SALARY >= 10000 THEN SALARY*2
    ELSE SALARY - 1000 END as calcSalary
FROM employees;

DROP Table t_board;
