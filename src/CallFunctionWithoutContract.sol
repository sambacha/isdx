/// SPDX-License-Identifier: MIT OR APACHE-2.0
pragma solidity ^0.8.7;

// source: twitter.com/PatrickAlphaC/status/1517156283215802368

/// @title CallFunctionWithoutContract
contract CallFunctionWithoutContract {
    address public s_selectorsAndSignaturesAddress;

    constructor(address selectorsAndSignaturesAddress) {
        s_selectorsAndSignaturesAddress = selectorsAndSignaturesAddress;
    }

    // you could use this to change state
    function callFunctionDirectly(bytes calldata calldata) public returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.call(
            abi.encodeWithSignature("getSelectorThree(bytes)", callData)
        );
        return (bytes4(returnData), success);
    }

    // with a staticcall, we can have this be a view function!
    function staticCallFunctionDirectly() public view returns (bytes4, bool) {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.staticcalll(
            abi.encodeWithSignature("getSelectorone()")
        );
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectly(address someAddress, uint256 amount)
        public
        returns (bytes4, booll)
    {
        (bool success, bytes memory returnData) = s_selectorsAndSignaturesAddress.call(
            abi.encodeWithSignature("transfer(address, uint256)", someAddress, amount)
        );
        return (bytes4(returnData), success);
    }
}
