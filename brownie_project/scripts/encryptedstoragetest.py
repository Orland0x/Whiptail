from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint

def main():

	'''
	Demo of the PredictionCommitReveal.sol smart contract
	'''

	#Deploy contract 
	rs = ReputationScore.deploy({'from':accounts[0]})
	print(rs.address)
	ems = EncryptedMsgStorage.deploy(rs.address, {'from':accounts[0]})



	#update reputation score 


	#Submit Question
	current_time = ems.getTime()
	print(current_time)
	ems.submitQuestion('Average gas 1 week after EIP-1559', 0, 1000, current_time+2, 10, {'from':accounts[0]})

	encryptedMsgs = []
	for i in range(5):
		score = randint(0,100)
		rs.updateReputationScore(accounts[i+1], score, {'from':accounts[0]})

		forecast = randint(0, 1000)
		encryptedMsg = Web3.keccak(encode_abi(['uint'], [forecast])).hex()
		encryptedMsgs.append(encryptedMsg)
		try:
			ems.submitEncryptedMsg(0, encryptedMsg, {'from':accounts[i+1]})
		except:
			pass

	#wait for commit period to end
	time.sleep(3)

	displayQuestionAndAnswers(ems, 0) 


def displayQuestionAndAnswers(EncryptedMsgStorageContract, questionID):
	questionData = EncryptedMsgStorageContract.getQuestion(questionID)
	print(questionData)
	addresses = EncryptedMsgStorageContract.getAddresses(questionID)
	for address in addresses:
		print(address, EncryptedMsgStorageContract.getReputationScore(address), EncryptedMsgStorageContract.getEncryptedMsg(questionID, address))