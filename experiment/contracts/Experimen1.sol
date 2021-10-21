// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

/*

  1. state access is expensive

  2. small types

  3. constant inlining

*/


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

}
