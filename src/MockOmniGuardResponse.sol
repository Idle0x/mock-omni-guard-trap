// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockOmniGuardResponse {
    event SecurityAlert(string message);

    // Matches the trap's return: abi.encode("STRING")
    function triggerResponse(string calldata message) external {
        emit SecurityAlert(message);
    }
}
