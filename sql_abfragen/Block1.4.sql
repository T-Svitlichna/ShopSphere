WITH kunden_ausgaben AS (
    SELECT customer_id, SUM(net_amount) AS gesamt_ausgabe
    FROM shopsphere_orders
    WHERE is_returned = 0
    GROUP BY customer_id
),
durchschnitt_ausgabe AS (
    SELECT AVG(gesamt_ausgabe) AS avg_kunden_ausgabe
    FROM kunden_ausgaben
)
SELECT (SELECT COUNT(*)  FROM kunden_ausgaben) as anzahk_kunden,
    COUNT(CASE WHEN gesamt_ausgabe > avg_kunden_ausgabe THEN 1 END) AS anzahl_kunden_über_avg,
    ROUND(
        SUM(CASE WHEN gesamt_ausgabe > avg_kunden_ausgabe THEN gesamt_ausgabe ELSE 0 END) * 100.0 
        / (SELECT SUM(gesamt_ausgabe) FROM kunden_ausgaben), 
    2) AS umsatzanteil_prc
FROM kunden_ausgaben
CROSS JOIN durchschnitt_ausgabe