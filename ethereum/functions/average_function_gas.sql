SELECT
  AVG(gas_used) AS average_gas_units_used,
  AVG(gas_price) AS average_gas_price_in_wei,
  AVG(gas_used) * AVG(gas_price) AS wei_paid
FROM
  ethereum.transactions
WHERE
  to = 0xE592427A0AEce92De3Edee1F18E0157C05861564 -- Uniswap V3 Router contract
  AND bytearray_substring(data, 1, 4) = 0x414bf389 -- 'exactInputSingle' method id
  AND block_time > CURRENT_TIMESTAMP - INTERVAL '30' day -- last X days
