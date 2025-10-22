# Time-locked Savings Vault

**Description:**

A basic Solidity project exploring the creation of a smart contract where users can deposit funds (e.g., Ether, CORE) that remain securely locked until a specified future time. This serves as a fundamental example of a DeFi (Decentralized Finance) "primitive," demonstrating time-based conditional logic for fund release. ⏳🔐

**Purpose:**

* To provide a simple, on-chain mechanism for users to commit funds for a specific duration.
* To demonstrate secure handling of cryptocurrency deposits and withdrawals within a smart contract.
* To illustrate the use of blockchain's native timekeeping (`block.timestamp`) to enforce rules.

**Core Features (Planned):**

* **Deposit:** Allow users to send native cryptocurrency to the contract using a `payable` function.
* **Time Lock:** Record the user's deposit amount and a specific `unlockTimestamp` provided by the user during deposit.
* **Withdrawal:** Allow users to withdraw their *entire* deposited balance *only after* the current `block.timestamp` is greater than or equal to their specified `unlockTimestamp`.
* **Security:** Implement basic checks (e.g., `require` statements) to prevent unauthorized withdrawals or withdrawals before the lock expires, and use patterns like Checks-Effects-Interactions to prevent re-entrancy attacks.

**Key Concepts Illustrated:**

* **Smart Contract Basics:** Contract structure, state variables (`mapping`), functions.
* **Handling Value:** `payable` functions, `msg.value`, `address(this).balance`, sending Ether (`.call{value: ...}`).
* **Time-Based Logic:** Using the global `block.timestamp` variable.
* **Access Control & Security:** `require` statements for condition enforcement, `msg.sender` for identifying users, basic re-entrancy protection.
* **Events:** Logging deposits and withdrawals for off-chain tracking.

**Status:**

🚧 Initial Setup & Development in Progress 🚧

**Technology Stack:**

* **Language:** Solidity (`^0.8.x`)
* **Development Environment:** [e.g., Hardhat, Remix]

**Getting Started:**

*(Basic setup commands will be added here as the project progresses)*
