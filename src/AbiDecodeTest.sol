pragma solidity >=0.4.22 <0.7.0;

contract AbiDecodeTest {
    //test data: 0xb82fedbbee8ea5499c660b8322896ada651fc8774b4a23e582b75e8f8e51d629da556a7400000000000000000000000035d76d9fad7c95873266deffd2be50ce2c350c37dbb31252d9bddb4e4d362c7b9c80cba74732280737af97971f42ccbdc716f3f3efb1db366880e52d09b1bfd59842e833f3004088892b7d14b9ce9e957cea9a82

    //execution cost: 860 gas
    function abiDecodeTest(
        bytes memory _data
    )
        public
        pure
        returns(
            bytes4 sig,
            bytes32 label,
            address account,
            bytes32 pubkeyA,
            bytes32 pubkeyB
        )
    {
        assembly {
            sig := mload(add(_data, 32))
            label := mload(add(_data, 36))
            account := mload(add(_data, 68))
            pubkeyA := mload(add(_data, 100))
            pubkeyB := mload(add(_data, 132))
        }
    }
    
    //execution cost: 1294 gas 
    function abiDecodeTest2(
        bytes calldata _data
    )
        external
        pure
        returns(
            bytes4 sig,
            bytes32 label,
            address account,
            bytes32 pubkeyA,
            bytes32 pubkeyB
        )
    {
        sig = _data[0] |  bytes4(_data[1]) >> 8 | bytes4(_data[2]) >> 16  | bytes4(_data[3]) >> 24;
        (label, account, pubkeyA, pubkeyB) = abi.decode(_data[4:], (bytes32, address, bytes32, bytes32));
    }
    
    //execution cost: 1192 gas
    function abiDecodeTest3(
        bytes calldata _data
    )
        external
        pure
        returns(
            bytes4 sig,
            bytes32 label,
            address account,
            bytes32 pubkeyA,
            bytes32 pubkeyB
        )
    {
        sig = getSelector(_data);
        (label, account, pubkeyA, pubkeyB) = abi.decode(_data[4:], (bytes32, address, bytes32, bytes32));
    }
    
    function getSelector(bytes memory _data) private pure returns(bytes4 sig) {
        assembly {
            sig := mload(add(_data, 32))
        }
    }

    //execution cost: 1885 gas
    function abiDecodeTest4(
        bytes calldata _data
    )
        external
        pure
        returns(
            bytes4 sig,
            bytes32 label,
            address account,
            bytes32 pubkeyA,
            bytes32 pubkeyB
        )
    {
        sig = getSelector(_data);
        (label, account, pubkeyA, pubkeyB) = abi.decode(slice(_data,4,_data.length-4), (bytes32, address, bytes32, bytes32));
    }
    
    function getSelector(bytes memory _data) private pure returns(bytes4 sig) {
        assembly {
            sig := mload(add(_data, 32))
        }
    }

    function slice(bytes memory _bytes, uint _start, uint _length) private pure returns (bytes memory) {
        require(_bytes.length >= (_start + _length));

        bytes memory tempBytes;

        assembly {
            switch iszero(_length)
            case 0 {
                // Get a location of some free memory and store it in tempBytes as
                // Solidity does for memory variables.
                tempBytes := mload(0x40)

                // The first word of the slice result is potentially a partial
                // word read from the original array. To read it, we calculate
                // the length of that partial word and start copying that many
                // bytes into the array. The first word we copy will start with
                // data we don't care about, but the last `lengthmod` bytes will
                // land at the beginning of the contents of the new array. When
                // we're done copying, we overwrite the full first word with
                // the actual length of the slice.
                let lengthmod := and(_length, 31)

                // The multiplication in the next line is necessary
                // because when slicing multiples of 32 bytes (lengthmod == 0)
                // the following copy loop was copying the origin's length
                // and then ending prematurely not copying everything it should.
                let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
                let end := add(mc, _length)

                for {
                    // The multiplication in the next line has the same exact purpose
                    // as the one above.
                    let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
                } lt(mc, end) {
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                    mstore(mc, mload(cc))
                }

                mstore(tempBytes, _length)

                //update free-memory pointer
                //allocating the array padded to 32 bytes like the compiler does now
                mstore(0x40, and(add(mc, 31), not(31)))
            }
            //if we want a zero-length slice let's just return a zero-length array
            default {
                tempBytes := mload(0x40)

                mstore(0x40, add(tempBytes, 0x20))
            }
        }

        return tempBytes;
    }


}
