// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/MockOmniGuardTrap.sol";
import "../src/MockOmniGuardResponse.sol";

contract Deploy is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MockOmniGuardTrap trap = new MockOmniGuardTrap();
        MockOmniGuardResponse response = new MockOmniGuardResponse();

        console.log("Trap Address:", address(trap));
        console.log("Response Address:", address(response));

        vm.stopBroadcast();
    }
}
