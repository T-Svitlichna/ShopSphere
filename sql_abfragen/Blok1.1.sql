select o.order_year, c.region, 
count(order_id) as count_orders, 
sum (o.net_amount) as tot_amount , 
round(sum (o.net_amount)/count(order_id),2) as avg_check,
round(sum (o.net_amount)*100/(select sum(net_amount) from shopsphere_orders where is_returned = 0),2) as amount_prc
from shopsphere_customers as c
JOIN shopsphere_orders as o USING (customer_id)
WHERE o.is_returned = 0
group by o.order_year, c.region

order by tot_amount DESC;
-- Überprüfung auf Dublicaten
SELECT customer_id, COUNT(*) as cnt
FROM shopsphere_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
-- fehlender Kunden in 
SELECT COUNT(*) FROM shopsphere_orders o
LEFT JOIN shopsphere_customers c USING (customer_id)
WHERE c.customer_id IS NULL;

