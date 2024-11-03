// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    uint256 mynumber = 5;
    FundMe fundMe;
    address myAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    address USER = makeAddr("manolo");
    uint256 constant SEND_VALUE = 0.1 ether;

    function setUp() external {
        mynumber = 6;
        DeployFundMe deployFundMe = new DeployFundMe();
        //fundMe = new FundMe(myAddress);
        fundMe = deployFundMe.run();
    }

    function testPriceFeedVersion() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testMinimumDollarIsfive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(), address(this));
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        emit log_address(USER);
        vm.prank(USER); //configura el msd.sender sea USER
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }
}
