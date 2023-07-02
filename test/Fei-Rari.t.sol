// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "forge-std/Test.sol";
import "./Exploit.sol";

contract FeiRari is Test, RelevantContracts {
    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    function setUp() public {
        /**
         * SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE
         */
        uint256 forkId = vm.createFork(MAINNET_RPC_URL, 14684813);
        vm.selectFork(forkId);
        assertEq(block.number, 14684813);
        console.log(unicode"🧨 Let's see if you can break it... 🧨");

        vm.label(address(rariComptroller), "rariComptroller");
        vm.label(address(fUSDC), "fUSDC");
        vm.label(address(fUSDT), "fUSDT");
        vm.label(address(fFRAX), "fFRAX");
        vm.label(address(fETH), "fETH");
        vm.label(address(usdc), "USDC");
        vm.label(address(usdt), "USDT");
        vm.label(address(frax), "FRAX");
        vm.label(address(weth), "WETH");
        vm.label(address(vault), "Vault");
    }

    function testExploit() public {
        /**
         * EXPLOIT START *
         */
        MasterAttacker attacker = new MasterAttacker();
        attacker.attackFeiRari();
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
        assertEq(address(fETH).balance, 0, "ETH not completely stolen");
        assertEq(usdc.balanceOf(address(fUSDC)), 0, "USDC not completely stolen");
        assertEq(usdt.balanceOf(address(fUSDT)), 0, "USDT not completely stolen");
        assertEq(frax.balanceOf(address(fFRAX)), 0, "FRAX not completely stolen");
    }
}
