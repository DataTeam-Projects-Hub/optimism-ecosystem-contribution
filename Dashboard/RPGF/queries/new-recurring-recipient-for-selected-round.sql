SELECT
  CASE 
    WHEN '{{Round}}' = 'All Rounds' THEN 0
    ELSE new
  END AS new,
  
  CASE 
    WHEN '{{Round}}' = 'All Rounds' THEN (
      SELECT COUNT(DISTINCT project_name) FROM query_5505357 WHERE round <> 'All Rounds'
    )
    ELSE recurring
  END AS recurring
FROM query_5518209
WHERE round = '{{Round}}' OR '{{Round}}' = 'All Rounds'
