WITH badgeholder_participation AS (
  SELECT
    address,
    COUNT(DISTINCT round) AS rounds_participated
  FROM query_5499039
   where round <> 'all'
  GROUP BY address
 
)
SELECT
  rounds_participated AS num_rounds,
  COUNT(*) AS num_common_badgeholders
FROM badgeholder_participation
GROUP BY rounds_participated
ORDER BY rounds_participated;
