from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint

def main():

	owner = accounts.load('whiptailOwner', password='abcd')	
	print(owner)

	ps = PredictionSubmission.at("0xa505E0D24Ef6d65cD57ad1c6Bb17EBd3547934Fe")

	current_time = ps.getTime() 
	ps.submitQuestion('Average gas 1 week after EIP-1559?', 0, 1000, current_time+2000, {'from':owner})

	print(ps.getNumOfQuestions())
