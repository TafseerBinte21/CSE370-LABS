create table customer(customer_id varchar(10) not null, customer_name varchar(20) not null,
customer_street varchar(30), customer_city varchar(30), primary key (customer_id)) ;

create table branch (branch_name varchar(15), branch_city varchar(30), assets int, primary key
(branch_name), check (assets >= 0)) ;

create table account(
branch_name varchar(15),
account_number varchar(10) not null,
balance int,
primary key (account_number),
check (balance >= 0)) ;


create table loan
(loan_number varchar(10) not null,
branch_name varchar(15),
amount int,
primary key (loan_number));

create table depositor
(customer_id varchar(10) not null,
account_number varchar(10) not null,
primary key (customer_id,account_number),
foreign key (customer_id) references customer(customer_id),
foreign key (account_number) references account(account_number));

create table borrower (customer_id varchar(10) not null,
loan_number varchar(10) not null,
primary key (customer_id, loan_number),
foreign key (customer_id) references customer(customer_id),
foreign key (loan_number) references loan(loan_number));


drop table borrower;
drop table depositor;
drop table loan;
drop table account;
drop table branch;
drop table customer;

insert into customer values
('C-101','Jones', 'Main', 'Harrison'), ('C-201','Smith', 'North', 'Rye'),('C-211','Hayes', 'Main',
'Harrison'), ('C-212','Curry', 'North', 'Rye'),('C-215','Lindsay', 'Park', 'Pittsfield'),('C-220','Turner',
'Putnam', 'Stamford'),('C-222','Williams', 'Nassau', 'Princeton'),('C-225','Adams', 'Spring',
'Pittsfield'),('C-226','Johnson', 'Alma', 'Palo Alto'),('C-233','Glenn', 'Sand Hill', 'Woodside'),('C-234','Brooks', 'Senator', 'Brooklyn'),('C-255','Green', 'Walnut', 'Stamford');

select *from customer;

insert into branch values
('Downtown', 'Brooklyn',9000000), ('Redwood', 'Palo Alto',2100000), ('Perryridge',
'Horseneck',1700000), ('Mianus', 'Horseneck',400000), ('Round Hill', 'Horseneck',8000000),
('Pownal', 'Bennington',300000), ('North Town', 'Rye',3700000), ('Brighton',
'Brooklyn',7100000);

select *from branch;

insert into  account  values ('Downtown','A-101',500), ('Mianus','A-215',700)  ,('Perryridge','A-102',400), ('Round Hill','A-305',350),  ('Brighton','A-201',900),  ('Redwood','A-222',700),  ('Brighton','A-217',750);

select *from account;

insert into loan values
('L-17', 'Downtown', 1000),('L-23', 'Redwood', 2000), ('L-15', 'Perryridge', 1500), ('L-14',
'Downtown', 1500), ('L-93', 'Mianus', 500), ('L-11', 'Round Hill', 900), ('L-16', 'Perryridge',
1300);

select *from loan;

insert into  depositor  values ('C-226',  'A-101'),  ('C-201',  'A-215'),  ('C-211',  'A-102'),  ('C-220',  'A-305'),  ('C-226',  'A-201'),  ('C-101',  'A-217'),('C-215',  'A-222');

select *from depositor;

insert into  borrower  values ('C-101',  'L-17'),  ('C-201', 'L-23'),  ('C-211',  'L-15'),  ('C-226',  'L-14'),  ('C-212',  'L-93'),  ('C-201',  'L-11'),  ('C-222',  'L-17'),  ('C-225',  'L-16');

select *from borrower;

select c.customer_name, b.loan_number from customer c, borrower b, loan l where c.customer_id = b.customer_id and b.loan_number = l.loan_number and l.branch_name = "Downtown" ;

select  branch_name, branch_city from branch where assets > any(select Min(assets) from branch where branch_city = "Horseneck") ;

select branch_name, branch_city from branch where assets > any (select Min(assets) from branch where branch_city = "Horseneck") and branch_city != "Horseneck"; 


select b.branch_name, COALESCE(depositor.depositor_number,0) as no_of_depositor from branch b Left Join (select branch_name, count(account_number) as depositor_number from account group by branch_name) depositor on b.branch_name = depositor.branch_name;

select distinct c1.customer_name as Customer1, c2.customer_name as Customer2, c1.customer_city as city from customer c1, customer c2 where c1.customer_name != c2.customer_name and c1.customer_city = c2.customer_city Group by c1.customer_city;

select distinct branch_name as Branch_name, (sum(balance)*0.04) as Total_Interest from account group by branch_name;

select city.City, city.account_number from (Select b.branch_city as city, a.account_number, max(Balance)  from Branch b, (Select branch_name, account_number, max(balance) as Balance from account group by branch_name) a where b.branch_name = a.branch_name group by branch_city ) city;

select account_number, balance from account where balance in (select max(balance) from account inner join branch on account.branch_name = branch.branch_name group by branch_city);

select branch_name from branch where assets < all(select Min(assets) from branch where branch_city = "Brooklyn");

select  c.customer_name, l.loan_number,l.amount from  (select loan_number, amount from loan order by amount desc limit 5) l, borrower b, customer c where l.loan_number = b.loan_number and c.customer_id = b.customer_id order by l.amount ;

select customer_name, loan_number, amount from (select C.customer_name, B.loan_number, L.amount from customer C, borrower B, loan L where C.customer_id=B.customer_id and B.loan_number=L.loan_number order by amount desc, loan_number desc limit 5)sub order by amount asc, loan_number desc;

select c.customer_name from customer c, depositor d, account a, loan l, borrower b where c.customer_id=d.customer_id and d.account_number=a.account_number and a.branch_name="Perryridge" and c.customer_id=b.customer_id and b.loan_number=l.loan_number and l.branch_name="Perryridge";
 
select customer_id, sum(amount) from loan L inner join borrower b on b.loan_number = L.loan_number group by b.customer_id  having count(b.customer_id) >=2;

select sum(l.amount) from (select loan_number from borrower where customer_id in (select customer_id from borrower group by customer_id having count(*)>1)) b, loan l where b.loan_number=l.loan_number;




