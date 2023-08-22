select
  date_trunc('day', block_time) as day,
  sum(usd_amount) as "Volume ($)",
  count(*) as "Trades",
  platform
from
  nft.trades
where
  block_time > now() - interval '3  days'
group by
  platform,
  day
  order by "Volume ($)" desc
