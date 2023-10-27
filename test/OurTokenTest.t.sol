// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTest is Test {    
    uint256 BOB_STARTING_AMOUNT = 100 ether;

    OurToken public ourToken;
    DeployOurToken public deployer;
    address public deployerAddress;
    address bob;
    address alice;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        bob = makeAddr("bob");
        alice = makeAddr("alice");

        deployerAddress = vm.addr(deployer.deployerKey());
        vm.prank(deployerAddress);
        ourToken.transfer(bob, BOB_STARTING_AMOUNT);
    }

    function testInitialSupply() public {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testAllowances() public {
        uint256 initialAllowance = 1000;

        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);
        uint256 transferAmount = 500;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);
        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - transferAmount);
    }

    /**
     * @dev The test below are test generated from chatGBT AI Prompt
     * 
     * function testTransfer() public {
        // Alice transfers 100 tokens to Bob
        vm.prank(alice);
        ourToken.transfer(bob, 100);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT + 100);
        }
     */

    // My correction to the test AI generated i wrote 
    function testTransfer() public {
        // Bob transfers 100 tokens to Alice
        vm.prank(bob);
        ourToken.transfer(alice, 100);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - 100);
    }

    /**
     * @dev The test below are test generated from chatGBT AI Prompt
     * 
     * function testTransferFrom() public {
        // Alice approves Bob to spend tokens on her behalf
        vm.prank(bob);
        ourToken.approve(alice, 1000);
        // Bob transfers 500 tokens from Alice to himself
        vm.prank(alice);
        ourToken.transferFrom(alice, bob, 500);
        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT + 500);
        assertEq(ourToken.balanceOf(alice), 500);
        }
     */

    // My correction to the test AI generated i wrote 
    function testTransferFrom() public {
        vm.prank(bob);

        ourToken.approve(alice, 1000); // Bob approves Alice to spend tokens on his behalf
    
        vm.prank(alice);
        ourToken.transferFrom(bob, alice, 500); // Bob transfers 500 tokens from Alice to himself

        assertEq(ourToken.balanceOf(bob), BOB_STARTING_AMOUNT - 500);
        assertEq(ourToken.balanceOf(alice), 500);
    }
    
    function testTotalSupply() public {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testForNumberOfdecimals() public {
        assertEq(ourToken.decimals(), deployer.DECIMALS());
    }

    function testForTokensymbol() public {
        string memory actualSymbol = "OT";
        assertEq(ourToken.symbol(), actualSymbol);
    }

    function testForTokenName() public {
        string memory actualName = "OurToken";
        assertEq(ourToken.name(), actualName);
    }

}


// forge test
// [⠔] Compiling...
// [⠆] Compiling 2 files with 0.8.21
// [⠒] Solc 0.8.21 finished in 13.09s
// Compiler run successful!

// Running 3 tests for test/OurTokenTest.t.sol:OurTokenTest
// [PASS] testAllowances() (gas: 73728)
// [PASS] testInitialSupply() (gas: 12678)
// [PASS] testUsersCantMint() (gas: 8267)
// Test result: ok. 3 passed; 0 failed; 0 skipped; finished in 6.82ms

// Ran 1 test suites: 3 tests passed, 0 failed, 0 skipped (3 total tests)


// forge test
// [⠰] Compiling...
// [⠊] Compiling 2 files with 0.8.21
// [⠢] Solc 0.8.21 finished in 8.56s
// Compiler run successful!

// Running 9 tests for test/OurTokenTest.t.sol:OurTokenTest
// [PASS] testAllowances() (gas: 73816)
// [PASS] testForNumberOfdecimals() (gas: 12751)
// [PASS] testForTokenName() (gas: 9622)
// [PASS] testForTokensymbol() (gas: 9643)
// [PASS] testInitialSupply() (gas: 12756)
// [PASS] testTotalSupply() (gas: 12799)
// [PASS] testTransfer() (gas: 45664)
// [PASS] testTransferFrom() (gas: 73838)
// [PASS] testUsersCantMint() (gas: 8289)
// Test result: ok. 9 passed; 0 failed; 0 skipped; finished in 137.19ms

// Ran 1 test suites: 9 tests passed, 0 failed, 0 skipped (9 total tests)
