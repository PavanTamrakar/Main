// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract StableCoin is ERC20Burnable, Ownable{
    constructor () ERC20 ("nStableCoin", "nUSD") {}

    function burn (uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0) {
            revert("Not Enough to Burn");
        }
        if(balance < _amount) {
            revert("Not Enough Balance to Burn");
        }
        super.burn(_amount);
    }

    function mint (address _to, uint256 _amount) external onlyOwner returns(bool) {
        if(_to == address(0)) {
            revert ("Cannot Mint");
        }
        if(_amount <=0) {
            revert ("Cannot mint null");
        }
        _mint(_to, _amount);
        return true;
    }
}