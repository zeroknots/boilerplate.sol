<img align="right" width="150" height="150" top="100" src="./public/readme.jpg">

# Boilerplate.sol ![license](https://img.shields.io/github/license/zeroknots/boilerplate.sol?label=license) ![solidity](https://img.shields.io/badge/solidity-^0.8.0-lightgrey)

Foundry Boilerplate for Smart Contract Security Audits
### Why?
I often found myself rewriting the same boilerplate code when auditing new DeFi protocols.
You always need multiple users and interact with the target contracts a certain way.

### Usage
import Boilerplate.sol and use it in your test:

```solidity
contract MyTest is Boilerplate
```


**User account boilerplate**

Boilerplate.sol creates 5 users:
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
  usdc.approve(address(0x1234), 100);
}
```


**Fork Deployments**

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


### Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or the smart contracts. They have not been audited and as such there can be no assurance they will work as intended, and users may experience delays, failures, errors, omissions, loss of transmitted information or loss of funds. The creators are not liable for any of the foregoing. Users should proceed with caution and use at their own risk._

See [LICENSE](./LICENSE) for more details.
