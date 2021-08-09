// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.6;

contract ReputationScore {
    
    address owner;
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    mapping(address => uint) addressToReputationScore; 
    
    function updateReputationScore(address _address, uint updatedScore) public onlyOwner() {
        addressToReputationScore[_address] = updatedScore;
    }
    
    function getReputationScore(address _address) external view returns(uint) {
        return addressToReputationScore[_address];
    }
}