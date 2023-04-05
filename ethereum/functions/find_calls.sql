SELECT
  tx_hash,
  gas,
  sub_traces,
  input,
  bytearray_substring (input, 1, 4) as "method_id", -- expression, start, length
  bytearray_substring (input, 101, 1) as "command_1" -- expression, start, length
FROM
  ethereum.traces
WHERE
  to = 0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B -- contract
  AND bytearray_substring (input, 1, 4) = 0x24856bc3 -- target method id
  AND tx_success = true
  AND bytearray_substring (input, 101, 1) = 0x10 -- seaport commands
LIMIT
  100;
