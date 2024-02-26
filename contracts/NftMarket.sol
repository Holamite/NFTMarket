// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFTMarket is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _nextTokenId;
    mapping(uint256 => uint256) private _tokenPrices;

    constructor() ERC721("Holamite", "HOT") Ownable(msg.sender) {}

    function safeMint() public {
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, getTokenURI());
    }

    function setTokenPrice(uint256 tokenId, uint256 price) public {
        require(_exists(tokenId), "Token does not exist");
        _tokenPrices[tokenId] = price;
    }

    function purchaseNFT(uint tokenId) returns () {
        require(_exists(tokenId), "Token does not exist");
        require(msg.value >= _tokenPrices[tokenId], "Insufficient payment");

        address owner = ownerOf(tokenId);
        _transfer(owner, msg.sender, tokenId);

        // Send payment to the seller
        payable(owner).transfer(msg.value);
    }

    function getTokenPrice(uint256 tokenId) public view returns (uint256) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenPrices[tokenId];
    }

    function getTokenURI(uint256 tokenId) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(tokenId)
                )
            );
    }
}
