const hre = require("hardhat");

async function main() {
  console.log("Deploying NFTMinter contract...");

  // Get the Contract Factory
  const NFTMinter = await hre.ethers.getContractFactory("NFTMinter");

  // Contract constructor arguments
  const name = "Core NFT Collection";
  const symbol = "CNFT";
  const maxSupply = 1000;
  const mintPrice = hre.ethers.utils.parseEther("0.01"); // 0.01 ETH
  const baseURI = "ipfs://YOUR_IPFS_CID/";

  // Deploy the contract
  const nftMinter = await NFTMinter.deploy(
    name,
    symbol,
    maxSupply,
    mintPrice,
    baseURI
  );
  await nftMinter.deployed();

  console.log(`NFTMinter contract deployed to: ${nftMinter.address}`);
  console.log(`Contract parameters:`);
  console.log(`- Name: ${name}`);
  console.log(`- Symbol: ${symbol}`);
  console.log(`- Max Supply: ${maxSupply}`);
  console.log(`- Mint Price: ${hre.ethers.utils.formatEther(mintPrice)} ETH`);
  console.log(`- Base URI: ${baseURI}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
