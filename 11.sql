
with cte as (
select first_player as "p", first_score as s
from Matches
union all
select second_player as "p", second_score as s
from Matches
),
cte2 as(
select p1.player_id, p1.group_id, sum(s) as total
from cte
join Players p1
on p1.player_id=cte.p
group by p1.player_id
order by total desc, p1.player_id asc)
select cte2.group_id as GROUP_ID, cte2.player_id as PLAYER_ID
from cte2
group by group_id