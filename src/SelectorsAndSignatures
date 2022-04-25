// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// source: twitter.com/PatrickAlphaC/status/1517156283215802368

/// @title SelectorsAndSignatures
contract SelectorsAndSignatures {
    address public s_someAddress;
    uint256 public s_amount;

    function getSelectorOne() public pure returns (bytes4 selector) {
        selector = bytes4(keccak256(bytes("transfer(address, uint256)")));
    }

    function getSelectorTwo() public view returns (bytes4 selector) {
        bytes memory functionCallData = abi.encodeWithSignature(
            "transfer(address, uint256)",
            address(this),
            123
        );

        selector = bytes4(
            bytes.concat(
                functionCallData[0],
                functionCallData[1],
                functionCallData[2],
                functionCallData[3]
            )
        );
    }

    function getCallData() public view returns (bytes memory) {
        return
            abi.encodeWithSignature(
                "transfer(address, uint256)",
                address(this),
                123
            );
    }

    function getSelectorThree(bytes calldata functionCallData)
        public
        pure
        returns (bytes4 selector)
    {
        // offset is a special attribute of calldata
        assembly {
            selector := calldataload(functionCallData.offset)
        }
    }

    function transfer(address someAddress, uint256 amount) public {
        // Some code
        S_someAddress = someAddress;
        S_amount = amount;
    }

    function getSelectorFour() public pure returns (bytes4 selector) {
        return this.transfer.selector;
    }

    function getSignature0ne() public pure returns (string memory) {
        return "transfer(address, uint256)";
    }
}
