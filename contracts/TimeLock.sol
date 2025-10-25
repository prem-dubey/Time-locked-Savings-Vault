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
    mapping(address => uint26) public balances;

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

    // Functions will be added here

    constructor() {
        // Constructor logic (if any)
    }
}