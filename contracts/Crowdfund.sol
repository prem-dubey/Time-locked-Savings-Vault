// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Crowdfund
 * @dev A simple crowdfunding contract where users can create campaigns,
 * contribute to campaigns, and creators can withdraw funds if the goal is met.
 */
contract Crowdfund {
    struct Campaign {
        address creator;
        uint256 goal;
        uint256 deadline;
        uint256 amountRaised;
        bool claimed;
        string title;
        string description;
    }

    // Campaign ID to Campaign data
    mapping(uint256 => Campaign) public campaigns;
    
    // Campaign ID to contributor address to amount contributed
    mapping(uint256 => mapping(address => uint256)) public contributions;
    
    uint256 public campaignCount;
    
    // Events
    event CampaignCreated(uint256 indexed campaignId, address indexed creator, uint256 goal, uint256 deadline);
    event ContributionMade(uint256 indexed campaignId, address indexed contributor, uint256 amount);
    event FundsClaimed(uint256 indexed campaignId, address indexed creator, uint256 amount);
    event RefundClaimed(uint256 indexed campaignId, address indexed contributor, uint256 amount);
    
    /**
     * @dev Creates a new crowdfunding campaign
     * @param _goal The funding goal in wei
     * @param _deadline The campaign deadline timestamp
     * @param _title The campaign title
     * @param _description The campaign description
     */
    function createCampaign(
        uint256 _goal,
        uint256 _deadline,
        string memory _title,
        string memory _description
    ) external {
        require(_goal > 0, "Goal must be greater than 0");
        require(_deadline > block.timestamp, "Deadline must be in the future");
        require(bytes(_title).length > 0, "Title cannot be empty");
        
        uint256 campaignId = campaignCount;
        
        campaigns[campaignId] = Campaign({
            creator: msg.sender,
            goal: _goal,
            deadline: _deadline,
            amountRaised: 0,
            claimed: false,
            title: _title,
            description: _description
        });
        
        campaignCount++;
        
        emit CampaignCreated(campaignId, msg.sender, _goal, _deadline);
    }
    
    /**
     * @dev Allows a user to contribute funds to a campaign
     * @param _campaignId The ID of the campaign to fund
     */
    function contribute(uint256 _campaignId) external payable {
        Campaign storage campaign = campaigns[_campaignId];
        
        require(campaign.deadline > block.timestamp, "Campaign has ended");
        require(msg.value > 0, "Must contribute more than 0");
        
        campaign.amountRaised += msg.value;
        contributions[_campaignId][msg.sender] += msg.value;
        
        emit ContributionMade(_campaignId, msg.sender, msg.value);
    }
    
    /**
     * @dev Allows the campaign creator to claim funds if the goal is met
     * @param _campaignId The ID of the campaign
     */
    function claimFunds(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        
        require(msg.sender == campaign.creator, "Only the creator can claim funds");
        require(campaign.deadline < block.timestamp, "Campaign has not ended yet");
        require(campaign.amountRaised >= campaign.goal, "Funding goal not met");
        require(!campaign.claimed, "Funds have already been claimed");
        
        campaign.claimed = true;
        
        payable(campaign.creator).transfer(campaign.amountRaised);
        
        emit FundsClaimed(_campaignId, campaign.creator, campaign.amountRaised);
    }
    
    /**
     * @dev Allows contributors to claim refunds if the campaign goal was not met
     * @param _campaignId The ID of the campaign
     */
    function claimRefund(uint256 _campaignId) external {
        Campaign storage campaign = campaigns[_campaignId];
        
        require(campaign.deadline < block.timestamp, "Campaign has not ended yet");
        require(campaign.amountRaised < campaign.goal, "Funding goal was met, no refunds");
        
        uint256 contributionAmount = contributions[_campaignId][msg.sender];
        require(contributionAmount > 0, "No contributions to refund");
        
        contributions[_campaignId][msg.sender] = 0;
        
        payable(msg.sender).transfer(contributionAmount);
        
        emit RefundClaimed(_campaignId, msg.sender, contributionAmount);
    }

    function getCampaign(uint256 _campaignId) external view returns (
        address creator,
        uint256 goal,
        uint256 deadline,
        uint256 amountRaised,
        bool claimed,
        string memory title,
        string memory description
    ) {
        Campaign storage campaign = campaigns[_campaignId];
        return (
            campaign.creator,
            campaign.goal,
            campaign.deadline,
            campaign.amountRaised,
            campaign.claimed,
            campaign.title,
            campaign.description
        );
    }
}