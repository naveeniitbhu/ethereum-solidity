(async ()=>{
    let accounts = await web3.eth.getAccounts();
    console.log(accounts, accounts.length)
    // this comes from blockchain node in remix
    // connect to metamask to see actual details
    
    let balance = await web3.eth.getBalance(accounts[0]);
    let balanceInEth = web3.utils.fromWei(balance, "ether");
    console.log(balanceInEth);
})()