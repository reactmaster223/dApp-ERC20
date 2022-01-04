// SPDX-License-Identifier: ISC
pragma solidity ^0.8.11;

import "./NeatBit.sol";

contract NeatBitSale {
    address admin;
    NeatBit public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(NeatBit _tokenContract, uint256 _tokenPrice) {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(
            msg.value == multiply(_numberOfTokens, tokenPrice),
            "ERROR LINE 25"
        );
        require(
            tokenContract.balanceOf(address(this)) >= _numberOfTokens,
            "ERROR LINE 26"
        );
        require(
            tokenContract.transfer(msg.sender, _numberOfTokens),
            "ERROR LINE 27"
        );

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(
            tokenContract.transfer(
                admin,
                tokenContract.balanceOf(address(this))
            )
        );

        payable(admin).transfer(address(this).balance);
    }
}
