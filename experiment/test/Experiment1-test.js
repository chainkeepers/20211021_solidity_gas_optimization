const Experiment1 = artifacts.require("Experiment1");

contract("Test Experiment1", async accounts => {

  it("has all methods functional", async () => {
    
    const contract = await Experiment1.deployed();

    await contract.setInMemory.sendTransaction(10);
    await contract.setInState.sendTransaction(10);
    await contract.setInStateNonzero.sendTransaction(10);

    await contract.setInStateToZero.sendTransaction();

    await contract.inc256.sendTransaction(10);
    await contract.inc8.sendTransaction(10);
    
  });

});
