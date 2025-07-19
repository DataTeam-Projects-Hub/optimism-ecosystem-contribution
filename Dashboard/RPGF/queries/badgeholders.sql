-- Count of badgeholders selected per round
select * from (SELECT
 distinct round as Round,
  COUNT(DISTINCT address) AS badgeholders_selected
FROM (-- All individual rounds
SELECT *, 'round2' AS round FROM dune.smriti0804.dataset_round2_citizens
UNION ALL
SELECT *, 'round3' AS round FROM dune.smriti0804.dataset_round3_citizens
UNION ALL
SELECT *, 'round4' AS round FROM dune.smriti0804.dataset_round4_citizens
UNION ALL
SELECT *, 'round5' AS round FROM dune.smriti0804.dataset_round5_citizens
UNION ALL
SELECT *, 'round6' AS round FROM dune.smriti0804.dataset_round6_citizens
UNION ALL
SELECT *, 'round7' AS round FROM dune.smriti0804.dataset_round7_citizens

-- Add the union of all rounds 
UNION ALL
SELECT *, 'all' AS round FROM (
  SELECT * FROM dune.smriti0804.dataset_round2_citizens
  UNION ALL
  SELECT * FROM dune.smriti0804.dataset_round3_citizens
  UNION ALL
  SELECT * FROM dune.smriti0804.dataset_round4_citizens
  UNION ALL
  SELECT * FROM dune.smriti0804.dataset_round5_citizens
  UNION ALL
  SELECT * FROM dune.smriti0804.dataset_round6_citizens
  UNION ALL
  SELECT * FROM dune.smriti0804.dataset_round7_citizens
) AS all_data;
)
GROUP BY 1)
where Round = '{{Round}}'

