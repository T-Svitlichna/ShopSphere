SELECT c.customer_id,
    c.region,
    c.acquisition_chan,
    sum(o.net_amount) as netto_umsatz,
    count(o.order_id) as anzahl_bestellungen, round(sum (o.net_amount)/count(o.order_id),2) as avg_check

FROM shopsphere_customers AS c
JOIN shopsphere_orders AS o USING(customer_id)
WHERE o.is_returned = 0
GROUP BY c.customer_id, c.region, c.acquisition_chan
ORDER BY  netto_umsatz DESC
LIMIT 10