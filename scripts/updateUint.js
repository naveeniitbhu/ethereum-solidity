(async () => {
    const address = "0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47";
    const abiArray = [
	{
		"inputs": [],
		"name": "myUint",
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
				"name": "newUint",
				"type": "uint256"
			}
		],
		"name": "setMyUint",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
];

    const contractInstance = new web3.eth.Contract(abiArray, address);
    console.log(await contractInstance.methods.myUint().call()) // call is reading operation

    const accounts = await web3.eth.getAccounts();
    const txnResult = await contractInstance.methods.setMyUint(235).send({from:accounts[0]});
    console.log(await contractInstance.methods.myUint().call()) // call is reading operation

    console.log(txnResult);
    
})()