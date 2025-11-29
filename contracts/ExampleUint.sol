// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

contract ExampleUint {
    // if we dont need default value otherwise it costs more gas
    // uint public myUint = 838338;
    
    // uint is alias for uint256

    uint256 public myUint;
    uint8 public myUint8;
    int public  myint = -10; // -2^128 to 2^128-1

    function setUint(uint _myUint) public {
        myUint = _myUint;
    }

    function incrementUint8() public {
        myUint8++;
    }

    function incrementint() public {
        myint++;
    }
    

}