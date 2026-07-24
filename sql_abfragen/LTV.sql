WITH customer_total AS (
 SELECT customer_id, SUM(net_amount) AS gesamt_umsatz
 FROM shopsphere_orders
 WHERE is_returned = 0
  GROUP BY customer_id
)
SELECT 
    c.acquisition_chan,
  COUNT(c.customer_id) AS anzahl_kunden,
 ROUND(AVG(ct.gesamt_umsatz), 2) AS avg_ltv
FROM shopsphere_customers AS c
JOIN customer_total AS ct USING (customer_id)
GROUP BY c.acquisition_chan
ORDER BY avg_ltv DESC