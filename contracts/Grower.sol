// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BatchNFT.sol";
import "./Packager.sol";

contract Growers {
    BatchNFT private nft;
    Packagers private packager;

    constructor(address nftAddress, address packager_address) {
        nft = BatchNFT(nftAddress);
        packager = Packagers(packager_address);
    }

    function createBatch(
        address packager_address,
        string memory tokenURI,
        uint256 weight,
        string memory genetics,
        string memory nutrients,
        string memory lighting
    ) public {
       nft.safeMint(packager_address, tokenURI, weight, genetics, nutrients, lighting);

    }

    function sendBatchToPackager(
        uint256 tokenId,
        uint256 weightToSend,
        address packager_address
    ) public {
        require(nft.ownerOf(tokenId) == msg.sender, "Growers: The tokenId must be owned by the sender");

        uint256 currentWeight = nft.weights(tokenId);
        require(currentWeight >= weightToSend, "Insufficient weight");

        uint256 newWeight = currentWeight - weightToSend;
        nft.updateWeight(tokenId, newWeight);

        string memory tokenURI = nft.tokenURI(tokenId);
        string memory genetics = nft.genetics(tokenId);
        string memory nutrients = nft.nutrients(tokenId);
        string memory lighting = nft.lighting(tokenId);

        nft.safeMint(packager_address, tokenURI, weightToSend, genetics, nutrients, lighting);

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
