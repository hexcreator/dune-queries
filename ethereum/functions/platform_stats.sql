 SELECT
  DATE_TRUNC('day', block_time) AS day,
  SUM(amount_usd) AS "Volume ($)",
  COUNT(*) AS "Trades",
  aggregator_name AS platform
FROM nft.trades
WHERE
  blockchain = 'ethereum' AND block_time > CURRENT_TIMESTAMP - INTERVAL '3' day
GROUP BY
  aggregator_name,
  1
ORDER BY
  "Volume ($)" DESC
