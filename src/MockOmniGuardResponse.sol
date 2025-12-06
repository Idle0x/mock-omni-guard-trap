// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockOmniGuardResponse {
    event SecurityAlert(string message);

    function triggerResponse(string memory message) external {
        emit SecurityAlert(message);
    }
}
