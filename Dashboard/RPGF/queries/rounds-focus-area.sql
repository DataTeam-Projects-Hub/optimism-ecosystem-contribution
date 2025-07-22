select * from (SELECT
  'Round1' AS "Round",
  'Early Optimistic Ethereum Contributors' AS "Focus_Area",
  'Reward early projects that contributed foundational value to the Optimistic Ethereum ecosystem before the Optimism Collective officially launched.' AS "Description"
  union all
SELECT
  'Round2' AS "Round",
  'OP Stack' AS "Focus_Area",
  'Fund public goods supporting OP Stack development, usability, and awareness.' AS "Description"
  union all
SELECT
  'Round3' AS "Round",
  'Multi-Category Expansion :OP Stack, Collective Governance, Developer Ecosystem, End User Experience & Adoption' AS "Focus_Area",
  'Reward contributors who created a measurable positive impact for the Optimism Collective, closing the gap between impact and profit in alignment with the impact = profit principle.' AS "Description"
  union all    
SELECT
  'Round4' AS "Round",
  'Onchain Builders' AS "Focus_Area",
  'Reward builders who deployed contracts on the Superchain and contributed to increased blockspace demand and collective value.' AS "Description"
  union all
SELECT
  'Round5' AS "Round",
  'OP Stack Contributors' AS "Focus_Area",
  'Reward contributors to the OP Stack core infrastructure, research and development, and accessibility tooling.' AS "Description"
  union all
SELECT
  'Round6' AS "Round",
  'Governance Contributors' AS "Focus_Area",
  'Reward impactful contributions to Optimism Governance, including infrastructure, analytics, and leadership that strengthen decentralized decision-making.' AS "Description"
  union all
SELECT
  'Round7' AS "Round",
  'Dual-Track Innovation' AS "Focus_Area",
  'Reward projects enabling cross-chain activity and driving Superchain adoption using data to measure real onchain impact.' AS "Description"
)
order by 1