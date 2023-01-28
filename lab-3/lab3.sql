SELECT * FROM 370lab3.employees;

create table employees(employee_id char(10),first_name varchar(20), last_name varchar(20), email varchar(60), phone_number char(14), hire_date date, job_id int, salary int , commission_pct decimal(5,3), manager_id char(10), department_id int);

insert	into employees
values("m123", "Husne","Mubarak","husne15@gmail.com",01542364711,"2020-06-3", 10, 35000, 55.000,"m123",1),
("abcd99","Naima","Tahsin","naima23@gmail.com",0134967210,"2020-05-14", 9,2000,11.000, "m123", 1),
("abcd91","Tanisha","Ahmed","tanisha27@gmail.com", 01845321701,"2020-11-2", 10, 7000, 16.000, "m123",1),
("abcd83","Mehedi","Hasan","mehedi25@gmail.com", 01945102869,"2019-02-14",3,69000,15.000,"m215",5),
("m215","Monirul","Haque","monirul21@gmail.com",01811657012,"2019-02-11",13,9700,51.000,"m215",5),
("abcd88","Intesur","Ahmed","intesur24@gmail.com",01432100781,"2019-05-17",3,8400,58.000,"m215",5),
("abcd75","Rafid","Azad","rafid8@gmail.com",01821108910,"2021-3-7",24,15000,30.000,"m301",7),
("abcd74","Raiyan","Shishir","shishir15@gmail.com",01765421301,"2021-3-12",4,21000,20.000,"m301",7),
("m301","Shihab","Sikder","shihab31@gmail.com",0164501123,"2021-9-27",4,10000,17.000,"m301",7);

drop table employees;
select * from employees;

select first_name, last_name, email, phone_number, hire_date,department_id from employees where hire_date = "2021-09-27" group by department_id; 

select first_name, last_name, employee_id, phone_number, salary,department_id from employees where hire_date ="2019-02-11" group by department_id;

select  first_name, last_name, employee_id, phone_number, salary, department_id from employees where salary = (select min(salary) from employees);

select  first_name, last_name, employee_id, commission_pct , department_id from employees where department_id = 9 and commission_pct < (select min(commission_pct) from employees where department_id = 1 or 7 );

select department_id, count(*) from employees group by department_id;

select  first_name, last_name, employee_id, email, salary ,department_id from employees where hire_date < "2020-01-01";

select first_name, last_name, employee_id, email, salary, department_id from employees  where manager_id = "m301" and salary in(select max(salary) from employees where manager_id ="m301")  ;


select department_id from employees where salary >30000 and salary in(select max(salary) from  employees GROUP BY  department_id);

select department_id, job_id ,commission_pct from employees where commission_pct not in (SELECT max(commission_pct) from employees GROUP BY department_id) ;


select first_name, last_name, employee_id, email, salary, department_id, commission_pct from employees where commission_pct in(SELECT MIN(commission_pct ) from employees GROUP BY manager_id);

select COUNT(*) from employees where employee_id = manager_id ;


select department_id, job_id ,salary from employees where salary not in (SELECT max(salary) from employees GROUP BY department_id) ;

select distinct manager_id from employees E1 where exists( select * from employees E2 where E1.manager_id = E2.manager_id and E1.salary < 1500) ;


select distinct manager_id from employees E1 where exists( select * from employees E2 where E1.manager_id = E2.manager_id and E1.commission_pct < 15.25) ;


select distinct  manager_id from employees where salary  in ( select min(salary) from employees  group by manager_id ) and salary > 3500 ;




