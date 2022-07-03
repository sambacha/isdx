pragma solidity ^0.8.15;
library oops {
    function test(bytes calldata testData_)
        public
        pure
        returns (bytes memory testReturn)
    {
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, testData_.offset, testData_.length)
            mstore(testReturn, mload(ptr))
        }
    }
}
