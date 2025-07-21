select * from (SELECT
 distinct round as Round,
  COUNT(DISTINCT project_name) AS recipents
FROM query_5505357
GROUP BY 1)
where Round = '{{Round}}'
