// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


/*

  Just measure real gas usage impact

  1. assignments
  2. small types
  3. storage computation
  4. constant inlining
  5. packing
  6. pre-initialization
  7. too many locals

*/


interface UniswapV2Router {
    function WETH() external pure returns (address);
}


contract Experiment1 {

    function computeValue() pure internal returns (uint256) {
      return 100;
    }

    function assignDefault() pure public {
      uint256 value = 0;
      value = 100;
    }

    function assignNoDefault() pure public {
      uint256 value;
      value = 100;
    }

    function assignCall() pure public {
      uint256 value;
      value = computeValue();
    }

    function assignSmallInt() pure public {
      uint8 value;
      value = 4;
    }

    /* Start with uint256 and only optimize later. */

    function receiveInt(uint256 value) pure public {
      value += 4;
    }

    function receiveSmallInt(uint8 value) pure public {
      value += 4;
    }

    uint256 finalResult = 0;

    function iterateInStorage(uint256[] memory values) public {
      for(uint256 i = 0; i < values.length; i++)
        finalResult += values[i];
    }

    function iterateInMemory(uint256[] memory values) public {
      uint256 result = values[0];
      for(uint256 i = 1; i < values.length; i++)
        result += values[i];
      finalResult = result;
    }

    function iterateInMemoryCalldata(uint256[] calldata values) public {
      uint256 result = values[0];
      for(uint256 i = 1; i < values.length; i++)
        result += values[i];
      finalResult = result;
    }

    /* In Solidity, there is a runtime abstraction cost. */
    
    address locationVariable = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    function contractVariable() view public {
      UniswapV2Router(locationVariable).WETH();
    }

    address constant locationConstant = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    function contractConstant() pure public {
      UniswapV2Router(locationConstant).WETH();
    }

    function inlineConstant() pure public {
      UniswapV2Router(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D).WETH();
    }

    uint128 unpackedFirst;
    uint256 unpackedSecond;
    uint128 unpackedThird;
    uint128 padding;

    function updateUnpackedState() public {
      unpackedFirst = 1;
      unpackedThird = 2;
    }

    /* Notice how ugly the code becomes! */

    uint128 packedFirst;
    uint128 packedThird;
    uint256 packedSecond;

    function updatePackedState() public {
      packedFirst = 1;
      unpackedThird = 2;
    }

    /* 
       This really is just transfering the cost somewhere else.

       Be astonished, that the same applies for
       - approve
       - token balance

       => It is way more expensive to transfer tokens to 
          an account that does no have any!
    */

    uint256 unInitialized;
    function setUnInitialized() public {
      unInitialized = 5;
    }

    uint256 preInitialized = 1;
    function setPreInitialized() public {
      preInitialized = 5;
    }

}
