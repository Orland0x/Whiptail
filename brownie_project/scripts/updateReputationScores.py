from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint
import sys  
import argparse 

def main():
	
	'''
	_questionID, submissionContractAddress, reputationContractAddress
	script to gather predictions for a given question from the submission smart contract
	and compute the score for each participant. These scores are then used to update the 
	Reputation Score smart contract. 
	''' 

	questionID = 0
	trueValue = 17

	#loading account with ownership status over the contracts
	owner = accounts.load('whiptailOwner', password='abcd')	
	print(owner)


	#loading contracts
	ps = PredictionSubmission.at("0xa505E0D24Ef6d65cD57ad1c6Bb17EBd3547934Fe")
	rs = ReputationScore.at("0x825477C09DD57bb72298c3161B26eA577B2D0EDe")

	current_time = ps.getTime() 

	print(ps.getNumOfQuestions())

	questionID = 0

	#get address prediction pairs for a given question. 
	addresses = ps.getAddresses(questionID)
	predictionList = []
	addressList = []
	for address in addresses: 
		prediction = ps.getPrediction(questionID, address)
		predictionList.append(prediction)
		addressList.append(address)
		print(address, prediction)


	#compute scores 
	scoreList = getScores(predictionList, 0, 20, trueValue)


	#update Reputation Contract with scores
	updateReputationScoreContract(rs, addressList, scoreList)



def getScores(_predictionList, _lowerBound, _upperBound, _trueValue):
	'''
	takes a list of predictions as input and returns a list of corresponding scores. 
	'''

	Range = _upperBound - _lowerBound

	#normalize the data by subtracting the true value and dividing by the range
	distanceList = [(prediction - _trueValue)/Range for prediction in _predictionList]

	#compute average distance from true value 
	averageDistance = 0
	for distance in distanceList:
		averageDistance += abs(distance)
	averageDistance = averageDistance/len(distanceList)

	scores = []
	for distance in distanceList:
		score = 100*averageDistance/(100*(distance**2) + 1) - 5
		scores.append(score)

	return scores 



def updateReputationScoreContract(ReputationStoreContract, addressList, scoreList):
	
	for address, score in zip(addressList, scoreList):
		prevScore = ReputationStoreContract.getReputationScore(address)
		ReputationStoreContract.updateReputationScore(address, prevScore + int(score))


