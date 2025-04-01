// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
    Contract c;
    event Transfer(address indexed from , address indexed to,uint value);// decleare a event .. enevts helps to connect with observer like node JS to observe a transaction  **up to 3 fields indexed
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function setUp() public {
        c = new Contract();//set up before running avobe functions
    }

    function testInc() public {
        assertEq(uint256(1), uint256(1),"ok");
    }
    function testMint() public{
        c.mint(address(this),100);
        assertEq(c.balanceOf(address(this)),100,"ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 0,"Ok");
         c.mint(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,100);
         assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), 100,"Ok");
    }
     function testTransfer() public{
        c.mint(address(this),100);
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,50);
        assertEq(c.balanceOf(address(this)),50,"ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4),50,"ok");
        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);//now after this next function  will call by the address given here
        c.transfer(address(this),50);
        assertEq(c.balanceOf(address(this)),100,"ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4),0,"ok");
    }
    function testApproval() public{
        c.mint(address(this),100);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 25);
        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transferFrom(address(this),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,20);
        assertEq(c.balanceOf(address(this)),80,"ok");
        assertEq(c.balanceOf(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4),20,"ok");
        assertEq(c.allowance(address(this),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4),5,"ok");

    }
    function test_RevertApproval() public{
        c.mint(address(this),100);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,10);
        vm.prank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        c.transferFrom(address(this),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 10);
    }
    function test_RevertTransfer()public{
        c.mint(address(this),100);
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 100); 
    }
    function testEvents() public{
        c.mint(address(this),100);
        vm.expectEmit(true,true,false,true);//first declear that an emit will happend very soon//first two used indexed thats why true and data field
        emit Transfer(address(this),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,10);//then what i emited to be expected
        c.transfer(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,10 );//then expected transfer event happend and compared with emit one
    }
    function test_ExpectEmitApprove() public {
        c.mint(address(this),100);
        vm.expectEmit(true, true, false, true);
        emit Approval(address(this),
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,10);
        c.approve(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 10);
    }
    
}