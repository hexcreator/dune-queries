SELECT
  DATE_TRUNC('day', block_time) AS day,
  SUM(amount_usd) AS "Volume ($)",
  COUNT(*) AS "Trades",
  platform
FROM
  nft.trades
WHERE
  blockchain = 'ethereum'
  AND block_time > CURRENT_TIMESTAMP - INTERVAL '3' day
GROUP BY
  platform,
  1
ORDER BY
  "Volume ($)" DESC
