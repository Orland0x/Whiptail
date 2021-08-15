from web3 import Web3 
from eth_abi import encode_abi 
from brownie import * 
import time
from random import randint
import sys  
import argparse 

def main():


	#loading account with ownership status over the contracts
	owner = accounts.load('whiptailOwner', password='abcd')	
	rs = ReputationScore.at("0x825477C09DD57bb72298c3161B26eA577B2D0EDe")

	print('0x223eCD219430Af7a3fC5DE057daa840568d8EaD4', rs.getReputationScore('0x223eCD219430Af7a3fC5DE057daa840568d8EaD4'))
	print('0x31Dff4dF097D0ebB842707e87F481118c9e2126a', rs.getReputationScore('0x31Dff4dF097D0ebB842707e87F481118c9e2126a'))
	print('0x7b76e737dc438FEb7c6f91259a9853162D027872' ,rs.getReputationScore('0x7b76e737dc438FEb7c6f91259a9853162D027872'))
