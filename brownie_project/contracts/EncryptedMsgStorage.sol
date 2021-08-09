// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.6;

interface IReputationScore {
    //function updateReputationScore(address _address, uint updatedScore) public;
    function getReputationScore(address _address) external view returns(uint);
}

contract EncryptedMsgStorage {
    
    address owner;
    uint nextID; 
    address reputationScoreContractAddress;
        
    struct EncryptedMsgData {
        bytes32 encryptedMsg;
        address submittorAddress;
    }
    
    struct QuestionData {
        uint ID;
        string text;
        uint reputationThreshold;
        uint64 creationTime;
        uint64 commitPeriodEndTime;
        uint upperLimit;
        uint lowerLimit;
        uint numPredictions;
        mapping(address => bytes32) AddressToEncryptedMsg;
        address[] forecasterAddresses; 
    }

    mapping(uint => QuestionData) indexToQuestion; // Maps the ID of a question to its QuestionData struct

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    
    modifier exceedReputationThreshold(uint _questionID) {
        require(IReputationScore(reputationScoreContractAddress).getReputationScore(msg.sender) >= indexToQuestion[_questionID].reputationThreshold);
        _;
    }

    constructor(address _reputationScoreContractAddress) {
        owner = msg.sender;
        reputationScoreContractAddress = _reputationScoreContractAddress;
        nextID = 0;
    }
    
    //contract owners can submit questions 
    function submitQuestion(string calldata _text, uint _lowerLimit, uint _upperLimit, uint64 _commitPeriodEndTime, uint _reputationThreshold) public onlyOwner() {
        QuestionData storage questionData = indexToQuestion[nextID];
        questionData.ID = nextID;
        questionData.text = _text;
        questionData.reputationThreshold = _reputationThreshold;
        questionData.creationTime = uint64(block.timestamp);
        questionData.commitPeriodEndTime = _commitPeriodEndTime;
        questionData.lowerLimit = _lowerLimit;
        questionData.upperLimit = _upperLimit; 
        questionData.numPredictions = 0; 
        nextID++; 
    }
    
    
    //forecasters with a sufficiently high reputation score can submit encrypted messages
    function submitEncryptedMsg(uint _questionID, bytes32 _msg) public exceedReputationThreshold(_questionID) {
        QuestionData storage questionData = indexToQuestion[_questionID];
        require(block.timestamp <= questionData.commitPeriodEndTime);
        questionData.AddressToEncryptedMsg[msg.sender] = _msg;
        questionData.forecasterAddresses.push(msg.sender);
        questionData.numPredictions++;
    }
    
    function getNumOfQuestions() public view returns(uint) {
        return nextID;
    }

    //return the data for a question given the ID
    function getQuestion(uint _questionID) public view returns (string memory, uint, uint64, uint, uint, uint) {
        require(_questionID < nextID);        
        return (indexToQuestion[_questionID].text,
        indexToQuestion[_questionID].reputationThreshold,
        indexToQuestion[_questionID].commitPeriodEndTime,
        indexToQuestion[_questionID].lowerLimit, 
        indexToQuestion[_questionID].upperLimit,
        indexToQuestion[_questionID].numPredictions);
    }

    //return an array containing the addresses of the users for a given question 
    function getAddresses(uint _questionID) public view returns (address[] memory) {
        require(_questionID < nextID);
        return indexToQuestion[_questionID].forecasterAddresses;
    }
    
    //return prediction for a given address and question
    function getEncryptedMsg(uint _questionID, address _address) public view returns (bytes32) {
        require(_questionID < nextID);
        return indexToQuestion[_questionID].AddressToEncryptedMsg[_address]; 
    }
    
    function getReputationScore(address _address) public view returns (uint) {
        return IReputationScore(reputationScoreContractAddress).getReputationScore(_address);
    }
    // //retrieves all encrypted messages for a given question ID. 
    // function retrieveAll(uint _questionID) public view returns(bytes32[] memory) {
        
    // }
    
    
    function getTime() public view returns (uint){
        return block.timestamp;
    }
    
    
    
    
}