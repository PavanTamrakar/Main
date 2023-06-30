// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import {StableCoin} from "./StableCoin";

contract nSCLogic {

    mapping (address token => address priceFeed) private s_priceFeeds;
    mapping(address user => mapping(address depositedToken => uint256 amount)) private s_depositedToken;
    mapping(address user => uint256 amount) private s_SCMinted;
    address[] private s_depositedTokens;

    event depositedToken(address indexed user, address indexed token, uint256 indexed amount);

    event redeemedToken(address indexed redeemedFrom, uint256 indexed amountDeposited, address from, address to);

    StableCoin private immutable i_sc;

    modifier moreThanZero (uint256 amount) {
        if(amount == 0) {
            revert("Need More Than Zero!");
        }
        _;
    }

    modifier allowedToken (address token) {
        if(s_priceFeeds[token] = address(0)){
            revert("Token Not Allowed");
        }
        _;
    }

    constructor (address [] tokenAddresses, address[] priceFeedAddresses, address scAddress) {
        if(tokenAddresses.length != priceFeedAddresses) {
            revert ("Token and Price Feed Adresses Lenght should be same");
        }
        for (uint256 i = 0; i < tokenAddresses.length; i++){
            s_priceFeeds[tokenAddresses[i]] = priceFeedAddresses[i];
        }
        i_sc = StableCoin(scAddress);
    }

    function depositAndMint (address depositedTokenAddress, uint256 amountDeposited, uint256 amountScToMint) external {
        depositCollateral(depositedTokenAddress, amountDeposited);
        mintDsc(amountScToMint);
    }

    function deposit (address depositTokenAddress, uint256 amountOfDeposit) moreThanZero (amountOfDeposit) allowedToken (depositTokenAddress) external {}

    function redeemDeposit () external {}


    function mintSC () public {}

    function burnSC () private {}

    function redeem () private {}

    function hetHealthFactor () external {}
}