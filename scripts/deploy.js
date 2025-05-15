const hre = require("hardhat");

async function main() {
  console.log("Deploying Crowdfund contract...");

  // Get the Contract Factory
  const Crowdfund = await hre.ethers.getContractFactory("Crowdfund");

  // Deploy the contract
  const crowdfund = await Crowdfund.deploy();
  await crowdfund.deployed();

  console.log(`Crowdfund contract deployed to: ${crowdfund.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
