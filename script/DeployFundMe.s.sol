// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

//import {HelperConfig} from "./Helperconfig.s.sol";

contract DeployFundMe is Script {
    address myAddress;

    function run() external returns (FundMe) {
        //HelperConfig helperConfig = new HelperConfig();
        vm.startBroadcast();
        FundMe fundMe = new FundMe(myAddress);
        vm.stopBroadcast;
        return fundMe;
    }
}
