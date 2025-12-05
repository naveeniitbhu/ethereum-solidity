// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Consumer {
    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function deposit() public payable {}
}
contract SmartContractWallet {
    address payable public owner;

    mapping(address => uint) public allowance;
    mapping(address => bool) public isAllowedToSend;
    mapping(address => bool) public guardians;

    mapping(address => mapping(address => bool)) nextOwnerGuardingVotedBool;
    address payable nextOwner;
    uint guardiansResetCount;
    uint public constant confirmationFromGuardiansForReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        guardians[_guardian] = _isGuardian;
    }

    function proposeNewOwner(address payable _newOwner) public {
        require(guardians[msg.sender],"You are not a guardian, go away.");
        require(nextOwnerGuardingVotedBool[_newOwner][msg.sender] == false, "You already voted");
        if(_newOwner != nextOwner) {
            nextOwner = _newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;
        if(guardiansResetCount >= confirmationFromGuardiansForReset) {
            owner = nextOwner;
            guardiansResetCount++;
        }
    }

    function setAllowance(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not the owner, aborting");
        allowance[_for] = _amount;
        if(_amount>0){
            isAllowedToSend[_for] = true;
        } else{
            isAllowedToSend[_for] = false;
        }
    }

    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns(bytes memory) {
        // require(msg.sender == owner, "You are not the owner, aborting");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send anything from this smart contract, aborting");
            require(allowance[msg.sender] >= _amount, "You are trying to send more than you are allowed to send, aborting");

            allowance[msg.sender] -= _amount;
        }
        (bool success, bytes memory returnedData)= _to.call{value: _amount}(_payload);
        require(success, "Call was not successfule, aborting");
        return returnedData;
    }
    receive() external payable {}
}


// Task:
// 1. Wallet has 1 owner
// 2. Receive funds with a fallback func
// 3. Spend money on EOA and contracts
// 4. Give allowance to other people
// 5. Set a new owner with 3 out of 5 guardians.