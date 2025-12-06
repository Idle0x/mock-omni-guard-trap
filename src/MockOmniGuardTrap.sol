// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../lib/drosera-contracts/interfaces/ITrap.sol";

contract MockOmniGuardTrap is ITrap {
    // SIMULATED STATE VARIABLES
    bool public isPaused; 
    address public lastRecipient; 
    uint256 public txCount; 

    // THRESHOLDS
    address constant BAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    uint256 constant MAX_COUNT = 10;

    // HELPER FUNCTIONS (For manual testing)
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

    // DROSERA LOGIC
    function collect() external view override returns (bytes memory) {
        return abi.encode(isPaused, lastRecipient, txCount);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        (bool paused, address recipient, uint256 count) = abi.decode(data[0], (bool, address, uint256));

        if (paused) {
            return (true, abi.encode("BRIDGE_PAUSED"));
        }

        if (recipient == BAD_ADDRESS) {
            return (true, abi.encode("BLACKLIST_INTERACTION"));
        }

        if (count > MAX_COUNT) {
            return (true, abi.encode("RATE_LIMIT_BREACH"));
        }

        return (false, bytes(""));
    }
}
