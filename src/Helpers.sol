pragma solidity ^0.8;

contract Helpers {
  // slice string
  function getSlice(uint256 begin, uint256 end, string memory text) internal pure returns (string memory) {
    bytes memory a = new bytes(end-begin+1);
    for(uint i=0;i<=end-begin;i++){
        a[i] = bytes(text)[i+begin-1];
    }
    return string(a);
  }

  // convert string to uint8 (numbers 0-9)
  function stringToUint8(string memory numString) public pure returns(uint8) {
    return uint8(bytes(numString)[0])-48;
  }
}
