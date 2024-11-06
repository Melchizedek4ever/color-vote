
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.3.1/index.ts';
import { assertEquals } from 'https://deno.land/std@0.170.0/testing/asserts.ts';

Clarinet.test({
    name: '`get-nb-of-voters` - returns the right number of voters',
    fn(chain: Chain, accounts: Map<string, Account>) {
     
      const { address } = accounts.get('wallet_1')!
  
      const block = chain.mineBlock([
        Tx.contractCall('color-vote', 'get-nb-of-voters', [], address),
      ])
  
      block.receipts[0].result.expectUint(0)
    },
  })

  Clarinet.test({
    name: '`vote` - participant can vote only one time',
    fn(chain: Chain, accounts: Map<string, Account>) {
      const { address } = accounts.get('wallet_1')!
  
      const vote = [types.uint(5), types.uint(5), types.uint(5), types.uint(5)]
  
      const block = chain.mineBlock([
        Tx.contractCall('color-vote', 'vote', vote, address),
        Tx.contractCall('color-vote', 'vote', vote, address),
      ])
  
      // check first receipt
      block.receipts[0].result.expectOk().expectBool(true)
      // check second receipt
      block.receipts[1].result.expectErr().expectUint(403)
    },
  })