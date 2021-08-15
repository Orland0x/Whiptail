from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint

def main():

	'''
	Demo of the PredictionCommitReveal.sol smart contract for use with a local blockchain
	'''

	#Deploy contract 
	pcr = PredictionCommitReveal.deploy({'from':accounts[0]})
	print(pcr)
	print('done')
	#Submit Question
	current_time = pcr.getTime()

	pcr.submitQuestion('Average gas 1 week after EIP-1559', 0, 1000, current_time+2, current_time+4, {'from':accounts[0]})


	predictions = []
	blinding_factors = []
	for i in range(5):
		prediction = randint(0, 1000)
		predictions.append(prediction)
		blinding_factor = randint(1,1000000000)
		blinding_factors.append(blinding_factor)
		commitment = Web3.keccak(encode_abi(['uint', 'uint'], [prediction, blinding_factor])).hex()
		pcr.commitPrediction(0, commitment, {'from':accounts[i+1]})


	#wait for commit period to end
	time.sleep(3)

	for i in range(5): 
		pcr.revealPrediction(0, predictions[i], blinding_factors[i], {'from':accounts[i+1]})

	displayQuestionAndAnswers(pcr, 0) 



def displayQuestionAndAnswers(PredictionCommitRevealContract, questionID):
	questionData = PredictionCommitRevealContract.indexToQuestion(questionID)
	print(questionData)
	addresses = PredictionCommitRevealContract.getAddresses(questionID)
	for address in addresses:
		print(address, PredictionCommitRevealContract.getPrediction(questionID, address))


