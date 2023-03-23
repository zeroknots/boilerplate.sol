pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Parameters.sol";

import {MockContract} from "../src/MockContract.sol";

/// @title Dummy contract that always reverts
/// @notice Used as a placeholder to ensure reverts on attempted calls to protocols unsupported on a given chain
contract UnsupportedProtocol {
    error UnsupportedProtocolError();

    fallback() external {
        revert UnsupportedProtocolError();
    }
}

contract DeployBoilerplate is Script {
    using stdJson for string;

    function setUp() public {}

    function run(string memory pathToJSON) public returns (MockContract router) {
        (MyParameters memory params, address unsupported) = fetchParameters(pathToJSON);
        return run(params, unsupported);
    }

    function run(MyParameters memory params, address unsupportedProtocol) public returns (MockContract deployment) {
        // only deploy unsupported if this chain doesn't already have one
        if (unsupportedProtocol == address(0)) {
            unsupportedProtocol = address(new UnsupportedProtocol());
            console2.log("UnsupportedProtocol deployed:", unsupportedProtocol);
        }

        params = MyParameters({
            universalRouter: params.universalRouter = mapUnsupported(params.universalRouter, unsupportedProtocol),
            permit2: params.permit2 = mapUnsupported(params.permit2, unsupportedProtocol),
            weth9: params.weth9 = mapUnsupported(params.weth9, unsupportedProtocol),
            usdt: params.usdt = mapUnsupported(params.usdt, unsupportedProtocol),
            usdc: params.usdc = mapUnsupported(params.usdc, unsupportedProtocol),
            dai: params.dai = mapUnsupported(params.dai, unsupportedProtocol)
        });

        deployment = new MockContract(params);
        console2.log("MockContract deployed at", address(deployment));
    }

    function fetchParameters(string memory pathToJSON)
        internal
        view
        returns (MyParameters memory params, address unsupportedProtocol)
    {
        string memory root = vm.projectRoot();
        string memory json = vm.readFile(string.concat(root, "/", pathToJSON));
        bytes memory rawParams = json.parseRaw(".*");
        (params, unsupportedProtocol) = abi.decode(rawParams, (MyParameters, address));
    }

    function mapUnsupported(address protocol, address unsupported) internal pure returns (address) {
        return protocol == address(0) ? unsupported : protocol;
    }
}
