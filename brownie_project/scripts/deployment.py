from brownie import * 

def main():

	owner = accounts.load('whiptailOwner', password='abcd')	
	print(owner)

	ps = PredictionSubmission.deploy({'from':owner})
	rs = ReputationScore.deploy({'from':owner})

	
