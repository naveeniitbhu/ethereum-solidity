// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract EventExample {
    mapping (address => uint) public tokenBalance;
    event TokensSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    // Below returns is only for inside smart contract interactions. 
    // That it why when we interact with metasmask we get decoded output empty
    // But in local we will get output.
    function sendToken(address _to, uint _amount) public returns(bool) {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens.");
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }
}