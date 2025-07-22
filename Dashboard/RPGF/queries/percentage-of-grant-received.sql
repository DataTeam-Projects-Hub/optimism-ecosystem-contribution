SELECT 
  DISTINCT project_name, 
  SUM(op_reward) AS total_grant_received,
  ROUND(
    SUM(op_reward) / SUM(SUM(op_reward)) OVER (), 
    2
  ) AS percentage_of_total_grant
FROM 
  query_5505357
WHERE 
  round = '{{Round}}'
GROUP BY 
  project_name
ORDER BY 
  total_grant_received DESC;
