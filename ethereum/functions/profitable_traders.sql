WITH sales AS(
SELECT seller, sum(original_amount), sum(usd_amount) AS usd_amount, count(*) as total
FROM NFT.trades
WHERE original_currency = 'ETH'
AND block_time >= now() - interval '3 days'
GROUP BY seller), 

buys AS(
SELECT buyer, sum(original_amount), 
sum(original_amount) AS usd_amount,
count(*) as total
FROM NFT.trades
WHERE original_currency = 'ETH'
AND block_time >= now() - interval '3 days'
GROUP BY buyer),

ens as (
SELECT distinct on (address)
name, address
FROM (
SELECT distinct on (name) 
name, address, updated_at
FROM labels.labels
WHERE "type" = 'ens name'
ORDER BY name, updated_at desc
) temp
ORDER BY address, updated_at desc
)

SELECT CASE WHEN ens.name IS NOT NULL 
THEN CONCAT('<a href="https://etherscan.io/address/0', substring(sales.seller::text from 2),'" target="_blank" >', CONCAT(ens.name, '.eth') , '</a>')
ELSE CONCAT('<a href="https://etherscan.io/address/0', substring(sales.seller::text from 2),'" target="_blank" >', CONCAT('0', substring(sales.seller::text from 2)) , '</a>')
END as "Wallet",
(sales.sum - buys.sum) AS "Profit/Loss (Ξ)",
sales.sum AS "Ξ Received",
buys.sum AS "Ξ Spent",
sales.usd_amount AS "$ Received",
CASE WHEN
buys.sum < 0.25 THEN 0
ELSE ((sales.sum - buys.sum)/buys.sum) END AS "P/L % (Ξ)",
buys.total + sales.total as "Total # of trades",
buys.sum+sales.sum as "Total trading volume (Ξ)",
CONCAT('<a href="https://etherscan.io/address/0', substring(sales.seller::text from 2),'" target="_blank" >', CONCAT('0', substring(sales.seller::text from 2)) , '</a>') as "Wallet Address"

FROM sales
JOIN buys
ON sales.seller = buys.buyer
JOIN ens
ON sales.seller = ens.address
ORDER BY 2 DESC
