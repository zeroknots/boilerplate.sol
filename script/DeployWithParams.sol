// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/StdJson.sol";
import "forge-std/Script.sol";
import {DeploymentParameters, Environment} from "./Parameters.sol";


contract DeployUniversalRouter is Script {
    using stdJson for string;

    function run(DeploymentParameters memory params) public returns (Environment) {
        vm.startBroadcast();
        Environment env = new Environment(params);

        // insert other deployment logic here
        vm.stopBroadcast();

        return env;
    }

    function run(string memory pathToJSON) public returns (Environment) {
        (DeploymentParameters memory params) = fetchParameters(pathToJSON);
        return run(params);
    }

    function fetchParameters(string memory pathToJSON) internal view returns (DeploymentParameters memory params) {
        string memory root = vm.projectRoot();
        string memory json = vm.readFile(string.concat(root, "/", pathToJSON));
        bytes memory rawParams = json.parseRaw(".*");

        (,, params) = abi.decode(rawParams, (address, address, DeploymentParameters));
    }
}
