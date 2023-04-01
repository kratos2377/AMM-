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

       function sell(uint tokens) public {
              require(balances[msg.sender] >= tokens);
              totalSupply = totalSupply.sub(tokens);
              uint256 balance = balances[msg.sender];
              balances[msg.sender] = balance.sub(tokens);

              uint256 ethReturn = calculateSellReturn(tokens);

              require(ethReturn <= address(this).balance, "not enough money in contract"); 
              payable(msg.sender).transfer(ethReturn);

       }
       function buy() public payable {
              require(msg.value > 0, "some eth is required");


              uint256  tokensToMint = calculateBuyReturn(msg.value);
              totalSupply = totalSupply.add(tokensToMint);
              uint256 currentBalance = balances[msg.sender];

              balances[msg.sender] = currentBalance.add(tokensToMint);
       }

       function calculateSellReturn(uint256 tokens) public view returns (uint256)  {
                     uint256 currentPrice = calculateTokenPrice();
                     return tokens.mul(currentPrice);
       }
       function calculateBuyReturn(uint depositAmount) public view returns (uint256) {
              uint256 currentPrice = calculateTokenPrice();

              return depositAmount.div(currentPrice);
       }

       function calculateTokenPrice() public view returns (uint256) {
              uint256 temp = totalSupply.mul(totalSupply);
              return slope.mul(temp);
       }

       function recieve() external payable {

       }
}