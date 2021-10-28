const Experiment1 = artifacts.require("Experiment1");


async function main() {

  const contract = await Experiment1.deployed()

  report = {}

  for(const name of [
    'setInMemory',
    'setInState',
    'setInStateNonzero',
  ]){
    const tx = await contract[name].sendTransaction(10);
    report[name] = tx['receipt']['gasUsed'];
  }

  const tx = await contract.setInStateToZero.sendTransaction();
  report['setInStateToZero'] = tx['receipt']['gasUsed'];

  for(const name of [
    'inc256',
    'inc8',
  ]){
    const tx = await contract[name].sendTransaction();
    report[name] = tx['receipt']['gasUsed'];
  }

  for(const name of [
    'unpackedStorage',
    'packedStorage',
  ]){
    const tx = await contract[name].sendTransaction();
    report[name] = tx['receipt']['gasUsed'];
  }

  const values = [1, 2, 3, 4, 5, 6];
  for(const name of [
    'incrementInStorage',
    'incrementInMemory',
    'incrementInMemoryCalldata',
    'incrementInMemoryCalldataPlusOne',
  ]){
    const tx = await contract[name].sendTransaction(values);
    report[name] = tx['receipt']['gasUsed'];
  }

  for(const name of [
    'getUniWeth',
    'getUniWethConst',
    'getUniWethFixed',
  ]){
    const tx = await contract[name].sendTransaction();
    report[name] = tx['receipt']['gasUsed'];
  }

  for(const name of [
    'incSumValues',
    'incSumValuesIndirect',
  ]){
    const tx = await contract[name].sendTransaction(values);
    report[name] = tx['receipt']['gasUsed'];
  }

  console.log(report);

}


module.exports = function(callback) {
  main().then(process.exit);
}
