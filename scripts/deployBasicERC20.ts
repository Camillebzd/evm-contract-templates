import { ethers } from "hardhat";

async function main() {
  const [ owner ] = await ethers.getSigners();
  const contract = await ethers.deployContract("BasicERC20", [owner.address]);

  await contract.waitForDeployment();

  console.log("Deployed:", contract.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});