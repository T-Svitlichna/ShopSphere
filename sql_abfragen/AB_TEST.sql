WITH Rangfolge AS (
    SELECT 
        o.order_id AS Bestell_ID,
        o.customer_id AS Kunden_ID,
        o.ab_variant AS Testgruppe,
        o.net_amount AS nettoumsatz,
        JULIANDAY(o.order_date) - JULIANDAY(c.signup_date) AS Tage_seit_Anmeldung,
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS Reihenfolge
    FROM shopsphere_orders as o
    JOIN shopsphere_customers as c USING(customer_id)
    WHERE o.ab_variant IN ('A', 'B')
),
Ergebnis AS (
    SELECT *,
        CASE 
       WHEN Reihenfolge = 1 AND Tage_seit_Anmeldung <= 60 THEN 'Neukunde'
       ELSE 'Bestandskunde'
       END AS Kundentyp
    FROM Rangfolge
)
SELECT 
Bestell_ID,
Testgruppe,
nettoumsatz,
 Kundentyp
FROM Ergebnis;