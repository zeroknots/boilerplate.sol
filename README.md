<img align="right" width="150" height="150" top="100" src="./public/readme.jpg">

# Boilerplate.sol ![license](https://img.shields.io/github/license/zeroknots/boilerplate.sol?label=license) ![solidity](https://img.shields.io/badge/solidity-^0.8.0-lightgrey)

Foundry Boilerplate for Smart Contract Security Audits:

## User account Boilerplate

I often found myself rewriting the same boilerplate code when auditing new DeFi protocols.
You always need multiple users and interact with the target contracts a certain way.

### Usage

import Boilerplate.sol and use it in your test:

```solidity
contract MyTest is Boilerplate {
  function setUp() public {
      makeAddr(); // this initializes addresses
  }
  function testFoo() public asUser(ATTACKER){
    // pwn things here
  }
}

```

Boilerplate.sol makeAddr() creates 5 users with labels.

```yml
ATTACKER: 0x1337
USER1: 0x1001
USER2: 0x1002
USER3: 0x1003
USER4: 0x1004
```

When you write your test functions, simply use the Boilerplate.sol modifier `asUser()`

```solidity
function testApprove() public asUser(USER1) {
  usdc.approve(ATTACKER, 100);
}
```


## json Boilerplate WIP

Spin up a foundry deployment and tests that point to already deployed contracts.
This can be useful to test against prod or auditing hardhat projects.

### Define Protocol Addresses

create a `.json` file with your target addresses:
```json
{
  "permit2": "0x000000000022D473030F116dDEE9F6B43aC78BA3",
  "weth9": "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
}
```

Adopt `MyParameters` to match the needs of your target.

```solidity
// src/Parameters.sol
// @dev add whatever addresses you have in your .json
struct MyParameters {
    address permit2;
    address weth9;
}
contract MyImmutables {

    address internal immutable PERMIT2;
    address internal immutable WETH9;

    constructor(MyParameters memory params) {
        PERMIT2 = params.permit2;
        WETH9 = params.weth9;
    }
}
```

Follow the `DeployWithParams.sol` example to either deploy with foundry or point to deployed contracts and start interacting wit them.

Run deployments with:
```sh 
forge script --broadcast \
--rpc-url $RPC_URL
--private-key $DEPLOYER_KEY
--sig 'run(string)' \ # neat trick to pass CLI params to foundry function
script/DeployWithParams.sol:DeployWithParams \
src/deploy/network.json \ # your .json
```

Tipp: Make sure you add file read access to your `foundry.toml`
```toml
fs_permissions = [{ access = "read", path = "./src/deploy"}]
```



### Blueprint

```txt
lib
├─ forge-std — https://github.com/foundry-rs/forge-std
├─ solmate — https://github.com/transmissions11/solmate
scripts
├─ DeployParameters.s.sol — Deploy Contract with .json parameters
src
├─ Parameters — Boilerplate to read .json file with deployed contract addresses
test
└─ Boilerplate.t — Boilerplate base for tests
```

### Notable Mentions

- [femplate](https://github.com/zeroknots/femplate)
- [foundry](https://github.com/foundry-rs/foundry)
- [solmate](https://github.com/Rari-Capital/solmate)
- [forge-std](https://github.com/brockelmore/forge-std)
- [forge-template](https://github.com/foundry-rs/forge-template)
- [foundry-toolchain](https://github.com/foundry-rs/foundry-toolchain)
- [universal-router](https://github.com/Uniswap/universal-router)

### Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._

See [LICENSE](./LICENSE) for more details.
