select distinct project_name, sum(op_reward) as total_grant_received from query_5505357
where round = '{{Round}}'
group by 1
order by 2 desc
limit 10