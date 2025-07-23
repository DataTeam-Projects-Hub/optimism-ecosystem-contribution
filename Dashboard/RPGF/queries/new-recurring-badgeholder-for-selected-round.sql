SELECT
  CASE 
    WHEN '{{Round}}' = 'All Rounds' THEN 0
    ELSE new
  END AS new,
  
  CASE 
    WHEN '{{Round}}' = 'All Rounds' THEN (
      SELECT COUNT(DISTINCT address) FROM query_5499039 WHERE round <> 'All Rounds'
    )
    ELSE recurring
  END AS recurring
FROM query_5518017
WHERE round = '{{Round}}' OR '{{Round}}' = 'All Rounds'
