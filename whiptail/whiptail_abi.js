var abi = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_questionID",
				"type": "uint256"
			}
		],
		"name": "getAddresses",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getNumOfQuestions",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_questionID",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "getPrediction",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_questionID",
				"type": "uint256"
			}
		],
		"name": "getQuestion",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			},
			{
				"internalType": "uint64",
				"name": "",
				"type": "uint64"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getTime",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_questionID",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_prediction",
				"type": "uint256"
			}
		],
		"name": "submitPrediction",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_text",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_lowerLimit",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_upperLimit",
				"type": "uint256"
			},
			{
				"internalType": "uint64",
				"name": "_submissionEndTime",
				"type": "uint64"
			}
		],
		"name": "submitQuestion",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]