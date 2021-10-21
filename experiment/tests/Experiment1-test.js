const Experiment1 = artifacts.require("Experiment1");

contract("Test Experiment1", async accounts => {

  const account = accounts[0];

  it("has all methods working", async () => {
    const contract = await Experiment1.deployed();

    await contract.assignDefault.sendTransaction();
    await contract.assignNoDefault.sendTransaction();
    await contract.assignCall.sendTransaction();
    await contract.assignSmallInt.sendTransaction();

    await contract.receiveSmallInt.sendTransaction(4);
    await contract.receiveInt.sendTransaction(4);

    await contract.contractVariable.sendTransaction();
    await contract.contractConstant.sendTransaction();
    await contract.inlineConstant.sendTransaction();

    await contract.updateUnpackedState.sendTransaction();
    await contract.updatePackedState.sendTransaction();

    await contract.setUnInitialized.sendTransaction();
    await contract.setPreInitialized.sendTransaction();

  });

});
