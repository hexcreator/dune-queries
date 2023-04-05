# Find Function Calls
🔗 https://dune.com/queries/2330700

Using v2 Dune SQL, you can find function calls. In the query above, I find all Uniswap NFT Aggregator `execute(bytes,bytes[])` calls that start with a `Seaport` command. Technique:

1. Scan `traces` table to find all transactions sent to the Uniswap NFT Aggregator at 0xEf1c6E67703c7BD7107eed8303Fbe6EC2554BF6B.
2. Filter all txs that start with the bytes `0x24856bc3`, which is the `execute(bytes,bytes[])` function signature. [Get sigs here.](https://piyolab.github.io/playground/ethereum/getEncodedFunctionSignature/)
3. Filter all successful txs.
4. Filter by seaport command.
5. Limit to the first 100 results.

v2 Dune SQL is 1-indexed and `bytearray_substring(expression, start, length)` takes a subtring from a byte array. Each index is a byte - index 1 represents the first byte, index 2 represents the second byte, and so on. Bytes 1-4 contain the function signature in the `data` or `input` field for transactions. In the case of the Uniswap NFT Aggregator, the flow fires `execute` first; followed by calls to `dispatch` per inputted command. At `dispatch`, `Command` values determine which branch of code will execute. The list of commands can be found on their Etherscan or Github source. Seaport happens to be `0x10`, which is where that value comes from. The value `101` comes from bytes 1-4 being the function sig, and the command value being stored in the 4th storage slot of the data field which I found from reversing. Since all storage slots are 32 bytes, 101 = 32*3+5. 

If you just want to find method calls, comment out the line that checks for the individual command. If you want to be more specific and filter also by some data value, you will need to find where the value is generally stored in the data field.
