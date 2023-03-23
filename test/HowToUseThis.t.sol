import {Boilerplate} from "./Boilerplate.t.sol";
import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";

contract MyTest is Boilerplate {
    MockERC20 usdc;

    function setUp() public {
        usdc = new MockERC20("USDC", "USDC", 6);
        makeAddr();
    }

    function testApprove() public asUser(USER1) {
        usdc.approve(address(0x1234), 100);
    }
}
