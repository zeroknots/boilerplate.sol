// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC20} from "solmate/tokens/ERC20.sol";

struct DeploymentParameters {
    address usdc;
    address weth9;
    address seaport;
    uint256 testPrivKey;
}

contract Environment {
    ERC20 public usdc;
    address public weth9;
    address public seaport;
    uint256 public privKey;

    constructor(DeploymentParameters memory params) {
        usdc = ERC20(params.usdc);
        weth9 = params.weth9;
        seaport = params.seaport;
        privKey = params.testPrivKey;
    }
}
