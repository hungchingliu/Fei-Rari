// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./Exploit.sol";

contract FeiRari is Test {
    address public constant fEth = 0x26267e41CeCa7C8E0f143554Af707336f27Fa051;
    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
     
    function setUp() public {
        /**
         * SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE
         */
        uint256 forkId = vm.createFork(MAINNET_RPC_URL, 14684813);
        vm.selectFork(forkId);
        assertEq(block.number, 14684813);
        console.log(unicode"🧨 Let's see if you can break it... 🧨");
    }

    function testExploit() public {
        /**
         * EXPLOIT START *
         */
        FuseFeiAttack attacker = new FuseFeiAttack();
        attacker.fuseFeiAttack();
        /**
         * EXPLOIT END *
         */
        validation();
        console.log(unicode"\n🎉 Congratulations, you can go to the next level! 🎉");
    }

    function validation() internal {
        /**
         * SUCCESS CONDITIONS
         */
        // All Eth in FEth pool have been Rekt
        assertEq(fEth.balance, 0);
    }
}