// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleMappingWithdrawals {
    
    mapping(address => uint) public balanceReceived;

    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint balanceToSendOut = balanceReceived[msg.sender]; // sender is the wallet that call this function
        balanceReceived[msg.sender] = 0;
        _to.transfer(balanceToSendOut); // to is the address we are sending the money to
    }
}
