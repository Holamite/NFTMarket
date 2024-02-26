// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFTMarket is ERC721, Ownable {
    using Strings for uint256;

    uint256 private _nextTokenId;

    constructor() ERC721("Holamite", "HOT") Ownable(msg.sender) {}

    function safeMint() public {
        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, getTokenURI());
    }

    function purchaseNFT(uint tokenId, uint _amount) returns () {}
}
