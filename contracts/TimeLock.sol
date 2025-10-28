// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title TimeLock
 * @dev A contract where users can deposit funds that are locked until a
 * specified unlock time.
 */
contract TimeLock {

    // =============================
    //      STATE VARIABLES
    // =============================

    /**
     * @dev Stores the deposited balance for each user.
     * The address maps to the amount of native currency (e.g., Ether, CORE) deposited.
     */
    mapping(address => uint256) public balances;

    /**
     * @dev Stores the unlock timestamp for each user's deposit.
     * The address maps to a Unix timestamp (seconds).
     */
    mapping(address => uint256) public unlockTimestamps;

    // =============================
    //           EVENTS
    // =============================

    /**
     * @dev Emitted when a user successfully deposits funds.
     * @param user The address of the depositor.
     * @param amount The amount deposited.
     * @param unlockTime The time when the funds can be withdrawn.
     */
    event Deposit(address indexed user, uint256 amount, uint256 unlockTime);

    /**
     * @dev Emitted when a user successfully withdraws their funds.
     * @param user The address of the withdrawer.
     * @param amount The amount withdrawn.
     */
    event Withdrawal(address indexed user, uint256 amount);

    // =============================
    //          FUNCTIONS
    // =============================

    constructor() {
        // Constructor logic (if any)
    }

    /**
     * @dev Deposits funds into the contract and sets a lock time.
     * @param _unlockTimestamp The future time (Unix timestamp) when
     * funds can be withdrawn.
     */
    function deposit(uint256 _unlockTimestamp) public payable {
        // --- CHECKS ---
        // 1. Ensure the user is sending some funds
        require(msg.value > 0, "TimeLock: Must send > 0 currency");

        // 2. Ensure the unlock time is in the future
        require(_unlockTimestamp > block.timestamp, "TimeLock: Unlock time must be in the future");

        // 3. Ensure the user doesn't already have a deposit
        // This is a simplifying assumption for this basic contract.
        require(balances[msg.sender] == 0, "TimeLock: Contract only supports one active deposit per user");

        // --- EFFECTS ---
        // 1. Update the user's balance
        balances[msg.sender] = msg.value;

        // 2. Store the user's unlock time
        unlockTimestamps[msg.sender] = _unlockTimestamp;

        // Emit event will be added here
    }
}