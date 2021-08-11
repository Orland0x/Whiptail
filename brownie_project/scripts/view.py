from brownie import *
from itertools import count
from click import style
from eth_utils import decode_hex
from time import sleep

def main():

	start_block = 12997793
	hacker = '0xC8a65Fadf0e0dDAf421F28FEAb69Bf6E2E589963'

	# network.connect('mainnet')

	def get_message(tx):
	    try:
	        return decode_hex(tx.input).decode('utf-8')
	    except UnicodeDecodeError:
	        return style('(unintelligible)', dim=True)


	for n in count(start_block):
		print(n)
	    while n > web3.eth.block_number:
	        sleep(1)

	    if n % 100 == 0 and n < web3.eth.block_number:
	        print(style(f'{web3.eth.block_number - n:,d} blocks remaining', dim=True))
	    block = web3.eth.get_block(n, True)
	    for tx in block.transactions:
	        if hacker not in [tx['from'], tx.to]:
	            continue
	        message = get_message(tx)
	        if message is None:
	            continue
	        print(
	            f'[{n:,}]',
	            style(f"{tx['from'][:10]} says:", fg='green' if tx['from'] == hacker else 'yellow'),
	            message,
	        )