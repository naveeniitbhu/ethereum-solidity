// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract ExampleBoolean {
    bool public mybool;
    function setBool(bool _myBool) public {
        // 0 is false
        // && || != ==
        mybool = _myBool;
    }
}