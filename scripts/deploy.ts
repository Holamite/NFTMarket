import { ethers } from "hardhat";

async function main() {
  const nftMarket = await ethers.deployContract("NFTMarket");

  await nftMarket.waitForDeployment();

  console.log(`Contract deployed to ${nftMarket.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
