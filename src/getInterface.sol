pragma solidity ^0.8.4;

function getInterface(string[] memory signatures)  public pure returns (bytes4 interfaceId) {
    for (uint256 i = 0; i < signatures.length; i++) {
        interfaceId ^= bytes4(keccak256(bytes(signatures[i])));
    }
}
