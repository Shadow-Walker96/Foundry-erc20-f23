// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";
import {console} from "forge-std/console.sol";

contract DeployOurToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1_000_000 ether; // 1 million tokens with 18 decimal places
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    // I added this variables for more test
    uint8 public DECIMALS = 18;// 1e18 = 18 zeros

    /**
     * dev run --> cast sig "symbol()" output is 0x95d89b41
     * run --> cast 4byte  0x95d89b41 output symbol()
     * 
     */
    string public SYMBOL = "OT";

    function run() external returns (OurToken) {
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }
        vm.startBroadcast(deployerKey);
        OurToken ourToken = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ourToken;
    }
}



// make deploy
// [⠃] Compiling...
// No files changed, compilation skipped
// Script ran successfully.

// == Return ==
// 0: contract OurToken 0x5FbDB2315678afecb367f032d93F642f64180aa3

// EIP-3855 is not supported in one or more of the RPCs used.
// Unsupported Chain IDs: 31337.
// Contracts deployed with a Solidity version equal or higher than 0.8.20 might not work properly.
// For more information, please see https://eips.ethereum.org/EIPS/eip-3855

// ## Setting up (1) EVMs.

// ==========================

// Chain 31337

// Estimated gas price: 5 gwei

// Estimated total gas used for script: 719629

// Estimated amount required: 0.003598145 ETH

// ==========================

// ###
// Finding wallets for all the necessary addresses...
// ##
// Sending transactions [0 - 0].
// ⠁ [00:00:00] [############################################################################################################################################] 1/1 txes (0.0s)
// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/broadcast/DeployOurToken.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/cache/DeployOurToken.s.sol/31337/run-latest.json

// ##
// Waiting for receipts.
// ⠉ [00:00:00] [########################################################################################################################################] 1/1 receipts (0.0s)
// ##### anvil-hardhat
// ✅  [Success]Hash: 0x9a413fce8879a15439d7154fcfe6473b3ecf97d8bcb5c27b722f85593af729db
// Contract Address: 0x5FbDB2315678afecb367f032d93F642f64180aa3
// Block: 1
// Paid: 0.002214964 ETH (553741 gas * 4 gwei)


// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/broadcast/DeployOurToken.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/cache/DeployOurToken.s.sol/31337/run-latest.json



// ==========================

// ONCHAIN EXECUTION COMPLETE & SUCCESSFUL.
// Total Paid: 0.002214964 ETH (553741 gas * avg 4 gwei)

// Transactions saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/broadcast/DeployOurToken.s.sol/31337/run-latest.json

// Sensitive values saved to: /home/shadow-walker/foundry-full-course-f23/foundry-erc20-f23/cache/DeployOurToken.s.sol/31337/run-latest.json
