from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint

def main():

	'''
	script to send predictions to the PredictionSubmission smart contract
	'''

	#loading a basic user account (unpriveledged status in the contract)
	user = accounts.load('whiptailUser', password='abcd')	
	print(user)

	#Load contract
	ps = PredictionSubmission.at("0xa505E0D24Ef6d65cD57ad1c6Bb17EBd3547934Fe")

	print(ps)

	#Submit Question
	current_time = ps.getTime()

	prediction = randint(0, 1000)

	ps.submitPrediction(0, prediction, {'from':user})

	displayQuestionAndAnswers(ps, 0)
    

def displayQuestionAndAnswers(PredictionSubmissionContract, questionID):
	questionData = PredictionSubmissionContract.getQuestion(questionID)
	print(questionData)
	addresses = PredictionSubmissionContract.getAddresses(questionID)
	for address in addresses:
		print(address, PredictionSubmissionContract.getPrediction(questionID, address))


