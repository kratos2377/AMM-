// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Pool is ERC20 {
    using SafeMath for uint256;
    using SafeMath for uint32;


    uint32 slope;
     

     constructor(uint256 initialSupply , uint32 _slope) ERC20("GGG" , "GG") {
       _mint(msg.sender , initialSupply);
            slope = _slope;
     }

       function sell(uint tokens) public {
              require(balanceOf(msg.sender) >= tokens);
              uint256 ethReturn = calculateSellReturn(tokens);

              require(ethReturn <= address(this).balance, "not enough money in contract"); 
              _burn(msg.sender , tokens);
              payable(msg.sender).transfer(ethReturn);

       }
       function buy() public payable {
              require(msg.value > 0, "some eth is required");
              uint256  tokensToMint = calculateBuyReturn(msg.value);
                 _mint(msg.sender , tokensToMint);
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
              uint256 supply = totalSupply();
              uint256 temp = supply.mul(supply);
              return slope.mul(temp);
       }

       function recieve() external payable {

       }
}