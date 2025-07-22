select distinct Address ,
name,
count(round) as Number_of_rounds_selected
from query_5499039
where round <> 'All Rounds'
group by 1,2
