// SPDX-License-Identifier: GPL-3.0


pragma solidity ^0.8.6;

contract PredictionCommitReveal {
    
    address owner;
    uint nextID; 
    
    struct QuestionData {
        uint ID;
        string text;
        uint64 creationTime;
        uint64 commitPeriodEndTime;
        uint64 revealPeriodEndTime;
        uint upperLimit;
        uint lowerLimit;
        uint numPredictions;
        mapping(address => PredictionData) AddressToPredictionData;
        
    }
    
    struct PredictionData {
        bytes32 commitment;
        bool hasCommitted;
        uint prediction;
        bool hasRevealed; 
        
    }
    
    mapping(uint => QuestionData) public indexToQuestion; // Maps the ID of a question to its QuestionData struct
    
    constructor() {
        owner = msg.sender;
        nextID = 0;
    }
    
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    

    //contract owner can submit questions with various parameters
    function submitQuestion(string calldata _text, uint _lowerLimit, uint _upperLimit, uint64 _commitPeriodEndTime, uint64 _revealPeriodEndTime) public onlyOwner() {
        
        QuestionData storage questionData = indexToQuestion[nextID];
        questionData.ID = nextID;
        questionData.text = _text; 
        questionData.creationTime = uint64(block.timestamp);
        questionData.commitPeriodEndTime = _commitPeriodEndTime;
        questionData.revealPeriodEndTime = _revealPeriodEndTime;
        questionData.lowerLimit = _lowerLimit;
        questionData.upperLimit = _upperLimit; 
        questionData.numPredictions = 0; 
        
        nextID++; 
        
    }
    
    //Users commit predictions during the commitment window
    function commitPrediction(uint _questionID, bytes32 _commitment) public {
        
        QuestionData storage questionData = indexToQuestion[_questionID];
        
        require(block.timestamp <= questionData.commitPeriodEndTime);
        
        questionData.AddressToPredictionData[msg.sender].commitment = _commitment;
        questionData.AddressToPredictionData[msg.sender].hasCommitted = true;
        questionData.numPredictions++;
        
    }
    
    //Users reveal their predictions during the reveal window
    function revealPrediction(uint _questionID, uint _prediction, uint _blindingFactor) public {
        
        QuestionData storage questionData = indexToQuestion[_questionID];
        
        require(questionData.AddressToPredictionData[msg.sender].hasCommitted == true, "You did not commit anything");
        require(block.timestamp >= questionData.commitPeriodEndTime, "Commit period has not ended");
        require(block.timestamp <= questionData.revealPeriodEndTime, "Reveal period has ended");
        require(keccak256(abi.encode(_prediction, _blindingFactor)) == questionData.AddressToPredictionData[msg.sender].commitment, "Invalid hash");
        require(_prediction >= questionData.lowerLimit && _prediction <= questionData.upperLimit, "Your Prediction was out of range");
        
        questionData.AddressToPredictionData[msg.sender].prediction = _prediction; 
        questionData.AddressToPredictionData[msg.sender].hasRevealed = true;
    }
    
    

    function getTime() public view returns (uint){
        return block.timestamp;
    }
} 
