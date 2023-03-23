// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract Boilerplate is Test {
    using stdStorage for StdStorage;

    address public ATTACKER;
    address public USER1;
    address public USER2;
    address public USER3;
    address public USER4;

    bool public activePrank;

    function suStart(address user) public {
        vm.startPrank(user);
        activePrank = true;
    }

    function suStop() public {
        vm.stopPrank();
        activePrank = false;
    }

    modifier su(address user) {
        suStart(user);
        _;
        suStop();
    }

    function makeAddr() public {
        ATTACKER = address(0x1337);
        vm.label(ATTACKER, "ATTACKER");
        USER1 = address(0x1001);
        vm.label(USER1, "USER1");
        USER2 = address(0x1002);
        vm.label(USER2, "USER2");
        USER3 = address(0x1003);
        vm.label(USER3, "USER3");
        USER4 = address(0x1004);
        vm.label(USER4, "USER4");
    }

    function readSlot(address target, bytes4 selector) public returns (bytes32) {
        uint256 slot = stdstore.target(target).sig(selector).find();
        return vm.load(target, bytes32(slot));
    }
}
