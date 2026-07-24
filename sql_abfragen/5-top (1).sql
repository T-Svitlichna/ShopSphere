select o.customer_id, c.region, c.age, o.net_amount, c.acquisition_chan, o.free_shipping 
from shopsphere_orders as o join shopsphere_customers as c USING (customer_id)
WHERE o.is_returned = 0


