
select 
channel, 
sum(budget) as budget_mark, 
sum(attributed_reven) as sum_revenue,
sum(attributed_reven) - sum(budget)  as profit,
round((sum(attributed_reven) - sum(budget)) * 100.0 /sum(budget),2)  as profit_prc,
round(sum(attributed_reven) * 1.0 / sum(budget),2)  as profit_on_dollar,
sum(impressions), sum(clicks),sum(conversions) AS total_conversions,
round((sum(clicks)*1.0/sum(impressions))* 100,2 ) as prc_imp_klick,
round((sum(conversions)*1.0/sum(clicks))* 100,2 ) as conv

from shopsphere_marketing
group by  channel
order by year, month, profit_prc  DESC