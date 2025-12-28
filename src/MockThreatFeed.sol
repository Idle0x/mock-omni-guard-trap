// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockThreatFeed {
    // STATE VARIABLES (These persist on-chain)
    bool public isPaused; 
    address public lastRecipient; 
    uint256 public txCount; 

    // HELPERS: You call these to simulate an attack
    function setPaused(bool _status) external {
        isPaused = _status;
    }

    function setRecipient(address _recipient) external {
        lastRecipient = _recipient;
    }

    function incrementCount() external {
        txCount++;
    }

    function resetCount() external {
        txCount = 0;
    }
}
