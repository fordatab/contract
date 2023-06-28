# Using the contract
Download the contract from this link: [contract](https://github.com/fordatab/contract/blob/main/contract.sol)\
First, compile the contract in the IDE and then deploy it with either 
account `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` or account 
`0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`.\
Owner one: `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` can only transfer on 
Mondays, Wednesdays, Fridays, and Sundays while owner two: 
`0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` can transfer on the other days.

### Methods
| Method            | Description                                                                                                                             | Parameters                                                                                           |
|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| *mint*            | Mints an amount of tokens to the passed address                                                                                         | receiver: The `address` to receive the tokens<br/> amount: the `uint256` of tokens to be minted      |
| *transfer*        | Transfers a given amount of tokens from one account to another; <br/>day restrictions and insufficient balances will throw an exception | receiver: The `address` to receive the tokens<br/> amount: the `uint256` of tokens to be transferred |
| *reset_balances*  | Resets all balances of the wallets, for testing                                                                                         | *None*                                                                                               |

All other methods are getter functions for convenience.
