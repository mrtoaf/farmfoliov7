// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BatchNFT.sol";
import "./Packager.sol";


contract Consumers {
    BatchNFT private nft;
    Packagers private packagers;

    constructor(address nftAddress, address packagersAddress) {
        nft = BatchNFT(nftAddress);
        packagers = Packagers(packagersAddress);
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
