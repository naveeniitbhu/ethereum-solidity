// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleAddress {
    address public someAddress;

    function setAddress(address _myAddress) public {
        someAddress = _myAddress;
    }

    function getBalance() public view returns(uint) {
        return someAddress.balance;
    }
}