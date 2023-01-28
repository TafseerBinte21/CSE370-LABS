show databases;
create database cse370lab1;
use cse370lab1;

create table users(member_id int,name varchar(25), email varchar(25), influence_count int, member_since date, multiplier int);
DROP table users;
insert	into users 
values(1,"Taylor Otwell", "	
otwell@laravel.com", 739360,"2020-6-10",10), 
(2,"Ryan Dahl", "	
otwell@laravel.com", 739360,"2020-6-10",10),
(3,"Brendan Eich", "eich@javascript.com", 	
939570,"2020-05-07",8),
(5,"Evan You", "you@vuejs.org", 	
982630,"2020-06-11",7),
(6,"Rasmus Lerdorf", "lerdorf@php.net", 	
937927,"2020-06-3",8),
(7,"Guido van Rossum", "guido@python.org", 	
968827,"2020-07-18",19),
(8,"Adrian Holovaty", "adrian@djangoproject.com", 	
570724,"2020-05-07",5),
(9,"Simon Willison", "simon@djangoproject.com", 	
864615,"2020-04-30",4),
(10,"James Gosling", "james@java.com", 	
719491,"2020-05-18",5),
(11,"Rod Johnson", "rod@spring.io", 	
601744,"2020-05-18",7),
(12,"Satoshi Nakamoto", "	
nakamoto@blockchain.com", 	
630488,"2020-05-10",10);

select *from users;
ALTER TABLE users change column influence_count followers int; 
ALTER TABLE users RENAME COLUMN member_since TO joining_date ;
select  name,email,followers from users;



ALTER TABLE users RENAME COLUMN multiplier TO multipliers;
select ((followers*100/1000000)*(multipliers*100/20))/100 AS Efficiency from users;

ALTER TABLE users MODIFY COLUMN multipliers char(2) ;

ALTER TABLE users ADD CHECK (multipliers <=20);
select *from users;

insert into  users(multipliers)
values(21);
select *from users;