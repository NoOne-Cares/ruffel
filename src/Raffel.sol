// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";

contract Raffel is VRFConsumerBaseV2Plus {
    error sendMoreToEnterRaffel();
    
    uint256 private immutable i_entranceFee;
    uint256 private immutable i_interval;
    address payable[] private s_player;

    event RaffelEntered(
        address indexed from
    );

    constructor(uint256 entranceFee ,uint256 interval, address vrfCoordinator) VRFConsumerBaseV2Plus(vrfCoordinator){
        i_entranceFee = entranceFee;
        i_interval = interval;
    }
    function enterRafel() external payable{
        if(msg.value<= i_entranceFee){
            revert sendMoreToEnterRaffel();
        }
        s_player.push(payable(msg.sender));
        emit RaffelEntered(msg.sender);

        //  requestId = s_vrfCoordinator.requestRandomWords(
        //     VRFV2PlusClient.RandomWordsRequest({
        //         keyHash: keyHash,
        //         subId: s_subscriptionId,
        //         requestConfirmations: requestConfirmations,
        //         callbackGasLimit: callbackGasLimit,
        //         numWords: numWords,
        //         extraArgs: VRFV2PlusClient._argsToBytes(
        //             VRFV2PlusClient.ExtraArgsV1({
        //                 nativePayment: enableNativePayment
        //             })
        //         )
        //     })
        // );

    }

    // function pickWinner()  external {
        
    // }

    /*
     *Geter function 
    */

   function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override{}

   function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
