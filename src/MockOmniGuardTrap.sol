// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ITrap} from "drosera-contracts/interfaces/ITrap.sol";

// Interface to read our persistent Threat Feed
interface IMockThreatFeed {
    function isPaused() external view returns (bool);
    function lastRecipient() external view returns (address);
    function txCount() external view returns (uint256);
}

contract MockOmniGuardTrap is ITrap {
    
    // CONFIGURATION
    // REPLACE THIS with the address of the deployed MockThreatFeed
    address public constant THREAT_FEED = 0xYOUR_THREAT_FEED_ADDRESS_HERE;
    
    address constant BAD_ADDRESS = 0x000000000000000000000000000000000000dEaD;
    uint256 constant MAX_COUNT = 10;

    function collect() external view override returns (bytes memory) {
        // READ from the external, persistent contract
        IMockThreatFeed feed = IMockThreatFeed(THREAT_FEED);
        
        return abi.encode(
            feed.isPaused(),
            feed.lastRecipient(),
            feed.txCount()
        );
    }

    function shouldRespond(bytes[] calldata data) external pure override returns (bool, bytes memory) {
        // SAFETY 1: Planner Guards (Prevent Reverts)
        if (data.length == 0 || data[0].length == 0) {
            return (false, bytes(""));
        }

        // DECODE: Read the data we collected from the Feed
        (bool paused, address recipient, uint256 count) = 
            abi.decode(data[0], (bool, address, uint256));

        // LOGIC 1: Bridge Paused
        if (paused) {
            return (true, abi.encode("BRIDGE_PAUSED"));
        }

        // LOGIC 2: Bad Actor
        if (recipient == BAD_ADDRESS) {
            return (true, abi.encode("BLACKLIST_INTERACTION"));
        }

        // LOGIC 3: Rate Limit
        if (count > MAX_COUNT) {
            return (true, abi.encode("RATE_LIMIT_BREACH"));
        }

        return (false, bytes(""));
    }
}
