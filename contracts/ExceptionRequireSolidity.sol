// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

contract ExampleExceptionRequire {
    mapping(address => uint) public balanceReceived;

    function receiveMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        // if(_amount <= balanceReceived[msg.sender]) {
        //     balanceReceived[msg.sender] -= _amount;
        //     _to.transfer(_amount);
        // }

        // if require fails whole transaction is rolled back, it doesnt matter if it is first or last statements
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting");
            balanceReceived[msg.sender] -= _amount;
            _to.transfer(_amount);
    }
}

contract ExampleExceptionRequire2 {
    mapping(address => uint8) public balanceReceived; // here it will roll over i.e. if we deposit 257, then 1 will be stored as 256 is rolled to 0

    function receiveMoney() public payable {
        assert(msg.value == uint8(msg.value)); 
        balanceReceived[msg.sender] += uint8(msg.value);
    }

    function withdrawMoney(address payable _to, uint8 _amount) public {
        // if(_amount <= balanceReceived[msg.sender]) {
        //     balanceReceived[msg.sender] -= _amount;
        //     _to.transfer(_amount);
        // }

        // if require fails whole transaction is rolled back, it doesnt matter if it is first or last statements
        require(_amount <= balanceReceived[msg.sender], "Not enough funds, aborting");
            balanceReceived[msg.sender] -= uint8(_amount);
            _to.transfer(_amount);
    }
}