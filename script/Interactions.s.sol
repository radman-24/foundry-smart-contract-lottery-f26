// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {HelperConfig, CodeConstants} from "script/HelperConfig.s.sol";
import {
    VRFCoordinatorV2PlusMock
} from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2PlusMock.sol";
import {LinkToken} from "test/mocks/LinkToken.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        (uint256 subId, ) = createSubscription(vrfCoordinator);
        return (subId, vrfCoordinator);
    }

    function createSubscription(
        address vrfCoordinator
    ) public returns (uint256, address) {
        console.log("Creating sunbscription on chain Id: ", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2PlusMock(vrfCoordinator)
            .createSubscription();
        vm.stopBroadcast();

        console.log("Your subscription Id is: ", subId);
        console.log(
            "Please update the subscription Id in your HelperConfig.s.sol"
        );
        return (subId, vrfCoordinator);
    }

    function run() external {
        createSubscriptionUsingConfig();
    }
}

contract FundSubscription is Script, CodeConstants {
    uint256 public constant FUND_AMOUNT = 3 ether;

    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        uint256 SubscriptionId = helperConfig.getConfig().subscriptionId;
        address linkToken = helperConfig.getConfig().link;
        fundSubscription(vrfCoordinator, SubscriptionId, linkToken);
    }

    function fundSubscription(
        address vrfCoordinator,
        uint256 SubscriptionId,
        address linkToken
    ) public {
        console.log("Funding subscription: ", SubscriptionId);
        console.log("Using vrfCoordinator: ", vrfCoordinator);
        console.log("On ChainId: ", block.chainid);

        if (block.chainid == LOCAL_CHAIN_ID) {
            vm.startBroadcast();
            VRFCoordinatorV2PlusMock(vrfCoordinator).fundSubscription(
                SubscriptionId,
                uint96(FUND_AMOUNT * 100)
            );
            vm.stopBroadcast();
        } else {
            vm.startBroadcast();
            LinkToken(linkToken).transferAndCall(
                vrfCoordinator,
                FUND_AMOUNT,
                abi.encode(SubscriptionId)
            );
            vm.stopBroadcast();
        }
    }

    function run() external {
        fundSubscriptionUsingConfig();
    }
}

contract AddConsumer is Script {
    function addConsumerUsingConfig(address mostRecentlyDeployed) public {
        HelperConfig helperConfig = new HelperConfig();
        uint256 subId = helperConfig.getConfig().subscriptionId;
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        addConsumer(mostRecentlyDeployed, vrfCoordinator, subId);
    }

    function addConsumer(
        address contractToAddToVrf,
        address vrfCoordinator,
        uint256 subId
    ) public {
        console.log("Adding consumer contract: ", contractToAddToVrf);
        console.log("To vrfCoordinator: ", vrfCoordinator);
        console.log("On ChainId: ", block.chainid);
        vm.startBroadcast();
        VRFCoordinatorV2PlusMock(vrfCoordinator).addConsumer(
            subId,
            contractToAddToVrf
        );
        vm.stopBroadcast();
    }

    function run() external {
        address mostResentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Raffle",
            block.chainid
        );
        addConsumerUsingConfig(mostResentlyDeployed);
    }
}
