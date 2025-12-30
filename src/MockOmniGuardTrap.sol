// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

contract OmniGuardTrap is ITrap {
    
    // TARGET: Ethereum Beacon Deposit Contract (The "Canary")
    address public constant BEACON_VAULT = 0x00000000219ab540356cBB839Cbe05303d7705Fa;

    // THRESHOLD: Trigger if balance drops below 10M ETH (Catastrophic Drain)
    uint256 public constant SAFETY_THRESHOLD = 10_000_000 ether;

    function collect() external view override returns (bytes memory) {
        // Single cheap state read
        return abi.encode(BEACON_VAULT.balance);
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // SAFETY: Only check current block
        if (data.length == 0 || data[0].length == 0) {
            return (false, bytes(""));
        }

        uint256 currentBalance = abi.decode(data[0], (uint256));

        // LOGIC: Panic if Vault is drained below 10M ETH
        if (currentBalance < SAFETY_THRESHOLD) {
            return (true, abi.encode("CRITICAL: BEACON DRAINED"));
        }

        return (false, bytes(""));
    }
}
