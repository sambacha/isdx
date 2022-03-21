// SPDX-License-Identifier: Apache-2.0

/******************************************************************************
 * Copyright 2020 IEXEC BLOCKCHAIN TECH                                       *
 *                                                                            *
 * Licensed under the Apache License, Version 2.0 (the "License");            *
 * you may not use this file except in compliance with the License.           *
 * You may obtain a copy of the License at                                    *
 *                                                                            *
 *     http://www.apache.org/licenses/LICENSE-2.0                             *
 *                                                                            *
 * Unless required by applicable law or agreed to in writing, software        *
 * distributed under the License is distributed on an "AS IS" BASIS,          *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
 * See the License for the specific language governing permissions and        *
 * limitations under the License.                                             *
 ******************************************************************************/

pragma solidity ^0.6.0;

contract CounterfactualFactory {
    function _create2(bytes memory _code, bytes32 _salt) internal returns (address) {
        bytes memory code = _code;
        bytes32 salt = _salt;
        address addr;
        // solium-disable-next-line security/no-inline-assembly
        assembly {
            addr := create2(0, add(code, 0x20), mload(code), salt)
            if iszero(extcodesize(addr)) {
                revert(0, 0)
            }
        }
        return addr;
    }

    function _predictAddress(bytes memory _code, bytes32 _salt) internal view returns (address) {
        return
            address(
                bytes20(
                    keccak256(
                        abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(_code))
                    ) << 0x60
                )
            );
    }
}
