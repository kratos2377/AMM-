// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Pool {
    using SafeMath for uint256;
    using SafeMath for uint32;


    mapping(address => uint256) public balances;
    uint256 totalSupply;
    uint32 slope;
     

     constructor(uint256 initialSupply , uint32 _slope) {
            totalSupply = initialSupply;
            slope = _slope;
     }
}