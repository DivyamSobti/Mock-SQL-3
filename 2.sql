with c as (
select o.item_id,o.seller_id, i.item_brand,RANK() OVER (PARTITION BY seller_id ORDER BY order_date ASC) AS rnk
from Orders o
join items i
on o.item_id=i.item_id
),
c2 as (select c.item_brand,c.seller_id
from c
where rnk=2)
select u.user_id as seller_id, 
case 
when u.favorite_brand=c2.item_brand then 'yes'
else 'no'
end as 2nd_item_fav_brand
from users u
left join c2
on u.user_id=c2.seller_id