// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/*

  1. state access is expensive

  2. small types

  3. constant inlining

  4. packing

  5. storage computation

  6. constant inlining

  7. too many locals

  8. call overhead

*/


interface UniV2Router {
  function WETH() external pure returns (address);
}


contract Experiment1 {

  function setInMemory(uint256 value) public {
    uint256 stored;
    stored = value;
  }

  uint256 storedValue;
  function setInState(uint256 value) public {
    storedValue = value;
  }

  uint256 storedValueNonzero = 1;
  function setInStateNonzero(uint256 value) public {
    storedValueNonzero = value;
  }

  uint256 storedValueToZero = 1;
  function setInStateToZero() public {
    storedValueToZero = 0;
  }

  function inc256() public {
    uint256 value = 10;
    value += 1;
  }

  function inc8() public {
    uint8 value = 10;
    value += 1;
  }

  /* EVM i storage sloty jsou 32B dlouhe. */

  uint128 varA1;
  uint256 varA2;
  uint128 varA3;

  function unpackedStorage() public {
    varA1 = 1;
    varA3 = 5;
  }

  uint128 varB1;
  uint128 varB3;
  uint256 varB2;

  function packedStorage() public {
    varB1 = 1;
    varB3 = 5;
  }

  uint256 computedValue = 0;

  function incrementInStorage(uint256[] memory values) public {
    for(uint256 i = 0; i < values.length; i++)
      computedValue += values[i];
  }

  uint256 computedValueInMemory = 0;

  function incrementInMemory(uint256[] memory values) public {
    uint256 sum = 0;
    for(uint256 i = 0; i < values.length; i++)
      sum += values[i];

    computedValueInMemory += sum;
  }

  uint256 computedValueInMemoryCalldata = 0;

  function incrementInMemoryCalldata(uint256[] calldata values) public {
    uint256 sum = 0;
    for(uint256 i = 0; i < values.length; i++)
      sum += values[i];

    computedValueInMemoryCalldata += sum;
  }

  function getComputedValue() public returns (uint256) {
    return computedValue;
  }

  uint256 computedValuePlusOne = 1;

  function incrementInMemoryCalldataPlusOne(uint256[] calldata values) public {
    uint256 sum = 0;
    for(uint256 i = 0; i < values.length; i++)
      sum += values[i];

    computedValue += sum;
  }

  function getComputedValuePlusOne() public returns (uint256) {
    return computedValuePlusOne - 1;
  }

  address UNI_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  function getUniWeth() public {
    UniV2Router(UNI_V2_ROUTER).WETH();
  }

  address constant UNI_V2_ROUTER_CONST = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
  function getUniWethConst() public {
    UniV2Router(UNI_V2_ROUTER_CONST).WETH();
  }

  function getUniWethFixed() public {
    UniV2Router(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D).WETH();
  }
  
  /* call overhead */

  uint256 valueSum = 1;
  function incSumValues(uint256[] calldata values) public {
    uint256 sum = 0;
    for(uint256 i = 0; i < values.length; i++)
      sum += values[i];

    computedValue += sum;
  }

  function sumValues(uint256[] memory values) internal returns (uint256) {
    uint256 sum = 0;
    for(uint256 i = 0; i < values.length; i++)
      sum += values[i];
    return sum;
  }

  function incSumValuesIndirect(uint256[] calldata values) public {
    computedValue += sumValues(values);
  }

}
