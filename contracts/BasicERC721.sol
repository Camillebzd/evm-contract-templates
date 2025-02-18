// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract BasicERC721 is ERC721 {
    uint public tokenId;
    uint public maxSupply = 1000;
    string public baseTokenURI;

    constructor() ERC721("BasicNFT", "BNFT") {
    }

    function tokenURI(uint _tokenId) override public view returns (string memory) {
        return string(abi.encodePacked(baseTokenURI, Strings.toString(_tokenId), ".json"));
    }

    function mint() public {
        require(tokenId < maxSupply, "All tokens have been minted");
        _safeMint(msg.sender, tokenId);
        tokenId++;
    }
}