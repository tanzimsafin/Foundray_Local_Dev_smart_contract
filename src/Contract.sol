// SPDX-License-Identifier: Unlicense
import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
pragma solidity ^0.8.13;

import {console} from "lib/forge-std/src/console.sol";
contract Contract is ERC20{ 
    constructor() ERC20("MyToken", "MTK")  {
       
        
    }
    function mint(address owner,uint amount) public{
        console.log(owner);
        _mint(owner,amount);
    }
    function test() public payable{

    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
}
}
