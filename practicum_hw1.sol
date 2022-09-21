// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract FeeCollector{
    uint balance;
    address owner;


    constructor ()  {
        owner = msg.sender;
    }

    receive() external payable {
        balance += msg.value;
    }


    function withdraw(uint256 _amount, address payable _destAdrr) public {
        require(owner == msg.sender, "Unauthorized to withdraw");
        require(balance >= _amount, "Insufficient funds");

        _destAdrr.transfer(_amount);
        balance -= _amount;
    }  

}