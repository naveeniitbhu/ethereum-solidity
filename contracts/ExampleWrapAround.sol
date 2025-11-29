// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleWrapAround {
    uint256 public myUint;
    uint8 public myUint8;

    function setUint(uint _myUint) public {
        myUint = _myUint;
    }

    function incrementUint8() public {
        myUint8++;
    }
    
    function decrementUint8() public {
        unchecked {
            myUint--;
        }
    }

}