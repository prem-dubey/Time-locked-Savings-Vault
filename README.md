# Crowdfund

A decentralized crowdfunding platform built on Core Testnet 2 using Solidity and Hardhat.

## Project Description

Crowdfund is a blockchain-based crowdfunding platform that enables creators to launch campaigns and seek financial support from the community. The platform provides a transparent and secure environment where backers can contribute to campaigns they believe in, and creators can receive funds if they meet their funding goals.

## Project Vision

To democratize fundraising by creating a decentralized platform that connects creators directly with backers, eliminates intermediaries, reduces fees, and ensures transparency throughout the funding process. Crowdfund aims to empower innovation and creativity by providing equal access to capital regardless of geographic location or traditional banking relationships.

## Key Features

- **Campaign Creation**: Users can create crowdfunding campaigns with customizable titles, descriptions, funding goals, and deadlines.
- **Transparent Contributions**: All contributions are recorded on the blockchain, ensuring full transparency.
- **Goal-Based Funding**: Creators can only withdraw funds if their campaign meets its funding goal by the deadline.
- **Refund Mechanism**: Contributors can claim refunds if a campaign fails to meet its goal by the deadline.
- **Campaign Details**: Anyone can view detailed information about campaigns, including current funding status.

## Future Scope

- **Campaign Categories**: Implement categories to organize campaigns by type (e.g., technology, art, charity).
- **Milestone-Based Funding**: Add support for releasing funds in stages as creators hit predefined milestones.
- **Campaign Updates**: Allow creators to post updates about their campaigns.
- **Token Rewards**: Implement a token-based reward system for campaign backers.
- **Campaign Verification**: Introduce a verification system to validate legitimate campaigns.
- **Governance System**: Implement a DAO structure for community governance of the platform.
- **Multi-Chain Support**: Expand support to multiple blockchain networks.

## Technical Setup

### Prerequisites

- Node.js (v14 or later)
- npm or yarn
- A wallet with some Core Testnet 2 tokens for gas fees

### Installation

1. Clone the repository:
```
git clone https://github.com/yourusername/crowdfund.git
cd crowdfund
```

2. Install dependencies:
```
npm install
```

3. Set up environment variables:
```
cp .env.example .env
```
Then edit `.env` and add your private key.

### Deployment

To deploy the contract to Core Testnet 2:

```
npm run deploy
```

### Testing

Run tests with:

```
npm test
```

## Contract Interaction

The Crowdfund smart contract provides the following main functions:

- `createCampaign`: Create a new crowdfunding campaign
- `contribute`: Contribute funds to an existing campaign
- `claimFunds`: Allows creators to claim funds if the goal is met
- `claimRefund`: Allows contributors to claim refunds if the goal is not met
- `getCampaign`: View details of a specific campaign

## License

This project is licensed under the MIT License.