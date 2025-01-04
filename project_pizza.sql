create database Project;

use project;

-- 1.retrieve the total number of orders placed.
select count(order_id) as total_orders from orders_;

-- 2.calculate the total revenue generated from the pizza sales.
SELECT 
    round(SUM(order_details_.quantity * pizzas_.price),2) AS total_revenue
FROM
    order_details_
        JOIN
    pizzas_ ON order_details_.pizza_id = pizzas_.pizza_id;

-- 3.identify the highest prized pizza.
select * from pizza_types_;
SELECT 
    pizza_types_.name, pizzas_.price AS highest_priced_pizza
FROM
    pizza_types_
        JOIN
    pizzas_ ON pizza_types_.pizza_type_id = pizzas_.pizza_type_id
ORDER BY pizzas_.price Desc; 

-- 4.identify the most common pizza size ordered.
SELECT 
    pizzas_.size,
    COUNT(order_details_.order_details_id) AS order_count
FROM
    pizzas_
        JOIN
    order_details_ ON pizzas_.pizza_id = order_details_.pizza_id
GROUP BY pizzas_.size
ORDER BY order_count DESC;

-- 5.list the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types_.name, SUM(order_details_.quantity) AS quantity
FROM
    pizza_types_
        JOIN
    pizzas_ ON pizza_types_.pizza_type_id = pizzas_.pizza_type_id
        JOIN
    order_details_ ON order_details_.pizza_id = pizzas_.pizza_id
GROUP BY pizza_types_.name
ORDER BY quantity DESC
LIMIT 5;

-- 6.join the necessary tables to find total quantity of each pizza category.
SELECT 
    pizza_types_.category,
    SUM(order_details_.quantity) AS total_quantity
FROM
    pizza_types_
        JOIN
    pizzas_ ON pizza_types_.pizza_type_id = pizzas_.pizza_type_id
        JOIN
    order_details_ ON order_details_.pizza_id = pizzas_.pizza_id
GROUP BY pizza_types_.category
ORDER BY total_quantity DESC;

-- 7.determine the distribution of orders by hours of the day.
select hour(time),count(order_id) from orders_ group by hour(time);

-- 8.join relevant tables to find the category wise distribution of pizzas.
select category,count(name) from pizza_types_ group by category;

-- 9.group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) as avg_pizza_ordered_per_day
FROM
    (SELECT 
        orders_.date, SUM(order_details_.quantity) AS quantity
    FROM
        orders_
    JOIN order_details_ ON orders_.order_id = order_details_.order_id
    GROUP BY orders_.date) AS order_quantity;


-- 10.determine the top 3 most ordered pizzas types based on revenue. 
SELECT 
    pizza_types_.name,
    SUM(order_details_.quantity * pizzas_.price) AS revenue
FROM
    pizza_types_
        JOIN
    pizzas_ ON pizzas_.pizza_type_id = pizza_types_.pizza_type_id
        JOIN
    order_details_ ON order_details_.pizza_id = pizzas_.pizza_id
GROUP BY pizza_types_.name
ORDER BY revenue DESC
LIMIT 3;





