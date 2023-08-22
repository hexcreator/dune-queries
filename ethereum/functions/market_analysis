select
  sum(usd_amount) as "Volume ($)",
  count(*) as "Trades",
  count(distinct(buyer)) as "Buyers",
  count(distinct(seller)) as "Sellers",
  365 as "Time"
from
  nft.trades
where
  block_time > now() - interval '365  days'
union
select
  sum(usd_amount) as "Volume ($)",
  count(*) as "Trades",
  count(distinct(buyer)) as "Buyers",
  count(distinct(seller)) as "Sellers",
  30 as "Time"
from
  nft.trades
where
  block_time > now() - interval '30  days'
union
select
  sum(usd_amount) as "Volume ($)",
  count(*) as "Trades",
  count(distinct(buyer)) as "Buyers",
  count(distinct(seller)) as "Sellers",
  7 as "Time"
from
  nft.trades
where
  block_time > now() - interval '7  days'
union
select
  sum(usd_amount) as "Volume ($)",
  count(*) as "Trades",
  count(distinct(buyer)) as "Buyers",
  count(distinct(seller)) as "Sellers",
  3 as "Time"
from
  nft.trades
where
  block_time > now() - interval '3  days'
 order by "Time" desc
