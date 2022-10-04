// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.5 <0.9.0;

contract BytesParsing {
    // example bytes calldata: 0x3A1174741911F257FFCA965A00000002010000
    // color codes: #3a1174, #741911, #f257ff, #ca965a, #000000
    // numbers: 2, 1, 0, 0

    function uint8tohexchar(uint8 i) internal pure returns (uint8) {
        return (i > 9) ?
            (i + 87) : // ascii a-f
            (i + 48); // ascii 0-9
    }

    function bytes3tohexstr(bytes3 c) internal pure returns (string memory) {
        uint24 i = uint24(c);
        bytes memory o = new bytes(6);
        uint24 mask = 0x00000f;
        o[5] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[4] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[3] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[2] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[1] = bytes1(uint8tohexchar(uint8(i & mask)));
        i = i >> 4;
        o[0] = bytes1(uint8tohexchar(uint8(i & mask)));
        return string(o);
    }

    function sliceBytes1(bytes calldata features) public pure returns(string memory) {
        bytes3 c = bytes3(features[0:3]);
        return bytes3tohexstr(c);
    }

    function sliceBytes2(bytes calldata features) public pure returns(string memory) {
        bytes3 c = bytes3(features[3:6]);
        return bytes3tohexstr(c);
    }

    function sliceBytes3(bytes calldata features) public pure returns(string memory) {
        bytes3 c = bytes3(features[6:9]);
        return bytes3tohexstr(c);
    }

    function sliceBytes4(bytes calldata features) public pure returns(string memory) {
        bytes3 c = bytes3(features[9:12]);
        return bytes3tohexstr(c);
    }

    function sliceBytes5(bytes calldata features) public pure returns(string memory) {
        bytes3 c = bytes3(features[12:15]);
        return bytes3tohexstr(c);
    }

    function sliceBytes6(bytes calldata features) public pure returns(uint8) {
        bytes1 a = bytes1(features[15:16]);
        return uint8(a);
    }

    function sliceBytes7(bytes calldata features) public pure returns(uint8) {
        bytes1 a = bytes1(features[16:17]);
        return uint8(a);
    }

    function sliceBytes8(bytes calldata features) public pure returns(uint8) {
        bytes1 a = bytes1(features[17:18]);
        return uint8(a);
    }

}
