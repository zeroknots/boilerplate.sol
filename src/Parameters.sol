pragma solidity ^0.8.0;

struct MyParameters {
    address universalRouter;
    address permit2;
    address weth9;
    address usdc;
    address usdt;
    address dai;
}

contract MyImmutables {
    address internal immutable UNIVERSAL_ROUTER;
    address internal immutable PERMIT2;
    address internal immutable WETH9;
    address internal immutable USDT;
    address internal immutable USDC;
    address internal immutable DAI;

    constructor(MyParameters memory params) {
        UNIVERSAL_ROUTER = params.universalRouter;
        PERMIT2 = params.permit2;
        WETH9 = params.weth9;
        USDT = params.usdt;
        USDC = params.usdc;
        DAI = params.dai;
    }
}
