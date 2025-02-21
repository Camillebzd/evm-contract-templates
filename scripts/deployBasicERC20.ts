import { ethers, run, network } from "hardhat";

async function deployBasicERC20() {
  const [ owner ] = await ethers.getSigners();
  const contract = await ethers.deployContract("BasicERC20", [owner.address]);

  await contract.waitForDeployment();

  console.log("Deployed:", contract.target);

  // Wait for Blockscout to index
  await new Promise(res => setTimeout(res, 6000)); // (6s) Adjust if needed

  // Verify on Blockscout
  try {
    await run("verify:verify", {
      address: contract.target,
      constructorArguments: [owner.address], // Match deployed constructor params
    });
    console.log("Contract verified on Blockscout!");
  } catch (error) {
    console.error("Verification failed:", error);
  }
}

deployBasicERC20().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});