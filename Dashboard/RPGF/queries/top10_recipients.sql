SELECT DISTINCT 
  project_name,
  CASE 
    WHEN '{{Round}}' = 'Round1' THEN CAST(SUM(op_reward) AS VARCHAR) || '$'
    ELSE CAST(SUM(op_reward) AS VARCHAR) || ' OP'
  END AS total_grant_received
FROM query_5505357
WHERE round = '{{Round}}'
GROUP BY project_name
-- ORDER BY 1, SUM(op_reward) DESC
LIMIT 10;
