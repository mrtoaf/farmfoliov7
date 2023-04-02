// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract BatchNFT is ERC721URIStorage, IERC721Receiver {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => uint256) public weights;
    mapping(uint256 => string) public genetics;
    mapping(uint256 => string) public nutrients;
    mapping(uint256 => string) public lighting;

    constructor() ERC721("Batch", "B") {}

    function safeMint(address recipient_address, string memory tokenURI, uint256 weight, string memory _genetics, string memory _nutrients, string memory _lighting) public returns (uint256) {
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(recipient_address, tokenId);
        _setTokenURI(tokenId, tokenURI);
        weights[tokenId] = weight;
        genetics[tokenId] = _genetics;
        nutrients[tokenId] = _nutrients;
        lighting[tokenId] = _lighting;
        _tokenIdCounter.increment();
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external override returns (bytes4) {

        return this.onERC721Received.selector;
    }

    function updateWeight(uint256 tokenId, uint256 newWeight) public {
        weights[tokenId] = newWeight;
    }

    function updated(uint256 number) public {
      // nothing goes in here at all so don't worry
    }


    function burn(uint256 tokenId) public {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "BatchNFT: caller is not owner nor approved");
        _burn(tokenId);
    }

    function safeWrapper(address to, address from, uint256 tokenId) public {
      safeTransferFrom(to, from, tokenId);
    }

    function viewBatchInformation(uint256 tokenId) public view returns (

    uint256 weight,
    string memory genetic,
    string memory nutrient,
    string memory lightings
    ) {

      require(_exists(tokenId), "CannabisBatchNFT: TokenId does not exist");
      uint256 weight = weights[tokenId];
      string memory genetic = genetics[tokenId];
      string memory nutrient = nutrients[tokenId];
      string memory lightings = lighting[tokenId];

      return (weight, genetic, nutrient, lightings);

    }

}
