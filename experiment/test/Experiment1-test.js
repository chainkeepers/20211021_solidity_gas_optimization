const Experiment1 = artifacts.require("Experiment1");

contract("Test Experiment1", async accounts => {

  it("has all methods functional", async () => {
    
    const contract = await Experiment1.deployed();

    await contract.setInMemory.sendTransaction(10);
    await contract.setInState.sendTransaction(10);
    await contract.setInStateNonzero.sendTransaction(10);

    await contract.setInStateToZero.sendTransaction();

    await contract.inc256.sendTransaction();
    await contract.inc8.sendTransaction();

    await contract.unpackedStorage.sendTransaction();
    await contract.packedStorage.sendTransaction();

    const values = [1, 2, 3, 4, 5, 6];
    await contract.incrementInStorage.sendTransaction(values);
    await contract.incrementInMemory.sendTransaction(values);
    await contract.incrementInMemoryCalldata.sendTransaction(values);
    await contract.incrementInMemoryCalldataPlusOne.sendTransaction(values);

    await contract.getUniWeth.sendTransaction();
    await contract.getUniWethConst.sendTransaction();
    await contract.getUniWethFixed.sendTransaction();

    await contract.incSumValues.sendTransaction(values);
    await contract.incSumValuesIndirect.sendTransaction(values);

  });

});
