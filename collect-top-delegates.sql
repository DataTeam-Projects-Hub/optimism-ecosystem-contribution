WITH delegate_snapshots AS (
  SELECT
    delegate,
    current_voting_power AS voting_power,
    block_time,
    ROW_NUMBER() OVER (
      PARTITION BY delegate
      ORDER BY block_time DESC, tx_hash DESC, evt_index DESC
    ) AS row_rank
  FROM op_governance_optimism.delegates
  WHERE block_time <= CURRENT_DATE
),

latest_delegate_state AS (
  SELECT
    delegate,
    voting_power,
    block_time
  FROM delegate_snapshots
  WHERE row_rank = 1
)

SELECT
  d.delegate,
  d.voting_power,
  d.block_time
FROM latest_delegate_state AS d
ORDER BY d.voting_power DESC
LIMIT 250;