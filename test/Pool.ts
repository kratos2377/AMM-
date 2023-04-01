import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Lock", function () { 
        it("should work" , async () => {
            const [owner , otherAccounts] = await ethers.getSigners();
            const Pool = await ethers.getContractFactory("Pool");
            const initalSupply = 100;
            const slope = 1;
            const pool = await Pool.deploy(initalSupply , slope);
        })
});
