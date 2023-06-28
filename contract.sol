// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "hardhat/console.sol";

contract Token {
    // Addresses of owners
    address public owner_1;
    address public owner_2;
    // Map address to balances
    mapping (address => uint) public balances;

    // Event of sending tokens
    event Sent(address from, address to, uint amount);

    // Constructor, set owner_1 to creator
    constructor() {
        console.log(msg.sender);
        owner_1 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        owner_2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    }

    // Modifier that checks if caller is an owner
    modifier onlyOwner() {
        require(owner_1 == msg.sender || owner_2 == msg.sender);
        _;
    }
    
    // TODO: testing
    // Function that adds tokens to balances
    function mint(address receiver, uint amount) public onlyOwner {
        balances[receiver] += amount;
    }
    // TODO: testing
    // Function that transfers tokens
    function transfer (address receiver, uint amount) public onlyOwner {
        // Boolean if able to transfer, default is true
        bool can_transfer = true;
        // Subtract 3 hours - 10800 seconds to account for GMT-3 (Eastern Time)
        uint32 time = (uint32) ((block.timestamp-10800) % 604800) / 86400;
        // Check if Thursday, Saturday, or Tuesday
        if (time == 0 || time == 2 || time == 5) {
            // If second owner, owner cannot transfer
            if (msg.sender == owner_1) {
                // console.log("a");
                can_transfer = false;
            }
        // If first owner, owner cannot transfer
        } else if (msg.sender == owner_2) {
            // console.log("b");
            can_transfer = false;
        }
        // Check if can transfer
        if (!can_transfer) {
            // console.log("c");
            revert CannotTransfer({time: time});
        }
        // Check if transfer amount is valid
        if (amount > balances[msg.sender]) {
            // console.log("d");
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });
        }
        // Transfer tokens
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        // Emit transfer event
        emit Sent(msg.sender, receiver, amount);
    }

    // Errors
    error InsufficientBalance(uint requested, uint available);
    error CannotTransfer(uint time);

    function get_owner_1_balance() public view returns (uint) {
        return balances[owner_1];
    }

    function get_owner_2_balance() public view returns (uint) {
        return balances[owner_2];
    }

    function reset_balances() public {
        balances[owner_1] = 0;
        balances[owner_2] = 0;
    }
}
