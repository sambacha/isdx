pragma solidity >=0.5.0 <0.9.0;
import "ds-test/test.sol";

// ------------------------------------------------------------------
// Test Harness
// ------------------------------------------------------------------
contract Hevm {
    function warp(uint) public;
}
contract GasMeterFactory {
    /*
    A GasMeter is a contract that returns the exact value of the gas provided
    in any call to it. It must be writtten in bytecode directly as the solidity
    function dispatch code already consumes gas, so any solidity implementation
    will always return an incorrect result.
    Bytecode:
    ---
    0x5a  0x60   0x02  0x01  0x60   0x00  0x52    0x60   0x20  0x60   0x00  0xf3
    GAS   PUSH1  2     ADD   PUSH1  0     MSTORE  PUSH1  32    PUSH1  0     RETURN
    Initcode:
    ---
    0x6b    0x5a  0x60  0x02  0x01  0x60  0x00  0x52  0x60  0x20  0x60  0x20  0x60  0x00  0xf3
    PUSH12
    0x60   0x00  0x52    0x60   0x20  0x60   0x14  0xf3
    PUSH1  0     MSTORE  PUSH1  32    PUSH1  20    RETURN
    */

    function build() public returns (address out) {
      assembly {
        mstore(mload(0x40), 0x6b5a60020160005260206000f360005260206014f3)
        out := create(0, add(11, mload(0x40)), 21)
      }
    }
}
