-- Creating DataBase for "PIZZA SHOP"
create database pizza_shop;

use pizza_shop;

-- Defining DataBase Schema while creating tables: 
-- 			customes, order, customes_order, pizza, order_pizza 
-- Total of five tables:

create table `customers`( 
	`customer_id` int not null auto_increment,
    `first_name` varchar(100) not null,
    `last_name` varchar(100) not null,
    `phone#` varchar(200) not null,
    primary key (`customer_id`)
    );

create table `order`( 
	`order_id` int not null auto_increment,
    `date&time` timestamp not null,
    primary key (`order_id`)
    );
    
 create table `pizza`( 
	`pizza_id` int not null,
    `pizza_type` varchar(200) not null,
	`price` decimal(5,2),
    primary key (`pizza_id`)
    ); 

create table customer_order ( `customer_id` int not null,
	`order_id` int not null,
	foreign key (customer_id) references `customers` (customer_id),
	foreign key (order_id) references `order` (order_id)
    );
    
create table `order_pizza` ( `order_id` int not null,
	`pizza_id` int not null,
    `pizza_quantity` int not null default 1,
    primary key (`pizza_id`, `order_id`),
	foreign key (order_id) references `order` (order_id),
	foreign key (pizza_id) references `pizza` (pizza_id)
    );

insert into `pizza`(pizza_id, pizza_type,price)
	values (1, 'Pepperoni & Cheese', 7.99);
    
insert into `pizza`(pizza_id, pizza_type,price)
	values (2, 'Vegetarian', 9.99);
    
insert into `pizza`(pizza_id, pizza_type,price)
	values (3, 'Meat Lovers', 14.99);
    
insert into `pizza`(pizza_id, pizza_type,price)
	values (4, 'Hawaiian', 12.99);
    

-- First Order:

insert into `customers`(first_name, last_name, `phone#`)
	values('Trevor', 'Page', '226-555-4982');
    
insert into `order`(`date&time`)
	values('2014-10-9 9:47:00');
    
insert into `customer_order`(customer_id, order_id)
	values(1,1);

insert into `order_pizza`(order_id,pizza_id, pizza_quantity)
	values(1,1,1);
    
insert into `order_pizza`(order_id,pizza_id, pizza_quantity)
	values(1,3,1);
    
    
-- Second Order:

insert into `customers`(first_name, last_name,`phone#`)
	values('John','Doe', '555-555-9498');

insert into `order`(`date&time`)
	values('2014-10-9 13:20:00');

insert into `customer_order`(customer_id,order_id)
	value(2,2);

insert into `order_pizza`(order_id, pizza_id, pizza_quantity)
	value(2, 2, 1);
    
insert into `order_pizza`(order_id, pizza_id, pizza_quantity)
	value(2, 3, 2);
    
-- Third order:

insert into `order`(`date&time`)
	value('2014-10-9 9:47:00');
select * from `order`;
insert into `customer_order`(customer_id, order_id)
	value(1,3);
    
insert into `order_pizza`(order_id, pizza_id, pizza_quantity)
	value(3, 3, 1);
insert into `order_pizza`(order_id, pizza_id, pizza_quantity)
	value(3, 4, 1);

-- Quering on database:

-- Q4: Now the restaurant would like to know which customers are spending the most money at their establishment. 
-- 	   Write a SQL query which will tell them how much money each individual customer has spent at their restaurant.

select c.customer_id, c.first_name, c.last_name, sum(p.price*op.pizza_quantity) from customers as c
join `customer_order` as co on c.customer_id = co.customer_id
join `order` as o on co.order_id = o.order_id
join `order_pizza` as op on o.order_id = op.order_id
join `pizza` as p on op.pizza_id = p.pizza_id
group by c.customer_id;

-- Q5: Modify the query from Q4 to separate the orders not just by customer, 
-- 	   but also by date so they can see how much each customer is ordering on which date.

select c.customer_id, c.first_name, c.last_name, date(o.`date&time`), sum(p.price*op.pizza_quantity) from customers as c
join `customer_order` as co on c.customer_id = co.customer_id
join `order` as o on co.order_id = o.order_id
join `order_pizza` as op on o.order_id = op.order_id
join `pizza` as p on op.pizza_id = p.pizza_id
group by o.`date&time`;


