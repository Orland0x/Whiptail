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
    
    mapping(address => bool) addressToHasRegistered; 
    mapping(address => uint) addressToReputationScore; 

    address[] addresses;
    
    function updateReputationScore(address _address, uint updatedScore) public onlyOwner() {
        addressToReputationScore[_address] = updatedScore;

        if (addressToHasRegistered[_address] != true) {
            addressToHasRegistered[_address] = true;
            addresses.push(_address);
        }

    }
    
    function hasRegistered(address _address) public view returns(bool) {
        return addressToHasRegistered[_address];
    }

    function getAddresses() external view returns(address[] memory) {
        return addresses; 

    }

    function getReputationScore(address _address) external view returns(uint) {
        if (addressToHasRegistered[_address] == true) {
            return addressToReputationScore[_address];
        }
        else {
            //baseline reputation you recieve at the beginning. 
            return 100;
        }
    }
}