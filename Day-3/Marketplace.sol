// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


interface IMarketplace{
    function paymentToken() external returns(IERC20);
    function nftToken() external returns(IERC721);
    function buy(uint256 listingId) external;
    function list(uint256 tokenId, uint256 price) external;
    function listDetails(uint256 listingId) external view returns(uint256, uint256);
}
contract Marketplace is IMarketplace{
    IERC20 public paymentToken;
    IERC721 public nftToken;
    uint256 listingId;
    struct Listing{
        address owner;
        uint256 tokenId;
        uint256 price;
    }
    mapping(uint256 => Listing) listings;

    constructor(IERC20 _paymentToken, IERC721 _NFTToken){
        paymentToken = _paymentToken;
        nftToken = _NFTToken;
    }

    function buy(uint256 _listingId) external{
        require(paymentToken.transferFrom(msg.sender, listings[_listingId].owner, listings[_listingId].price),"payment failed");
        nftToken.transferFrom(listings[_listingId].owner, msg.sender, listings[_listingId].tokenId);
    }
    function list(uint256 tokenId, uint256 price) external{
        require(nftToken.ownerOf(tokenId) == msg.sender,"only owners can list");
        Listing memory newListing = Listing(msg.sender, tokenId, price);
        listings[listingId] = newListing;
        listingId += 1;
    }
    function listDetails(uint256 _listingId) external view returns(uint256, uint256){
        return (listings[_listingId].tokenId,listings[_listingId].price);
    }

}