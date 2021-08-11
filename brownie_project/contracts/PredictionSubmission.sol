// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.6;

contract PredictionSubmission {
    
    address owner;
    uint nextID; 
    
    struct QuestionData {
        uint ID;
        string text;
        uint64 creationTime;
        uint64 submissionEndTime;
        uint upperLimit;
        uint lowerLimit;
        uint numPredictions;
        mapping(address => uint) AddressToPrediction;
        address[] predictionAddresses; 
    }
        
    mapping(uint => QuestionData) indexToQuestion; // Maps the ID of a question to its QuestionData struct
    
    constructor() {
        owner = msg.sender;
        nextID = 0;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    

    //contract owner can submit questions with various parameters
    function submitQuestion(string calldata _text, uint _lowerLimit, uint _upperLimit, uint64 _submissionEndTime) public onlyOwner() {
        
        QuestionData storage questionData = indexToQuestion[nextID];
        questionData.ID = nextID;
        questionData.text = _text; 
        questionData.creationTime = uint64(block.timestamp);
        questionData.submissionEndTime = _submissionEndTime;
        questionData.lowerLimit = _lowerLimit;
        questionData.upperLimit = _upperLimit; 
        questionData.numPredictions = 0; 
        
        nextID++; 
        
    }
    
    //Users reveal their predictions during the reveal window
    function submitPrediction(uint _questionID, uint _prediction) public {
        
        QuestionData storage questionData = indexToQuestion[_questionID];
        
        require(block.timestamp <= questionData.submissionEndTime, "Submission period has ended");
        require(_prediction >= questionData.lowerLimit && _prediction <= questionData.upperLimit, "Your Prediction was out of range");
        
        questionData.AddressToPrediction[msg.sender] = _prediction; 
        questionData.predictionAddresses.push(msg.sender);
        questionData.numPredictions++;

    }
    
    function getNumOfQuestions() public view returns(uint) {
        return nextID;
    }

    //return the data for a question given the ID
    function getQuestion(uint _questionID) public view returns (string memory, uint64, uint, uint, uint) {
        return (indexToQuestion[_questionID].text, 
        indexToQuestion[_questionID].submissionEndTime,
        indexToQuestion[_questionID].lowerLimit, 
        indexToQuestion[_questionID].upperLimit,
        indexToQuestion[_questionID].numPredictions);
    }

    //return an array containing the addresses of the users for a given question 
    function getAddresses(uint _questionID) public view returns (address[] memory) {
        require(_questionID < nextID);
        return indexToQuestion[_questionID].predictionAddresses;
    }
    
    //return prediction for a given address and question
    function getPrediction(uint _questionID, address _address) public view returns (uint) {
        require(_questionID < nextID);
        return indexToQuestion[_questionID].AddressToPrediction[_address]; 
    }
    
    function getTime() public view returns (uint){
        return block.timestamp;
    }
    
} 