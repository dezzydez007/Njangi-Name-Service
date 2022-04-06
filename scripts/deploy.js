const main = async () => {
    const domainContractFactory = await hre.ethers.getContractFactory('Domains');
    const domainContract = await domainContractFactory.deploy("njangi");
    await domainContract.deployed();
  
    console.log("Contract deployed to:", domainContract.address);
  
    // CHANGE THIS DOMAIN TO SOMETHING ELSE! I don't want to see OpenSea full of web3verses lol
    let txn = await domainContract.register("web3verse",  {value: hre.ethers.utils.parseEther('1')});
    await txn.wait();
    console.log("Minted domain web3verse.njangi");
  
    txn = await domainContract.setRecord("web3verse", "Am I a web3verse or a njangi??");
    await txn.wait();
    console.log("Set record for web3verse.njangi");
  
    const address = await domainContract.getAddress("web3verse");
    console.log("Owner of domain web3verse:", address);
  
    const balance = await hre.ethers.provider.getBalance(domainContract.address);
    console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
  }
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();