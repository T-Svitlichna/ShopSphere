with car_merge as (SELECT oi.category as category, 
    oi.line_total as gesamtumsatz, 
    p.margin_pct as AVG_marge,
    o.is_returned as is_ret
     
FROM shopsphere_order_items as oi
JOIN shopsphere_products as p USING(product_id)
join shopsphere_orders as o USING(order_id) )               
SELECT category, sum(gesamtumsatz) as gesamtumsatz_summe , avg(AVG_marge) as AVG_marge, 
round(100.0 * sum(case when is_ret = 1 then 1 else 0 end)/COUNT(*),2) as prc_rücksenden
from car_merge
GROUP by category
ORDER by gesamtumsatz_summe