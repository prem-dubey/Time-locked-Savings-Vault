// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title NFTMinter
 * @dev A contract for minting unique NFTs with customizable metadata
 */
contract NFTMinter is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    
    // Maximum supply of NFTs that can be minted
    uint256 public maxSupply;
    
    // Cost to mint one NFT
    uint256 public mintPrice;
    
    // Flag to toggle public minting
    bool public publicMintActive;
    
    // Base URI for computing {tokenURI}
    string private _baseTokenURI;
    
    // Mapping for whitelisted addresses
    mapping(address => bool) public whitelisted;
    
    // Events
    event NFTMinted(address indexed minter, uint256 indexed tokenId, string tokenURI);
    event MintPriceChanged(uint256 oldPrice, uint256 newPrice);
    event PublicMintToggled(bool active);
    event BaseURIChanged(string newBaseURI);
    event AddressWhitelisted(address indexed account, bool status);
    
    /**
     * @dev Constructor initializes the NFT collection
     * @param name Collection name
     * @param symbol Collection symbol
     * @param _maxSupply Maximum supply of NFTs
     * @param _mintPrice Cost to mint one NFT
     * @param baseURI Base URI for token metadata
     */
    constructor(
        string memory name,
        string memory symbol,
        uint256 _maxSupply,
        uint256 _mintPrice,
        string memory baseURI
    ) ERC721(name, symbol) {
        maxSupply = _maxSupply;
        mintPrice = _mintPrice;
        _baseTokenURI = baseURI;
        publicMintActive = false;
    }
    
    /**
     * @dev Mint a new NFT token
     * @param recipient Address to receive the NFT
     * @param tokenURI URI for token metadata
     * @return tokenId The ID of the newly minted token
     */
    function mintNFT(address recipient, string memory tokenURI) 
        public 
        payable 
        returns (uint256) 
    {
        // Check if minting is open to public or if the sender is whitelisted
        require(publicMintActive || whitelisted[msg.sender], "Minting not active or not whitelisted");
        
        // Check if sender sent enough ETH
        require(msg.value >= mintPrice, "Insufficient payment");
        
        // Check if we haven't reached max supply
        uint256 newTokenId = _tokenIds.current();
        require(newTokenId < maxSupply, "Max supply reached");
        
        _tokenIds.increment();
        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        
        emit NFTMinted(recipient, newTokenId, tokenURI);
        
        return newTokenId;
    }
    
    /**
     * @dev Toggle public minting status
     * @param _active New status for public minting
     */
    function setPublicMintActive(bool _active) public onlyOwner {
        publicMintActive = _active;
        emit PublicMintToggled(_active);
    }
    
    /**
     * @dev Set the mint price
     * @param _mintPrice New price for minting
     */
    function setMintPrice(uint256 _mintPrice) public onlyOwner {
        uint256 oldPrice = mintPrice;
        mintPrice = _mintPrice;
        emit MintPriceChanged(oldPrice, _mintPrice);
    }
    
    /**
     * @dev Set base URI for computing {tokenURI}
     * @param baseURI New base URI
     */
    function setBaseURI(string memory baseURI) public onlyOwner {
        _baseTokenURI = baseURI;
        emit BaseURIChanged(baseURI);
    }
    
    /**
     * @dev Add or remove an address from whitelist
     * @param account Address to modify
     * @param status Whitelist status to set
     */
    function setWhitelistStatus(address account, bool status) public onlyOwner {
        whitelisted[account] = status;
        emit AddressWhitelisted(account, status);
    }
    
    /**
     * @dev Withdraw contract balance to owner
     */
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(owner()).transfer(balance);
    }
    
    /**
     * @dev Get current token count
     * @return Current count of minted tokens
     */
    function tokenCount() public view returns (uint256) {
        return _tokenIds.current();
    }
    
    /**
     * @dev Base URI for computing {tokenURI}
     */
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }
}