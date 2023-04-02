// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "./BatchNFT.sol";

contract Packagers is IERC721Receiver {
    BatchNFT private nft;

    constructor(address nftAddress) {
        nft = BatchNFT(nftAddress);
    }

    function createSmallerBatch(address consumer_address, uint256 tokenId, uint256 weightToSplit) public {

        uint256 currentWeight = nft.weights(tokenId);
        require(currentWeight >= weightToSplit, "Insufficient weight");

        uint256 newWeight = currentWeight - weightToSplit;
        nft.updateWeight(tokenId, newWeight);

        string memory tokenURI = nft.tokenURI(tokenId);
        string memory genetics = nft.genetics(tokenId);
        string memory nutrients = nft.nutrients(tokenId);
        string memory lighting = nft.lighting(tokenId);

        nft.safeMint(consumer_address, tokenURI, weightToSplit, genetics, nutrients, lighting);

    }



    function viewBatchInformation(uint256 tokenId) public view returns (
      uint256 weight,
      string memory genetic,
      string memory nutrient,
      string memory lightings
    ) {
        return nft.viewBatchInformation(tokenId);
    }



}
