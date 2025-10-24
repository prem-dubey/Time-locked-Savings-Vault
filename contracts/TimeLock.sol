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
    
    // Events will be added here

    // Functions will be added here

    constructor() {
        // Constructor logic (if any)
    }
}