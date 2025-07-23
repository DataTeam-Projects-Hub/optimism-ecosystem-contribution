WITH all_badgeholders AS (
  -- Combine all rounds with a round label
  SELECT address, 'Round2' AS round FROM dune.smriti0804.dataset_round2_citizens
  UNION ALL
  SELECT address, 'Round3' AS round FROM dune.smriti0804.dataset_round3_citizens
  UNION ALL
  SELECT address, 'Round4' AS round FROM dune.smriti0804.dataset_round4_citizens
  UNION ALL
  SELECT address, 'Round5' AS round FROM dune.smriti0804.dataset_round5_citizens
  UNION ALL
  SELECT address, 'Round6' AS round FROM dune.smriti0804.dataset_round6_citizens
  -- UNION ALL
  -- SELECT address, 'Round7' AS round FROM dune.smriti0804.dataset_round7_citizens
),
rounds_numbered AS (
  -- Assign numeric round numbers for comparison (e.g., Round2 → 2)
  SELECT
    address,
    round,
    CAST(REPLACE(round, 'Round', '') AS INTEGER) AS round_number
  FROM all_badgeholders
),
with_new_and_recurring AS (
  -- Label each badgeholder in a round as 'New' or 'Recurring'
  SELECT
    current.round,
    current.address,
    CASE
      WHEN EXISTS (
        SELECT 1
        FROM rounds_numbered prev
        WHERE prev.address = current.address
          AND prev.round_number < current.round_number
      )
      THEN 'Recurring'
      ELSE 'New'
    END AS status
  FROM rounds_numbered current
),
grouped AS (
  -- Count badgeholders by round and status
  SELECT
    round,
    status,
    COUNT(DISTINCT address) AS count
  FROM with_new_and_recurring
  GROUP BY round, status
)
-- Pivot rows to columns: one row per round with new and recurring counts
SELECT
  round,
  COALESCE(MAX(CASE WHEN status = 'New' THEN count END), 0) AS New,
  COALESCE(MAX(CASE WHEN status = 'Recurring' THEN count END), 0) AS Recurring
FROM grouped
GROUP BY round
ORDER BY CAST(REPLACE(round, 'Round', '') AS INTEGER);
