WITH all_recipients AS (
  -- Unified dataset of RPGF recipients per round
  SELECT project_name, op_reward, 'Round1' AS round FROM dune.smriti0804.dataset_round1_results
  UNION ALL
  SELECT project_name, op_reward, 'Round2' AS round FROM dune.smriti0804.dataset_round2_results
  UNION ALL
  SELECT project_name, op_reward, 'Round3' AS round FROM dune.smriti0804.dataset_round3_results
  UNION ALL
  SELECT project_name, op_reward, 'Round4' AS round FROM dune.smriti0804.dataset_round4_results
  UNION ALL
  SELECT project_name, op_reward, 'Round5' AS round FROM dune.smriti0804.dataset_round5_results
  UNION ALL
  SELECT project_name, op_reward, 'Round6' AS round FROM dune.smriti0804.dataset_round6_results
  UNION ALL
  SELECT display_name AS project_name, op_reward, 'Round7' AS round FROM dune.smriti0804.dataset_round7_results_m1
  UNION ALL
  SELECT display_name AS project_name, op_reward, 'Round7' AS round FROM dune.smriti0804.dataset_round7_results_m2
  UNION ALL
  SELECT display_name AS project_name, op_reward, 'Round7' AS round FROM dune.smriti0804.dataset_round7_results_m3
  UNION ALL
  SELECT display_name AS project_name, op_reward, 'Round7' AS round FROM dune.smriti0804.dataset_round7_results_m4
  UNION ALL
  SELECT display_name AS project_name, op_reward, 'Round7' AS round FROM dune.smriti0804.dataset_round7_results_m5
),
numbered_recipients AS (
  -- Assign numeric round numbers for logical comparison
  SELECT 
    project_name,
    round,
    CAST(REPLACE(round, 'Round', '') AS INTEGER) AS round_num
  FROM all_recipients
),
labeled_recipients AS (
  -- Determine whether recipient is "New" or "Recurring"
  SELECT 
    curr.project_name,
    curr.round,
    CASE 
      WHEN EXISTS (
        SELECT 1 
        FROM numbered_recipients prev
        WHERE prev.project_name = curr.project_name
          AND prev.round_num < curr.round_num
      ) THEN 'Recurring'
      ELSE 'New'
    END AS recipient_status
  FROM numbered_recipients curr
),
grouped AS (
  SELECT
    round,
    recipient_status,
    COUNT(DISTINCT project_name) AS count
  FROM labeled_recipients
  GROUP BY round, recipient_status
)
-- Final pivot-style output
SELECT
  round,
  COALESCE(MAX(CASE WHEN recipient_status = 'New' THEN count END), 0) AS New,
  COALESCE(MAX(CASE WHEN recipient_status = 'Recurring' THEN count END), 0) AS Recurring
FROM grouped
GROUP BY round
ORDER BY CAST(REPLACE(round, 'Round', '') AS INTEGER);
