import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Lock", function () { 
        it("should work" , async () => {
            const [owner , otherAccounts] = await ethers.getSigners();
            const Pool = await ethers.getContractFactory("Pool");

            
            const initalSupply = ethers.utils.parseUints("20" , 8);
            const slope = 1;
            const pool = await Pool.deploy(initalSupply , slope);
            await owner.sendTransaction({
                to: pool.address,
                value: ethers.utils.parseEther("1000.0"),
            });
            
            const tokenPrice = await pool.calculateTokenPrice();
            
            
            await pool.buy({value: ethers.utils.parseEther("2.0")})
            
            const contractBalance = ethers.provider.getBalance(pool.address);

            const newTokenPrice = await pool.calculateTokenPrice();
            console.log(newTokenPrice)
            const balance = await pool.balances(owner.address)
            console.log("Current token balance is: " , balance)


            await pool.sell(balance)

            const priceAfterSell = await pool.calculateTokenPrice();
            console.log(priceAfterSell)

            const newBalance = await pool.balances(owner.address);
            console.log(newBalance)
        })
});
